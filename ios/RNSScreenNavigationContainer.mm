#import "RNSScreenNavigationContainer.h"
#import "RNSScreen.h"
#import "RNSScreenContainer.h"

#ifdef RCT_NEW_ARCH_ENABLED
#import <React/RCTFabricComponentsPlugins.h>
#import <react/renderer/components/rnscreens/ComponentDescriptors.h>
#import <react/renderer/components/rnscreens/Props.h>

namespace react = facebook::react;
#endif // RCT_NEW_ARCH_ENABLED

@implementation RNSContainerNavigationController

@end

@implementation RNSScreenNavigationContainerView

- (void)setupController
{
  self.controller = [[RNSContainerNavigationController alloc] init];
  [(RNSContainerNavigationController *)self.controller setNavigationBarHidden:YES animated:NO];
  [self addSubview:self.controller.view];
}

- (void)updateContainer
{
  for (RNSScreenView *screen in self.reactSubviews) {
    if (screen.activityState == RNSActivityStateOnTop) {
      // there should never be more than one screen with `RNSActivityStateOnTop`
      // since this component should be used for `tabs` and `drawer` navigators
      [(RNSContainerNavigationController *)self.controller setViewControllers:@[ screen.controller ] animated:NO];
      [screen notifyFinishTransitioning];
    }
  }

  [self maybeDismissVC];
}

#pragma mark-- Fabric specific
#ifdef RCT_NEW_ARCH_ENABLED
+ (react::ComponentDescriptorProvider)componentDescriptorProvider
{
  return react::concreteComponentDescriptorProvider<react::RNSScreenNavigationContainerComponentDescriptor>();
}

// Needed because of this: https://github.com/facebook/react-native/pull/37274
+ (void)load
{
  [super load];
}

#endif

@end

#ifdef RCT_NEW_ARCH_ENABLED
Class<RCTComponentViewProtocol> RNSScreenNavigationContainerCls(void)
{
  return RNSScreenNavigationContainerView.class;
}
#endif

@implementation RNSScreenNavigationContainerManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
  return [[RNSScreenNavigationContainerView alloc] init];
}

@end
