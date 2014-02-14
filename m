Return-Path: <cyrus@holtmann.org>
Message-ID: <1392370354.2437.2.camel@develbox>
Subject: [PATCH] btusb.c add IMC Networks id 13d3:3404 (bcm20702A0) - retry
From: Jurgen Kramer <gtmkramer@xs4all.nl>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Fri, 14 Feb 2014 10:32:34 +0100
Content-Type: multipart/mixed; boundary="=-f2BeFds9rIDiWNnJz4hT"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-f2BeFds9rIDiWNnJz4hT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 343f62050b33972929db749aee296e98332600d6 Mon Sep 17 00:00:00 2001
From: Jurgen Kramer <gtmkramer@xs4all.nl>
Date: Fri, 14 Feb 2014 10:22:51 +0100
Subject: [PATCH] btusb.c add IMC Networks id 13d3:3404 (bcm20702A0)

---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3980fd1..5dce16d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -106,6 +106,7 @@ static const struct usb_device_id btusb_table[] = {
 	{ USB_DEVICE(0x04ca, 0x2003) },
 	{ USB_DEVICE(0x0489, 0xe042) },
 	{ USB_DEVICE(0x413c, 0x8197) },
+	{ USB_DEVICE(0x13d3, 0x3404) },
 
 	/* Foxconn - Hon Hai */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01) },
-- 
1.8.5.3

Signed-off-by: Jurgen Kramer <gtm.kramer@xs4all.nl>

Retry. I've included the relevant part of the
requested /sys/kernel/debug/usb/devices output.

Jurgen

--=-f2BeFds9rIDiWNnJz4hT
Content-Disposition: attachment; filename="sys-kernel-debug-usb-devices-0x13d3-0x3404.txt"
Content-Type: text/plain; name="sys-kernel-debug-usb-devices-0x13d3-0x3404.txt";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

T:  Bus=01 Lev=02 Prnt=02 Port=04 Cnt=01 Dev#=  3 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3404 Rev= 1.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM20702A0
S:  SerialNumber=240A649F8246
C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

--=-f2BeFds9rIDiWNnJz4hT--

