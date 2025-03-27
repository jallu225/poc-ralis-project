#!/bin/bash
set -e

# Remove pre-existing server.pid
rm -f /app/tmp/pids/server.pid

# Create or migrate the SQLite database
bundle exec rails db:create db:migrate

# Execute the command passed to the container
exec "$@"
