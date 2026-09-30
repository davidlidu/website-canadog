# Fundación Canadog — Sitio web

Landing page de la **Fundación Canadog** (Santuario Canadog), entidad sin ánimo de lucro de Medellín, Antioquia, dedicada al rescate, rehabilitación y adopción responsable de perros y gatos.

🌐 Producción: [https://canadog.org](https://canadog.org)

## Características

- Sitio estático (HTML, CSS y JavaScript sin dependencias ni proceso de build).
- Diseño responsive inspirado en la plantilla Kutto.
- Galería de fotos con visor (teclado, flechas y gesto de deslizar en móvil).
- Página dedicada de **Transparencia** (`/transparencia/`) con la información exigida para el Régimen Tributario Especial (RTE): directivos y documentos. El home tiene un banner que lleva a ella.
- SEO: metaetiquetas, Open Graph/Twitter, datos estructurados JSON-LD (`NGO`), `robots.txt`, `sitemap.xml` e imágenes WebP optimizadas.

## Estructura

```
.
├── index.html              # Página principal
├── transparencia/
│   └── index.html          # Página de transparencia (RTE)
├── robots.txt
├── sitemap.xml
├── site.webmanifest
├── assets/
│   ├── css/styles.css
│   ├── js/main.js
│   ├── docs/               # PDFs de transparencia (RTE)
│   └── img/
│       ├── animalitos/     # Fotos grandes (WebP)
│       │   └── thumbs/     # Miniaturas de la galería
│       ├── logo-canadog.*  # Logo de la fundación
│       ├── og-canadog.jpg  # Imagen para redes sociales (1200×630)
│       └── deersystems.webp
├── docker/nginx.conf       # Configuración de Nginx para producción
├── Dockerfile
└── recursos-base/          # Material original (ignorado por git)
```

## Desarrollo local

Cualquier servidor estático sirve. Por ejemplo:

```bash
npx serve .
```

o con Docker:

```bash
docker build -t canadog-web .
```

```bash
docker run --rm -p 8080:80 canadog-web
```

Luego abre <http://localhost:8080>.

## Despliegue en Dokploy

1. En Dokploy, crea una **Application** dentro del proyecto.
2. **Provider:** conecta el repositorio Git y selecciona la rama `main`.
3. **Build Type:** `Dockerfile` (ruta: `Dockerfile`, contexto: `.`).
4. **Domains:** agrega `canadog.org` (y `www.canadog.org` si se usa), puerto del contenedor **80**, HTTPS activado con Let's Encrypt.
5. Pulsa **Deploy**. El contenedor expone `/healthz` para verificar que está arriba.

> Recomendado: redirigir `www.canadog.org` → `canadog.org` para evitar contenido duplicado en buscadores.

## Tareas de contenido

### Agregar o actualizar documentos de transparencia

1. Copia el PDF a `assets/docs/` con un nombre en minúsculas y sin espacios (ej. `estados-financieros-2026.pdf`).
2. En `transparencia/index.html`, reemplaza el `<li class="doc doc--pending">` correspondiente por uno sin `doc--pending` con el botón **Ver PDF** (usa como modelo el de *Estatutos*).

Documentos pendientes por publicar:

- [ ] Informe de resultados
- [ ] Certificación del representante legal (versión firmada)
- [ ] Estados financieros
- [ ] Certificado de existencia y representación legal
- [ ] Acta que autoriza al representante legal a aplicar al RTE
- [ ] Certificación de antecedentes

### Agregar fotos a la galería

```bash
sips -Z 1100 foto.jpg --out tmp.jpg && cwebp -q 78 tmp.jpg -o assets/img/animalitos/canadog-20.webp
```

```bash
sips -Z 640 foto.jpg --out tmp.jpg && cwebp -q 72 tmp.jpg -o assets/img/animalitos/thumbs/canadog-20.webp
```

Después duplica un `<button class="gallery__item">` en la sección `#peludos`, con su `alt` descriptivo y el `width`/`height` reales de la miniatura.

### Pendientes de contenido

- [ ] Foto real de Ana Cristina Duque (sección `#fundadora`, formato 4:5).
- [ ] Reemplazar los textos *lorem ipsum*.
- [ ] Cifras reales en la sección de contadores.
- [ ] Redes sociales (Instagram / Facebook) si las hay.

## Créditos

Desarrollado por [DeerSystems](https://deersystems.net).
