Return-Path: <cyrus@holtmann.org>
From: Takashi Iwai <tiwai@suse.de>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: [PATCH] Bluetooth: Add support for yet another BCM20702A0 variant (0489:e031)
Date: Wed,  7 Jan 2015 21:50:34 +0100
Message-Id: <1420663834-16333-1-git-send-email-tiwai@suse.de>
List-ID: <linux-bluetooth.vger.kernel.org>

0489:e031 needs BTUSB_BCM_PATCHRAM, too.

Bugzilla: https://bugzilla.opensuse.org/show_bug.cgi?id=911311
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 19cf2cf22e87..a6f8182e6d3a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -108,6 +108,8 @@ static const struct usb_device_id btusb_table[] = {
 	{ USB_DEVICE(0x413c, 0x8197) },
 	{ USB_DEVICE(0x13d3, 0x3404),
 	  .driver_info = BTUSB_BCM_PATCHRAM },
+	{ USB_DEVICE(0x13d3, 0xe031),
+	  .driver_info = BTUSB_BCM_PATCHRAM },
 
 	/* Foxconn - Hon Hai */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
-- 
2.2.1
