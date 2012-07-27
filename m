Return-Path: <cyrus@holtmann.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	sachin.kamat@linaro.org,
	patches@linaro.org
Subject: [PATCH 01/11] Bluetooth: Use devm_kzalloc in bcm203x.c file.
Date: Fri, 27 Jul 2012 12:38:31 +0530
Message-Id: <1343372921-18780-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
References: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

devm_kzalloc() eliminates the need to free memory explicitly
thereby saving some cleanup code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/bluetooth/bcm203x.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/bcm203x.c b/drivers/bluetooth/bcm203x.c
index 37ae175..364f82b 100644
--- a/drivers/bluetooth/bcm203x.c
+++ b/drivers/bluetooth/bcm203x.c
@@ -177,7 +177,7 @@ static int bcm203x_probe(struct usb_interface *intf, const struct usb_device_id
 	if (intf->cur_altsetting->desc.bInterfaceNumber != 0)
 		return -ENODEV;
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(&intf->dev, sizeof(*data), GFP_KERNEL);
 	if (!data) {
 		BT_ERR("Can't allocate memory for data structure");
 		return -ENOMEM;
@@ -189,14 +189,12 @@ static int bcm203x_probe(struct usb_interface *intf, const struct usb_device_id
 	data->urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!data->urb) {
 		BT_ERR("Can't allocate URB");
-		kfree(data);
 		return -ENOMEM;
 	}
 
 	if (request_firmware(&firmware, "BCM2033-MD.hex", &udev->dev) < 0) {
 		BT_ERR("Mini driver request failed");
 		usb_free_urb(data->urb);
-		kfree(data);
 		return -EIO;
 	}
 
@@ -209,7 +207,6 @@ static int bcm203x_probe(struct usb_interface *intf, const struct usb_device_id
 		BT_ERR("Can't allocate memory for mini driver");
 		release_firmware(firmware);
 		usb_free_urb(data->urb);
-		kfree(data);
 		return -ENOMEM;
 	}
 
@@ -224,7 +221,6 @@ static int bcm203x_probe(struct usb_interface *intf, const struct usb_device_id
 		BT_ERR("Firmware request failed");
 		usb_free_urb(data->urb);
 		kfree(data->buffer);
-		kfree(data);
 		return -EIO;
 	}
 
@@ -236,7 +232,6 @@ static int bcm203x_probe(struct usb_interface *intf, const struct usb_device_id
 		release_firmware(firmware);
 		usb_free_urb(data->urb);
 		kfree(data->buffer);
-		kfree(data);
 		return -ENOMEM;
 	}
 
@@ -271,7 +266,6 @@ static void bcm203x_disconnect(struct usb_interface *intf)
 	usb_free_urb(data->urb);
 	kfree(data->fw_data);
 	kfree(data->buffer);
-	kfree(data);
 }
 
 static struct usb_driver bcm203x_driver = {
-- 
1.7.4.1
