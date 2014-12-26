Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: btusb: Set the HCI_QUIRK_BROKEN_LOCAL_COMMANDS quirk
Date: Fri, 26 Dec 2014 04:42:33 +0100
Message-Id: <1419565354-49553-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The AVM BlueFritz! 2.0 USB dongles do not support the HCI command for
reading the local supported commands. So set this quirk to let the
core know about it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c926835aec37..f051a93c6cad 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -49,6 +49,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_INTEL_BOOT	0x200
 #define BTUSB_BCM_PATCHRAM	0x400
 #define BTUSB_MARVELL		0x800
+#define BTUSB_AVM		0x1000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -85,7 +86,7 @@ static const struct usb_device_id btusb_table[] = {
 	{ USB_DEVICE(0x05ac, 0x8281) },
 
 	/* AVM BlueFRITZ! USB v2.0 */
-	{ USB_DEVICE(0x057c, 0x3800) },
+	{ USB_DEVICE(0x057c, 0x3800), .driver_info = BTUSB_AVM },
 
 	/* Bluetooth Ultraport Module from IBM */
 	{ USB_DEVICE(0x04bf, 0x030a) },
@@ -2080,6 +2081,9 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_MARVELL)
 		hdev->set_bdaddr = btusb_set_bdaddr_marvell;
 
+	if (id->driver_info & BTUSB_AVM)
+		set_bit(HCI_QUIRK_BROKEN_LOCAL_COMMANDS, &hdev->quirks);
+
 	if (id->driver_info & BTUSB_INTEL_BOOT)
 		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
 
-- 
2.1.0

