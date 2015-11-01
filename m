Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Cl=C3=A9ment_de_l=27Hamaide?=
	<clement.delhamaide@gmail.com>
Date: Sun, 1 Nov 2015 01:55:02 +0100
Message-ID: <CAG4Y7escv=GDSCJ2=3+L21Fc=O+oEzGGJ_h77W2-2Vkykys=Nw@mail.gmail.com>
Subject: Re: ath3k Bluetooth adapter not loading: [0cf3:3004] Atheros
 Communications, Inc. AR3012 Bluetooth 4.0
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This is my first mail in this list, I've subscribed this list
because I own a MSI GS60 laptop with QCA6174 chipset (Wifi+Bluetooth)
where Bluetooth doesn't work.

I am in the very same bug than the one reported by Sumit (same dmesg report)
and it's now solved by applying the following patch:


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


After a fresh kernel compilation and reboot, my Bluetooth [0cf3:3004]
is now working as expected.

I hope my feedback will help the bluetooth community to commit this patch.

Regards,
Clément
