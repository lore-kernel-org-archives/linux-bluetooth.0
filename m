Return-Path: <cyrus@holtmann.org>
From: "Yao, Costa" <cqyao@qca.qualcomm.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "padovan@profusion.mobi"
	<padovan@profusion.mobi>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth: btusb: Add Qualcomm Atheros AR3006 in
 blacklist_table
Date: Wed, 16 Nov 2011 11:09:12 +0000
Message-ID: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF3A49@nasanexd02b.na.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Add Qualcomm Atheros AR3006 entry in blacklist_table in btusb.c for bcdDevi=
ce check.

Signed-off-by: Costa Yao <cqyao@qca.qualcomm.com>
---
 drivers/bluetooth/btusb.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 39dd65c..94124ad 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -55,6 +55,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_BROKEN_ISOC	0x20
 #define BTUSB_WRONG_SCO_MTU	0x40
 #define BTUSB_ATH3012		0x80
+#define BTUSB_ATH3006		0x0100
=20
 static struct usb_device_id btusb_table[] =3D {
 	/* Bluetooth USB interface */
@@ -125,6 +126,7 @@ static struct usb_device_id blacklist_table[] =3D {
=20
 	/* Atheros 3012 with sflash firmware */
 	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info =3D BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0cf3, 0x3006), .driver_info =3D BTUSB_ATH3006 },
=20
 	/* Atheros AR5BBU12 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xe02c), .driver_info =3D BTUSB_IGNORE },
@@ -937,7 +939,8 @@ static int btusb_probe(struct usb_interface *intf,
 	if (ignore_sniffer && id->driver_info & BTUSB_SNIFFER)
 		return -ENODEV;
=20
-	if (id->driver_info & BTUSB_ATH3012) {
+	if ((id->driver_info & BTUSB_ATH3012) ||
+				(id->driver_info & BTUSB_ATH3006)) {
 		struct usb_device *udev =3D interface_to_usbdev(intf);
=20
 		/* Old firmware would otherwise let ath3k driver load
--=20
1.7.4.1
