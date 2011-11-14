Return-Path: <cyrus@holtmann.org>
From: "Yao, Costa" <cqyao@qca.qualcomm.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>,
	"padovan@profusion.mobi" <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth: btusb: Use USB_INTERFACE_INFO to do device
 matching
Date: Mon, 14 Nov 2011 06:34:50 +0000
Message-ID: <07BBB2AAB1A10A488A2AD166C7CB8B0DEEEF58@nasanexd02b.na.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


1 Use USB_INTERFACE_INFO to do device matching, other than USB_DEVICE_INFO.
2 And we try to find the first interface containing the interrupt endpoint.

Signed-off-by: Costa Yao <cqyao@qca.qualcomm.com>
---
 drivers/bluetooth/btusb.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9db2476..80d7e2d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -58,7 +58,7 @@ static struct usb_driver btusb_driver;
 
 static struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
-	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
+	{ USB_INTERFACE_INFO(0xe0, 0x01, 0x01) },
 
 	/* Broadcom SoftSailing reporting vendor specific */
 	{ USB_DEVICE(0x05ac, 0x21e1) },
@@ -915,9 +915,14 @@ static int btusb_probe(struct usb_interface *intf,
 
 	BT_DBG("intf %p id %p", intf, id);
 
-	/* interface numbers are hardcoded in the spec */
-	if (intf->cur_altsetting->desc.bInterfaceNumber != 0)
+	for (i = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
+		ep_desc = &intf->cur_altsetting->endpoint[i].desc;
+
+		if (usb_endpoint_is_int_in(ep_desc))
+			break;
+
 		return -ENODEV;
+	}
 
 	if (!id->driver_info) {
 		const struct usb_device_id *match;
@@ -1014,8 +1019,9 @@ static int btusb_probe(struct usb_interface *intf,
 
 	hdev->owner = THIS_MODULE;
 
-	/* Interface numbers are hardcoded in the specification */
-	data->isoc = usb_ifnum_to_if(data->udev, 1);
+
+	data->isoc = usb_ifnum_to_if(data->udev,
+		1+intf->cur_altsetting->desc.bInterfaceNumber);
 
 	if (!reset)
 		set_bit(HCI_QUIRK_NO_RESET, &hdev->quirks);
-- 
1.7.4.1
