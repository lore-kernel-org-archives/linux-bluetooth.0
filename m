Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 06/18] Bluetooth: btwilink: Remove empty destruct cb
Date: Sat,  7 Jan 2012 15:47:12 +0100
Message-Id: <1325947644-11736-7-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The destruct cb is optional so remove our empty dummy cb.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/btwilink.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
index b5f83b4..da9cf6a 100644
--- a/drivers/bluetooth/btwilink.c
+++ b/drivers/bluetooth/btwilink.c
@@ -291,14 +291,6 @@ static int ti_st_send_frame(struct sk_buff *skb)
 	return 0;
 }
 
-static void ti_st_destruct(struct hci_dev *hdev)
-{
-	BT_DBG("%s", hdev->name);
-	/* do nothing here, since platform remove
-	 * would free the hdev->driver_data
-	 */
-}
-
 static int bt_ti_probe(struct platform_device *pdev)
 {
 	static struct ti_st *hst;
@@ -325,7 +317,6 @@ static int bt_ti_probe(struct platform_device *pdev)
 	hdev->close = ti_st_close;
 	hdev->flush = NULL;
 	hdev->send = ti_st_send_frame;
-	hdev->destruct = ti_st_destruct;
 	hdev->owner = THIS_MODULE;
 
 	err = hci_register_dev(hdev);
-- 
1.7.8.1
