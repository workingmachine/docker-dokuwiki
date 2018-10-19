FROM php:7.1-apache
RUN apt-get -y update \
&&  apt-get -y dist-upgrade \
&&  apt-get install -y \
                       libfreetype6-dev \
                       libjpeg62-turbo-dev \
                       libpng-dev
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd
RUN apt-get clean \
&&  apt-get -y autoremove --purge \
&&  rm -rf /var/lib/apt/lists/*