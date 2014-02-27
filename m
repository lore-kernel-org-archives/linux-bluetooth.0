Return-Path: <cyrus@holtmann.org>
Message-ID: <530FC224.90305@gmail.com>
Date: Thu, 27 Feb 2014 23:54:28 +0100
From: Bela Hausmann <bela.hausmann@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetooth: ath3k: added Atheros AR3012 with ID 0x0b05:0x17d0
References: <530FB0CA.4070309@gmail.com> <613439C8-AFCE-4B23-81FE-AD4B91A27768@holtmann.org>
In-Reply-To: <613439C8-AFCE-4B23-81FE-AD4B91A27768@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

sorry for the messed up tabs.

Here is /sys/kernel/debug/usb/devices:
T:  Bus=02 Lev=02 Prnt=02 Port=03 Cnt=02 Dev#=  4 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0b05 ProdID=17d0 Rev= 0.02
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms

An again the patch.

Best wishes,
Bela


This adds support for the Atheros AR3012 chipset on the ASUS Z87-Pro (C2) mainboard (ID 0x0b05:0x17d0).

Signed-off-by: Bela Hausmann <bela.hausmann@gmail.com>
---
diff -uprN -X linux-3.13.5-gentoo/Documentation/dontdiff linux-3.13.5-gentoo/drivers/bluetooth/ath3k.c linux-3.13.5-gentoo-bela/drivers/bluetooth/ath3k.c
--- linux-3.13.5-gentoo/drivers/bluetooth/ath3k.c	2014-01-20 03:40:07.000000000 +0100
+++ linux-3.13.5-gentoo-bela/drivers/bluetooth/ath3k.c	2014-02-27 20:09:33.047878117 +0100
@@ -97,6 +97,7 @@ static const struct usb_device_id ath3k_
 	{ USB_DEVICE(0x13d3, 0x3402) },
 	{ USB_DEVICE(0x0cf3, 0x3121) },
 	{ USB_DEVICE(0x0cf3, 0xe003) },
+	{ USB_DEVICE(0x0b05, 0x17d0) },

 	/* Atheros AR5BBU12 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xE02C) },
@@ -140,6 +141,7 @@ static const struct usb_device_id ath3k_
 	{ USB_DEVICE(0x13d3, 0x3402), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x3121), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0xe003), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0b05, 0x17d0), .driver_info = BTUSB_ATH3012 },

 	/* Atheros AR5BBU22 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xE03C), .driver_info = BTUSB_ATH3012 },
diff -uprN -X linux-3.13.5-gentoo/Documentation/dontdiff linux-3.13.5-gentoo/drivers/bluetooth/btusb.c linux-3.13.5-gentoo-bela/drivers/bluetooth/btusb.c
--- linux-3.13.5-gentoo/drivers/bluetooth/btusb.c	2014-01-20 03:40:07.000000000 +0100
+++ linux-3.13.5-gentoo-bela/drivers/bluetooth/btusb.c	2014-02-27 20:10:20.825905643 +0100
@@ -164,6 +164,7 @@ static const struct usb_device_id blackl
 	{ USB_DEVICE(0x13d3, 0x3402), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x3121), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0xe003), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0b05, 0x17d0), .driver_info = BTUSB_ATH3012 },

 	/* Atheros AR5BBU12 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xe02c), .driver_info = BTUSB_IGNORE },



On 27/02/14 23:43, Marcel Holtmann wrote:
> Hi Bela,
> 
>> This adds support for the Atheros AR3012 chipset on the ASUS Z87-Pro (C2) mainboard (ID 0x0b05:0x17d0).
> 
> include the content of /sys/kernel/debug/usb/devices for this controller.
> 
>>
>> Signed-off-by: Bela Hausmann <bela.hausmann@gmail.com>
>> ---
>> diff -uprN -X linux-3.13.5-gentoo/Documentation/dontdiff linux-3.13.5-gentoo/drivers/bluetooth/ath3k.c linux-3.13.5-gentoo-bela/drivers/bluetooth/ath3k.c
>> --- linux-3.13.5-gentoo/drivers/bluetooth/ath3k.c    2014-01-20 03:40:07.000000000 +0100
>> +++ linux-3.13.5-gentoo-bela/drivers/bluetooth/ath3k.c    2014-02-27 20:09:33.047878117 +0100
>> @@ -97,6 +97,7 @@ static const struct usb_device_id ath3k_
>>     { USB_DEVICE(0x13d3, 0x3402) },
>>     { USB_DEVICE(0x0cf3, 0x3121) },
>>     { USB_DEVICE(0x0cf3, 0xe003) },
>> +    { USB_DEVICE(0x0b05, 0x17d0) },
> 
> Make sure that you email client does not screw up tabs. This looks pretty much like it is messed up.
> 
> Regards
> 
> Marcel
> 
> 
