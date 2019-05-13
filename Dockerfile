FROM php:7.3.5-fpm-alpine
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
