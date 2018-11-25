
import UIKit
import Intents

enum SiriShortcutType {
    case makeRed
    case makeGreen
    
    var siriActivityType: String {
        switch self {
            case .makeRed:
            return "com.rio.SiriShortcuts.makeRed"
            case .makeGreen:
            return "com.rio.SiriShortcuts.makeGreen"
        }
    }
    
    var siriShortcutTitle: String {
        switch self {
        case .makeRed:
            return "Make View Red"
        case .makeGreen:
            return "Make View Green"
        }
    }
    
    var color: String {
        switch self {
        case .makeRed:
            return "red"
        case .makeGreen:
            return "green"
        }
    }
    
    static let allCases:[SiriShortcutType] = [.makeGreen, .makeRed]
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func registerSiriShortcut() {
        if #available(iOS 12.0, *) {
            let cases = SiriShortcutType.allCases
            var suggestions: [INShortcut] = []
            for type in cases {
                
                let activity = NSUserActivity(activityType: type.siriActivityType)
                activity.userInfo = ["color" : type.color]
                activity.title = type.siriShortcutTitle
                activity.isEligibleForSearch = true
                activity.isEligibleForPrediction = true
                activity.persistentIdentifier = NSUserActivityPersistentIdentifier(type.siriActivityType)
                suggestions.append(INShortcut(userActivity: activity))
            }
            INVoiceShortcutCenter.shared.setShortcutSuggestions(suggestions)
        }
    }
    
    @IBAction func buttonAction(sender: UIButton) {
        registerSiriShortcut()
    }
    
    public func makeView(activity: NSUserActivity) {
        print(activity.activityType)
         if(activity.activityType == "com.rio.SiriShortcuts.makeRed") {
        view.backgroundColor = .red
         } else {
            view.backgroundColor = .green
        }
    }
}

