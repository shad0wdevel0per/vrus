import Cocoa
import AVFoundation

class ChaosView: NSView {
    var timer: Timer?

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        layer?.backgroundColor = NSColor.black.cgColor
        startChaos()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startChaos() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            self.setNeedsDisplay(self.bounds)
        }
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        let colors: [NSColor] = [.red, .green, .blue, .yellow, .magenta, .cyan, .white]
        let path = NSBezierPath()

        for _ in 0..<10 {
            let shapeType = Int.random(in: 0...2)
            let color = colors.randomElement() ?? .white
            color.set()

            let x = CGFloat.random(in: 0..<bounds.width)
            let y = CGFloat.random(in: 0..<bounds.height)
            let w = CGFloat.random(in: 10..<100)
            let h = CGFloat.random(in: 10..<100)
            let rect = NSRect(x: x, y: y, width: w, height: h)

            switch shapeType {
            case 0:
                NSBezierPath(rect: rect).fill()
            case 1:
                NSBezierPath(ovalIn: rect).fill()
            case 2:
                path.move(to: CGPoint(x: x, y: y))
                path.line(to: CGPoint(x: x + w, y: y + h))
                path.lineWidth = CGFloat.random(in: 1...4)
                path.stroke()
            default:
                break
            }
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    var audioPlayer: AVAudioPlayerNode!
    var engine: AVAudioEngine!
    var timer: Timer?

    func applicationDidFinishLaunching(_ notification: Notification) {
        let screenSize = NSScreen.main!.frame
        window = NSWindow(contentRect: screenSize,
                          styleMask: [.borderless],
                          backing: .buffered,
                          defer: false)
        window.level = .mainMenu + 1
        window.isOpaque = true
        window.backgroundColor = .black
        window.makeKeyAndOrderFront(nil)

        let chaosView = ChaosView(frame: screenSize)
        window.contentView = chaosView

        gerarSons()

        timer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: false) { _ in
            self.encerrarCaos()
        }
    }

    func gerarSons() {
        engine = AVAudioEngine()
        let oscillator = AVAudioSourceNode { _, _, frameCount, audioBufferList -> OSStatus in
            let ablPointer = UnsafeMutableAudioBufferListPointer(audioBufferList)
            let freq = Float.random(in: 500...15000)
            let sampleRate = Float(44100)
            for frame in 0..<Int(frameCount) {
                let sampleVal = sin(2.0 * .pi * freq * Float(frame) / sampleRate)
                for buffer in ablPointer {
                    let buf = buffer.mData?.assumingMemoryBound(to: Float.self)
                    buf?[frame] = sampleVal
                }
            }
            return noErr
        }
        engine.attach(oscillator)
        engine.connect(oscillator, to: engine.mainMixerNode, format: AVAudioFormat(standardFormatWithSampleRate: 44100, channels: 2))
        try? engine.start()
    }

    func encerrarCaos() {
        engine.stop()
        timer?.invalidate()

        window.backgroundColor = .white
        window.contentView = nil

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            NSApp.terminate(nil)
        }
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.setActivationPolicy(.regular)
app.run()