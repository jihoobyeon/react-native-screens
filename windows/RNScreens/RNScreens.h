#pragma once

#include "pch.h"
#include "resource.h"

#include "NativeModules.h"

namespace winrt::RNScreens::implementation {

class RNScreensModule {
 public:
  RNScreensModule(Microsoft::ReactNative::IReactContext const &reactContext);

  static winrt::Windows::Foundation::Collections::IMapView<
      winrt::hstring,
      winrt::Microsoft::ReactNative::ViewManagerPropertyType>
  NativeProps() noexcept;
  void UpdateProperties(winrt::Microsoft::ReactNative::IJSValueReader const
                            &propertyMapReader) noexcept;

  static winrt::Microsoft::ReactNative::ConstantProviderDelegate
  ExportedCustomBubblingEventTypeConstants() noexcept;
  static winrt::Microsoft::ReactNative::ConstantProviderDelegate
  ExportedCustomDirectEventTypeConstants() noexcept;

  static winrt::Windows::Foundation::Collections::IVectorView<winrt::hstring>
  Commands() noexcept;
  void DispatchCommand(
      winrt::hstring const &commandId,
      winrt::Microsoft::ReactNative::IJSValueReader const
          &commandArgsReader) noexcept;

 private:
  Microsoft::ReactNative::IReactContext m_reactContext{nullptr};
};
} // namespace winrt::RNScreens::implementation

namespace winrt::RNScreens::factory_implementation {
struct RNScreensModule
    : implementation::RNScreensModule {};
} // namespace winrt::RNScreens::factory_implementation
