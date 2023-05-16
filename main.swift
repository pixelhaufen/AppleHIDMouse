//
//  main.swift
//  AppleHDIMouse
//
//  Created by Ruben Demus on 16.05.2023
//

import CoreFoundation
import Foundation

let button1Key = "Button1" as CFString
let button2Key = "Button2" as CFString
let appIdentifier = "com.apple.driver.AppleHIDMouse" as CFString

CoreFoundation.CFPreferencesSetAppValue(button1Key, 1 as CFPropertyList, appIdentifier)
CoreFoundation.CFPreferencesSetAppValue(button2Key, 2 as CFPropertyList, appIdentifier)
CoreFoundation.CFPreferencesAppSynchronize(appIdentifier)

let bezelServicesPath = "/System/Library/PrivateFrameworks/BezelServices.framework/BezelServices"
let bezelServicesHandle = dlopen(bezelServicesPath, RTLD_LAZY)
let symbolName = "BSKernelPreferenceChanged"
if let functionPointer = dlsym(bezelServicesHandle, symbolName) {
    typealias BSKernelPreferenceChangedType = @convention(c) (CFString) -> Void
    let BSKernelPreferenceChanged = unsafeBitCast(functionPointer, to: BSKernelPreferenceChangedType.self)
    
    BSKernelPreferenceChanged(appIdentifier)
} else {
    print("Failed to load symbol: \(symbolName)")
}

dlclose(bezelServicesHandle)
