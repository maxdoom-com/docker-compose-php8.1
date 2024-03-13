FROM alpine:3.19

RUN apk add                     \
    bash                        \
    mc                          \
    git                         \
    apache2                     \
    apache2-ssl                 \
    apache2-proxy               \
    apache2-proxy-html          \
    mysql-client                \
    graphicsmagick              \
    php81                       \
    php81-apache2               \
    php81-pdo_mysql             \
    php81-mysqli                \
    php81-mysqlnd               \
    php81-pdo_sqlite            \
    php81-session               \
    php81-gd                    \
    php81-xml                   \
    php81-simplexml             \
    php81-xmlreader             \
    php81-xmlwriter             \
    php81-zip                   \
    php81-intl                  \
    php81-fileinfo              \
    php81-iconv                 \
    php81-tokenizer             \
    php81-phar                  \
    php81-curl                  \
    php81-posix                 \
    php81-pcntl                 \
    php81-mbstring              \
    php81-gmp                   \
    php81-bcmath                \
    php81-opcache               \
    php81-pecl-apcu             \
    php81-exif                  \
    php81-soap                  \
    php81-ldap                  \
    python3                     \
    py3-virtualenv              #

# fix a dompdf problem...
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.13/community/ gnu-libiconv=1.15-r3
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so


COPY home/you /home/you
COPY srv/ssl /srv/ssl
COPY srv/adminer /srv/adminer
# COPY etc/apache2/conf.d/vhosts.d /etc/apache2/conf.d/vhosts.d

RUN ln -s /usr/lib/libxml2.so.2 /usr/lib/libxml2.so
# Syntax error on line 13 of /etc/apache2/conf.d/proxy-html.conf:
# Cannot load /usr/lib/libxml2.so into server: Error loading shared library /usr/lib/libxml2.so: No such file or directory

ADD ["sbin/boot.sh", "/sbin/"]
ENTRYPOINT ["/bin/sh", "/sbin/boot.sh"]
