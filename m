Return-Path: <cyrus@holtmann.org>
From: Rick Dunn <rick@rickdunn.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rick Dunn <rick@rickdunn.com>
Subject: [PATCH] Add 0b05 17cf line for BCM4352 combo card sub chip section BCM20702A0
Date: Fri, 16 Jan 2015 17:15:18 -0500
Message-Id: <1421446518-6903-2-git-send-email-rick@rickdunn.com>
In-Reply-To: <1421446518-6903-1-git-send-email-rick@rickdunn.com>
References: <1421446518-6903-1-git-send-email-rick@rickdunn.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Rick Dunn <rick@rickdunn.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4a6495a..9c78e1b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -107,6 +107,8 @@ static const struct usb_device_id btusb_table[] = {
 	{ USB_DEVICE(0x0b05, 0x17b5) },
 	{ USB_DEVICE(0x0b05, 0x17cb) },
 	{ USB_DEVICE(0x413c, 0x8197) },
+	{ USB_DEVICE(0x0b05, 0x17cf),
+	 .driver_info = BTUSB_BCM_PATCHRAM },
 	{ USB_DEVICE(0x13d3, 0x3404),
 	  .driver_info = BTUSB_BCM_PATCHRAM },
 
-- 
1.9.1

