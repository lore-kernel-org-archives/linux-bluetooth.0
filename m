Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: btusb: Ignore unknown Intel devices with generic descriptor
Date: Wed, 28 Jan 2015 19:41:43 -0800
Message-Id: <1422502903-12203-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Intel Bluetooth devices use the generic USB device/interface class
descriptors that are assigned to Bluetooth H:2 conforming transports.

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12   MxCh= 0
D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1

However newer chips have a bootloader stage and require firmware to
be loaded before they are functional. To avoid any confusion for the
users, just ignore unknown Intel Bluetooth devices.

All the released Intel Bluetooth devices have an entry in the device
table identifying their setup and support requirements. The advantage
here is that older kernel can be booted with newer devices without
causing any disturbance.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4f5b93568ecc..9d2d059a7540 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -263,11 +263,14 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x1286, 0x2044), .driver_info = BTUSB_MARVELL },
 	{ USB_DEVICE(0x1286, 0x2046), .driver_info = BTUSB_MARVELL },
 
-	/* Intel Bluetooth device */
+	/* Intel Bluetooth devices */
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL },
 	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_NEW },
 
+	/* Other Intel Bluetooth devices */
+	{ USB_VENDOR_AND_INTERFACE_INFO(0x8087, 0xe0, 0x01, 0x01),
+	  .driver_info = BTUSB_IGNORE },
 
 	{ }	/* Terminating entry */
 };
-- 
2.1.0

