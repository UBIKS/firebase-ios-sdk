/*
 * Copyright 2018 Google
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "FIRIAMRenderingWindowHelper.h"
#import "FIRIAMBannerViewUIWindow.h"

@implementation FIRIAMRenderingWindowHelper

+ (UIWindow *)UIWindowForModalView {
  static UIWindow *UIWindowForModal;
  static dispatch_once_t onceToken;

  dispatch_once(&onceToken, ^{
#if defined(__IPHONE_13_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
    if (@available(iOS 13.0, *)) {
      UIWindowScene *foregroundedScene = [[self class] foregroundedScene];
      UIWindowForModal = [[UIWindow alloc] initWithWindowScene:foregroundedScene];
    } else {
#endif  // defined(__IPHONE_13_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
      UIWindowForModal = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
#if defined(__IPHONE_13_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
    }
#endif  // defined(__IPHONE_13_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
    // NOTE: iPad で Keyboard accessory view が前面に表示されてしまうため window level をカスタマイズ
    UIWindowForModal.windowLevel = UIWindowLevelStatusBar;
  });
  return UIWindowForModal;
}

+ (UIWindow *)UIWindowForBannerView {
  static UIWindow *UIWindowForBanner;
  static dispatch_once_t onceToken;

  dispatch_once(&onceToken, ^{
#if defined(__IPHONE_13_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
    if (@available(iOS 13.0, *)) {
      UIWindowScene *foregroundedScene = [[self class] foregroundedScene];
      UIWindowForBanner = [[FIRIAMBannerViewUIWindow alloc] initWithWindowScene:foregroundedScene];
    } else {
#endif  // defined(__IPHONE_13_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
      UIWindowForBanner =
          [[FIRIAMBannerViewUIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
#if defined(__IPHONE_13_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
    }
#endif
    // NOTE: iPad で Keyboard accessory view が前面に表示されてしまうため window level をカスタマイズ
    UIWindowForBanner.windowLevel = UIWindowLevelStatusBar;
  });

  return UIWindowForBanner;
}

+ (UIWindow *)UIWindowForImageOnlyView {
  static UIWindow *UIWindowForImageOnly;
  static dispatch_once_t onceToken;

  dispatch_once(&onceToken, ^{
#if defined(__IPHONE_13_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
    if (@available(iOS 13.0, *)) {
      UIWindowScene *foregroundedScene = [[self class] foregroundedScene];
      UIWindowForImageOnly = [[UIWindow alloc] initWithWindowScene:foregroundedScene];
    } else {
#endif  // defined(__IPHONE_13_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
      UIWindowForImageOnly = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
#if defined(__IPHONE_13_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
    }
#endif  // defined(__IPHONE_13_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
    // NOTE: iPad で Keyboard accessory view が前面に表示されてしまうため window level をカスタマイズ
    UIWindowForImageOnly.windowLevel = UIWindowLevelStatusBar;
  });

  return UIWindowForImageOnly;
}

#if defined(__IPHONE_13_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
+ (UIWindowScene *)foregroundedScene API_AVAILABLE(ios(13.0)) {
  for (UIWindowScene *connectedScene in [UIApplication sharedApplication].connectedScenes) {
    if (connectedScene.activationState == UISceneActivationStateForegroundActive) {
      return connectedScene;
    }
  }
  return nil;
}
#endif
@end
