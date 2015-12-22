Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: syamsidhardh@gmail.com, Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 2/3] Bluetooth: bfusb: Remove redundant error message
Date: Tue, 22 Dec 2015 19:30:19 +0530
Message-id: <1450792820-15352-2-git-send-email-s.syam@samsung.com>
In-reply-to: <1450792820-15352-1-git-send-email-s.syam@samsung.com>
References: <1450792820-15352-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

devm_kzalloc prints its own OOM message upon failure.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 drivers/bluetooth/bfusb.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 72d8bfa..c304102 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -636,10 +636,8 @@ static int bfusb_probe(struct usb_interface *intf, const struct usb_device_id *i
 
 	/* Initialize control structure and load firmware */
 	data = devm_kzalloc(&intf->dev, sizeof(struct bfusb_data), GFP_KERNEL);
-	if (!data) {
-		BT_ERR("Can't allocate memory for control structure");
+	if (!data)
 		goto done;
-	}
 
 	data->udev = udev;
 	data->bulk_in_ep    = bulk_in_ep->desc.bEndpointAddress;
-- 
1.7.9.5

