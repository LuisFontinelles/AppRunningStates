# Estados de Execução de um App no iOS

Quando um aplicativo roda no iOS, ele passa por diferentes estados, e entender isso ajuda a otimizar o desempenho e evitar problemas.

## Estados de um Aplicativo iOS

- **Active:** O app está no primeiro plano e interagindo com o usuário.
- **Inactive:** O app está visível, mas não recebe interações, como quando o usuário recebe uma ligação.
- **Background:** O app está rodando em segundo plano e pode executar algumas tarefas limitadas, como música ou GPS.
- **Not Running:** O app não está na memória. Isso acontece quando ele é fechado pelo usuário ou encerrado pelo sistema.
- **Suspended:** O app ainda está na memória, mas não está executando código. Se o iOS precisar de recursos, ele pode ser encerrado sem aviso.

![image](https://github.com/user-attachments/assets/63dbf63f-fa1a-4132-835a-1149174c107c)

Imagem retirada da documentação da Apple


---

## Exemplo de Implementação em UIKit

No UIKit, podemos monitorar os estados do app através do `SceneDelegate`.

```swift
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        print("📲 App foi iniciado (willConnectTo)")
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = ViewController() 
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        print("❌ Cena foi desconectada (sceneDidDisconnect)")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("⚡ Cena está ativa (sceneDidBecomeActive)")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("⏸️ Cena inativa (sceneWillResignActive)")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        print("🔄 Cena entrando para primeiro plano (sceneWillEnterForeground)")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print("🌙 Cena entrou em segundo plano (sceneDidEnterBackground)")
    }
}
```

---

## E em SwiftUI?

No SwiftUI, a Apple recomenda utilizar a variável de ambiente `scenePhase` para acessar o estado atual do app.

```swift
import SwiftUI

@main
struct ExampleApp: App {
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onChange(of: scenePhase) { oldPhase, newPhase in
                    switch newPhase {
                    case .background:
                        print("ScenePhase: Background from \(oldPhase)")
                    case .inactive:
                        print("ScenePhase: Inactive from \(oldPhase)")
                    case .active:
                        print("ScenePhase: Active/Foreground from \(oldPhase)")
                    @unknown default:
                        print("ScenePhase: Unknown scene phase \(newPhase) from \(oldPhase)")
                    }
                }
        }
    }
}
```

Se você estiver dentro de um código Swift que não seja diretamente uma View, pode utilizar `NotificationCenter` para capturar os estados do app:

```swift
NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: .main) { _ in
    print("App Ativo")
}

NotificationCenter.default.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: .main) { _ in
    print("App Inativo")
}

NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main) { _ in
    print("App em Background")
}

NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { _ in
    print("App voltando ao Foreground")
}
```

---

## Como isso impacta o desenvolvimento?

Compreender os estados do aplicativo é essencial para:

- Melhorar a **eficiência do app**, pausando e retomando processos corretamente.
- Reduzir o consumo de **bateria e desempenho**, evitando processos desnecessários no background.
- Garantir que o estado do usuário seja salvo corretamente ao alternar entre apps ou fechar o aplicativo.

Saber lidar com esses estados faz toda a diferença na experiência do usuário e na qualidade do seu app.
