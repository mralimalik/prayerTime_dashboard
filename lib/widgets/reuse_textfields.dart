import 'package:flutter/material.dart';

class ReuseTextFields extends StatelessWidget {
  final String text;
  final String hintText;
  final IconData prefixicon;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final bool readonly = false;
  final void Function(String)? onChanged; // Changed the type to match TextFormField's onChanged
  const ReuseTextFields({super.key, required this.text, required this.hintText, required this.prefixicon, required this.controller, this.onTap, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Text(text),
            TextFormField(
              onTap: (){
                if(onTap != null){
                onTap!();
                }
                },
              controller: controller,
              onChanged: (value){
                print("change call");
                if(onChanged != null){
                  onChanged!(value);
                }

                },
              decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Icon(prefixicon),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),),

          ],
        ),
    );
  }
}
