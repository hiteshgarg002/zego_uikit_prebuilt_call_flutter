// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:zego_uikit_prebuilt_call/src/components/assets.dart';
import 'package:zego_uikit_prebuilt_call/src/minimizing/mini_overlay_machine.dart';
import 'package:zego_uikit_prebuilt_call/src/minimizing/prebuilt_data.dart';

/// @nodoc
class ZegoMinimizingButton extends StatefulWidget {
  const ZegoMinimizingButton({
    Key? key,
    required this.prebuiltData,
    this.afterClicked,
    this.icon,
    this.iconSize,
    this.buttonSize,
    this.rootNavigator = false,
  }) : super(key: key);

  final bool rootNavigator;

  final ButtonIcon? icon;

  ///  You can do what you want after pressed.
  final VoidCallback? afterClicked;

  /// the size of button's icon
  final Size? iconSize;

  /// the size of button
  final Size? buttonSize;

  final ZegoUIKitPrebuiltCallData prebuiltData;

  @override
  State<ZegoMinimizingButton> createState() => _ZegoMinimizingButtonState();
}

/// @nodoc
class _ZegoMinimizingButtonState extends State<ZegoMinimizingButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final containerSize = widget.buttonSize ?? Size(96.zR, 96.zR);
    final sizeBoxSize = widget.iconSize ?? Size(56.zR, 56.zR);

    return GestureDetector(
      onTap: () {
        if (PrebuiltCallMiniOverlayPageState.minimizing ==
            ZegoUIKitPrebuiltCallMiniOverlayMachine().state()) {
          ZegoLoggerService.logInfo(
            'is minimizing, ignore',
            tag: 'call',
            subTag: 'overlay button',
          );

          return;
        }

        ZegoUIKitPrebuiltCallMiniOverlayMachine().changeState(
          PrebuiltCallMiniOverlayPageState.minimizing,
          prebuiltData: widget.prebuiltData,
        );

        Navigator.of(
          context,
          rootNavigator: widget.rootNavigator,
        ).pop();

        if (widget.afterClicked != null) {
          widget.afterClicked!();
        }
      },
      child: Container(
        width: containerSize.width,
        height: containerSize.height,
        decoration: BoxDecoration(
          color: widget.icon?.backgroundColor ??
              ZegoUIKitDefaultTheme.buttonBackgroundColor,
          shape: BoxShape.circle,
        ),
        child: SizedBox.fromSize(
          size: sizeBoxSize,
          child: widget.icon?.icon ??
              PrebuiltCallImage.asset(PrebuiltCallIconUrls.minimizing),
        ),
      ),
    );
  }
}
