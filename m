Return-Path: <larry.finger@gmail.com>
Sender: Larry Finger <larry.finger@gmail.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH] Bluetooth: btusb: Fix device recognition problems for certain Realtek units
Date: Fri, 13 Nov 2015 08:36:02 -0600
Message-Id: <1447425362-13417-1-git-send-email-Larry.Finger@lwfinger.net>
List-ID: <linux-bluetooth.vger.kernel.org>

A few Realtek devices such as RTL8723AU and RTL8723BU have a single USB
ID shared between the wifi and Bluetooth parts. With the current ID table
structure, the Bluetooth part is not found during the device probe.

The fix is to move the USB_VENDOR_AND_INTERFACE_INFO macro for vendor 0x0bda
from the usb_device_id blacklist_table[] to usb_device_id btusb_table[].

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/bluetooth/btusb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 92f0ee3..17233ea 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -157,6 +157,10 @@ static const struct usb_device_id btusb_table[] = {
 	{ USB_DEVICE(0x8087, 0x0a5a),
 	  .driver_info = BTUSB_INTEL_BOOT | BTUSB_BROKEN_ISOC },
 
+	/* Realtek Bluetooth devices */
+	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
+	  .driver_info = BTUSB_REALTEK },
+
 	{ }	/* Terminating entry */
 };
 
@@ -310,10 +314,6 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x8087, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_IGNORE },
 
-	/* Realtek Bluetooth devices */
-	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
-	  .driver_info = BTUSB_REALTEK },
-
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3394), .driver_info = BTUSB_REALTEK },
-- 
2.1.4
