Return-Path: <cyrus@holtmann.org>
From: "Henrik Rydberg" <rydberg@euromail.se>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Henrik Rydberg <rydberg@euromail.se>
Subject: [PATCH] Bluetooth: Add support for Apple vendor-specific devices
Date: Sat, 25 Aug 2012 19:28:06 +0200
Message-Id: <1345915686-3915-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As pointed out by Gustavo and Marcel, all Apple-specific Broadcom
devices seen so far have the same interface class, subclass and
protocol numbers. This patch adds an entry which matches all of them,
using the new USB_VENDOR_AND_INTERFACE_INFO() macro.

In particular, this patch adds support for the MacBook Pro Retina
(05ac:8286), which is not in the present list.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
Hi Gustavo,

here is a patch for the Apple devices, utilizing commit d81a5d19, for
3.6. Tested on the MacBookPro10,1 (Retina). If you want, I can
follow-up with a patch for 3.7 which removes the specific entries. I
have verified the lsusb output of all of them, except MacMini5,1.

Thanks,
Henrik

 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 12075ad..1fae607 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -52,6 +52,9 @@ static struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
 	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
 
+	/* Apple-specific (Broadcom) devices */
+	{ USB_VENDOR_AND_INTERFACE_INFO(0x05ac, 0xff, 0x01, 0x01) },
+
 	/* Broadcom SoftSailing reporting vendor specific */
 	{ USB_DEVICE(0x0a5c, 0x21e1) },
 
-- 
1.7.12

