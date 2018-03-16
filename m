Return-Path: <vicencb@gmail.com>
From: Vicente Bergas <vicencb@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Vicente Bergas <vicencb@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add USB ID 7392:a611 for Edimax EW-7611ULB
Date: Fri, 16 Mar 2018 22:45:37 +0100
Message-Id: <20180316214537.1540-1-vicencb@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This WiFi/Bluetooth USB dongle uses a Realtek chipset, so, use btrtl for it.

Product information:
https://wikidevi.com/wiki/Edimax_EW-7611ULB

Tested-by: Vicente Bergas <vicencb@gmail.com>
Signed-off-by: Vicente Bergas <vicencb@gmail.com>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 60bf04b8f103..c4baf4aed256 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -367,6 +367,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3459), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3494), .driver_info = BTUSB_REALTEK },
 
+	/* Additional Realtek 8723BU Bluetooth devices */
+	{ USB_DEVICE(0x7392, 0xa611), .driver_info = BTUSB_REALTEK },
+
 	/* Additional Realtek 8821AE Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3414), .driver_info = BTUSB_REALTEK },
-- 
2.16.2
