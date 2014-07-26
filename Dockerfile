FROM ubuntu

MAINTAINER Ukang'a Dickson

RUN apt-get update
RUN apt-get install -y vim-nox wget dialog net-tools

ENV CODENAME trusty
RUN echo "deb http://archive.ubuntu.com/ubuntu $CODENAME main universe" > /etc/apt/sources.list
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ $CODENAME-pgdg main" > /etc/apt/sources.list.d/pgdg.list
ADD apt.postgresql.org.gpg /apt.postgresql.org.gpg
ENV KEYRING /etc/apt/trusted.gpg.d/apt.postgresql.org.gpg
RUN test -e $KEYRING || touch $KEYRING
RUN apt-key --keyring $KEYRING add /apt.postgresql.org.gpg
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y postgresql-9.0-postgis-2.1 postgresql-9.3-postgis-script postgis

RUN mkdir -p /data/postgres
ADD pg_hba.conf /data/postgres/pg_hba.conf
ADD postgresql.conf /data/postgres/postgresql.conf

ADD start /start
RUN chmod 0755 /start

# Cleanup
RUN apt-get clean

EXPOSE 5432

VOLUME ["/var/lib/postgres/data"]

ENV USERNAME dbusername
ENV PASS dbpasswd

CMD ["/start"]
