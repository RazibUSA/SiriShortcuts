# Siri Shortcuts
Project Goal: A simple way to register multiple Siri shortcut at once by iterating enum values.

## Introduction to Siri feature:
At WWDC 2018 in San Jose, Apple announced Siri Shortcuts,Siri can predict shortcuts to actions those are registered in the app and suggest those shortcuts to the user in places such as Spotlight search, Lock Screen, and the Siri watch face. Siri learns about the shortcuts available for the app through registeration to an app registers to Siri. Users can also use registered shortcuts to add personalized voice phrases to Siri.

Your app can make register using an **NSUserActivity** object or **INInteraction** object. 

**NSUserActivity** provides a lightweight approach for making a registeration that also integrates with other Apple features such as Handoff and Spotlight search.

The other way to make a donation is to use an **INInteraction** object. This involves a bit more work, but gives you more control over defining and handling the action.

## Inside this Project 
In this project , A simple approach has been taken to registered the multiple siri shortcut using **NSUserActivity**
We registered two shortcuts from this app. If you need more dynamic and multile siri shortcut for your app, you should use custom **Intend** class.

1. Info.plist: You need to mention how many NSUserActivityTypes:

```
<Key>NSUserActivityTypes</key>
<array> 
<string>com.rio.SiriShortcuts.makeGreen</string>
<string>com.rio.SiriShortcuts.makeRed</string>
</array>
```

2. Enum class:

```
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

static let allCases:[SiriShortcutType] = [.makeRed, .makeGreen]
}
```

3. Now my register method in VC (called by button action):

```
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
```
