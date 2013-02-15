Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/12 v2] Bluetooth: Add hci_transaction_cmd_complete function
Date: Fri, 15 Feb 2013 10:30:25 +0200
Message-Id: <1360917034-5503-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1360917034-5503-1-git-send-email-johan.hedberg@gmail.com>
References: <1360917034-5503-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This function is used to process the HCI transaction state, including
things like picking the next command to send, calling the complete
callback for the current transaction and moving the next transaction
from the queue (if any) to hdev->current_transaction.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |   65 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5cd58f5..54efaa2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1062,6 +1062,7 @@ int hci_start_transaction(struct hci_dev *hdev);
 int hci_complete_transaction(struct hci_dev *hdev,
 			     void (*complete)(struct hci_dev *hdev,
 					      __u16 last_cmd, int status));
+bool hci_transaction_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status);
 
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
 void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7739f58..c564440 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2976,6 +2976,71 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
+static void __transaction_next(struct hci_dev *hdev, u16 opcode, int status)
+{
+	struct hci_transaction *transaction;
+
+	transaction = hdev->current_transaction;
+	if (!transaction)
+		goto next_in_queue;
+
+	if (status || skb_queue_empty(&transaction->cmd_q)) {
+		hdev->current_transaction = NULL;
+
+		/* We need to give up the transaction lock temporarily
+		 * since the complete callback might trigger a deadlock
+		 */
+		hci_transaction_unlock(hdev);
+		if (transaction->complete)
+			transaction->complete(hdev, opcode, status);
+		__transaction_free(transaction);
+		hci_transaction_lock(hdev);
+
+		transaction = hdev->current_transaction;
+	}
+
+	if (transaction)
+		return;
+
+next_in_queue:
+	if (list_empty(&hdev->transaction_q))
+		return;
+
+	transaction = list_first_entry(&hdev->transaction_q,
+				       struct hci_transaction, list);
+	if (transaction)
+		list_del(&transaction->list);
+
+	hdev->current_transaction = transaction;
+}
+
+bool hci_transaction_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status)
+{
+	bool queue_empty;
+
+	/* Ignore this event if it doesn't match the last HCI command
+	 * that was sent
+	 */
+	if (!hci_sent_cmd_data(hdev, opcode))
+		return false;
+
+	hci_transaction_lock(hdev);
+
+	__transaction_next(hdev, opcode, status);
+
+	if (!hdev->current_transaction) {
+		queue_empty = true;
+		goto unlock;
+	}
+
+	queue_empty = skb_queue_empty(&hdev->current_transaction->cmd_q);
+
+unlock:
+	hci_transaction_unlock(hdev);
+
+	return queue_empty;
+}
+
 static void hci_rx_work(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev, rx_work);
-- 
1.7.10.4

