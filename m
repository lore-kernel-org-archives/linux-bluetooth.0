Return-Path: <cyrus@holtmann.org>
From: "Jesse Sung" <jesse.sung@canonical.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Cache firmware images for later use
Date: Fri, 31 Aug 2012 13:21:50 +0800
Message-Id: <1346390510-18538-3-git-send-email-jesse.sung@canonical.com>
In-Reply-To: <1346390510-18538-1-git-send-email-jesse.sung@canonical.com>
References: <1346390510-18538-1-git-send-email-jesse.sung@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Wen-chien Jesse Sung <jesse.sung@canonical.com>

Since request_firmware() may fail when resume from suspend, store
used firmware image in ram to make sure that we can have what we need
on resume.

Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
---
 drivers/bluetooth/btusb.c |   77 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 60 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7189fed..8bf9e89 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -218,18 +218,34 @@ MODULE_FIRMWARE(FW_0A5C_21F3);
 MODULE_FIRMWARE(FW_0A5C_21F4);
 MODULE_FIRMWARE(FW_413C_8197);
 
+struct firmware_cache {
+	const char *filename;
+	u8* data;
+	size_t size;
+};
+
+static struct firmware_cache firmware[] = {
+	{ .filename = FW_0A5C_21D3, },
+	{ .filename = FW_0A5C_21D7, },
+	{ .filename = FW_413C_8197, },
+	{ .filename = FW_0489_E031, },
+	{ .filename = FW_0A5C_21E6, },
+	{ .filename = FW_0A5C_21F3, },
+	{ .filename = FW_0A5C_21F4, },
+};
+
 static struct usb_device_id patchram_table[] = {
 	/* Dell DW1704 */
-	{ USB_DEVICE(0x0a5c, 0x21d3), .driver_info = (kernel_ulong_t) FW_0A5C_21D3 },
-	{ USB_DEVICE(0x0a5c, 0x21d7), .driver_info = (kernel_ulong_t) FW_0A5C_21D7 },
+	{ USB_DEVICE(0x0a5c, 0x21d3), .driver_info = (kernel_ulong_t) &firmware[0] },
+	{ USB_DEVICE(0x0a5c, 0x21d7), .driver_info = (kernel_ulong_t) &firmware[1] },
 	/* Dell DW380 */
-	{ USB_DEVICE(0x413c, 0x8197), .driver_info = (kernel_ulong_t) FW_413C_8197 },
+	{ USB_DEVICE(0x413c, 0x8197), .driver_info = (kernel_ulong_t) &firmware[2] },
 	/* FoxConn Hon Hai */
-	{ USB_DEVICE(0x0489, 0xe031), .driver_info = (kernel_ulong_t) FW_0489_E031 },
+	{ USB_DEVICE(0x0489, 0xe031), .driver_info = (kernel_ulong_t) &firmware[3] },
 	/* Lenovo */
-	{ USB_DEVICE(0x0a5c, 0x21e6), .driver_info = (kernel_ulong_t) FW_0A5C_21E6 },
-	{ USB_DEVICE(0x0a5c, 0x21f3), .driver_info = (kernel_ulong_t) FW_0A5C_21F3 },
-	{ USB_DEVICE(0x0a5c, 0x21f4), .driver_info = (kernel_ulong_t) FW_0A5C_21F4 },
+	{ USB_DEVICE(0x0a5c, 0x21e6), .driver_info = (kernel_ulong_t) &firmware[4] },
+	{ USB_DEVICE(0x0a5c, 0x21f3), .driver_info = (kernel_ulong_t) &firmware[5] },
+	{ USB_DEVICE(0x0a5c, 0x21f4), .driver_info = (kernel_ulong_t) &firmware[6] },
 };
 
 #define BTUSB_MAX_ISOC_FRAMES	10
@@ -953,14 +969,27 @@ static inline void load_patchram_fw(struct usb_device *udev, const struct usb_de
 {
 	size_t pos = 0;
 	int err = 0;
-	const struct firmware *fw;
+	struct firmware_cache *fwcache;
 
 	unsigned char reset_cmd[] = { 0x03, 0x0c, 0x00 };
 	unsigned char download_cmd[] = { 0x2e, 0xfc, 0x00 };
 
-	if (request_firmware(&fw, (const char *) id->driver_info, &udev->dev) < 0) {
-		BT_INFO("can't load firmware, may not work correctly");
-		return;
+	fwcache = (struct firmware_cache *)id->driver_info;
+	if (!fwcache->data) {
+		const struct firmware *fw;
+		if (request_firmware(&fw, fwcache->filename, &udev->dev) < 0) {
+			BT_INFO("can't load firmware, may not work correctly");
+			return;
+		}
+		fwcache->data = kmalloc(fw->size, GFP_KERNEL);
+		if (!fwcache->data) {
+			BT_INFO("OOM");
+			release_firmware(fw);
+			return;
+		}
+		fwcache->size = fw->size;
+		memcpy(fwcache->data, fw->data, fwcache->size);
+		release_firmware(fw);
 	}
 
 	if (usb_control_msg(udev, usb_sndctrlpipe(udev, 0), 0, USB_TYPE_CLASS, 0, 0,
@@ -977,12 +1006,12 @@ static inline void load_patchram_fw(struct usb_device *udev, const struct usb_de
 	}
 	msleep(300);
 
-	while (pos < fw->size) {
+	while (pos < fwcache->size) {
 		size_t len;
-		len = fw->data[pos + 2] + 3;
-		if ((pos + len > fw->size) ||
+		len = fwcache->data[pos + 2] + 3;
+		if ((pos + len > fwcache->size) ||
 			(usb_control_msg(udev, usb_sndctrlpipe(udev, 0), 0,
-			USB_TYPE_CLASS, 0, 0, (void *)fw->data + pos, len,
+			USB_TYPE_CLASS, 0, 0, (void *)(fwcache->data + pos), len,
 			PATCHRAM_TIMEOUT) < 0)) {
 			err = -1;
 			goto out;
@@ -995,7 +1024,6 @@ static inline void load_patchram_fw(struct usb_device *udev, const struct usb_de
 out:
 	if (err)
 		BT_INFO("fail to load firmware, may not work correctly");
-	release_firmware(fw);
 }
 
 static int btusb_probe(struct usb_interface *intf,
@@ -1326,7 +1354,22 @@ static struct usb_driver btusb_driver = {
 	.disable_hub_initiated_lpm = 1,
 };
 
-module_usb_driver(btusb_driver);
+static int __init btusb_init(void)
+{
+	return usb_register(&btusb_driver);
+}
+
+static void __exit btusb_exit(void)
+{
+	int i;
+	for (i = 0; i < sizeof(firmware) / sizeof(firmware[0]); i++)
+		if (firmware[i].data)
+			kfree(firmware[i].data);
+	usb_deregister(&btusb_driver);
+}
+
+module_init(btusb_init);
+module_exit(btusb_exit);
 
 module_param(ignore_dga, bool, 0644);
 MODULE_PARM_DESC(ignore_dga, "Ignore devices with id 08fd:0001");
-- 
1.7.9.5

