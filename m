Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 2/2] Bluetooth: bcm203x: Use GFP_KERNEL in workqueue
Date: Tue, 25 Oct 2011 21:13:36 +0200
Message-Id: <1319570016-7439-2-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1319570016-7439-1-git-send-email-dh.herrmann@googlemail.com>
References: <1319570016-7439-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

A workqueue is allowed to sleep so we can safely use GFP_KERNEL instead of
GFP_ATOMIC. This is still legacy code when the driver used timer BHs and not a
worqueue.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/bcm203x.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/bcm203x.c b/drivers/bluetooth/bcm203x.c
index 6b42732..d644cf7 100644
--- a/drivers/bluetooth/bcm203x.c
+++ b/drivers/bluetooth/bcm203x.c
@@ -162,7 +162,7 @@ static void bcm203x_work(struct work_struct *work)
 	if (atomic_read(&data->shutdown))
 		return;
 
-	if (usb_submit_urb(data->urb, GFP_ATOMIC) < 0)
+	if (usb_submit_urb(data->urb, GFP_KERNEL) < 0)
 		BT_ERR("Can't submit URB");
 }
 
-- 
1.7.7.1
