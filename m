Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Graham Gower <graham.gower@gmail.com>
To: linux-bluetooth@vger.kernel.org, graham.gower@gmail.com
Subject: [PATCH] Bluetooth: btusb: set HCI_QUIRK_BROKEN_LOCAL_COMMANDS for 0x0a5c:0x21f3
Date: Mon,  8 May 2017 20:38:48 +0930
Message-Id: <20170508110848.8639-1-graham.gower@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Card labelled BCM943228HMB found in Lenovo X131e laptop.

$ usb-devices
...
T:  Bus=02 Lev=02 Prnt=02 Port=04 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a5c ProdID=21f3 Rev=01.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM20702A0
S:  SerialNumber=B00594EAFD30
C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
...

$ hcidump &hciconfig hci0 up
...
commands
< HCI Command: Set Event Mask Page 2 (0x03|0x0063) plen 8
    Mask: 0x0000000000000000
> HCI Event: Command Complete (0x0e) plen 4
    Set Event Mask Page 2 (0x03|0x0063) ncmd 1
    status 0x01
    Error: Unknown HCI Command
---
 drivers/bluetooth/btusb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7fa373b..7be8cf1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -66,6 +66,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_BCM2045		0x40000
 #define BTUSB_IFNUM_2		0x80000
 #define BTUSB_CW6622		0x100000
+#define BTUSB_BCM21F3		0x200000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -127,6 +128,10 @@ static const struct usb_device_id btusb_table[] = {
 	/* Broadcom BCM20702A0 */
 	{ USB_DEVICE(0x413c, 0x8197) },
 
+	/* Broadcom BCM20702A0 */
+	{ USB_DEVICE(0x0a5c, 0x21f3),
+	  .driver_info = BTUSB_BCM21F3 | BTUSB_BCM_PATCHRAM },
+
 	/* Broadcom BCM20702B0 (Dynex/Insignia) */
 	{ USB_DEVICE(0x19ff, 0x0239), .driver_info = BTUSB_BCM_PATCHRAM },
 
@@ -2994,6 +2999,9 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_BCM2045)
 		set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
 
+	if (id->driver_info & BTUSB_BCM21F3)
+		set_bit(HCI_QUIRK_BROKEN_LOCAL_COMMANDS, &hdev->quirks);
+
 	if (id->driver_info & BTUSB_BCM92035)
 		hdev->setup = btusb_setup_bcm92035;
 
-- 
2.9.0

