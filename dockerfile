FROM litespeedtech/openlitespeed

ARG DOMAIN
ARG EMAIL

RUN bash bin/webadmin.sh my_password
RUN bash bin/domain.sh [-A, --add] $DOMAIN 
RUN bash bin/database.sh [-D, --domain] $DOMAIN
RUN ./bin/appinstall.sh [-A, --app] wordpress [-D, --domain] $DOMAIN
RUN ./bin/acme.sh [-I, --install] [-E, --email] $EMAIL
RUN ./bin/acme.sh [-D, --domain] $DOMAIN
RUN bash bin/webadmin.sh [-M, --mod-secure] enable

EXPOSE $PORT

CMD bash bin/demosite.sh
