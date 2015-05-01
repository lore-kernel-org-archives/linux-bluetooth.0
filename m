Return-Path: <cyrus@holtmann.org>
From: volkov <info@dv2c.ru>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] add device for fixed 60901
Date: Fri, 01 May 2015 22:27:49 +0300
Message-ID: <1489102.I3KRxURPTr@it1765>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1829761.ZHRMGUJGUg"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.

--nextPart1829761.ZHRMGUJGUg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

That patch fix bug https://bugzilla.kernel.org/show_bug.cgi?id=60901 for my 
Roper Class 1 dongle

Signed-off-by: Aleksei Volkov <info@dv2c.ru>
--nextPart1829761.ZHRMGUJGUg
Content-Disposition: attachment; filename="PATCH_TO_KERNEL_BLUETOOTH"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="PATCH_TO_KERNEL_BLUETOOTH"

--- linux-4.0.0-gentoo/drivers/bluetooth/btusb.c.orig	2015-05-01 12:06:59.000000000 +0300
+++ linux-4.0.0-gentoo/drivers/bluetooth/btusb.c	2015-05-01 12:02:00.000000000 +0300
@@ -254,6 +254,7 @@ static const struct usb_device_id blackl
 
 	/* Roper Class 1 Bluetooth Dongle (Silicon Wave based) */
 	{ USB_DEVICE(0x1300, 0x0001), .driver_info = BTUSB_SWAVE },
+	{ USB_DEVICE(0x1310, 0x0001), .driver_info = BTUSB_SWAVE },
 
 	/* Digianswer devices */
 	{ USB_DEVICE(0x08fd, 0x0001), .driver_info = BTUSB_DIGIANSWER },

--nextPart1829761.ZHRMGUJGUg--

