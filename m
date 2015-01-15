Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 15 Jan 2015 14:43:14 -0500
Message-ID: <CABPUHrbPgbp3qgjk2+Qom6XAOARr2yh074_sjz_G=gihSW=-qA@mail.gmail.com>
Subject: Bluetooth: Add support for BCM4352 combo card BCM20702A0 sub chip
From: Rick Dunn <rick@rickdunn.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Please add upstream to support the sub BT chip on the combo card...

>From e5ba79b482a755f0068bd502dad0ef1492ac4c8d Mon Sep 17 00:00:00 2001
From: Rick Dunn <rick@rickdunn.com>
Date: Thu, 15 Jan 2015 13:00:19 -0500
Subject: [PATCH] Add 0b05:17cf line for BCM4352 combo card BCM20702A0 chip

---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index af122e2..0725003 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -107,6 +107,7 @@ static const struct usb_device_id btusb_table[] = {
  { USB_DEVICE(0x0b05, 0x17cb) },
  { USB_DEVICE(0x04ca, 0x2003) },
  { USB_DEVICE(0x0489, 0xe042) },
+ { USB_DEVICE(0x0b05, 0x17cf), .driver_info = BTUSB_BCM_PATCHRAM },
  { USB_DEVICE(0x13d3, 0x3388), .driver_info = BTUSB_BCM_PATCHRAM },
  { USB_DEVICE(0x13d3, 0x3389), .driver_info = BTUSB_BCM_PATCHRAM },
  { USB_DEVICE(0x413c, 0x8197), .driver_info = BTUSB_BCM_PATCHRAM },
-- 
1.9.1

/sys/kernel/debug/usb/devices
T:  Bus=03 Lev=01 Prnt=01 Port=06 Cnt=03 Dev#=  5 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0b05 ProdID=17cf Rev= 1.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM20702A0
S:  SerialNumber=54271E3298CD
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


Firmware is extracted from the latest Broadcom BCM4352 WIndows driver
by extracting the zip and searching the .hex file names for '17cf' ..
the hex file must then be converted to hcd format using the hex2hcd
git below and named fw-0b05_17cf.hcd  fw file moved to
/lib/firmware/fw-0b05_17cf.hcd

git clone https://github.com/jessesung/hex2hcd.git

Thanks

Rick
