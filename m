Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: btusb: Set reset quirk for A-Link and Medialink devices
Date: Thu,  9 Aug 2012 18:03:32 +0300
Message-Id: <1344524613-15810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Broadcom devices A-LINK (0a5c:2148) and Medialink (0a5c:2198) works more stable
when setting HCI_QUIRK_RESET_ON_CLOSE. Without this patch they do not always
come up after reset and down.
---
 drivers/bluetooth/btusb.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f637c25..57ca6fd 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -47,6 +47,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_BROKEN_ISOC	0x20
 #define BTUSB_WRONG_SCO_MTU	0x40
 #define BTUSB_ATH3012		0x80
+#define BTUSB_BCM_RESET_QUIRK	0x100
 
 static struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -149,6 +150,10 @@ static struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0a5c, 0x2039), .driver_info = BTUSB_WRONG_SCO_MTU },
 	{ USB_DEVICE(0x0a5c, 0x2101), .driver_info = BTUSB_WRONG_SCO_MTU },
 
+	/* Broadcom chips works better with reset quirk */
+	{ USB_DEVICE(0x0a5c, 0x2148), .driver_info = BTUSB_BCM_RESET_QUIRK },
+	{ USB_DEVICE(0x0a5c, 0x2198), .driver_info = BTUSB_BCM_RESET_QUIRK },
+
 	/* IBM/Lenovo ThinkPad with Broadcom chip */
 	{ USB_DEVICE(0x0a5c, 0x201e), .driver_info = BTUSB_WRONG_SCO_MTU },
 	{ USB_DEVICE(0x0a5c, 0x2110), .driver_info = BTUSB_WRONG_SCO_MTU },
@@ -1023,6 +1028,9 @@ static int btusb_probe(struct usb_interface *intf,
 			set_bit(HCI_QUIRK_FIXUP_BUFFER_SIZE, &hdev->quirks);
 	}
 
+	if (id->driver_info & BTUSB_BCM_RESET_QUIRK)
+		set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
+
 	if (id->driver_info & BTUSB_BROKEN_ISOC)
 		data->isoc = NULL;
 
-- 
1.7.9.5

