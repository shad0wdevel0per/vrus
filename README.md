# ⚠️ AVISO IMPORTANTE ⚠️

> Este aplicativo foi criado **apenas para fins educacionais e artísticos**.
> **NÃO use em ambientes de produção ou com dados importantes abertos!**
> O app simula um “vírus visual e sonoro”, podendo gerar sons altos e caos gráfico por 30 segundos, após os quais o sistema é desligado automaticamente.

---

# 💥 FakeVirus.app — Simulador de Caos Visual e Sonoro no macOS

**FakeVirus** é um app para macOS feito em **Swift** usando **Cocoa + AVFoundation**, que simula um ataque caótico visual e sonoro por 30 segundos, finalizando com o desligamento da máquina.

Este é um projeto artístico, criado como um "vírus de mentirinha", perfeito para quem curte experiências experimentais com Swift no macOS.

---

## 🎯 Funcionalidades

- 🎵 Geração aleatória de **frequências sonoras agudas** com `AVAudioEngine`
- 🧱 Desenho de **formas geométricas aleatórias coloridas** que se acumulam na tela
- 🕒 Após 30 segundos de execução, o app **força o desligamento** do sistema
- ❌ Não remove arquivos, não acessa rede, não causa dano real — é **simulação**

---

## 🔧 Como usar

### Pré-requisitos

- macOS 12.6.7 ou superior
- Swift 5.5+ instalado

### 🛠 Como compilar

1. Salve o código Swift principal como `main.swift`
2. Compile via terminal com:

```bash
swiftc -framework Cocoa -framework AVFoundation main.swift -o FakeVirus
