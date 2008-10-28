Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Allow SCO with Asus WL-BTD202 dongle in btusb
From: Guillaume Bedot <littletux@zarb.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-s0m0U0EqbmniVN1SD14g"
Date: Tue, 28 Oct 2008 01:00:42 +0100
Message-Id: <1225152042.17240.18.camel@localhost>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-s0m0U0EqbmniVN1SD14g
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello again,

This an other patch that allows my dongle to be configured correctly for
the voice/sco profile.

I already sent one for hci_usb some time ago, so it may sound familiar,
but it probably didn't have correct style...

Regards,

Guillaume B.

PS:
The HT-820 combo headset can now quite reliably use alternatively voice
and hi-fi profiles (and the keys).
This sometimes makes pulseaudio crash though.
Anyway, thanks for your hard work.


--=-s0m0U0EqbmniVN1SD14g
Content-Disposition: attachment; filename="btusb-wl-btd202.patch"
Content-Type: text/x-patch; name="btusb-wl-btd202.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This patch allows the 0b05:1715 Asus WL-BTD202 dongle to be used with a SCO 
headset with having to specify "options btusb force_scofix=1".

Signed-off-by: Guillaume Bedot <littletux@zarb.org>
--- kernel-linus-2.6.28-0.rc1.1.1mdv.orig/drivers/bluetooth/btusb.c	2008-10-27 17:38:14.000000000 +0100
+++ kernel-linus-2.6.28-0.rc1.1.1mdv/drivers/bluetooth/btusb.c	2008-10-27 17:43:34.000000000 +0100
@@ -109,6 +109,9 @@
 	/* Apple MacBook Pro with Broadcom chip */
 	{ USB_DEVICE(0x05ac, 0x820f), .driver_info = BTUSB_RESET },
 
+	/* Asus dongle with Broadcom 2045 chip */
+	{ USB_DEVICE(0x0b05, 0x1715), .driver_info = BTUSB_WRONG_SCO_MTU },
+
 	/* IBM/Lenovo ThinkPad with Broadcom chip */
 	{ USB_DEVICE(0x0a5c, 0x201e), .driver_info = BTUSB_RESET | BTUSB_WRONG_SCO_MTU },
 	{ USB_DEVICE(0x0a5c, 0x2110), .driver_info = BTUSB_RESET | BTUSB_WRONG_SCO_MTU },

--=-s0m0U0EqbmniVN1SD14g--

