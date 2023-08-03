# add extensions to cnpg postgresql image: timescaledb, pg_cron
ARG POSTGRESQL_VERSION=15.3
FROM ghcr.io/cloudnative-pg/postgresql:${POSTGRESQL_VERSION}

USER root
RUN apt-get update
RUN apt-get --yes install wget
RUN wget https://api.pgxn.org/dist/pg_repack/1.4.8/pg_repack-1.4.8.zip
RUN echo $(ls -la)
RUN apt-get --yes install unzip
RUN unzip pg_repack-1.4.8.zip
WORKDIR "/pg_repack-1.4.8"
RUN apt install make
RUN ls /usr/bin/make
RUN apt --yes install build-essential
RUN make -version
#RUN apt-get --yes install autoconf
#RUN find / -name "pg_config" -print
RUN export PATH="/usr/lib/postgresql/15/bin"
# RUN autoconf
# RUN ./configure
RUN pwd
RUN echo $PATH
RUN apt-get autoclean
RUN apt --yes install postgresql-server-dev-15
RUN apt-get --yes install make gcc libpq-dev libssl-dev libxml2-dev pkg-config liblz4-dev libzstd-dev libbz2-dev libz-dev libreadline-dev
RUN cat Makefile
RUN ls -la 
RUN make
RUN make install
RUN cp bin/pg_repack /usr/local/bin/
    # switch back to the postgres user
USER postgres
