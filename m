Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/12 v2] Bluetooth: Add basic start/complete HCI transaction functions
Date: Fri, 15 Feb 2013 10:30:24 +0200
Message-Id: <1360917034-5503-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1360917034-5503-1-git-send-email-johan.hedberg@gmail.com>
References: <1360917034-5503-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

With these functions it will be possible to declare the start and end of
a transaction. hci_start_transaction() creates hdev->build_transaction
which will be used by hci_send_command() to construct a transaction.
hci_complete_transaction() indicates the end of a transaction with an
optional complete callback to be called once the transaction is
complete. The transaction is either moved to hdev->current_transaction
(if no other transaction is in progress) or appended to
hdev->transaction_q.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    5 +++
 net/bluetooth/hci_core.c         |   80 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0e53032..5cd58f5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1058,6 +1058,11 @@ int hci_unregister_cb(struct hci_cb *hcb);
 #define hci_transaction_lock(d)		mutex_lock(&d->transaction_lock)
 #define hci_transaction_unlock(d)	mutex_unlock(&d->transaction_lock)
 
+int hci_start_transaction(struct hci_dev *hdev);
+int hci_complete_transaction(struct hci_dev *hdev,
+			     void (*complete)(struct hci_dev *hdev,
+					      __u16 last_cmd, int status));
+
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
 void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
 void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 05e2e8b..7739f58 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2196,6 +2196,86 @@ static int hci_send_frame(struct sk_buff *skb)
 	return hdev->send(skb);
 }
 
+int hci_start_transaction(struct hci_dev *hdev)
+{
+	struct hci_transaction *transaction;
+	int err;
+
+	hci_transaction_lock(hdev);
+
+	/* We can't start a new transaction if there's another one in
+	 * progress of being built.
+	 */
+	if (hdev->build_transaction) {
+		err = -EBUSY;
+		goto unlock;
+	}
+
+	transaction = kzalloc(sizeof(*transaction), GFP_ATOMIC);
+	if (!transaction) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	skb_queue_head_init(&transaction->cmd_q);
+
+	hdev->build_transaction = transaction;
+
+	err = 0;
+
+unlock:
+	hci_transaction_unlock(hdev);
+
+	return err;
+}
+
+static void __transaction_add(struct hci_dev *hdev,
+			      struct hci_transaction *transaction)
+{
+	if (hdev->current_transaction || !list_empty(&hdev->transaction_q)) {
+		list_add_tail(&transaction->list, &hdev->transaction_q);
+	} else {
+		hdev->current_transaction = transaction;
+		queue_work(hdev->workqueue, &hdev->cmd_work);
+	}
+}
+
+int hci_complete_transaction(struct hci_dev *hdev,
+			     void (*complete)(struct hci_dev *hdev,
+					      __u16 last_cmd, int status))
+{
+	struct hci_transaction *transaction;
+	int err;
+
+	hci_transaction_lock(hdev);
+
+	transaction = hdev->build_transaction;
+	if (!transaction) {
+		err = -EINVAL;
+		goto unlock;
+	}
+
+	hdev->build_transaction = NULL;
+
+	/* Do not allow empty transactions */
+	if (skb_queue_empty(&transaction->cmd_q)) {
+		__transaction_free(transaction);
+		err = -EINVAL;
+		goto unlock;
+	}
+
+	transaction->complete = complete;
+
+	__transaction_add(hdev, transaction);
+
+	err = 0;
+
+unlock:
+	hci_transaction_unlock(hdev);
+
+	return err;
+}
+
 /* Send HCI command */
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 {
-- 
1.7.10.4

