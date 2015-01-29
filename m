Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add support for USB based AMP controllers
Date: Wed, 28 Jan 2015 20:27:34 -0800
Message-Id: <1422505654-28931-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth HCI transport specification for USB device defines on how
a standard AMP controller is identified and operated. This patch adds
the needed handling to hook it up to the Bluetooth stack.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9d2d059a7540..d114786490b1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -51,11 +51,15 @@ static struct usb_driver btusb_driver;
 #define BTUSB_MARVELL		0x800
 #define BTUSB_SWAVE		0x1000
 #define BTUSB_INTEL_NEW		0x2000
+#define BTUSB_AMP		0x4000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
 	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
 
+	/* Generic Bluetooth AMP device */
+	{ USB_DEVICE_INFO(0xe0, 0x01, 0x04), .driver_info = BTUSB_AMP },
+
 	/* Apple-specific (Broadcom) devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x05ac, 0xff, 0x01, 0x01) },
 
@@ -320,6 +324,7 @@ struct btusb_data {
 	struct usb_endpoint_descriptor *isoc_rx_ep;
 
 	__u8 cmdreq_type;
+	__u8 cmdreq;
 
 	unsigned int sco_num;
 	int isoc_altsetting;
@@ -973,7 +978,7 @@ static struct urb *alloc_ctrl_urb(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	dr->bRequestType = data->cmdreq_type;
-	dr->bRequest     = 0;
+	dr->bRequest     = data->cmdreq;
 	dr->wIndex       = 0;
 	dr->wValue       = 0;
 	dr->wLength      = __cpu_to_le16(skb->len);
@@ -2640,7 +2645,13 @@ static int btusb_probe(struct usb_interface *intf,
 	if (!data->intr_ep || !data->bulk_tx_ep || !data->bulk_rx_ep)
 		return -ENODEV;
 
-	data->cmdreq_type = USB_TYPE_CLASS;
+	if (id->driver_info & BTUSB_AMP) {
+		data->cmdreq_type = USB_TYPE_CLASS | 0x01;
+		data->cmdreq = 0x2b;
+	} else {
+		data->cmdreq_type = USB_TYPE_CLASS;
+		data->cmdreq = 0x00;
+	}
 
 	data->udev = interface_to_usbdev(intf);
 	data->intf = intf;
@@ -2672,6 +2683,11 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->bus = HCI_USB;
 	hci_set_drvdata(hdev, data);
 
+	if (id->driver_info & BTUSB_AMP)
+		hdev->dev_type = HCI_AMP;
+	else
+		hdev->dev_type = HCI_BREDR;
+
 	data->hdev = hdev;
 
 	SET_HCIDEV_DEV(hdev, &intf->dev);
@@ -2718,8 +2734,13 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_ATH3012)
 		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
 
-	/* Interface numbers are hardcoded in the specification */
-	data->isoc = usb_ifnum_to_if(data->udev, 1);
+	if (id->driver_info & BTUSB_AMP) {
+		/* AMP controllers do not support SCO packets */
+		data->isoc = NULL;
+	} else {
+		/* Interface numbers are hardcoded in the specification */
+		data->isoc = usb_ifnum_to_if(data->udev, 1);
+	}
 
 	if (!reset)
 		set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
-- 
2.1.0

