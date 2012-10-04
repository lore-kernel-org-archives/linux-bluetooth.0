Return-Path: <cyrus@holtmann.org>
From: Jesse Sung <jesse.sung@canonical.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 resend 2/2] broadcom patchram firmware loader
Date: Thu,  4 Oct 2012 15:30:47 +0800
Message-Id: <1349335847-1615-3-git-send-email-jesse.sung@canonical.com>
In-Reply-To: <1349335847-1615-1-git-send-email-jesse.sung@canonical.com>
References: <cover.1347959921.git.jesse.sung@canonical.com>
 <1349335847-1615-1-git-send-email-jesse.sung@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Wen-chien Jesse Sung <jesse.sung@canonical.com>

There is an user space firmware loading tool which can be found at
http://marc.info/?l=linux-bluetooth&m=132039175324993&w=2

This tool requires hci device to do the firmware loading, but this
may cause some race condition between patchram tool and bluetoothd
or something that also works on hci interface.

Also it needs some hooks to make firmware loads after bootup, s3,
s4, rfkill, and device hotplug events. Implement this loader in kernel
module would make things more easier.

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
 drivers/bluetooth/btusb.c |   75 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index fbfb069..408a5c6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -23,6 +23,8 @@
 
 #include <linux/module.h>
 #include <linux/usb.h>
+#include <linux/delay.h>
+#include <linux/firmware.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -47,6 +49,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_BROKEN_ISOC	0x20
 #define BTUSB_WRONG_SCO_MTU	0x40
 #define BTUSB_ATH3012		0x80
+#define BTUSB_BCM_PATCHRAM	0x100
 
 static struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -97,13 +100,13 @@ static struct usb_device_id btusb_table[] = {
 
 	/* Broadcom BCM20702A0 */
 	{ USB_DEVICE(0x0489, 0xe042) },
-	{ USB_DEVICE(0x413c, 0x8197) },
+	{ USB_DEVICE(0x413c, 0x8197), .driver_info = BTUSB_BCM_PATCHRAM },
 
 	/* Foxconn - Hon Hai */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01) },
 
 	/*Broadcom devices with vendor specific id */
-	{ USB_VENDOR_AND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01) },
+	{ USB_VENDOR_AND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01), .driver_info = BTUSB_BCM_PATCHRAM },
 
 	{ }	/* Terminating entry */
 };
@@ -204,12 +207,14 @@ static struct usb_device_id blacklist_table[] = {
 #define BTUSB_ISOC_RUNNING	2
 #define BTUSB_SUSPENDING	3
 #define BTUSB_DID_ISO_RESUME	4
+#define BTUSB_FIRMWARE_DONE	5
 
 struct btusb_data {
 	struct hci_dev       *hdev;
 	struct usb_device    *udev;
 	struct usb_interface *intf;
 	struct usb_interface *isoc;
+	const struct usb_device_id *id;
 
 	spinlock_t lock;
 
@@ -914,6 +919,69 @@ static void btusb_waker(struct work_struct *work)
 	usb_autopm_put_interface(data->intf);
 }
 
+#define PATCHRAM_TIMEOUT	1000
+#define PATCHRAM_NAME_LEN	20
+
+static void btusb_load_firmware(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct usb_device *udev = data->udev;
+	const struct usb_device_id *id = data->id;
+	size_t pos = 0;
+	int err = 0;
+	char filename[PATCHRAM_NAME_LEN];
+	const struct firmware *fw;
+
+	unsigned char reset_cmd[] = { 0x03, 0x0c, 0x00 };
+	unsigned char download_cmd[] = { 0x2e, 0xfc, 0x00 };
+
+	if (!(id->driver_info & BTUSB_BCM_PATCHRAM))
+		return;
+	if (test_and_set_bit(BTUSB_FIRMWARE_DONE, &data->flags))
+		return;
+
+	snprintf(filename, PATCHRAM_NAME_LEN, "fw-%04x_%04x.hcd",
+		id->idVendor, id->idProduct);
+	if (request_firmware(&fw, (const char *) filename, &udev->dev) < 0) {
+		BT_INFO("can't load firmware, may not work correctly");
+		return;
+	}
+
+	if (usb_control_msg(udev, usb_sndctrlpipe(udev, 0), 0, USB_TYPE_CLASS, 0, 0,
+		reset_cmd, sizeof(reset_cmd), PATCHRAM_TIMEOUT) < 0) {
+		err = -1;
+		goto out;
+	}
+	msleep(300);
+
+	if (usb_control_msg(udev, usb_sndctrlpipe(udev, 0), 0, USB_TYPE_CLASS, 0, 0,
+		download_cmd, sizeof(download_cmd), PATCHRAM_TIMEOUT) < 0) {
+		err = -1;
+		goto out;
+	}
+	msleep(300);
+
+	while (pos < fw->size) {
+		size_t len;
+		len = fw->data[pos + 2] + 3;
+		if ((pos + len > fw->size) ||
+			(usb_control_msg(udev, usb_sndctrlpipe(udev, 0), 0,
+			USB_TYPE_CLASS, 0, 0, (void *)fw->data + pos, len,
+			PATCHRAM_TIMEOUT) < 0)) {
+			err = -1;
+			goto out;
+		}
+		pos += len;
+	}
+
+	err = (usb_control_msg(udev, usb_sndctrlpipe(udev, 0), 0, USB_TYPE_CLASS, 0, 0,
+		reset_cmd, sizeof(reset_cmd), PATCHRAM_TIMEOUT) < 0);
+out:
+	if (err)
+		BT_INFO("fail to load firmware, may not work correctly");
+	release_firmware(fw);
+}
+
 static int btusb_probe(struct usb_interface *intf,
 				const struct usb_device_id *id)
 {
@@ -1001,6 +1069,8 @@ static int btusb_probe(struct usb_interface *intf,
 	init_usb_anchor(&data->isoc_anchor);
 	init_usb_anchor(&data->deferred);
 
+	data->id = id;
+
 	hdev = hci_alloc_dev();
 	if (!hdev) {
 		kfree(data);
@@ -1019,6 +1089,7 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->flush    = btusb_flush;
 	hdev->send     = btusb_send_frame;
 	hdev->notify   = btusb_notify;
+	hdev->load_firmware = btusb_load_firmware;
 
 	/* Interface numbers are hardcoded in the specification */
 	data->isoc = usb_ifnum_to_if(data->udev, 1);
-- 
1.7.9.5
