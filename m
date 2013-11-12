Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Nov 2013 13:10:58 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: don.fry@intel.com, tedd.an@intel.com, marcel@holtmann.org
Subject: [PATCH] Bluetooth: Add support for Intel Bluetooth device
 [8087:0a2a]
Message-ID: <20131112131058.6c23affb@han1-desk-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds support for new Intel Bluetooth device.

T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  4 Spd=12   MxCh= 0
D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=8087 ProdID=0a2a Rev= 0.01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btusb.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c206091..0263997 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -225,6 +225,7 @@ static const struct usb_device_id blacklist_table[] = {
 
 	/* Intel Bluetooth device */
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
+	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL },
 
 	{ }	/* Terminating entry */
 };
-- 
1.7.9.5

