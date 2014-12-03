Return-Path: <cyrus@holtmann.org>
From: Wen-chien Jesse Sung <jesse.sung@canonical.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] Bluetooth: Add BTUSB_BCM_PATCHRAM to Broadcom 413c:8197
Date: Wed,  3 Dec 2014 14:45:42 +0800
Message-Id: <1417589145-30467-3-git-send-email-jesse.sung@canonical.com>
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


This device needs an external firmware to make HSP and HFP work.

Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
---
 drivers/bluetooth/btusb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


--------------2.1.0
Content-Type: text/x-patch; name="0003-Bluetooth-Add-BTUSB_BCM_PATCHRAM-to-Broadcom-413c-81.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="0003-Bluetooth-Add-BTUSB_BCM_PATCHRAM-to-Broadcom-413c-81.patch"

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5b8e029..c92f59f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -105,7 +105,8 @@ static const struct usb_device_id btusb_table[] = {
 	{ USB_DEVICE(0x04ca, 0x2003) },
 	{ USB_DEVICE(0x0b05, 0x17b5) },
 	{ USB_DEVICE(0x0b05, 0x17cb) },
-	{ USB_DEVICE(0x413c, 0x8197) },
+	{ USB_DEVICE(0x413c, 0x8197),
+	  .driver_info = BTUSB_BCM_PATCHRAM },
 
 	/* Foxconn - Hon Hai */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),

--------------2.1.0--


