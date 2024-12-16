import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quill_html_editor_v2/src/widgets/responsive_layout.dart';

///
class CustomColorPicker extends StatelessWidget {
  ///
  const CustomColorPicker({
    super.key,
    required this.onColorChanged,
    required this.color,
    this.size,
    this.labelText,
    this.isRequired = true,
  });

  ///
  final void Function(Color) onColorChanged;

  ///
  final Color color;

  ///
  final double? size;

  ///
  final String? labelText;

  ///
  final bool isRequired;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                labelText!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isRequired) ...[
                const SizedBox(width: 8),
                const Icon(
                  FontAwesomeIcons.asterisk,
                  color: Colors.red,
                  size: 8,
                )
              ]
            ],
          ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              barrierDismissible: true,
              useRootNavigator: true,
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Dialog(
                    insetPadding: EdgeInsets.zero,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 5,
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: ResponsiveLayout.tinyLimit,
                        maxWidth: ResponsiveLayout.phoneLimit,
                      ),
                      child: IntrinsicHeight(
                        child: ColorPicker(
                          onColorChanged: onColorChanged,
                          enableOpacity: true,
                          borderRadius: 4,
                          runSpacing: 25,
                          wheelDiameter: 250,
                          wheelSquarePadding: 10,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          columnSpacing: 30,
                          color: color,
                          pickersEnabled: const <ColorPickerType, bool>{
                            ColorPickerType.both: false,
                            ColorPickerType.primary: true,
                            ColorPickerType.accent: false,
                            ColorPickerType.wheel: true,
                          },
                          showColorCode: true,
                          copyPasteBehavior: const ColorPickerCopyPasteBehavior(
                            copyButton: true,
                            ctrlC: true,
                            ctrlV: true,
                            copyFormat: ColorPickerCopyFormat.numHexAARRGGBB,
                            pasteButton: true,
                          ),
                          showRecentColors: true,
                          actionButtons: const ColorPickerActionButtons(
                            closeButton: true,
                            okButton: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "packages/quill_html_editor_v2/assets/color_picker.png",
                height: size ?? 40,
                width: size ?? 40,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 8),
              Container(
                height: size ?? 40,
                width: size ?? 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: color,
                  border: const Border.fromBorderSide(BorderSide()),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
