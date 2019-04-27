FROM alpine:3.9

RUN apk add --no-cache varnish bash

ADD entrypoint.sh /entrypoint.sh

CMD /entrypoint.sh
