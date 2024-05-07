#!/bin/bash

if [ ! -f "vendor/autoload.php" ]; then
    composer install --no-progress --no-interaction
fi

if [ ! -f ".env" ]; then
    echo "Creating the env file ${APP_ENV}"
    cp .env.example .env
else
    echo "ENV exist"
fi

php artisan migrate
php artisan key:generate
php artisan optimize:clear

php artisan serve --port=$PORT --host=0.0.0.0 --env=.env
exec docker-php-entrypoint "$@"
