Return-Path: <cyrus@holtmann.org>
From: "Li, Steven" <yongli@qca.qualcomm.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth: Ath3k keeps same PID/VID after downloading the
 patch and radio table
Date: Mon, 27 Jun 2011 08:27:25 +0000
Message-ID: <73DDB75979F36A42B75F3E2B6EB2943401031018@nasanexd02c.na.qualcomm.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


The new Ath3k needs to download patch and radio table,
and it keeps same PID/VID even after downloading the patch and radio table.
This patch is to use the bcdDevice (Device Release Number) to judge whether the
chip has been patched or not. The init bcdDevice value of the chip is 0x0001,
this value increases after patch and radio table downloading.

Signed-off-by: Steven.Li <yongli@qca.qualcomm.com>
---
 drivers/bluetooth/ath3k.c |    3 +++
 drivers/bluetooth/btusb.c |    9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 6bacef3..7ae1098 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -375,6 +375,9 @@ static int ath3k_probe(struct usb_interface *intf,
 
 	/* load patch and sysconfig files for AR3012 */
 	if (id->driver_info & BTUSB_ATH3012) {
+		if(le16_to_cpu(udev->descriptor.bcdDevice) > 0x0001)
+			return -ENODEV;
+
 		ret = ath3k_load_patch(udev);
 		if (ret < 0) {
 			BT_ERR("Loading patch file failed");
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c2de895..9d01e25 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -54,6 +54,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_BCM92035		0x10
 #define BTUSB_BROKEN_ISOC	0x20
 #define BTUSB_WRONG_SCO_MTU	0x40
+#define BTUSB_ATH3012		0x80
 
 static struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -110,7 +111,7 @@ static struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x03f0, 0x311d), .driver_info = BTUSB_IGNORE },
 
 	/* Atheros 3012 with sflash firmware */
-	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_IGNORE },
+	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
 
 	/* Atheros AR5BBU12 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xe02c), .driver_info = BTUSB_IGNORE },
@@ -914,6 +915,12 @@ static int btusb_probe(struct usb_interface *intf,
 	if (ignore_sniffer && id->driver_info & BTUSB_SNIFFER)
 		return -ENODEV;
 
+	if (id->driver_info & BTUSB_ATH3012) {
+		struct usb_device *udev = interface_to_usbdev(intf);
+		if(le16_to_cpu(udev->descriptor.bcdDevice) <= 0x0001)
+			return -ENODEV;
+	}
+
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
-- 
1.7.1
