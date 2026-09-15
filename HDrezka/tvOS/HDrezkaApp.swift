import Defaults
import FactoryKit
import FirebaseCore
import Kingfisher
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct HDrezkaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate
    @State private var appState: AppState = .shared
    @State private var downloader: Downloader = .shared
    @State private var cookiesManager: CookiesManager = .shared
    @Default(.theme) private var theme
    @Injected(\.modelContainer) private var modelContainer

    init() {
        switch Defaults[.cache] {
        case .off, .memory:
            ImageCache.default.diskStorage.config.expiration = .expired
        default:
            break
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appState)
                .environment(downloader)
                .environment(cookiesManager)
                .preferredColorScheme(theme.scheme)
        }
        .modelContainer(modelContainer)
    }
}