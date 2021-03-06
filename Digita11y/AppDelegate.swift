import UIKit
import Crashlytics
import RWFramework

extension UIWindow {
  public override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
    if event.type == .Motion && event.subtype == .MotionShake {
      NSNotificationCenter.defaultCenter().postNotificationName("SHAKESHAKESHAKE", object: nil)
    }
  }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, RWFrameworkProtocol {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    Crashlytics.startWithAPIKey("69056dd4dfd70d4a7ca049983df384d1c090537f")
    CLSNSLogv("APPLICATION DID FINISH LAUNCHING", getVaList([]))
    debugPrintln("APPLICATION DID FINISH LAUNCHING")

    UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)

    setupAudio() { granted, error in
      if granted == false {
        debugPrintln("Unable to setup audio: \(error)")
        if let error = error {
          CLSNSLogv("Unable to setup audio: \(error)", getVaList([error]))
        }
      }
    }
    setupRWFramework()

    application.applicationSupportsShakeToEdit = true

    return true
  }

  func applicationDidBecomeActive(application: UIApplication) {
    debugPrintln("APPLICATION DID BECOME ACTIVE")
    CLSNSLogv("APPLICATION DID BECOME ACTIVE", getVaList([]))
  }

  func applicationDidEnterBackground(application: UIApplication) {
    debugPrintln("APPLICATION DID ENTER BACKGROUND")
    CLSNSLogv("APPLICATION DID ENTER BACKGROUND", getVaList([]))
  }

  func applicationWillEnterForeground(application: UIApplication) {
    debugPrintln("APPLICATION WILL ENTER FOREGROUND")
    CLSNSLogv("APPLICATION WILL ENTER FOREGROUND", getVaList([]))
  }

  func applicationWillResignActive(application: UIApplication) {
    debugPrintln("APPLICATION WILL RESIGN ACTIVE")
    CLSNSLogv("APPLICATION WILL RESIGN ACTIVE", getVaList([]))
  }

  func applicationWillTerminate(application: UIApplication) {
    debugPrintln("APPLICATION WILL TERMINATE")
    CLSNSLogv("APPLICATION WILL TERMINATE", getVaList([]))
  }

  func setupRWFramework() {
    var root = self.window!.rootViewController as! RootTabBarController
    root.delegate = root
    root.rwData = RWData()

    var rwf = RWFramework.sharedInstance
    rwf.addDelegate(root)
    rwf.start()
  }

  override func accessibilityPerformMagicTap() -> Bool {
    debugPrintln("ACCESSIBILITY PERFORM MAGIC TAP - APP DELEGATE")
    return MagicTapCenter.sharedInstance().execute()
  }
}
