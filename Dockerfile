FROM ruby:3.2.2

# Install dependencies (Node.js for assets + SQLite)
RUN apt-get update -qq && \
    apt-get install -y nodejs sqlite3

# Set the working directory
WORKDIR /app

# Copy Gemfiles and install gems (ensure SQLite gem is included in Gemfile)
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the entire application
COPY . .

# Create the database directory (required for SQLite)
RUN mkdir -p db

# Precompile assets (for production)
RUN bundle exec rake assets:precompile

# Expose port 3000 for Rails
EXPOSE 3000

# Set entrypoint script (ensure it's executable)
ENTRYPOINT ["./docker-entrypoint.sh"]

# Default command to start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
