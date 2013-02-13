Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/12] Bluetooth: Switch from hdev->cmd_q to using transactions
Date: Wed, 13 Feb 2013 16:50:38 +0200
Message-Id: <1360767045-26958-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1360767045-26958-1-git-send-email-johan.hedberg@gmail.com>
References: <1360767045-26958-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch converts the code from using a single hdev->cmd_q HCI command
queue to use the HCI transaction infrastructure.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c  |   87 ++++++++++++++++++++++++++++++++++++++-------
 net/bluetooth/hci_event.c |   11 ++++--
 net/bluetooth/hci_sock.c  |    5 +--
 3 files changed, 87 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 72abf9c..2c0ad61 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -80,10 +80,18 @@ void hci_req_complete(struct hci_dev *hdev, __u16 cmd, int result)
 			return;
 
 		skb = skb_clone(hdev->sent_cmd, GFP_ATOMIC);
+		hci_transaction_lock(hdev);
 		if (skb) {
-			skb_queue_head(&hdev->cmd_q, skb);
-			queue_work(hdev->workqueue, &hdev->cmd_work);
+			struct hci_transaction *transaction =
+						hdev->current_transaction;
+			if (transaction) {
+				skb_queue_head(&transaction->cmd_q, skb);
+				queue_work(hdev->workqueue, &hdev->cmd_work);
+			} else {
+				kfree_skb(skb);
+			}
 		}
+		hci_transaction_unlock(hdev);
 
 		return;
 	}
@@ -203,22 +211,30 @@ static void amp_init(struct hci_dev *hdev)
 
 static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
 {
+	struct hci_transaction *transaction;
 	struct sk_buff *skb;
 
 	BT_DBG("%s %ld", hdev->name, opt);
 
 	/* Driver initialization */
 
+	if (hci_start_transaction(hdev) < 0)
+		return;
+
+	hci_transaction_lock(hdev);
+
+	transaction = hdev->build_transaction;
+
 	/* Special commands */
 	while ((skb = skb_dequeue(&hdev->driver_init))) {
 		bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
 		skb->dev = (void *) hdev;
-
-		skb_queue_tail(&hdev->cmd_q, skb);
-		queue_work(hdev->workqueue, &hdev->cmd_work);
+		skb_queue_tail(&transaction->cmd_q, skb);
 	}
 	skb_queue_purge(&hdev->driver_init);
 
+	hci_transaction_unlock(hdev);
+
 	/* Reset */
 	if (!test_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks))
 		hci_reset_req(hdev, 0);
@@ -236,6 +252,8 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
 		BT_ERR("Unknown device type %d", hdev->dev_type);
 		break;
 	}
+
+	hci_complete_transaction(hdev, NULL);
 }
 
 static void hci_scan_req(struct hci_dev *hdev, unsigned long opt)
@@ -2312,6 +2330,7 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 	int len = HCI_COMMAND_HDR_SIZE + plen;
 	struct hci_command_hdr *hdr;
 	struct sk_buff *skb;
+	int err;
 
 	BT_DBG("%s opcode 0x%4.4x plen %d", hdev->name, opcode, plen);
 
@@ -2336,10 +2355,41 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 	if (test_bit(HCI_INIT, &hdev->flags))
 		hdev->init_last_cmd = opcode;
 
-	skb_queue_tail(&hdev->cmd_q, skb);
-	queue_work(hdev->workqueue, &hdev->cmd_work);
+	err = 0;
 
-	return 0;
+	hci_transaction_lock(hdev);
+
+	/* If this is part of a multi-command transaction (i.e.
+	 * hci_start_transaction() has been called) just add the skb to
+	 * the end of the transaction being built.
+	 */
+	if (hdev->build_transaction) {
+		skb_queue_tail(&hdev->build_transaction->cmd_q, skb);
+		goto unlock;
+	}
+
+	/* If we're in the middle of a hci_request the req lock will be
+	 * held and our only choice is to append to the request
+	 * transaction.
+	 */
+	if (hdev->req_status && hdev->current_transaction) {
+		skb_queue_tail(&hdev->current_transaction->cmd_q, skb);
+		goto unlock;
+	}
+
+	/* This is neither a multi-command transaction nor a hci_request
+	 * situation, but simply hci_send_cmd being called without any
+	 * existing context. Create a simple one-command transaction out
+	 * of the skb
+	 */
+	err = __transaction_from_skb(hdev, skb);
+	if (err < 0)
+		kfree_skb(skb);
+
+unlock:
+	hci_transaction_unlock(hdev);
+
+	return err;
 }
 
 /* Get data from the previously sent command */
@@ -3129,16 +3179,26 @@ static void hci_rx_work(struct work_struct *work)
 static void hci_cmd_work(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev, cmd_work);
+	struct hci_transaction *transaction;
 	struct sk_buff *skb;
 
+	hci_transaction_lock(hdev);
+
+	__transaction_next(hdev, 0, 0);
+	transaction = hdev->current_transaction;
+
 	BT_DBG("%s cmd_cnt %d cmd queued %d", hdev->name,
-	       atomic_read(&hdev->cmd_cnt), skb_queue_len(&hdev->cmd_q));
+	       atomic_read(&hdev->cmd_cnt),
+	       transaction ? skb_queue_len(&transaction->cmd_q) : 0);
+
+	if (!transaction)
+		goto unlock;
 
 	/* Send queued commands */
 	if (atomic_read(&hdev->cmd_cnt)) {
-		skb = skb_dequeue(&hdev->cmd_q);
+		skb = skb_dequeue(&transaction->cmd_q);
 		if (!skb)
-			return;
+			goto unlock;
 
 		kfree_skb(hdev->sent_cmd);
 
@@ -3152,10 +3212,13 @@ static void hci_cmd_work(struct work_struct *work)
 				mod_timer(&hdev->cmd_timer,
 					  jiffies + HCI_CMD_TIMEOUT);
 		} else {
-			skb_queue_head(&hdev->cmd_q, skb);
+			skb_queue_head(&transaction->cmd_q, skb);
 			queue_work(hdev->workqueue, &hdev->cmd_work);
 		}
 	}
+
+unlock:
+	hci_transaction_unlock(hdev);
 }
 
 int hci_do_inquiry(struct hci_dev *hdev, u8 length)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 477726a..13d0f1a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2505,6 +2505,8 @@ static void hci_qos_setup_complete_evt(struct hci_dev *hdev,
 static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_cmd_complete *ev = (void *) skb->data;
+	u8 status = skb->data[sizeof(*ev)];
+	bool queue_empty;
 	__u16 opcode;
 
 	skb_pull(skb, sizeof(*ev));
@@ -2748,9 +2750,11 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (ev->opcode != HCI_OP_NOP)
 		del_timer(&hdev->cmd_timer);
 
+	queue_empty = hci_transaction_cmd_complete(hdev, ev->opcode, status);
+
 	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags)) {
 		atomic_set(&hdev->cmd_cnt, 1);
-		if (!skb_queue_empty(&hdev->cmd_q))
+		if (!queue_empty)
 			queue_work(hdev->workqueue, &hdev->cmd_work);
 	}
 }
@@ -2758,6 +2762,7 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_cmd_status *ev = (void *) skb->data;
+	bool queue_empty;
 	__u16 opcode;
 
 	skb_pull(skb, sizeof(*ev));
@@ -2841,9 +2846,11 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (ev->opcode != HCI_OP_NOP)
 		del_timer(&hdev->cmd_timer);
 
+	queue_empty = hci_transaction_cmd_complete(hdev, ev->opcode, ev->status);
+
 	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags)) {
 		atomic_set(&hdev->cmd_cnt, 1);
-		if (!skb_queue_empty(&hdev->cmd_q))
+		if (!queue_empty)
 			queue_work(hdev->workqueue, &hdev->cmd_work);
 	}
 }
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 07f0739..bf008f9 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -859,8 +859,9 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 			skb_queue_tail(&hdev->raw_q, skb);
 			queue_work(hdev->workqueue, &hdev->tx_work);
 		} else {
-			skb_queue_tail(&hdev->cmd_q, skb);
-			queue_work(hdev->workqueue, &hdev->cmd_work);
+			err = hci_transaction_from_skb(hdev, skb);
+			if (err < 0)
+				goto drop;
 		}
 	} else {
 		if (!capable(CAP_NET_RAW)) {
-- 
1.7.10.4

