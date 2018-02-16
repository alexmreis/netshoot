FROM alpine:3.6

RUN set -ex \
    && echo "http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && apk update \
    && apk add --no-cache \
    tcpdump \
    bridge-utils \
    netcat-openbsd \
    util-linux \
    iptables \
    iputils \
    iproute2 \
    iftop \
    drill \
    apache2-utils \
    strace \
    curl \
    ethtool \
    ipvsadm \
    ngrep \
    iperf \
    nmap \
    conntrack-tools \
    socat
# apparmor issue #1414s
RUN addgroup -g 433 swuser && \
adduser -u 431 -G swuser -h /home/swuser -s /sbin/nologin -g "Docker image user" swuser -D && \
mkdir -p /home/swuser && \
chown -R swuser:swuser /home/swuser
RUN mv /usr/sbin/tcpdump /usr/bin/tcpdump

ADD netgen.sh /usr/local/bin/netgen
ADD sleep.sh /usr/local/bin/run_on_boot

USER swuser
CMD ["run_on_boot"]
