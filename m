Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix issue with Roper Class 1 Bluetooth Dongle
Date: Thu,  1 Jan 2015 17:34:37 -0800
Message-Id: <1420162477-2669-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Roper Class 1 Bluetooth Dongle is another device that claims to
support Bluetooth 1.2 specification, but does not support the HCI
command for reading the local supported commands.

  < HCI Command: Read Local Version Information (0x04|0x0001) plen 0
  > HCI Event: Command Complete (0x0e) plen 12
      Read Local Version Information (0x04|0x0001) ncmd 1
      status 0x00
      HCI Version: 1.2 (0x2) HCI Revision: 0x0
      LMP Version: 1.2 (0x2) LMP Subversion: 0x757
      Manufacturer: Silicon Wave (11)

It clearly claims Bluetooth 1.2 support and in that regard has the
same issue as the AVM BlueFritz! USB devices (Silicon Wave based),
but the HCI Read Local Supported Commands command fails.

  < HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0
  > HCI Event: Command Status (0x0f) plen 4
      Read Local Supported Commands (0x04|0x0002) status 0x01 ncmd 1
      Error: Unknown HCI Command

Use the HCI_QUIRK_BROKEN_LOCAL_COMMANDS quirk for these devices and
the failing command will be skipped.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f051a93c6cad..833881392ce1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -49,7 +49,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_INTEL_BOOT	0x200
 #define BTUSB_BCM_PATCHRAM	0x400
 #define BTUSB_MARVELL		0x800
-#define BTUSB_AVM		0x1000
+#define BTUSB_SWAVE		0x1000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -86,7 +86,7 @@ static const struct usb_device_id btusb_table[] = {
 	{ USB_DEVICE(0x05ac, 0x8281) },
 
 	/* AVM BlueFRITZ! USB v2.0 */
-	{ USB_DEVICE(0x057c, 0x3800), .driver_info = BTUSB_AVM },
+	{ USB_DEVICE(0x057c, 0x3800), .driver_info = BTUSB_SWAVE },
 
 	/* Bluetooth Ultraport Module from IBM */
 	{ USB_DEVICE(0x04bf, 0x030a) },
@@ -238,6 +238,9 @@ static const struct usb_device_id blacklist_table[] = {
 	/* CONWISE Technology based adapters with buggy SCO support */
 	{ USB_DEVICE(0x0e5e, 0x6622), .driver_info = BTUSB_BROKEN_ISOC },
 
+	/* Roper Class 1 Bluetooth Dongle (Silicon Wave based) */
+	{ USB_DEVICE(0x1300, 0x0001), .driver_info = BTUSB_SWAVE },
+
 	/* Digianswer devices */
 	{ USB_DEVICE(0x08fd, 0x0001), .driver_info = BTUSB_DIGIANSWER },
 	{ USB_DEVICE(0x08fd, 0x0002), .driver_info = BTUSB_IGNORE },
@@ -2081,7 +2084,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_MARVELL)
 		hdev->set_bdaddr = btusb_set_bdaddr_marvell;
 
-	if (id->driver_info & BTUSB_AVM)
+	if (id->driver_info & BTUSB_SWAVE)
 		set_bit(HCI_QUIRK_BROKEN_LOCAL_COMMANDS, &hdev->quirks);
 
 	if (id->driver_info & BTUSB_INTEL_BOOT)
-- 
2.1.0

