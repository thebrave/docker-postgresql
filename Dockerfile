FROM debian:jessie
MAINTAINER Jean Berniolles <jean@berniolles.fr>
# Original version by sameer@damagehead.com

# init
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y dist-upgrade

ENV PG_VERSION=9.4 \
    PG_USER=postgres \
    PG_HOME=/var/lib/postgresql \
    PG_RUNDIR=/run/postgresql \
    PG_LOGDIR=/var/log/postgresql

ENV PG_BINDIR="/usr/lib/postgresql/${PG_VERSION}/bin" \
    PG_CONFDIR="${PG_HOME}/${PG_VERSION}/main" \
    PG_DATADIR="${PG_HOME}/${PG_VERSION}/main"

RUN apt-get install -y sudo postgresql-${PG_VERSION} \
  postgresql-client-${PG_VERSION} postgresql-contrib-${PG_VERSION} \
 && rm -rf ${PG_HOME} \
 && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 5432/tcp
VOLUME ["${PG_HOME}", "${PG_RUNDIR}"]
CMD ["/sbin/entrypoint.sh"]
