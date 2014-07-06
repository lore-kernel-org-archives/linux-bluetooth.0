Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Ignore isochronous endpoints for Intel USB bootloader
Date: Sun,  6 Jul 2014 14:53:55 +0200
Message-Id: <1404651235-51172-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The isochronous endpoints are not valid when the Intel Bluetooth
controller boots up in bootloader mode. So just mark these endpoints
as broken and then they will not be configured.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index fe24f600ed65..b7d0fed3417f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -120,7 +120,8 @@ static const struct usb_device_id btusb_table[] = {
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x13d3, 0xff, 0x01, 0x01) },
 
 	/* Intel Bluetooth USB Bootloader (RAM module) */
-	{ USB_DEVICE(0x8087, 0x0a5a), .driver_info = BTUSB_INTEL_BOOT },
+	{ USB_DEVICE(0x8087, 0x0a5a),
+	  .driver_info = BTUSB_INTEL_BOOT | BTUSB_BROKEN_ISOC },
 
 	{ }	/* Terminating entry */
 };
-- 
1.9.3

