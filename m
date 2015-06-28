Return-Path: <cyrus@holtmann.org>
Message-ID: <BLU436-SMTP4499391DA658335C8089499EAB0@phx.gbl>
From: Xi Ruoyao <xry111@outlook.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Larry Finger <Larry.Finger@lwfinger.net>
CC: Johan Hedberg <johan.hedberg@gmail.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xi Ruoyao <xry111@outlook.com>
Subject: [PATCH RESEND] Bluetooth: btusb: Modify entry to support misc devices with BT interface
Date: Mon, 29 Jun 2015 05:49:32 +0800
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

In the USB device table in btusb driver, the code specify a generic Bluetooth
device by matching Device Descriptor. However, some devices with BT interface
are classified as "Miscellaneous Device" and have different Device Descriptor,
such as Realtek RTL8723AU. Then btusb wouldn't probe them.

To resolve this, specify generic Bluetooth device in the USB device table by
matching Interface Descriptor, to probe all devices with Bluetooth interface
including these "Miscellaneous" ones.

Signed-off-by: Xi Ruoyao <xry111@outlook.com>
---
The Bluetooth USB driver changed a lot since 4.1 released. However this problem
still exists now, so I think I should resend this patch.

After apply this patch, my RTL8723AU works well. This is the info of the RTL8723AU
USB device:

T:  Bus=03 Lev=02 Prnt=02 Port=03 Cnt=03 Dev#=  5 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=1724 Rev= 2.00
S:  Manufacturer=Realtek
S:  Product=802.11n WLAN Adapter
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

 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b4cf8d9..950afda 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -63,7 +63,7 @@ static struct usb_driver btusb_driver;
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
-	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
+	{ USB_INTERFACE_INFO(0xe0, 0x01, 0x01) },
 
 	/* Generic Bluetooth AMP device */
 	{ USB_DEVICE_INFO(0xe0, 0x01, 0x04), .driver_info = BTUSB_AMP },
-- 
1.9.1
