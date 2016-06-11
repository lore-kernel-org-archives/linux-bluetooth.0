Return-Path: <SRS0=tFU8=SD=m4x.org=yvain.thonnart@bounces.m4x.org>
From: Yvain THONNART <yvain.thonnart@m4x.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Yvain THONNART <yvain.thonnart@m4x.org>
Subject: [PATCH] bluetooth: add support for device 0489:e092
Date: Sat, 11 Jun 2016 15:43:30 +0200
Message-Id: <1465652610-1293-1-git-send-email-yvain.thonnart@m4x.org>
List-ID: <linux-bluetooth.vger.kernel.org>

With current btusb.ko kernel module, Bluetooth pretends to be active
but there is no real activity.

I'm using an Acer Aspire VN7-791.

Output of lsusb:
Bus 003 Device 007: ID 0489:e092 Foxconn / Hon Hai

On my laptop, this device is actually used as a combo with wifi chipset
Atheros Qualcomm Killer N1525 Wireless-AC [168c:003e],

* Fix by adding a declaration in kernel sources drivers/bluetooth/btusb.c

        { USB_DEVICE(0x0489, 0xe092), .driver_info = BTUSB_QCA_ROME },

* Compiled extra module /lib/modules/4.4.0-22-generic/extra/btusb.ko

* Successfully tested against my phone (obex file transfer)

DistroRelease: Ubuntu 16.04
Package: linux-image-4.4.0-22-generic 4.4.0-22.40
ProcVersionSignature: Ubuntu 4.4.0-22.40-generic 4.4.8
Uname: Linux 4.4.0-22-generic x86_64
Signed-off-by: Yvain THONNART <yvain.thonnart@m4x.org>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a191e31..74b52bb 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -244,6 +244,7 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0cf3, 0xe007), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe300), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe360), .driver_info = BTUSB_QCA_ROME },
+	{ USB_DEVICE(0x0489, 0xe092), .driver_info = BTUSB_QCA_ROME },
 
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
-- 
2.7.4
