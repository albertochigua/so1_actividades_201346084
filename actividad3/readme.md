### Sistemas Operativos 1 - A - 1S2023
### Ing. Jesús Alberto Guzmán Polanco
---
### Actividad 3
##### José Alberto Alarcón Chigua
##### 201346084

---
# Solucion 
Debido a que estamos usando un paquete npm dentro de nuestro contenedor de docker, un servidor de archivos estaticos desarrolador por la empresa Vercel.com
![Uso del paquete serve en dockerfile](img1.png?raw=true)

Utilizaremos una opccion en su ejecucion, una bandera que le indica que estamos sirviendo una SAP (-s), la cual agrega redirecciones a la pagina index.html cuando no se reconcoe la ruta, ya que se manipulan virtualmente en el lado del cliente por React.
![Uso del paquete serve](img2.png?raw=true)

__solucion__ 
cambiar
`CMD ["serve", "build"]`
por
`CMD ["serve", "-s", "build"]`

# Teoria
### Rutas virtuales
### Lado del servidor vs Lado del cliente

Lo primero que hay que entender sobre esto es que ahora hay 2 lugares donde se interpreta la URL, mientras que solía haber solo 1 en 'los viejos tiempos'. En el pasado, cuando la vida era simple, algún usuario enviaba una solicitud al http://example.com/about, que inspeccionaba la parte de la ruta de la URL, determinaba que el usuario estaba solicitando la página acerca de y luego devolvía esa página.

Con el enrutamiento del lado del cliente, que es lo que proporciona React Router, las cosas son menos simples. Al principio, el cliente aún no tiene ningún código JavaScript cargado. Entonces, la primera solicitud siempre será para el servidor. Eso devolverá una página que contiene las etiquetas de script necesarias para cargar React y React Router, etc. Solo cuando esos scripts se han cargado, comienza la fase 2. En la fase 2, cuando el usuario hace clic en el enlace de navegación 'Acerca de nosotros', por ejemplo, la URL se cambia localmente solo a http://example.com/about (posible gracias a la API de historial ), pero no se realiza ninguna solicitud al servidor . En cambio, React Router hace lo suyo en el lado del cliente, determina qué vista de React renderizar y la renderiza. Asumiendo que su página acerca de no necesita hacer ningún RESTllamadas, ya está hecho. Ha pasado de Inicio a Acerca de nosotros sin que se haya activado ninguna solicitud del servidor.

## Omitiendo el problema por completo: Historial de hash
Con Hash History , en lugar de Browser History , su URL para la página Acerca de se vería así: http://example.com/#/about

La parte posterior al #símbolo hash ( ) no se envía al servidor. Entonces, el servidor solo ve http://example.com/y envía la página de índice como se esperaba. React Router recogerá la #/aboutpieza y mostrará la página correcta.

Desventajas :
- URL 'feas'
- La representación del lado del servidor no es posible con este enfoque. En lo que respecta a la optimización de motores de búsqueda (SEO), su sitio web consta de una sola página sin apenas contenido.

## Comodín
Con este enfoque, utiliza el Historial del navegador, pero simplemente configura un catch-all en el servidor que envía /*a index.html, brindándole efectivamente la misma situación que con Hash History. Sin embargo, tiene URL limpias y podría mejorar este esquema más adelante sin tener que invalidar todos los favoritos de sus usuarios.

Desventajas :

- Más complejo de configurar
- Todavía no hay un buen SEO

fuente: [https://stackoverflow.com/questions/27928372/react-router-urls-dont-work-when-refreshing-or-writing-manually/](https://stackoverflow.com/questions/27928372/react-router-urls-dont-work-when-refreshing-or-writing-manually)
