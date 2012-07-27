Return-Path: <cyrus@holtmann.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	sachin.kamat@linaro.org,
	patches@linaro.org
Subject: [PATCH 04/11] Bluetooth: Use devm_kzalloc in bpa10x.c file
Date: Fri, 27 Jul 2012 12:38:34 +0530
Message-Id: <1343372921-18780-5-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
References: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

devm_kzalloc() eliminates the need to free memory explicitly
thereby saving some cleanup code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/bluetooth/bpa10x.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index 29caaed..2fe4a80 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -443,7 +443,7 @@ static int bpa10x_probe(struct usb_interface *intf, const struct usb_device_id *
 	if (intf->cur_altsetting->desc.bInterfaceNumber != 0)
 		return -ENODEV;
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(&intf->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -453,10 +453,8 @@ static int bpa10x_probe(struct usb_interface *intf, const struct usb_device_id *
 	init_usb_anchor(&data->rx_anchor);
 
 	hdev = hci_alloc_dev();
-	if (!hdev) {
-		kfree(data);
+	if (!hdev)
 		return -ENOMEM;
-	}
 
 	hdev->bus = HCI_USB;
 	hci_set_drvdata(hdev, data);
@@ -475,7 +473,6 @@ static int bpa10x_probe(struct usb_interface *intf, const struct usb_device_id *
 	err = hci_register_dev(hdev);
 	if (err < 0) {
 		hci_free_dev(hdev);
-		kfree(data);
 		return err;
 	}
 
@@ -500,7 +497,6 @@ static void bpa10x_disconnect(struct usb_interface *intf)
 	hci_free_dev(data->hdev);
 	kfree_skb(data->rx_skb[0]);
 	kfree_skb(data->rx_skb[1]);
-	kfree(data);
 }
 
 static struct usb_driver bpa10x_driver = {
-- 
1.7.4.1
