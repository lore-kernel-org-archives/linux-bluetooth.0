Return-Path: <cyrus@holtmann.org>
From: "Yao, Costa" <cqyao@qca.qualcomm.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "marcel@holtmann.org" <marcel@holtmann.org>,
	"padovan@profusion.mobi" <padovan@profusion.mobi>
Subject: [PATCH] Bluetooth: btusb: Use macro USB_INTERFACE_INFO to do device
 match
Date: Thu, 29 Dec 2011 06:59:34 +0000
Message-ID: <07BBB2AAB1A10A488A2AD166C7CB8B0DF1B28B@nasanexd02b.na.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From b77d709b9defc08a1348922d5001164a5598c654 Mon Sep 17 00:00:00 2001
From: Costa Yao <cqyao@qca.qualcomm.com>
Date: Thu, 29 Dec 2011 14:42:23 +0800
Subject: [PATCH] Bluetooth: btusb: Use macro USB_INTERFACE_INFO to do device match

1 Use USB_INTERFACE_INFO to do device match, other than USB_DEVICE_INFO.
2 Delete desc.bInterfaceNumber != 0 check.

Signed-off-by: Costa Yao <cqyao@qca.qualcomm.com>
---
 drivers/bluetooth/btusb.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index fbfba80..9e56de0 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -57,8 +57,8 @@ static struct usb_driver btusb_driver;
 #define BTUSB_ATH3012		0x80
 
 static struct usb_device_id btusb_table[] = {
-	/* Generic Bluetooth USB device */
-	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
+	/* Bluetooth USB interface */
+	{ USB_INTERFACE_INFO(0xe0, 0x01, 0x01) },
 
 	/* Broadcom SoftSailing reporting vendor specific */
 	{ USB_DEVICE(0x05ac, 0x21e1) },
@@ -913,10 +913,6 @@ static int btusb_probe(struct usb_interface *intf,
 
 	BT_DBG("intf %p id %p", intf, id);
 
-	/* interface numbers are hardcoded in the spec */
-	if (intf->cur_altsetting->desc.bInterfaceNumber != 0)
-		return -ENODEV;
-
 	if (!id->driver_info) {
 		const struct usb_device_id *match;
 		match = usb_match_id(intf, blacklist_table);
@@ -1012,8 +1008,12 @@ static int btusb_probe(struct usb_interface *intf,
 
 	hdev->owner = THIS_MODULE;
 
-	/* Interface numbers are hardcoded in the specification */
-	data->isoc = usb_ifnum_to_if(data->udev, 1);
+	/* According to HCI-USB specification, the interface for
+	 * SCO data endpoints follows the interface for commands,
+	 * events and ACL data
+	 */
+	data->isoc = usb_ifnum_to_if(data->udev,
+		intf->cur_altsetting->desc.bInterfaceNumber + 1);
 
 	if (!reset)
 		set_bit(HCI_QUIRK_NO_RESET, &hdev->quirks);
-- 
1.7.4.1
