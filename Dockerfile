FROM bitnami/minideb:stretch

# Build Varnish 6.2 with vmod dynamic
RUN apt-get update \
    && apt-get install -y git make libtool m4 automake pkg-config python3-docutils python3-sphinx libpcre3-dev libedit-dev \
    && cd /root \
    && git clone -b 6.2 --depth 1 https://github.com/varnishcache/varnish-cache.git \
    && cd /root/varnish-cache/ \
    && ./autogen.sh \
    && ./configure \
    && make \
    && make install \
    && cd /root \
    && rm -Rf /root/varnish-cache/ \
    && git clone -b 6.2 --depth 1 https://github.com/nigoroll/libvmod-dynamic.git \
    && cd /root/libvmod-dynamic/  \
    && ./autogen.sh \
    && ./configure \
    && make \
    && make install \
    && cd /root \
    && rm -Rf /root/libvmod-dynamic \
    && apt-get purge -y git make libtool m4 automake pkg-config python3-docutils python3-sphinx libpcre3-dev libedit-dev \
    && rm -Rf /var/lib/apt/lists/* \
    && useradd varnish

ADD entrypoint.sh /entrypoint.sh

CMD /entrypoint.sh
