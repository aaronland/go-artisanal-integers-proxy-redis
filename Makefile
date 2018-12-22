prep:
	if test -d pkg; then rm -rf pkg; fi

self:   prep
	if test -d src; then rm -rf src; fi
	mkdir -p src/github.com/aaronland/go-artisanal-integers-proxy-redis
	# cp *.go src/github.com/aaronland/go-artisanal-integers-proxy-redis/
	cp -r vendor/* src/

rmdeps:
	if test -d src; then rm -rf src; fi 

deps:
	@GOPATH=$(shell pwd) go get "github.com/aaronland/go-artisanal-integers-proxy"
	@GOPATH=$(shell pwd) go get "github.com/whosonfirst/go-whosonfirst-pool-redis"
	@echo "move all the things from go-artisanal-integers-proxy in to place here..."

vendor-deps: rmdeps deps
	if test ! -d vendor; then mkdir vendor; fi
	if test -d vendor; then rm -rf vendor; fi
	cp -r src vendor
	find vendor -name '.git' -print -type d -exec rm -rf {} +
	rm -rf src

fmt:
	go fmt cmd/*.go
	go fmt service/*.go

bin:	self
	@GOPATH=$(shell pwd) go build -o bin/proxy-server cmd/proxy-server.go

