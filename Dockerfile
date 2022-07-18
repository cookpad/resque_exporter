FROM quay.io/prometheus/golang-builder as builder

COPY . $GOPATH/src/github.com/cookpad/resque_exporter
WORKDIR $GOPATH/src/github.com/cookpad/resque_exporter

RUN make PREFIX=/

FROM quay.io/prometheus/busybox
MAINTAINER Ed Robinson <edward-robinson@cookpad.com>

COPY --from=builder /resque_exporter /bin/resque_exporter

EXPOSE 9447
ENTRYPOINT ["/bin/resque_exporter"]
