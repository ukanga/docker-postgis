# postgis image

- Change `dbusername` and `dbpasswd` to appropriate username and passwords in `Dockerfile`

## Install postgis image

    $ docker build -t USERNAME/postgis .
    $ docker run -v "~/postgres/data":"/var/lib/postgres/data" -p 5432:5432 -d USERNAME/postgis
