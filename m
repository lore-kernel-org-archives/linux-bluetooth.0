Return-Path: <cyrus@holtmann.org>
From: Giancarlo Formicuccia <giancarlo.formicuccia@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo@padovan.org>, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>
Subject: [PATCH] [RESEND] btusb,ath3k: add support for 0930:0219
Date: Sun, 10 Jun 2012 08:33:11 +0200
Message-ID: <1379642.mNRPMjYO4c@ilstop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

this patch adds support for the AR3012 chip found on the Toshiba Sallite M840-1000-XQ.

usb-devices shows:

T:  Bus=01 Lev=02 Prnt=02 Port=02 Cnt=01 Dev#=  5 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0930 ProdID=0219 Rev=00.02
S:  Manufacturer=Atheros Communications
S:  Product=Bluetooth USB Host Controller
S:  SerialNumber=Alaska Day 2006
C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

Thanks,

Giancarlo

Signed-off-by: Giancarlo Formicuccia <giancarlo.formicuccia@gmail.com>
---
diff -urpN -X linux-3.5-rc1/Documentation/dontdiff linux-3.5-rc1.org/drivers/bluetooth/ath3k.c linux-3.5-rc1/drivers/bluetooth/ath3k.c
--- linux-3.5-rc1.org/drivers/bluetooth/ath3k.c	2012-06-03 03:29:26.000000000 +0200
+++ linux-3.5-rc1/drivers/bluetooth/ath3k.c	2012-06-06 10:29:11.325484026 +0200
@@ -77,6 +77,7 @@ static struct usb_device_id ath3k_table[
 	{ USB_DEVICE(0x04CA, 0x3005) },
 	{ USB_DEVICE(0x13d3, 0x3362) },
 	{ USB_DEVICE(0x0CF3, 0xE004) },
+	{ USB_DEVICE(0x0930, 0x0219) },
 
 	/* Atheros AR5BBU12 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xE02C) },
@@ -101,6 +102,7 @@ static struct usb_device_id ath3k_blist_
 	{ USB_DEVICE(0x04ca, 0x3005), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x13d3, 0x3362), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0xe004), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0930, 0x0219), .driver_info = BTUSB_ATH3012 },
 
 	/* Atheros AR5BBU22 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xE03C), .driver_info = BTUSB_ATH3012 },
diff -urpN -X linux-3.5-rc1/Documentation/dontdiff linux-3.5-rc1.org/drivers/bluetooth/btusb.c linux-3.5-rc1/drivers/bluetooth/btusb.c
--- linux-3.5-rc1.org/drivers/bluetooth/btusb.c	2012-06-03 03:29:26.000000000 +0200
+++ linux-3.5-rc1/drivers/bluetooth/btusb.c	2012-06-06 10:29:35.616401307 +0200
@@ -139,6 +139,7 @@ static struct usb_device_id blacklist_ta
 	{ USB_DEVICE(0x04ca, 0x3005), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x13d3, 0x3362), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0xe004), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0930, 0x0219), .driver_info = BTUSB_ATH3012 },
 
 	/* Atheros AR5BBU12 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xe02c), .driver_info = BTUSB_IGNORE },
