Return-Path: <cyrus@holtmann.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	sachin.kamat@linaro.org,
	patches@linaro.org
Subject: [PATCH 09/11] Bluetooth: Use devm_kzalloc in btusb.c file
Date: Fri, 27 Jul 2012 12:38:39 +0530
Message-Id: <1343372921-18780-10-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
References: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

devm_kzalloc() eliminates the need to free memory explicitly
thereby saving some cleanup code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/bluetooth/btusb.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e272214..f637c25 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -952,7 +952,7 @@ static int btusb_probe(struct usb_interface *intf,
 			return -ENODEV;
 	}
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(&intf->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -975,10 +975,8 @@ static int btusb_probe(struct usb_interface *intf,
 		}
 	}
 
-	if (!data->intr_ep || !data->bulk_tx_ep || !data->bulk_rx_ep) {
-		kfree(data);
+	if (!data->intr_ep || !data->bulk_tx_ep || !data->bulk_rx_ep)
 		return -ENODEV;
-	}
 
 	data->cmdreq_type = USB_TYPE_CLASS;
 
@@ -998,10 +996,8 @@ static int btusb_probe(struct usb_interface *intf,
 	init_usb_anchor(&data->deferred);
 
 	hdev = hci_alloc_dev();
-	if (!hdev) {
-		kfree(data);
+	if (!hdev)
 		return -ENOMEM;
-	}
 
 	hdev->bus = HCI_USB;
 	hci_set_drvdata(hdev, data);
@@ -1069,7 +1065,6 @@ static int btusb_probe(struct usb_interface *intf,
 							data->isoc, data);
 		if (err < 0) {
 			hci_free_dev(hdev);
-			kfree(data);
 			return err;
 		}
 	}
@@ -1077,7 +1072,6 @@ static int btusb_probe(struct usb_interface *intf,
 	err = hci_register_dev(hdev);
 	if (err < 0) {
 		hci_free_dev(hdev);
-		kfree(data);
 		return err;
 	}
 
@@ -1110,7 +1104,6 @@ static void btusb_disconnect(struct usb_interface *intf)
 		usb_driver_release_interface(&btusb_driver, data->isoc);
 
 	hci_free_dev(hdev);
-	kfree(data);
 }
 
 #ifdef CONFIG_PM
-- 
1.7.4.1
