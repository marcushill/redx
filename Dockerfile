FROM openresty/openresty:1.9.15.1-xenial 
RUN apt-get update -qq && apt-get install --fix-missing -y \
    libssl-dev \
    lua-socket

RUN /usr/local/openresty/luajit/bin/luarocks install luasec 0.4-4 && \
    /usr/local/openresty/luajit/bin/luarocks install lua-cjson 2.1.0-1 && \
    /usr/local/openresty/luajit/bin/luarocks install lapis 1.0.4-1 && \
    /usr/local/openresty/luajit/bin/luarocks install moonscript 0.2.4-1 && \
    /usr/local/openresty/luajit/bin/luarocks install busted 2.0.rc12-1 && \
    /usr/local/openresty/luajit/bin/luarocks install lbase64 20120820-1 && \
    /usr/local/openresty/luajit/bin/luarocks install luacov 0.12.0-1 && \
    /usr/local/openresty/luajit/bin/luarocks install inspect 1.2-2

COPY . /opt/redx
COPY nginx.conf.example /usr/local/openresty/nginx/conf/nginx.conf

RUN /usr/local/openresty/luajit/bin/moonc /opt/redx
EXPOSE 8080
EXPOSE 8081


ENTRYPOINT ["bash", "-c"]
CMD ["/usr/local/openresty/nginx/sbin/nginx"]
