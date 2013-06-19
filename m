Return-Path: <cyrus@holtmann.org>
From: Jesse Sung <jesse.sung@canonical.com>
To: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Anthony Wong <anthony.wong@canonical.com>,
	Wen-chien Jesse Sung <jesse.sung@canonical.com>
Subject: [PATCH 1/5] Bluetooth: Support for loading broadcom patchram firmware
Date: Wed, 19 Jun 2013 23:28:34 +0800
Message-Id: <1371655718-1753-1-git-send-email-jesse.sung@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Wen-chien Jesse Sung <jesse.sung@canonical.com>

There is an user space firmware loading tool which can be found at
http://marc.info/?l=linux-bluetooth&m=132039175324993&w=2

The supported firmware is in hcd format, which is a collection of
hci commands. The download process would be:
1. reset command
2. download command
3. firmware image in hcd file
4. reset command

/sys/kernel/debug/usb/devices before loading firmware:
T:  Bus=01 Lev=02 Prnt=02 Port=04 Cnt=02 Dev#=  4 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a5c ProdID=21d3 Rev= 1.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM43142A0
S:  SerialNumber=3859F9D6199A
C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

/sys/kernel/debug/usb/devices after loading firmware:
T:  Bus=01 Lev=02 Prnt=02 Port=04 Cnt=02 Dev#=  4 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a5c ProdID=21d3 Rev= 1.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM43142A0
S:  SerialNumber=3859F9D6199A
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

Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
---
 drivers/bluetooth/btusb.c | 76 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7a7e5f8..8cab88c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/usb.h>
 #include <linux/firmware.h>
+#include <linux/delay.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -49,6 +50,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_WRONG_SCO_MTU	0x40
 #define BTUSB_ATH3012		0x80
 #define BTUSB_INTEL		0x100
+#define BTUSB_BCM_PATCHRAM	0x200
 
 static struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -101,13 +103,13 @@ static struct usb_device_id btusb_table[] = {
 	{ USB_DEVICE(0x0b05, 0x17b5) },
 	{ USB_DEVICE(0x04ca, 0x2003) },
 	{ USB_DEVICE(0x0489, 0xe042) },
-	{ USB_DEVICE(0x413c, 0x8197) },
+	{ USB_DEVICE(0x413c, 0x8197), .driver_info = BTUSB_BCM_PATCHRAM },
 
 	/* Foxconn - Hon Hai */
-	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01) },
+	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01), .driver_info = BTUSB_BCM_PATCHRAM },
 
 	/*Broadcom devices with vendor specific id */
-	{ USB_VENDOR_AND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01) },
+	{ USB_VENDOR_AND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01), .driver_info = BTUSB_BCM_PATCHRAM },
 
 	{ }	/* Terminating entry */
 };
@@ -1317,6 +1319,71 @@ exit_mfg_deactivate:
 	return 0;
 }
 
+static int btusb_setup_patchram_packet(struct hci_dev *hdev, u16 opcode, u32 plen, const void *param)
+{
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, opcode, plen, param, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb))
+		return -PTR_ERR(skb);
+	kfree_skb(skb);
+	return 0;
+}
+
+#define PATCHRAM_NAME_LEN	20
+
+static int btusb_setup_patchram(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct usb_device *udev = data->udev;
+	size_t pos = 0;
+	int err = 0;
+	char filename[PATCHRAM_NAME_LEN];
+	const struct firmware *fw;
+	u8 val = 0x00;
+
+	snprintf(filename, PATCHRAM_NAME_LEN, "fw-%04x_%04x.hcd",
+			le16_to_cpu(udev->descriptor.idVendor),
+			le16_to_cpu(udev->descriptor.idProduct));
+	if (request_firmware(&fw, (const char *) filename, &udev->dev) < 0) {
+		BT_INFO("can't load firmware, may not work correctly");
+		return 0;
+	}
+
+	err = btusb_setup_patchram_packet(hdev, 0x0c03, 1, &val);
+	if (err)
+		goto out;
+
+	err = btusb_setup_patchram_packet(hdev, 0xfc2e, 1, &val);
+	if (err)
+		goto out;
+
+	msleep(1000);
+	while (pos < fw->size) {
+		size_t len;
+		len = fw->data[pos + 2] + 3;
+		if (pos + len > fw->size) {
+			err = -EINVAL;
+			goto out;
+		}
+		err = btusb_setup_patchram_packet(hdev, le16_to_cpu(*(u16*)(fw->data + pos)),
+							fw->data[pos + 2] , &fw->data[pos + 3]);
+		if (err)
+			goto out;
+		pos += len;
+	}
+
+	err = btusb_setup_patchram_packet(hdev, 0x0c03, 1, &val);
+out:
+	release_firmware(fw);
+	if (err) {
+		BT_INFO("fail to load firmware");
+		return err;
+	}
+	BT_INFO("firmware loaded");
+	return 0;
+}
+
 static int btusb_probe(struct usb_interface *intf,
 				const struct usb_device_id *id)
 {
@@ -1425,6 +1492,9 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_INTEL)
 		hdev->setup = btusb_setup_intel;
 
+	if (id->driver_info & BTUSB_BCM_PATCHRAM)
+		hdev->setup = btusb_setup_patchram;
+
 	/* Interface numbers are hardcoded in the specification */
 	data->isoc = usb_ifnum_to_if(data->udev, 1);
 
-- 
1.8.1.2
