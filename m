Return-Path: <cyrus@holtmann.org>
From: Alexander Holler <holler@ahsoftware.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Alicke Xu <sxu@atheros.com>,
	"Luis R. Rodriguez" <lrodriguez@atheros.com>,
	Vikram Kandukuri <vikram.kandukuri@atheros.com>,
	linux-bluetooth@vger.kernel.org,
	Alexander Holler <holler@ahsoftware.de>
Subject: [PATCH] ath3k: reduce memory usage
Date: Mon, 22 Nov 2010 21:09:01 +0100
Message-Id: <1290456541-3812-1-git-send-email-holler@ahsoftware.de>
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to hold the firmware in memory.

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 drivers/bluetooth/ath3k.c |   75 ++++++++++++---------------------------------
 1 files changed, 20 insertions(+), 55 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 128cae4..81cd1ed 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -43,46 +43,40 @@ MODULE_DEVICE_TABLE(usb, ath3k_table);
 #define USB_REQ_DFU_DNLOAD	1
 #define BULK_SIZE		4096
 
-struct ath3k_data {
-	struct usb_device *udev;
-	u8 *fw_data;
-	u32 fw_size;
-	u32 fw_sent;
-};
-
-static int ath3k_load_firmware(struct ath3k_data *data,
-				unsigned char *firmware,
-				int count)
+static int ath3k_load_firmware(struct usb_device *udev,
+				const struct firmware *firmware)
 {
 	u8 *send_buf;
 	int err, pipe, len, size, sent = 0;
+	int count = firmware->size;
 
-	BT_DBG("ath3k %p udev %p", data, data->udev);
+	BT_DBG("udev %p", udev);
 
-	pipe = usb_sndctrlpipe(data->udev, 0);
+	pipe = usb_sndctrlpipe(udev, 0);
 
-	if ((usb_control_msg(data->udev, pipe,
+	send_buf = kmalloc(BULK_SIZE, GFP_ATOMIC);
+	if (!send_buf) {
+		BT_ERR("Can't allocate memory chunk for firmware");
+		return -ENOMEM;
+	}
+
+	memcpy(send_buf, firmware->data, 20);
+	if ((err = usb_control_msg(udev, pipe,
 				USB_REQ_DFU_DNLOAD,
 				USB_TYPE_VENDOR, 0, 0,
-				firmware, 20, USB_CTRL_SET_TIMEOUT)) < 0) {
+				send_buf, 20, USB_CTRL_SET_TIMEOUT)) < 0) {
 		BT_ERR("Can't change to loading configuration err");
-		return -EBUSY;
+		goto error;
 	}
 	sent += 20;
 	count -= 20;
 
-	send_buf = kmalloc(BULK_SIZE, GFP_ATOMIC);
-	if (!send_buf) {
-		BT_ERR("Can't allocate memory chunk for firmware");
-		return -ENOMEM;
-	}
-
 	while (count) {
 		size = min_t(uint, count, BULK_SIZE);
-		pipe = usb_sndbulkpipe(data->udev, 0x02);
-		memcpy(send_buf, firmware + sent, size);
+		pipe = usb_sndbulkpipe(udev, 0x02);
+		memcpy(send_buf, firmware->data + sent, size);
 
-		err = usb_bulk_msg(data->udev, pipe, send_buf, size,
+		err = usb_bulk_msg(udev, pipe, send_buf, size,
 					&len, 3000);
 
 		if (err || (len != size)) {
@@ -108,57 +102,28 @@ static int ath3k_probe(struct usb_interface *intf,
 {
 	const struct firmware *firmware;
 	struct usb_device *udev = interface_to_usbdev(intf);
-	struct ath3k_data *data;
-	int size;
 
 	BT_DBG("intf %p id %p", intf, id);
 
 	if (intf->cur_altsetting->desc.bInterfaceNumber != 0)
 		return -ENODEV;
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	data->udev = udev;
-
 	if (request_firmware(&firmware, "ath3k-1.fw", &udev->dev) < 0) {
-		kfree(data);
 		return -EIO;
 	}
 
-	size = max_t(uint, firmware->size, 4096);
-	data->fw_data = kmalloc(size, GFP_KERNEL);
-	if (!data->fw_data) {
+	if (ath3k_load_firmware(udev, firmware)) {
 		release_firmware(firmware);
-		kfree(data);
-		return -ENOMEM;
-	}
-
-	memcpy(data->fw_data, firmware->data, firmware->size);
-	data->fw_size = firmware->size;
-	data->fw_sent = 0;
-	release_firmware(firmware);
-
-	usb_set_intfdata(intf, data);
-	if (ath3k_load_firmware(data, data->fw_data, data->fw_size)) {
-		usb_set_intfdata(intf, NULL);
-		kfree(data->fw_data);
-		kfree(data);
 		return -EIO;
 	}
+	release_firmware(firmware);
 
 	return 0;
 }
 
 static void ath3k_disconnect(struct usb_interface *intf)
 {
-	struct ath3k_data *data = usb_get_intfdata(intf);
-
 	BT_DBG("ath3k_disconnect intf %p", intf);
-
-	kfree(data->fw_data);
-	kfree(data);
 }
 
 static struct usb_driver ath3k_driver = {
-- 
1.7.2.3
