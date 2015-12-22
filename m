Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: syamsidhardh@gmail.com, Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 3/3] Bluetooth: bfusb: Fix the return error code
Date: Tue, 22 Dec 2015 19:30:20 +0530
Message-id: <1450792820-15352-3-git-send-email-s.syam@samsung.com>
In-reply-to: <1450792820-15352-1-git-send-email-s.syam@samsung.com>
References: <1450792820-15352-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

-ENOMEM is the appropriate error code instead of -EIO.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 drivers/bluetooth/bfusb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index c304102..3bf4ec6 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -637,7 +637,7 @@ static int bfusb_probe(struct usb_interface *intf, const struct usb_device_id *i
 	/* Initialize control structure and load firmware */
 	data = devm_kzalloc(&intf->dev, sizeof(struct bfusb_data), GFP_KERNEL);
 	if (!data)
-		goto done;
+		return -ENOMEM;
 
 	data->udev = udev;
 	data->bulk_in_ep    = bulk_in_ep->desc.bEndpointAddress;
-- 
1.7.9.5

