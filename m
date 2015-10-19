Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add support for latest Apple controllers
Date: Tue, 20 Oct 2015 00:53:33 +0200
Message-Id: <1445295213-33576-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The latest Apple Bluetooth controllers with Broadcom chip in it have
a small design change. Instead of including a USB hub with mouse and
keyboard devices, they are now HID interfaces on the same device.

T:  Bus=04 Lev=02 Prnt=02 Port=04 Cnt=01 Dev#= 39 Spd=12   MxCh= 0
D:  Ver= 2.01 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=05ac ProdID=8290 Rev= 0.79
S:  Manufacturer=Broadcom Corp.
S:  Product=Bluetooth USB Host Controller
C:* #Ifs= 6 Cfg#= 1 Atr=e0 MxPwr=  0mA
A:  FirstIf#= 2 IfCount= 4 Cls=ff(vend.) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
E:  Ad=85(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
I:* If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
E:  Ad=86(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 3 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 3 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 3 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 3 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 3 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 5 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

The general layout of Bluetooth devices is that interface 0 is the main
interface and interface 1 is for audio data. This design obviously moves
it to main interface 2 and audio data on interface 3.

Starting with the MacBookPro12,1 (early 2015 models) the new Broadcom
BCM943602CS cards are used which show this interface layout.

usb 4-1.5: New USB device found, idVendor=05ac, idProduct=8290
usb 4-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 4-1.5: Product: Bluetooth USB Host Controller
usb 4-1.5: Manufacturer: Broadcom Corp.
Bluetooth: hci0: BCM: chip id 102 build 0243
Bluetooth: hci0: BCM: product 05ac:8290
Bluetooth: hci0: BCM20703A1 Generic USB UHE Apple 20Mhz fcbga_X87

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c064bb9540ee..5ee98231ac27 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -61,6 +61,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_BCM_APPLE		0x10000
 #define BTUSB_REALTEK		0x20000
 #define BTUSB_BCM2045		0x40000
+#define BTUSB_IFNUM_2		0x80000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -74,7 +75,7 @@ static const struct usb_device_id btusb_table[] = {
 
 	/* Apple-specific (Broadcom) devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x05ac, 0xff, 0x01, 0x01),
-	  .driver_info = BTUSB_BCM_APPLE },
+	  .driver_info = BTUSB_BCM_APPLE | BTUSB_IFNUM_2 },
 
 	/* MediaTek MT76x0E */
 	{ USB_DEVICE(0x0e8d, 0x763f) },
@@ -2758,13 +2759,20 @@ static int btusb_probe(struct usb_interface *intf,
 	struct usb_endpoint_descriptor *ep_desc;
 	struct btusb_data *data;
 	struct hci_dev *hdev;
+	unsigned ifnum_base;
 	int i, err;
 
 	BT_DBG("intf %p id %p", intf, id);
 
 	/* interface numbers are hardcoded in the spec */
-	if (intf->cur_altsetting->desc.bInterfaceNumber != 0)
-		return -ENODEV;
+	if (intf->cur_altsetting->desc.bInterfaceNumber != 0) {
+		if (!(id->driver_info & BTUSB_IFNUM_2))
+			return -ENODEV;
+		if (intf->cur_altsetting->desc.bInterfaceNumber != 2)
+			return -ENODEV;
+	}
+
+	ifnum_base = intf->cur_altsetting->desc.bInterfaceNumber;
 
 	if (!id->driver_info) {
 		const struct usb_device_id *match;
@@ -2879,7 +2887,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_bdaddr = btbcm_set_bdaddr;
 
 		/* Broadcom LM_DIAG Interface numbers are hardcoded */
-		data->diag = usb_ifnum_to_if(data->udev, 2);
+		data->diag = usb_ifnum_to_if(data->udev, ifnum_base + 2);
 	}
 
 	if (id->driver_info & BTUSB_BCM_APPLE) {
@@ -2887,7 +2895,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_diag = btusb_bcm_set_diag;
 
 		/* Broadcom LM_DIAG Interface numbers are hardcoded */
-		data->diag = usb_ifnum_to_if(data->udev, 2);
+		data->diag = usb_ifnum_to_if(data->udev, ifnum_base + 2);
 	}
 #endif
 
@@ -2949,8 +2957,8 @@ static int btusb_probe(struct usb_interface *intf,
 		/* AMP controllers do not support SCO packets */
 		data->isoc = NULL;
 	} else {
-		/* Interface numbers are hardcoded in the specification */
-		data->isoc = usb_ifnum_to_if(data->udev, 1);
+		/* Interface orders are hardcoded in the specification */
+		data->isoc = usb_ifnum_to_if(data->udev, ifnum_base + 1);
 	}
 
 	if (!reset)
-- 
2.4.3

