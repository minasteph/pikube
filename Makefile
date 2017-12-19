BINARY=pikube

VERSION=`cat VERSION.txt`
BUILD=`git rev-parse HEAD`
AK="AKIAJIMPINIXBGGUM2OQ"
LDFLAGS=-ldflags "-X main.Version=${VERSION} -X main.Build=${BUILD}"

.DEFAULT_GOAL: ${BINARY}

${BINARY}:
#	go get ./...
	go build ${LDFLAGS} -o ${BINARY} .

get:
	go get ./...

static:
#	go get ./...
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo ${LDFLAGS} -o ${BINARY} .

docker:
#	go get ./...
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo ${LDFLAGS} -o ${BINARY} .
	docker build . -t ${BINARY}:${VERSION}

install:
	go install ${LDFLAGS} -o ${BINARY} .

clean:
	if [ -f ${BINARY} ] ; then rm -f ${BINARY} ; fi


.PHONY: clean install
