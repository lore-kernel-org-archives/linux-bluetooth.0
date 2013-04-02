Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] Bluetooth: Remove driver init queue from core
Date: Tue,  2 Apr 2013 20:21:27 +0300
Message-Id: <1364923287-25935-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1364923287-25935-1-git-send-email-johan.hedberg@gmail.com>
References: <1364923287-25935-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcel Holtmann <marcel@holtmann.org>

The driver init queue is no longer needed. This can be all handled
inside the drivers now. So remove it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Acked-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 --
 net/bluetooth/hci_core.c         |   23 -----------------------
 2 files changed, 25 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b464b2e..88dd46e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -268,8 +268,6 @@ struct hci_dev {
 
 	struct hci_dev_stats	stat;
 
-	struct sk_buff_head	driver_init;
-
 	atomic_t		promisc;
 
 	struct dentry		*debugfs;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cd93986..2b488ed 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -201,29 +201,9 @@ static void amp_init(struct hci_request *req)
 static void hci_init1_req(struct hci_request *req, unsigned long opt)
 {
 	struct hci_dev *hdev = req->hdev;
-	struct hci_request init_req;
-	struct sk_buff *skb;
 
 	BT_DBG("%s %ld", hdev->name, opt);
 
-	/* Driver initialization */
-
-	hci_req_init(&init_req, hdev);
-
-	/* Special commands */
-	while ((skb = skb_dequeue(&hdev->driver_init))) {
-		bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
-		skb->dev = (void *) hdev;
-
-		if (skb_queue_empty(&init_req.cmd_q))
-			bt_cb(skb)->req.start = true;
-
-		skb_queue_tail(&init_req.cmd_q, skb);
-	}
-	skb_queue_purge(&hdev->driver_init);
-
-	hci_req_run(&init_req, NULL);
-
 	/* Reset */
 	if (!test_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks))
 		hci_reset_req(req, 0);
@@ -2026,7 +2006,6 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
 
-	skb_queue_head_init(&hdev->driver_init);
 	skb_queue_head_init(&hdev->rx_q);
 	skb_queue_head_init(&hdev->cmd_q);
 	skb_queue_head_init(&hdev->raw_q);
@@ -2045,8 +2024,6 @@ EXPORT_SYMBOL(hci_alloc_dev);
 /* Free HCI device */
 void hci_free_dev(struct hci_dev *hdev)
 {
-	skb_queue_purge(&hdev->driver_init);
-
 	/* will free via device release */
 	put_device(&hdev->dev);
 }
-- 
1.7.10.4

