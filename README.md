TechMarket: Estandarización de Pipelines CI/CD

Este repositorio contiene una solución de Integración y Entrega Continua (CI/CD) diseñada para TechMarket, enfocada en la estandarización, reutilización y automatización de infraestructura mediante el uso de plantillas modulares en GitHub Actions.

1. Estructura del Proyecto
El repositorio sigue una estructura estándar para la reutilización de flujos de trabajo:

.github/workflows/main_pipeline.yml: Workflow orquestador que invoca las plantillas reutilizables.

.github/workflows/template_build.yml: Plantilla para la construcción y empaquetado del software (v1.1.0).

.github/workflows/template_test.yml: Plantilla para la ejecución de pruebas unitarias y de integridad (v1.1.0).

.github/workflows/template_deploy.yml: Plantilla para el aprovisionamiento de infraestructura con Terraform y despliegue en AWS S3 (v1.1.0).

terraform/: Contiene los archivos de configuración de Infraestructura como Código (IaC).

2. Guía de Uso y Reutilización
Las plantillas han sido diseñadas para ser consumidas por cualquier equipo de desarrollo dentro de la organización sin necesidad de modificar la lógica base.

Ejemplo de Invocación
Para utilizar estas plantillas en un nuevo proyecto, se debe referenciar la ruta local en el job correspondiente:
jobs:
  Deploy:
    needs: Test
    uses: ./.github/workflows/template_deploy.yml
    with:
      bucket-name: 'nombre-de-tu-bucket'
    secrets:
      AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
      AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
      AWS_SESSION_TOKEN: ${{ secrets.AWS_SESSION_TOKEN }}

Parámetros Configurables (Inputs)

node-version: Define la versión de Node.js para el entorno de construcción.


env: Especifica el entorno de ejecución para las pruebas (dev, staging, prod).


bucket-name: Nombre único del bucket de S3 donde se alojará la aplicación.

3. Justificación Técnica y de Negocio
Contribución a la Agilidad y Eficiencia
La implementación de esta capa de abstracción impacta positivamente en TechMarket mediante:


Reducción de Tiempos: Se elimina la necesidad de configurar pipelines desde cero para cada microservicio, acelerando el "Time-to-Market".


Consistencia Operativa: Garantiza que todos los despliegues sigan los mismos pasos lógicos, reduciendo errores humanos y configuraciones manuales en la nube.


Escalabilidad: El uso de Terraform permite que la infraestructura sea predecible y fácil de replicar en distintos entornos.

Integración de Acciones del Marketplace
Se han seleccionado componentes externos por su estabilidad y seguridad:

actions/checkout@v4: Para la obtención segura del código fuente.

actions/setup-node@v4: Para la estandarización del entorno de ejecución.

hashicorp/setup-terraform@v3: Para la automatización profesional de la infraestructura.

4. Configuración de Seguridad
Para el correcto funcionamiento del despliegue en AWS Academy, es obligatorio configurar los siguientes secretos en el repositorio:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

AWS_SESSION_TOKEN