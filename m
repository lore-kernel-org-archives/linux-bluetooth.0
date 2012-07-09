Return-Path: <cyrus@holtmann.org>
From: "Henrik Rydberg" <rydberg@bitmath.se>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Henrik Rydberg <rydberg@euromail.se>
Subject: [PATCH] Bluetooth: Add MacBookPro10,1 support
Date: Mon,  9 Jul 2012 19:52:27 +0200
Message-Id: <1341856347-257-1-git-send-email-rydberg@euromail.se>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for the 2012 15'' MacBook Pro Retina.

Patch originally written by clipcarl (forums.opensuse.org).

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
Hi Gustavo,

This patch adds support for the new retina. Picked up from the suse
forum. Getting it into 3.5 would be great, if possible.

Cheers,
Henrik

 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 83ebb24..6cc54da 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -84,6 +84,9 @@ static struct usb_device_id btusb_table[] = {
 	/* Apple MacMini5,1 */
 	{ USB_DEVICE(0x05ac, 0x8281) },
 
+	/* Apple MacBookPro10,1 */
+	{ USB_DEVICE(0x05ac, 0x8286) },
+
 	/* AVM BlueFRITZ! USB v2.0 */
 	{ USB_DEVICE(0x057c, 0x3800) },
 
-- 
1.7.11.1

