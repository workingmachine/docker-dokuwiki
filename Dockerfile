FROM php:7.1-apache
RUN apt-get update -y -q \
&&  apt-get dist-upgrade -y -q \
&&  apt-get install -y -q --no-install-recommends \
        libwebp-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev

RUN docker-php-ext-configure gd \
    --with-webp-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd

RUN a2enmod remoteip \
&&  touch /etc/apache2/conf-available/remoteip.conf \
&&  a2enconf remoteip

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

RUN apt-get clean \
&&  apt-get -y autoremove --purge \
&&  rm -rf /var/lib/apt/lists/*
