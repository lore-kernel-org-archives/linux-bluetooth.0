Return-Path: <vicencb@gmail.com>
From: Vicente Bergas <vicencb@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Vicente Bergas <vicencb@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add USB ID 7392:a611 for Edimax EW-7611ULB
Date: Tue, 20 Mar 2018 19:41:10 +0100
Message-Id: <20180320184110.3888-1-vicencb@gmail.com>
In-Reply-To: <CA64719F-6732-4683-ACC6-AF82733384C3@holtmann.org>
References: <CA64719F-6732-4683-ACC6-AF82733384C3@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This WiFi/Bluetooth USB dongle uses a Realtek chipset, so, use btrtl for it.

Product information:
https://wikidevi.com/wiki/Edimax_EW-7611ULB

>From /sys/kernel/debug/usb/devices
T:  Bus=02 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=7392 ProdID=a611 Rev= 2.00
S:  Manufacturer=Realtek
S:  Product=Edimax Wi-Fi N150 Bluetooth4.0 USB Adapter
S:  SerialNumber=00e04c000001
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=500mA
A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
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
I:* If#= 2 Alt= 0 #EPs= 6 Cls=ff(vend.) Sub=ff Prot=ff Driver=rtl8723bu
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=03(Int.) MxPS=  64 Ivl=500us
E:  Ad=08(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=09(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Tested-by: Vicente Bergas <vicencb@gmail.com>
Signed-off-by: Vicente Bergas <vicencb@gmail.com>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

Hi Marcel,
here is the patch with updated commit message.

The WiFi driver should be rtl8xxxu instead of the out-of-tree rtl8723bu,
but rtl8xxxu does not work just by adding the VID:PID. The rtl8xxxu
maintainer has already been contacted regarding this.
In any case, the bluetooth side works fine.

Regards,
  Vicente.

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 60bf04b8f103..c4baf4aed256 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -367,6 +367,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3459), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3494), .driver_info = BTUSB_REALTEK },
 
+	/* Additional Realtek 8723BU Bluetooth devices */
+	{ USB_DEVICE(0x7392, 0xa611), .driver_info = BTUSB_REALTEK },
+
 	/* Additional Realtek 8821AE Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3414), .driver_info = BTUSB_REALTEK },
-- 
2.16.2
