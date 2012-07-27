Return-Path: <cyrus@holtmann.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
	sachin.kamat@linaro.org, patches@linaro.org
Subject: [PATCH 02/11] Bluetooth: Use devm_kzalloc in bfusb.c file
Date: Fri, 27 Jul 2012 12:38:32 +0530
Message-Id: <1343372921-18780-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
References: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

devm_kzalloc() eliminates the need to free memory explicitly
thereby saving some cleanup code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/bluetooth/bfusb.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 32e8251..995aee9 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -653,7 +653,7 @@ static int bfusb_probe(struct usb_interface *intf, const struct usb_device_id *i
 	}
 
 	/* Initialize control structure and load firmware */
-	data = kzalloc(sizeof(struct bfusb_data), GFP_KERNEL);
+	data = devm_kzalloc(&intf->dev, sizeof(struct bfusb_data), GFP_KERNEL);
 	if (!data) {
 		BT_ERR("Can't allocate memory for control structure");
 		goto done;
@@ -674,7 +674,7 @@ static int bfusb_probe(struct usb_interface *intf, const struct usb_device_id *i
 
 	if (request_firmware(&firmware, "bfubase.frm", &udev->dev) < 0) {
 		BT_ERR("Firmware request failed");
-		goto error;
+		goto done;
 	}
 
 	BT_DBG("firmware data %p size %zu", firmware->data, firmware->size);
@@ -690,7 +690,7 @@ static int bfusb_probe(struct usb_interface *intf, const struct usb_device_id *i
 	hdev = hci_alloc_dev();
 	if (!hdev) {
 		BT_ERR("Can't allocate HCI device");
-		goto error;
+		goto done;
 	}
 
 	data->hdev = hdev;
@@ -708,7 +708,7 @@ static int bfusb_probe(struct usb_interface *intf, const struct usb_device_id *i
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
 		hci_free_dev(hdev);
-		goto error;
+		goto done;
 	}
 
 	usb_set_intfdata(intf, data);
@@ -718,9 +718,6 @@ static int bfusb_probe(struct usb_interface *intf, const struct usb_device_id *i
 release:
 	release_firmware(firmware);
 
-error:
-	kfree(data);
-
 done:
 	return -EIO;
 }
@@ -741,7 +738,6 @@ static void bfusb_disconnect(struct usb_interface *intf)
 
 	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
-	kfree(data);
 }
 
 static struct usb_driver bfusb_driver = {
-- 
1.7.4.1

