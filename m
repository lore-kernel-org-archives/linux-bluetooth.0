Return-Path: <ioan.moldovan1999@gmail.com>
From: Ioan Moldovan <ioan.moldovan1999@gmail.com>
Subject: [PATCH] Add a new 04ca:3015 QCA_ROME device
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org
Message-ID: <86a45247-6443-6bc3-285d-b8191575ef1c@gmail.com>
Date: Mon, 28 Aug 2017 18:09:39 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the 04ca:3015 (from a QCA9377 board) Bluetooth device to 
the btusb blacklist and makes the kernel use the btqca module instead of 
btusb. The patch is necessary because, without it the 04ca:3015 device 
defaults to using the btusb driver, which makes the WIFI side of the 
QCA9377 board unusable (obtains 0 MBps in speedtest, when the 04ca:3015 
bluetooth is used with an audio headset).

Signed-off-by: Ioan Moldovan <ioan.moldovan1999@gmail.com>
---

Notes:
     /sys/kernel/debug/usb/devices for the patch
         T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480  MxCh=12
     B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
     D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
     P:  Vendor=1d6b ProdID=0002 Rev= 4.12
     S:  Manufacturer=Linux 4.12.9 xhci-hcd
     S:  Product=xHCI Host Controller
     S:  SerialNumber=0000:00:14.0
     C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
     I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
     E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms
         T:  Bus=01 Lev=01 Prnt=01 Port=04 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
     D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
     P:  Vendor=04ca ProdID=3015 Rev= 0.01
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
         T:  Bus=01 Lev=01 Prnt=01 Port=06 Cnt=02 Dev#=  3 Spd=480  MxCh= 0
     D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
     P:  Vendor=04f2 ProdID=b571 Rev=99.52
     S:  Manufacturer=Chicony Electronics Co.,Ltd.
     S:  Product=HD WebCam
     C:* #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
     A:  FirstIf#= 0 IfCount= 2 Cls=0e(video) Sub=03 Prot=00
     I:* If#= 0 Alt= 0 #EPs= 1 Cls=0e(video) Sub=01 Prot=00 Driver=uvcvideo
     E:  Ad=87(I) Atr=03(Int.) MxPS=  16 Ivl=16ms
     I:* If#= 1 Alt= 0 #EPs= 0 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
     I:  If#= 1 Alt= 1 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
     E:  Ad=81(I) Atr=05(Isoc) MxPS= 192 Ivl=125us
     I:  If#= 1 Alt= 2 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
     E:  Ad=81(I) Atr=05(Isoc) MxPS= 384 Ivl=125us
     I:  If#= 1 Alt= 3 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
     E:  Ad=81(I) Atr=05(Isoc) MxPS= 512 Ivl=125us
     I:  If#= 1 Alt= 4 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
     E:  Ad=81(I) Atr=05(Isoc) MxPS= 640 Ivl=125us
     I:  If#= 1 Alt= 5 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
     E:  Ad=81(I) Atr=05(Isoc) MxPS= 800 Ivl=125us
     I:  If#= 1 Alt= 6 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
     E:  Ad=81(I) Atr=05(Isoc) MxPS= 944 Ivl=125us
     I:  If#= 1 Alt= 7 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
     E:  Ad=81(I) Atr=05(Isoc) MxPS=1280 Ivl=125us
     I:  If#= 1 Alt= 8 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
     E:  Ad=81(I) Atr=05(Isoc) MxPS=1600 Ivl=125us
     I:  If#= 1 Alt= 9 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
     E:  Ad=81(I) Atr=05(Isoc) MxPS=1984 Ivl=125us
     I:  If#= 1 Alt=10 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
     E:  Ad=81(I) Atr=05(Isoc) MxPS=2880 Ivl=125us
     I:  If#= 1 Alt=11 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
     E:  Ad=81(I) Atr=05(Isoc) MxPS=3060 Ivl=125us
         T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=5000 MxCh= 6
     B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
     D:  Ver= 3.00 Cls=09(hub  ) Sub=00 Prot=03 MxPS= 9 #Cfgs=  1
     P:  Vendor=1d6b ProdID=0003 Rev= 4.12
     S:  Manufacturer=Linux 4.12.9 xhci-hcd
     S:  Product=xHCI Host Controller
     S:  SerialNumber=0000:00:14.0
     C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
     I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
     E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms

  drivers/bluetooth/btusb.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index fa24d693af24..250c2d8c48b1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -268,6 +268,7 @@ static const struct usb_device_id blacklist_table[] = {
  	{ USB_DEVICE(0x0489, 0xe092), .driver_info = BTUSB_QCA_ROME },
  	{ USB_DEVICE(0x0489, 0xe0a2), .driver_info = BTUSB_QCA_ROME },
  	{ USB_DEVICE(0x04ca, 0x3011), .driver_info = BTUSB_QCA_ROME },
+	{ USB_DEVICE(0x04ca, 0x3015), .driver_info = BTUSB_QCA_ROME },
   	/* Broadcom BCM2035 */
  	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
-- 
2.11.0
