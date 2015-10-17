Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Mark BCM2045 devices to have broken link key commands
Date: Sat, 17 Oct 2015 14:39:27 +0200
Message-Id: <1445085567-55373-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The BCM2045 seems to have a problem with the stored link key commands
and thus just mark them as broken.

  HCI Event: Command Complete (0x0e) plen 12
     Read Local Supported Features (0x04|0x0003) ncmd 1
     status 0x00
     Features: 0xff 0xff 0x8d 0xfe 0x8f 0xf9 0x00 0x80
  HCI Event: Command Complete (0x0e) plen 12
     Read Local Version Information (0x04|0x0001) ncmd 1
     status 0x00
     HCI Version: 2.0 (0x3) HCI Revision: 0x2000
     LMP Version: 2.0 (0x3) LMP Subversion: 0x410d
     Manufacturer: Broadcom Corporation (15)
  HCI Event: Command Complete (0x0e) plen 11
     Read Buffer Size (0x04|0x0005) ncmd 1
     status 0x00
     ACL MTU 1017:8 SCO MTU 64:0
  HCI Event: Command Complete (0x0e) plen 68
     Read Local Supported Commands (0x04|0x0002) ncmd 1
     status 0x00
     Commands: ffffff03feffcfffffffffff0300f8ff07
  HCI Event: Command Complete (0x0e) plen 4
     Delete Stored Link Key (0x03|0x0012) ncmd 1
     status 0x11 deleted 2048
     Error: Unsupported Feature or Parameter Value

>From the looks of it, this device seems genuine and not one of the
devices that are neither Broadcom nor CSR devices in reality.

T: Bus=04 Lev=02 Prnt=02 Port=02 Cnt=02 Dev#= 3 Spd=12 MxCh= 0
D: Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=0a5c ProdID=2045 Rev= 1.12
S: Manufacturer=Broadcom Corp
S: Product=BCM2045A
S: SerialNumber=000000000000
C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=1ms
E: Ad=82(I) Atr=02(Bulk) MxPS= 64 Ivl=0ms
E: Ad=02(O) Atr=02(Bulk) MxPS= 64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 0 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 0 Ivl=1ms
I: If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 9 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 9 Ivl=1ms
I: If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 17 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 17 Ivl=1ms
I: If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 25 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 25 Ivl=1ms
I: If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 33 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 33 Ivl=1ms
I: If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 49 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E: Ad=84(I) Atr=02(Bulk) MxPS= 32 Ivl=0ms
E: Ad=04(O) Atr=02(Bulk) MxPS= 32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

Reported-by: Julio González Mejías <juliolokooo@gmail.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 27830da67063..448b824d1782 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -60,6 +60,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_QCA_ROME		0x8000
 #define BTUSB_BCM_APPLE		0x10000
 #define BTUSB_REALTEK		0x20000
+#define BTUSB_BCM2045		0x40000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -164,6 +165,9 @@ static const struct usb_device_id blacklist_table[] = {
 	/* Broadcom BCM2033 without firmware */
 	{ USB_DEVICE(0x0a5c, 0x2033), .driver_info = BTUSB_IGNORE },
 
+	/* Broadcom BCM2045 devices */
+	{ USB_DEVICE(0x0a5c, 0x2045), .driver_info = BTUSB_BCM2045 },
+
 	/* Atheros 3011 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xe027), .driver_info = BTUSB_IGNORE },
 	{ USB_DEVICE(0x0489, 0xe03d), .driver_info = BTUSB_IGNORE },
@@ -2857,6 +2861,9 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->send   = btusb_send_frame;
 	hdev->notify = btusb_notify;
 
+	if (id->driver_info & BTUSB_BCM2045)
+		set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
+
 	if (id->driver_info & BTUSB_BCM92035)
 		hdev->setup = btusb_setup_bcm92035;
 
-- 
2.4.3

