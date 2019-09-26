#!/usr/bin/python
import CoreFoundation
from Foundation import NSBundle
import objc
CoreFoundation.CFPreferencesSetAppValue("Button1",1,"com.apple.driver.AppleHIDMouse")
CoreFoundation.CFPreferencesSetAppValue("Button2",2,"com.apple.driver.AppleHIDMouse")
CoreFoundation.CFPreferencesAppSynchronize("com.apple.driver.AppleHIDMouse")
bezel_bundle = NSBundle.bundleWithPath_('/System/Library/PrivateFrameworks/BezelServices.framework')
functions = [('BSKernelPreferenceChanged', '@@'),]
objc.loadBundleFunctions(bezel_bundle, globals(), functions)
BSKernelPreferenceChanged("com.apple.driver.AppleHIDMouse")
