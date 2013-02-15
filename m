Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/12 v2] Bluetooth: Remove unused hdev->cmd_q HCI command queue
Date: Fri, 15 Feb 2013 10:30:28 +0200
Message-Id: <1360917034-5503-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1360917034-5503-1-git-send-email-johan.hedberg@gmail.com>
References: <1360917034-5503-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch removes the now unused hdev->cmd_q HCI command queue. The HCI
transaction framework takes care of the same functionality.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    1 -
 net/bluetooth/hci_core.c         |    5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b5c6f99..fd8d305 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -247,7 +247,6 @@ struct hci_dev {
 
 	struct sk_buff_head	rx_q;
 	struct sk_buff_head	raw_q;
-	struct sk_buff_head	cmd_q;
 
 	struct mutex		transaction_lock;
 	struct hci_transaction	*build_transaction;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 48ea6e1..2c6f524 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -808,7 +808,6 @@ int hci_dev_open(__u16 dev)
 		flush_work(&hdev->rx_work);
 
 		hci_transaction_cleanup(hdev);
-		skb_queue_purge(&hdev->cmd_q);
 		skb_queue_purge(&hdev->rx_q);
 
 		if (hdev->flush)
@@ -873,7 +872,6 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 
 	/* Reset device */
 	hci_transaction_cleanup(hdev);
-	skb_queue_purge(&hdev->cmd_q);
 	atomic_set(&hdev->cmd_cnt, 1);
 	if (!test_bit(HCI_RAW, &hdev->flags) &&
 	    test_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks)) {
@@ -887,7 +885,6 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 
 	/* Drop queues */
 	skb_queue_purge(&hdev->rx_q);
-	skb_queue_purge(&hdev->cmd_q);
 	hci_transaction_cleanup(hdev);
 	skb_queue_purge(&hdev->raw_q);
 
@@ -958,7 +955,6 @@ int hci_dev_reset(__u16 dev)
 
 	/* Drop queues */
 	skb_queue_purge(&hdev->rx_q);
-	skb_queue_purge(&hdev->cmd_q);
 	hci_transaction_cleanup(hdev);
 
 	hci_dev_lock(hdev);
@@ -1785,7 +1781,6 @@ struct hci_dev *hci_alloc_dev(void)
 
 	skb_queue_head_init(&hdev->driver_init);
 	skb_queue_head_init(&hdev->rx_q);
-	skb_queue_head_init(&hdev->cmd_q);
 	skb_queue_head_init(&hdev->raw_q);
 
 	init_waitqueue_head(&hdev->req_wait_q);
-- 
1.7.10.4

