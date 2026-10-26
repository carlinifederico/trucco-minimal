# TRUCCO — minimal

Versión mínima del site: una sola página, HTML y CSS planos, sin build ni JS.
La versión completa (Work, proyectos, About, Contact) sigue en el repo `trucco`.

```
index.html             llegada (reel + logo) y, al bajar, About us + contacto
assets/site.css        todo el diseño
assets/reel-*.mp4      reel de fondo, 1080 y 720 (mobile), sin audio, en loop
tools/build-reel.sh    arma el reel con ffmpeg
```

## Reel

`tools/build-reel.sh` intercala fragmentos de Paraíso y El Quebrado (`../site/assets/media`)
con planos del reel de federicocarlini.com (`../REEL/src/fc-reel-1080.mp4`). Cada línea
`frag` / `cut` es un plano; para cambiar el picado se editan esas líneas y se corre:

```bash
bash tools/build-reel.sh
```

## Pendientes (en `index.html`)

- Mail definitivo (hoy `hello@trucco.studio`)
- LinkedIn de Santiago

## Ver local

```bash
npx http-server -p 8766 -c-1
```

## Dominio

Para servir en un dominio propio: crear un archivo `CNAME` con el dominio, apuntar el DNS
(A → IPs de GitHub Pages, o CNAME `www` → `carlinifederico.github.io`) y activarlo en
Settings → Pages. No agregar el `CNAME` antes de que el DNS apunte.
