# Chacalitos
Este proyecto desarrolla el Juego de Chacales en lenguaje MIPS Assembly

## Capturas de Pantalla
Juego funcionando


## Descripción

El Juego de Chacales es un juego que maneja un tablero donde  el jugador busca descubrir tesoros con suerte de no encontrarse chacales. El tablero está compuesto por 12 casillas ocultas, que albergan 4 chacales y 8 tesoros repartidos al azar al inicio de cada partida.

El jugador, con la suerte de su lado, debe encontrar 4 tesoros antes de descubrir a todos los chacales o caer en casillas ya descubiertas 3 veces seguidas.

## Funcionalidades

- **Tablero Dinámico:** Al inicio de cada partida, los chacales y tesoros se distribuyen de manera aleatoria, asegurando que cada juego sea una nueva experiencia.
- **Gestión de Estado:** Proporciona una visión del estado del tablero, incluyendo el dinero acumulado, los tesoros encontrados y los chacales revelados en cada turno.
- **Decisiones Estratégicas:** El jugador tiene la opción de seguir jugando para incrementar sus ganancias o retirarse con la cantidad acumulada.
## Requisitos
- Tener instalado Java 8. Si aún no lo tienes, puedes descargarlo desde [Windows x64](https://www.java.com/es/download/ie_manual.jsp) o [MacOs x64](https://javadl.oracle.com/webapps/download/AutoDL?BundleId=249843_43d62d619be4e416215729597d70b8ac).
- Reiniciar la computadora después de instalar Java.

## Instalación

1. Clona el repositorio con: `git clone https://github.com/angmcruz/Chacalitos.git`
2. Para ejecutar el proyecto:
    - Desde la carpeta del proyecto, ejecuta:
      ```bash
      java -jar .\simulador\Mars4_5.jar .\Chacalitos.asm
      ```
    - Alternativamente, puedes usar VS Code y ejecutar la tarea seleccionando "Run Task" y luego "Run MARS".

## Uso

1. Inicia el juego siguiendo las instrucciones del simulador MIPS.
2. Obtendras un numero al azar y descubriras lo que esconde la casilla.
3. Sigue las indicaciones en pantalla para desarrollar tu estrategia y decidir si continuar o retirarte.

## Autores
- Nestor Arias [niarias@espol.edu.ec]
- Melissa Cruz [angmcruz@espol.edu.ec]
