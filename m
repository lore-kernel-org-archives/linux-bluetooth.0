Return-Path: <cyrus@holtmann.org>
From: Wen-chien Jesse Sung <jesse.sung@canonical.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] Bluetooth: Add BTUSB_BCM_PATCHRAM flag for Broadcom devices 0489:*
Date: Wed,  3 Dec 2014 14:45:40 +0800
Message-Id: <1417589145-30467-1-git-send-email-jesse.sung@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.1.0"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------2.1.0
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Most modules of this BCM20702A0 variant are known to require external
firmware to work properly.

Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
---
 drivers/bluetooth/btusb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


--------------2.1.0
Content-Type: text/x-patch; name="0001-Bluetooth-Add-BTUSB_BCM_PATCHRAM-flag-for-Broadcom-d.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="0001-Bluetooth-Add-BTUSB_BCM_PATCHRAM-flag-for-Broadcom-d.patch"

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 292c38e..5c9eeda 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -108,7 +108,8 @@ static const struct usb_device_id btusb_table[] = {
 	{ USB_DEVICE(0x413c, 0x8197) },
 
 	/* Foxconn - Hon Hai */
-	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01) },
+	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
+	  .driver_info = BTUSB_BCM_PATCHRAM },
 
 	/* Broadcom devices with vendor specific id */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01),

--------------2.1.0--


