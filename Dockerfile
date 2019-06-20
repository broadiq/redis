FROM redis:5.0.5
MAINTAINER John S. Lutz <jlutz@broadiq.com>

# Update the base image.
RUN apt-get update && \
    apt-get install pwgen -y && \
    rm -rf /var/lib/apt/lists/*

# Copy default configuration files, based on
# Pantheon's recommended settings.
COPY redis.conf /usr/local/etc/redis/redis.conf

# Add start script.
ADD init.sh /init.sh
RUN chmod +x /init.sh

ENV REDIS_PASS **Random**

VOLUME ["/var/log/redis"]

EXPOSE 6379

CMD ["/init.sh"]
