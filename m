Return-Path: <cyrus@holtmann.org>
From: "Yao, Costa" <cqyao@qca.qualcomm.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>,
	"padovan@profusion.mobi" <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth: btusb: Add AR3006 in blacklist_table
Date: Tue, 22 Nov 2011 02:49:50 +0000
Message-ID: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF417E@nasanexd02b.na.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From c21eede5fafd811fdf6c100693a07a64f621ddea Mon Sep 17 00:00:00 2001
From: Costa Yao <cqyao@qca.qualcomm.com>
Date: Fri, 18 Nov 2011 14:08:56 +0800
Subject: [PATCH] Bluetooth: btusb: Add AR3006 in blacklist_table.

Add AR3006 entry in blacklist_table in btusb.c for bcdDevice check.
Then ath3k.c has the chance to download firmware and reset hardware.

Signed-off-by: Costa Yao <cqyao@qca.qualcomm.com>
---
 drivers/bluetooth/btusb.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 39dd65c..4ba4fdf 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -54,7 +54,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_BCM92035		0x10
 #define BTUSB_BROKEN_ISOC	0x20
 #define BTUSB_WRONG_SCO_MTU	0x40
-#define BTUSB_ATH3012		0x80
+#define BTUSB_ATH3K			0x80
 
 static struct usb_device_id btusb_table[] = {
 	/* Bluetooth USB interface */
@@ -124,7 +124,8 @@ static struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x03f0, 0x311d), .driver_info = BTUSB_IGNORE },
 
 	/* Atheros 3012 with sflash firmware */
-	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3K },
+	{ USB_DEVICE(0x0cf3, 0x3006), .driver_info = BTUSB_ATH3K },
 
 	/* Atheros AR5BBU12 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xe02c), .driver_info = BTUSB_IGNORE },
@@ -937,7 +938,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (ignore_sniffer && id->driver_info & BTUSB_SNIFFER)
 		return -ENODEV;
 
-	if (id->driver_info & BTUSB_ATH3012) {
+	if (id->driver_info & BTUSB_ATH3K) {
 		struct usb_device *udev = interface_to_usbdev(intf);
 
 		/* Old firmware would otherwise let ath3k driver load
-- 
1.7.4.1
