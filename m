Return-Path: <cyrus@holtmann.org>
From: Wen-chien Jesse Sung <jesse.sung@canonical.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] Bluetooth: Add BTUSB_BCM_PATCHRAM to Broadcom devices 13d3:*
Date: Wed,  3 Dec 2014 14:45:41 +0800
Message-Id: <1417589145-30467-2-git-send-email-jesse.sung@canonical.com>
In-Reply-To: <1417589145-30467-1-git-send-email-jesse.sung@canonical.com>
References: <1417589145-30467-1-git-send-email-jesse.sung@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.1.0"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------2.1.0
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


It is known that at least 13d3:3388, 13d3:3389, and 13d3:3404 require
external firmwares to work properly. Since the firmware loading
procedure is skipped if there's no firmware file provided, it is safe to
set BTUSB_BCM_PATCHRAM for 13d3:* instead of adding each module one by
one.

Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
---
 drivers/bluetooth/btusb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


--------------2.1.0
Content-Type: text/x-patch; name="0002-Bluetooth-Add-BTUSB_BCM_PATCHRAM-to-Broadcom-devices.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="0002-Bluetooth-Add-BTUSB_BCM_PATCHRAM-to-Broadcom-devices.patch"

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5c9eeda..5b8e029 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -122,7 +122,8 @@ static const struct usb_device_id btusb_table[] = {
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x050d, 0xff, 0x01, 0x01) },
 
 	/* IMC Networks - Broadcom based */
-	{ USB_VENDOR_AND_INTERFACE_INFO(0x13d3, 0xff, 0x01, 0x01) },
+	{ USB_VENDOR_AND_INTERFACE_INFO(0x13d3, 0xff, 0x01, 0x01),
+	  .driver_info = BTUSB_BCM_PATCHRAM },
 
 	/* Intel Bluetooth USB Bootloader (RAM module) */
 	{ USB_DEVICE(0x8087, 0x0a5a),

--------------2.1.0--


