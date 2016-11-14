Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?SsOpcsOpbXkgTGFs?= <kapouer@melix.org>
Date: Mon, 14 Nov 2016 07:57:01 +0100
Message-ID: <CAJxTCxxMvwdrLZnsMsOG4vLDNbYmtdGgAXLofUMLvPvoepTk7Q@mail.gmail.com>
Subject: hig_magicmouse HID_BATTERY_QUIRK_IGNORE
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,
i've using this patch for a while, or else
https://bugzilla.kernel.org/show_bug.cgi?id=103631
happens (mouse freeze when battery reports).

--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -321,6 +321,9 @@
  { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
    USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI),
    HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
+  { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
+    USB_DEVICE_ID_APPLE_MAGICMOUSE),
+    HID_BATTERY_QUIRK_IGNORE },
  { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM,
    USB_DEVICE_ID_ELECOM_BM084),
    HID_BATTERY_QUIRK_IGNORE },

