Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/14 v2] Bluetooth: Add initial skeleton for HCI transaction framework
Date: Fri, 22 Feb 2013 15:34:00 +0200
Message-Id: <1361540040-14488-1-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1361538759-13558-4-git-send-email-johan.hedberg@gmail.com>
References: <1361538759-13558-4-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds the initial definitions and functions for HCI
transactions. HCI transactions are essentially a group of HCI commands
together with an optional completion callback. The transaction is
tracked through the already existing command queue by having the
necessary context information as part of the control buffer of each skb.

The only information needed in the skb control buffer is a flag for
indicating that the skb is the start of a transaction as well as the
optional complete callback that should be used for the transaction (this
will only be set for skbs that also have the start flag set).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
v2: Use splice_tail() instead of splice() so that new transactions don't
    get precedence over ones already part of hdev->cmd_q

 include/net/bluetooth/bluetooth.h |   11 +++++++++++
 include/net/bluetooth/hci_core.h  |   13 +++++++++++++
 net/bluetooth/hci_core.c          |   35 +++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 9531bee..9e1d197 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -260,12 +260,23 @@ struct l2cap_ctrl {
 	__u8		retries;
 };
 
+struct hci_dev;
+
+typedef void (*transaction_complete_t)(struct hci_dev *hdev, u16 last_cmd,
+				       int status);
+
+struct transaction_ctrl {
+	__u8			start;
+	transaction_complete_t	complete;
+};
+
 struct bt_skb_cb {
 	__u8 pkt_type;
 	__u8 incoming;
 	__u16 expect;
 	__u8 force_active;
 	struct l2cap_ctrl control;
+	struct transaction_ctrl transaction;
 };
 #define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 787d3b9..e97d8e5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -248,6 +248,8 @@ struct hci_dev {
 	__u32			req_status;
 	__u32			req_result;
 
+	transaction_complete_t	transaction_complete;
+
 	__u16			init_last_cmd;
 
 	struct list_head	mgmt_pending;
@@ -1041,6 +1043,17 @@ static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
 int hci_register_cb(struct hci_cb *hcb);
 int hci_unregister_cb(struct hci_cb *hcb);
 
+struct hci_transaction {
+	struct hci_dev		*hdev;
+	struct sk_buff_head	cmd_q;
+	transaction_complete_t	complete;
+};
+
+void hci_transaction_init(struct hci_transaction *transaction,
+			  struct hci_dev *hdev,
+			  transaction_complete_t complete);
+int hci_transaction_run(struct hci_transaction *transaction);
+
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
 void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
 void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9730424..51bf551 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2435,6 +2435,36 @@ static int hci_send_frame(struct sk_buff *skb)
 	return hdev->send(skb);
 }
 
+void hci_transaction_init(struct hci_transaction *transaction,
+			  struct hci_dev *hdev,
+			  transaction_complete_t complete)
+{
+	memset(transaction, 0, sizeof(*transaction));
+	skb_queue_head_init(&transaction->cmd_q);
+	transaction->hdev = hdev;
+	transaction->complete = complete;
+}
+
+int hci_transaction_run(struct hci_transaction *transaction)
+{
+	struct hci_dev *hdev = transaction->hdev;
+	unsigned long flags;
+
+	BT_DBG("length %u", skb_queue_len(&transaction->cmd_q));
+
+	/* Do not allow empty transactions */
+	if (skb_queue_empty(&transaction->cmd_q))
+		return -EINVAL;
+
+	spin_lock_irqsave(&hdev->cmd_q.lock, flags);
+	skb_queue_splice_tail(&transaction->cmd_q, &hdev->cmd_q);
+	spin_unlock_irqrestore(&hdev->cmd_q.lock, flags);
+
+	queue_work(hdev->workqueue, &hdev->cmd_work);
+
+	return 0;
+}
+
 /* Send HCI command */
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 {
@@ -3209,6 +3239,11 @@ static void hci_cmd_work(struct work_struct *work)
 		hdev->sent_cmd = skb_clone(skb, GFP_ATOMIC);
 		if (hdev->sent_cmd) {
 			atomic_dec(&hdev->cmd_cnt);
+
+			if (bt_cb(skb)->transaction.start)
+				hdev->transaction_complete =
+					bt_cb(skb)->transaction.complete;
+
 			hci_send_frame(skb);
 			if (test_bit(HCI_RESET, &hdev->flags))
 				del_timer(&hdev->cmd_timer);
-- 
1.7.10.4

