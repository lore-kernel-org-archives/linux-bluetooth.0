Return-Path: <cyrus@holtmann.org>
Message-ID: <BLU436-SMTP271CCFFC79A0620E44589B9EA10@phx.gbl>
From: Xi Ruoyao <xry111@outlook.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Larry Finger <Larry.Finger@lwfinger.net>
CC: Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xi Ruoyao <xry111@outlook.com>
Subject: [PATCH] Bluetooth: btusb: Modify entry to support misc devices with BT interface
Date: Mon, 22 Jun 2015 23:28:49 +0800
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

In the USB device table in btusb driver, the code specify a generic Bluetooth
device by matching Device Descriptor. However, some devices with BT interface
are classified as "Miscellaneous Device" and have different Device Descriptor,
such as Realtek RTL8723AU. Then btusb wouldn't probe them.

To resolve this, specify generic Bluetooth device in the USB device table by
matching Interface Descriptor, to probe all devices with Bluetooth interface
including these "Miscellaneous" ones.

Signed-off-by: Xi Ruoyao <xry111@outlook.com>
---
 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3c10d4d..beb6b23 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -62,7 +62,7 @@ static struct usb_driver btusb_driver;
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
-	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
+	{ USB_INTERFACE_INFO(0xe0, 0x01, 0x01) },
 
 	/* Generic Bluetooth AMP device */
 	{ USB_DEVICE_INFO(0xe0, 0x01, 0x04), .driver_info = BTUSB_AMP },
-- 
1.9.1
