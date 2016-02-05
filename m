Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Cl=C3=A9ment_de_l=27Hamaide?=
	<clement.delhamaide@gmail.com>
Date: Fri, 5 Feb 2016 13:12:40 +0100
Message-ID: <CAG4Y7ev8wYnKyrTp-3QAP7O17ypAU9PYBD_QJdcR-8bPLZ=xCw@mail.gmail.com>
Subject: [PATCH] 0cf3:3004 Atheros Communications, Inc. AR3012 Bluetooth 4.0
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Some months ago I posted a patch.
I can see some people around internet reporting 0cf3:3004 not working
then I realized that my patch have not been reviewed/commited.

My bluetooth is working well since end of October with my patch.
I'm sure Linux users who have this hardware would be thanksful if my
patch is reviewed and commited.


diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b6aceaf..884dbe5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -199,7 +199,6 @@ static const struct usb_device_id blacklist_table[] = {
        { USB_DEVICE(0x0930, 0x0227), .driver_info = BTUSB_ATH3012 },
        { USB_DEVICE(0x0b05, 0x17d0), .driver_info = BTUSB_ATH3012 },
        { USB_DEVICE(0x0cf3, 0x0036), .driver_info = BTUSB_ATH3012 },
-       { USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
        { USB_DEVICE(0x0cf3, 0x3008), .driver_info = BTUSB_ATH3012 },
        { USB_DEVICE(0x0cf3, 0x311d), .driver_info = BTUSB_ATH3012 },
        { USB_DEVICE(0x0cf3, 0x311e), .driver_info = BTUSB_ATH3012 },
@@ -230,6 +229,7 @@ static const struct usb_device_id blacklist_table[] = {
        { USB_DEVICE(0x0cf3, 0xe007), .driver_info = BTUSB_QCA_ROME },
        { USB_DEVICE(0x0cf3, 0xe300), .driver_info = BTUSB_QCA_ROME },
        { USB_DEVICE(0x0cf3, 0xe360), .driver_info = BTUSB_QCA_ROME },
+       { USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_QCA_ROME },

        /* Broadcom BCM2035 */
        { USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },



Regards,
Clément
