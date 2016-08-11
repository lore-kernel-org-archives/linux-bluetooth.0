Return-Path: <wsa@the-dreams.de>
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-usb@vger.kernel.org
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] bluetooth: bcm203x: don't print error when allocating urb fails
Date: Thu, 11 Aug 2016 22:51:34 +0200
Message-Id: <1470948695-23421-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1470948695-23421-1-git-send-email-wsa@the-dreams.de>
References: <1470948695-23421-1-git-send-email-wsa@the-dreams.de>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Wolfram Sang <wsa-dev@sang-engineering.com>

kmalloc will print enough information in case of failure.

Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>
---
 drivers/bluetooth/bcm203x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/bcm203x.c b/drivers/bluetooth/bcm203x.c
index 5b0ef7bbe8ac87..5ce6d4176dc302 100644
--- a/drivers/bluetooth/bcm203x.c
+++ b/drivers/bluetooth/bcm203x.c
@@ -185,10 +185,8 @@ static int bcm203x_probe(struct usb_interface *intf, const struct usb_device_id
 	data->state = BCM203X_LOAD_MINIDRV;
 
 	data->urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!data->urb) {
-		BT_ERR("Can't allocate URB");
+	if (!data->urb)
 		return -ENOMEM;
-	}
 
 	if (request_firmware(&firmware, "BCM2033-MD.hex", &udev->dev) < 0) {
 		BT_ERR("Mini driver request failed");
-- 
2.8.1
