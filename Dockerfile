FROM indexyz/php
LABEL maintainer="aipeach <aipeachpro@outlook.com>"

COPY . /var/www
WORKDIR /var/www

RUN	cp config/.config.example.php config/.config.php && \
	chmod -R 755 storage && \
    chmod -R 777 /var/www/storage/framework/smarty/compile/ && \
    curl -SL https://getcomposer.org/installer -o composer-setup.php && \
    php composer-setup.php && \
    php composer.phar install && \
	php xcat initQQWry && \
    curl https://getcaddy.com | bash -s personal dyndns,tls.dns.cloudflare && \
    mkdir /etc/caddy && chown -R root:www-data /etc/caddy && cp Caddyfile /etc/caddy/Caddyfile


VOLUME /var/www/config
ENV TZ=Asia/Shanghai

CMD ["/usr/local/bin/caddy", "--conf", "/etc/caddy/Caddyfile"]