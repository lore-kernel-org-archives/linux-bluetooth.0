Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Missing support in btusb for broadcom dongle 0a5c:2009
From: Guillaume Bedot <littletux@zarb.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1225130694.7157.12.camel@californication>
References: <1225123432.15672.6.camel@localhost>
	 <1225130694.7157.12.camel@californication>
Content-Type: multipart/mixed; boundary="=-otmxFtwDsMlqiCUvD89c"
Date: Mon, 27 Oct 2008 19:33:38 +0100
Message-Id: <1225132418.29183.7.camel@localhost>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-otmxFtwDsMlqiCUvD89c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Le lundi 27 octobre 2008 à 19:04 +0100, Marcel Holtmann a écrit :
> Hi Guillaume,
> 
> > It seems this particular dongle needs a quirk that existed in hci_usb,
> > but doesn't in btusb.
> > 
> > Is it possible to send some command to use this dongle (as hciconfig
> > reset can replace the reset quirk) ?
> > 
> > Or should the quirk be introduced in btusb too ?
> 
> you can load btusb with reset=1 and that does the same trick, but the
> quirk should be added to btusb directly. Send in the lsusb output and
> content of /proc/bus/usb/devices for your dongle.

Sorry I was not clear enough...

It's a different init quirk that concern only that dongle at the moment.
With this patch it should be clearer.

Regards,

Guillaume B.

--=-otmxFtwDsMlqiCUvD89c
Content-Disposition: attachment; filename="btusb-bcm92035.patch"
Content-Type: text/x-patch; name="btusb-bcm92035.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This patch should allow the 0a5c:2009 broadcom dongle to work with btusb.

See this Mandriva bug for more information:
http://qa.mandriva.com/show_bug.cgi?id=44886

(and soon, for results of Jan tests especially)

Signed-off-by: Guillaume Bedot <littletux@zarb.org>
--- kernel-linus-2.6.28-0.rc1.1.1mdv.orig/drivers/bluetooth/btusb.c	2008-10-27 17:36:17.000000000 +0100
+++ kernel-linus-2.6.28-0.rc1.1.1mdv/drivers/bluetooth/btusb.c	2008-10-27 17:37:11.000000000 +0100
@@ -96,6 +96,7 @@
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x2035), .driver_info = BTUSB_RESET | BTUSB_WRONG_SCO_MTU },
 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = BTUSB_RESET | BTUSB_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
 
 	/* Broadcom BCM2045 */
 	{ USB_DEVICE(0x0a5c, 0x2039), .driver_info = BTUSB_RESET | BTUSB_WRONG_SCO_MTU },

--=-otmxFtwDsMlqiCUvD89c--

