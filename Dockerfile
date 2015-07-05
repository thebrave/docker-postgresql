FROM thebrave/rpi-maxexcloo-debian:latest
MAINTAINER Jean Berniolles <jean@berniolles.fr>

ENV PG_VERSION 9.4
RUN apt-get update \
 && apt-get install -y curl postgresql-${PG_VERSION} postgresql-client-${PG_VERSION} postgresql-contrib-${PG_VERSION} \
 && rm -rf /var/lib/postgresql \	
 && apt-get clean \
 && echo -n > /var/lib/apt/extended_states
 
RUN curl -o /sbin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.4/gosu-armhf" \
 && chmod +x /sbin/gosu

ADD start /start
RUN chmod 755 /start

EXPOSE 5432

VOLUME ["/var/lib/postgresql"]
VOLUME ["/run/postgresql"]

CMD ["/start"]
