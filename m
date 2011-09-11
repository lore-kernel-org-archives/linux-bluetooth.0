Return-Path: <cyrus@holtmann.org>
Subject: [PATCH][resend] Add MacMini5,1 support
From: Jurgen Kramer <gtmkramer@xs4all.nl>
To: linux-bluetooth@vger.kernel.org
Date: Sun, 11 Sep 2011 13:12:59 +0200
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315739582.4448.1.camel@paragon.slim>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'll resend my patch to add MacMini5,1 support. The one I sent a week
ago was not picked up.

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3ef4760..cbecc6e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -75,6 +75,9 @@ static struct usb_device_id btusb_table[] = {
 	/* Apple MacBookPro8,2 */
 	{ USB_DEVICE(0x05ac, 0x821a) },
 
+	{* Apple MacMini5,1 */
+	{ USB_DEVICE(0x05ac, 0x8281) },
+
 	/* AVM BlueFRITZ! USB v2.0 */
 	{ USB_DEVICE(0x057c, 0x3800) },
 

Please apply.

Thanks,
Jurgen

