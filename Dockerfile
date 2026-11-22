FROM nginx:1.27-alpine
RUN apk upgrade --no-cache
COPY index.html /usr/share/nginx/html/index.html
RUN printf '%s\n' \
    'pid /tmp/nginx.pid;' \
    'events {}' \
    'http {' \
    '    include /etc/nginx/mime.types;' \
    '    default_type application/octet-stream;' \
    '    client_body_temp_path /tmp/client_temp;' \
    '    proxy_temp_path /tmp/proxy_temp;' \
    '    fastcgi_temp_path /tmp/fastcgi_temp;' \
    '    uwsgi_temp_path /tmp/uwsgi_temp;' \
    '    scgi_temp_path /tmp/scgi_temp;' \
    '    server {' \
    '        listen 8080;' \
    '        server_name _;' \
    '        location / {' \
    '            root /usr/share/nginx/html;' \
    '            index index.html;' \
    '        }' \
    '    }' \
    '}' > /etc/nginx/nginx.conf
EXPOSE 8080
USER nginx
CMD ["nginx", "-g", "daemon off;"]