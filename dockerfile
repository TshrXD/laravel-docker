FROM php:8.2 as php

RUN apt-get update \
    && apt-get install -y unzip libpq-dev libcurl4-gnutls-dev \
    && docker-php-ext-install pdo pdo_mysql bcmath

WORKDIR /var/www
COPY . .

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

ENV PORT=8000
ENTRYPOINT [ "Docker/entrypoint.sh" ]
