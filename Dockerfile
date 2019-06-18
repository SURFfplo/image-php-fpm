FROM php:7.2.18-fpm-alpine
LABEL image="php-fpm"
LABEL versie="0.2"
LABEL datum="2019 05 13"

# Use the default production configuration
RUN cp "/usr/local/etc/php/php.ini-production" "/usr/local/etc/php/php.ini"

# gmp: used by the oidc module of the idp
#RUN apk add --update --no-cache gmp gmp-dev php7-gmp libgmpxx \
#    && docker-php-ext-configure gmp \
#    && docker-php-ext-install gmp

# ldap: used by idp
RUN apk add --update --no-cache openldap-dev php7-ldap \
    && docker-php-ext-configure ldap \
    && docker-php-ext-install ldap

# mysql pdo: used by account & portal
RUN apk add --update --no-cache php7-pdo_mysql \
    && docker-php-ext-configure pdo_mysql \
    && docker-php-ext-install pdo_mysql

# copy script to configure stuff
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh", "docker-php-entrypoint"]
