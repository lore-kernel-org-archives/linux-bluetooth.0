Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: syamsidhardh@gmail.com, Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 1/3] Bluetooth: bcm203x: Remove redundant error message
Date: Tue, 22 Dec 2015 19:30:18 +0530
Message-id: <1450792820-15352-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

devm_kzalloc prints its own OOM message upon failure.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 drivers/bluetooth/bcm203x.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/bcm203x.c b/drivers/bluetooth/bcm203x.c
index 364f82b..5b0ef7b 100644
--- a/drivers/bluetooth/bcm203x.c
+++ b/drivers/bluetooth/bcm203x.c
@@ -178,10 +178,8 @@ static int bcm203x_probe(struct usb_interface *intf, const struct usb_device_id
 		return -ENODEV;
 
 	data = devm_kzalloc(&intf->dev, sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		BT_ERR("Can't allocate memory for data structure");
+	if (!data)
 		return -ENOMEM;
-	}
 
 	data->udev  = udev;
 	data->state = BCM203X_LOAD_MINIDRV;
-- 
1.7.9.5

