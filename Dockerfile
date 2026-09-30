# Sitio estático de Fundación Canadog servido con Nginx
FROM nginx:1.27-alpine

# Configuración propia de Nginx (caché, gzip, cabeceras de seguridad)
RUN rm /etc/nginx/conf.d/default.conf
COPY docker/nginx.conf /etc/nginx/conf.d/canadog.conf

# Archivos del sitio
COPY index.html robots.txt sitemap.xml site.webmanifest /usr/share/nginx/html/
COPY assets /usr/share/nginx/html/assets
COPY transparencia /usr/share/nginx/html/transparencia

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget -qO- http://127.0.0.1/healthz || exit 1
