Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Remove driver init queue from core
Date: Mon, 12 Nov 2012 14:02:16 +0900
Message-Id: <1352696536-13937-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The driver init queue is no longer needed. This can be all handled
inside the drivers now. So remove it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  2 --
 net/bluetooth/hci_core.c         | 15 ---------------
 2 files changed, 17 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c14d52e..4e007db 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -261,8 +261,6 @@ struct hci_dev {
 
 	struct hci_dev_stats	stat;
 
-	struct sk_buff_head	driver_init;
-
 	atomic_t		promisc;
 
 	struct dentry		*debugfs;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 52acfee..50066f3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -203,22 +203,10 @@ static void amp_init(struct hci_dev *hdev)
 
 static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
 {
-	struct sk_buff *skb;
-
 	BT_DBG("%s %ld", hdev->name, opt);
 
 	/* Driver initialization */
 
-	/* Special commands */
-	while ((skb = skb_dequeue(&hdev->driver_init))) {
-		bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
-		skb->dev = (void *) hdev;
-
-		skb_queue_tail(&hdev->cmd_q, skb);
-		queue_work(hdev->workqueue, &hdev->cmd_work);
-	}
-	skb_queue_purge(&hdev->driver_init);
-
 	/* Reset */
 	if (!test_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks))
 		hci_reset_req(hdev, 0);
@@ -1735,7 +1723,6 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
 
-	skb_queue_head_init(&hdev->driver_init);
 	skb_queue_head_init(&hdev->rx_q);
 	skb_queue_head_init(&hdev->cmd_q);
 	skb_queue_head_init(&hdev->raw_q);
@@ -1754,8 +1741,6 @@ EXPORT_SYMBOL(hci_alloc_dev);
 /* Free HCI device */
 void hci_free_dev(struct hci_dev *hdev)
 {
-	skb_queue_purge(&hdev->driver_init);
-
 	/* will free via device release */
 	put_device(&hdev->dev);
 }
-- 
1.7.11.7

