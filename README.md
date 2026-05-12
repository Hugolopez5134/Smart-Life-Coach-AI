# Smart-Life-Coach-AI (LangGraph + Gemini Multi-Agent)

Sistema de Inteligencia Artificial basado en **LangGraph**, **FastAPI** y **Google Gemini**, diseñado para funcionar como el motor de IA del proyecto **Smart Life Coach**.

La arquitectura implementa un enfoque de **agentes con herramientas reales**, permitiendo que la IA:

* interprete intenciones del usuario
* consulte información existente
* cree planes y tareas reales
* interactúe con un backend principal mediante APIs
* mantenga una estructura escalable para futuros agentes especializados

---

# Arquitectura General

```txt
Frontend
   ↓
Backend Principal
   ↓
AI Component (FastAPI + LangGraph)
   ↓
ReAct Agent
   ↓
Tools / Backend API
   ↓
Respuesta estructurada
```

---

# Flujo del Sistema

```txt
Usuario
   ↓
Frontend
   ↓
Backend Principal
   ↓
POST /chat
   ↓
LangGraph Agent
   ↓
Gemini Model
   ↓
Tool Calling
   ├── create_plan()
   ├── create_task()
   └── get_current_plans()
   ↓
Consolidación de respuesta
   ↓
Backend Principal
   ↓
Frontend
```

---

# Características

## Implementado actualmente

* FastAPI API server
* Agente ReAct con LangGraph
* Integración con Google Gemini
* Tool Calling real
* Integración con backend externo
* Esquemas tipados con Pydantic
* Dockerización
* Variables de entorno
* Arquitectura desacoplada
* Compatibilidad para memoria futura
* Preparado para multiagentes

---

# Stack Tecnológico

| Tecnología  | Uso                     |
| ----------- | ----------------------- |
| Python 3.12 | Runtime                 |
| FastAPI     | API REST                |
| LangGraph   | Orquestación de agentes |
| LangChain   | Integración LLM         |
| Gemini      | Modelo IA               |
| Pydantic    | Validación              |
| Docker      | Contenedorización       |
| Requests    | Comunicación HTTP       |
| Uvicorn     | ASGI Server             |

---

# Arquitectura Interna

```txt
AI-component/
│
├── main.py
├── graph_app.py
├── tools.py
├── schemas.py
├── backend_simulator.py
├── requirements.txt
├── Dockerfile
├── .env.template
├── .gitignore
└── README.md
```

---

# Componentes

## main.py

Expone la API REST utilizando FastAPI.

Endpoints:

* `GET /`
* `POST /chat`

Responsabilidades:

* recibir payloads
* validar datos
* ejecutar agente
* manejar errores
* responder al backend principal

---

## graph_app.py

Contiene la lógica principal del agente.

Responsabilidades:

* inicializar Gemini
* construir mensajes LangChain
* crear agente ReAct
* gestionar tool calling
* generar respuesta final

---

## tools.py

Define herramientas disponibles para el agente.

### Herramientas actuales

| Tool              | Función                     |
| ----------------- | --------------------------- |
| create_plan       | Crear metas principales     |
| create_task       | Crear tareas asociadas      |
| get_current_plans | Consultar planes existentes |

---

## schemas.py

Define contratos de entrada y salida usando Pydantic.

Modelos:

* ChatPayload
* Message
* CoachResponse
* RouterDecision
* WeekPlan
* Milestone
* RiskItem

---

# Variables de Entorno

Crear archivo `.env`

```env
GOOGLE_API_KEY=tu_api_key
FASTAPI_URL=http://localhost:8000
```

---

# Obtener API Key de Gemini

Puedes obtener una API Key en:

[Google AI Studio](https://aistudio.google.com?utm_source=chatgpt.com)

---

# Instalación Local

## 1. Clonar repositorio

```bash
git clone https://github.com/tu_usuario/smart-life-coach-ai.git
cd smart-life-coach-ai/AI-component
```

---

## 2. Crear entorno virtual

### Con uv

```bash
uv venv .venv --python 3.12
```

Activar:

### Linux / Mac

```bash
source .venv/bin/activate
```

### Windows

```powershell
.venv\Scripts\activate
```

---

## 3. Instalar dependencias

```bash
uv pip install -r requirements.txt
```

---

# Ejecutar Localmente

```bash
uvicorn main:app --host 0.0.0.0 --port 8001 --reload
```

Servidor disponible en:

```txt
http://localhost:8001
```

---

# Docker

## Build

```bash
docker build -t smart-life-coach-ai .
```

---

## Run

```bash
docker run -p 8001:8001 --env-file .env smart-life-coach-ai
```

---

# Docker Compose (recomendado)

```yaml
services:
  ai-component:
    build: .
    ports:
      - "8001:8001"
    env_file:
      - .env
```

---

# Ejemplo de Request

## POST `/chat`

```json
{
  "id": "session-001",
  "trigger": "new_message",
  "user_name": "Victor",
  "age": 22,
  "messages": [
    {
      "id": "msg-001",
      "role": "user",
      "parts": [
        {
          "type": "text",
          "text": "Quiero un plan para aprender backend con FastAPI"
        }
      ]
    }
  ]
}
```

---

# Ejemplo de Response

```json
{
  "status": "success",
  "session_id": "session-001",
  "coach_response": {
    "summary": "Te propongo un roadmap backend...",
    "response_type": "answer",
    "message_for_user": "Te propongo un roadmap backend..."
  },
  "route_used": "agent",
  "route_reason": "agent process"
}
```

---

# Funcionamiento del Agente

El agente utiliza el patrón **ReAct**:

```txt
Thought → Action → Observation → Response
```

Esto permite:

* razonar
* decidir herramientas
* ejecutar acciones reales
* responder basado en resultados

---

# Seguridad

## Actualmente

* CORS abierto para desarrollo
* Token Bearer opcional
* Variables de entorno protegidas por `.gitignore`

---

## Recomendado para producción

* JWT validation
* Rate limiting
* CORS restringido
* Logs estructurados
* Monitoring
* Retries automáticos
* Secret manager
* HTTPS

---

# Mejoras Planeadas

## IA

* Multi-agent supervisor
* Specialized agents
* Persistent memory
* Conversation history
* Embeddings
* Vector database
* RAG
* Streaming responses

---

## Infraestructura

* Redis
* PostgreSQL
* ChromaDB
* Async tools
* Celery / workers
* Kubernetes deployment

---

# Roadmap Arquitectónico

## V1

```txt
Backend → Gemini → Response
```

## V2 (actual)

```txt
Backend → LangGraph Agent → Tools → Backend
```

## V3 (planeado)

```txt
Supervisor
   ├── Planner Agent
   ├── Study Agent
   ├── Health Agent
   ├── Productivity Agent
   └── Tool Executor
```

---

# Buenas Prácticas Aplicadas

* arquitectura desacoplada
* tipado fuerte
* separación de responsabilidades
* variables de entorno
* dockerización
* modularidad
* extensibilidad
* herramientas reales
* integración backend-first

---

# Licencia

MIT License

---

# Autor

Proyecto desarrollado como prototipo académico y base para un sistema de coaching inteligente multiagente enfocado en productividad, metas y crecimiento personal.
