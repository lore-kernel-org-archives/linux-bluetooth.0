Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oneukum@suse.de>
To: Marcel Holtmann <marcel@holtmann.org>, padovan@profusion.mobi,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] btusb: add device entry for Broadcom SoftSailing
Date: Wed, 21 Sep 2011 11:41:45 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201109211141.45978.oneukum@suse.de>
List-ID: <linux-bluetooth.vger.kernel.org>

=46rom 0cea73465cd22373c5cd43a3edd25fbd4bb532ef Mon Sep 17 00:00:00 2001
=46rom: Oliver Neukum <oliver@neukum.org>
Date: Wed, 21 Sep 2011 11:37:15 +0200
Subject: [PATCH] btusb: add device entry for Broadcom SoftSailing

This device declares itself to be vendor specific
It therefore needs to be added to the device table
to make btusb bind.

Signed-off-by: Oliver Neukum <oneukum@suse.de>
=2D--
 drivers/bluetooth/btusb.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3ef4760..ae71d34 100644
=2D-- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -60,6 +60,9 @@ static struct usb_device_id btusb_table[] =3D {
 	/* Generic Bluetooth USB device */
 	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
=20
+	/* Broadcom SoftSailing reporting vendor specific */
+	{ USB_DEVICE(0x05ac, 0x21e1) },
+
 	/* Apple MacBookPro 7,1 */
 	{ USB_DEVICE(0x05ac, 0x8213) },
=20
=2D-=20
1.7.1
