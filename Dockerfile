FROM alpine:3.17

RUN apk add                     \
    bash                        \
    mc                          \
    apache2                     \
    apache2-ssl                 \
    apache2-proxy               \
    apache2-proxy-html          \
    mysql-client                \
    graphicsmagick              \
    php8                        \
    php8-apache2                \
    php8-pdo_mysql              \
    php8-mysqli                 \
    php8-mysqlnd                \
    php8-pdo_sqlite             \
    php8-session                \
    php8-gd                     \
    php8-xml                    \
    php8-simplexml              \
    php8-xmlreader              \
    php8-xmlwriter              \
    php8-zip                    \
    php8-intl                   \
    php8-fileinfo               \
    php8-iconv                  \
    php8-tokenizer              \
    php8-phar                   \
    php8-curl                   \
    php8-posix                  \
    php8-pcntl                  \
    php8-mbstring               \
    php8-gmp                    \
    php8-bcmath                 \
    php8-opcache                \
    php8-pecl-apcu              \
    php8-exif                   #

# fix a dompdf problem...
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.13/community/ gnu-libiconv=1.15-r3
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so


COPY home/you /home/you
COPY srv/ssl /srv/ssl
COPY srv/adminer /srv/adminer
COPY etc/apache2/conf.d/vhosts.d /etc/apache2/conf.d/vhosts.d

RUN ln -s /usr/lib/libxml2.so.2 /usr/lib/libxml2.so
# Syntax error on line 13 of /etc/apache2/conf.d/proxy-html.conf:
# Cannot load /usr/lib/libxml2.so into server: Error loading shared library /usr/lib/libxml2.so: No such file or directory

ADD ["sbin/boot.sh", "/sbin/"]
ENTRYPOINT ["/bin/sh", "/sbin/boot.sh"]
