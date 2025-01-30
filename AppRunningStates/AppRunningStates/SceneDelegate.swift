//
//  SceneDelegate.swift
//  AppRunningStates
//
//  Created by Luis Fontinelles on 29/01/25.
//

import UIKit

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
