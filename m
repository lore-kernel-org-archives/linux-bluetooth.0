Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/14] Bluetooth: Add transaction cmd_complete and cmd_status functions
Date: Fri, 22 Feb 2013 15:12:32 +0200
Message-Id: <1361538759-13558-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1361538759-13558-1-git-send-email-johan.hedberg@gmail.com>
References: <1361538759-13558-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch introduces functions to process the transaction state when
receiving HCI Command Status or Command Complete events. Some HCI
commands, like Inquiry do not result in a Command complete event so
special handling is needed for them. Inquiry is a particularly important
one since it is the only forseeable "non-cmd_complete" command that will
make good use of the transaction framework, and its completion is either
indicated by an Inquiry Complete event of a successful Command Complete
for HCI_Inquiry_Cancel.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_core.c         |   69 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |    7 ++++
 3 files changed, 78 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8c2553f..038f8c7a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1056,6 +1056,8 @@ int hci_transaction_run(struct hci_transaction *transaction);
 int hci_transaction_cmd(struct hci_transaction *transaction, u16 opcode,
 			u32 plen, void *param);
 void hci_transaction_from_skb(struct hci_dev *hdev, struct sk_buff *skb);
+void hci_transaction_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status);
+void hci_transaction_cmd_status(struct hci_dev *hdev, u16 opcode, u8 status);
 
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
 void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 93fa440..c3ce832 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3217,6 +3217,75 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
+static bool transaction_is_complete(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+
+	skb = skb_peek(&hdev->cmd_q);
+	if (!skb)
+		return true;
+
+	return bt_cb(skb)->transaction.start;
+}
+
+void hci_transaction_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status)
+{
+	unsigned long flags;
+	struct sk_buff *skb;
+
+	BT_DBG("opcode 0x%04x status 0x%02x", opcode, status);
+
+	/* Check that the completed command really matches the last one
+	 * that was sent.
+	 */
+	if (!hci_sent_cmd_data(hdev, opcode))
+		return;
+
+	/* If the command succeeded and there's still more commands in
+	 * this transaction the transaction is not yet complete.
+	 */
+	if (!status && !transaction_is_complete(hdev))
+		return;
+
+	/* Remove all pending commands belonging to this transaction */
+	spin_lock_irqsave(&hdev->cmd_q.lock, flags);
+	while ((skb = __skb_dequeue(&hdev->cmd_q))) {
+		if (bt_cb(skb)->transaction.start) {
+			__skb_queue_head(&hdev->cmd_q, skb);
+			break;
+		}
+
+		kfree_skb(skb);
+	}
+	spin_unlock_irqrestore(&hdev->cmd_q.lock, flags);
+
+	if (hdev->transaction_complete) {
+		hdev->transaction_complete(hdev, opcode, status);
+		hdev->transaction_complete = NULL;
+	}
+}
+
+void hci_transaction_cmd_status(struct hci_dev *hdev, u16 opcode, u8 status)
+{
+	BT_DBG("opcode 0x%04x status 0x%02x", opcode, status);
+
+	if (status) {
+		hci_transaction_cmd_complete(hdev, opcode, status);
+		return;
+	}
+
+	/* No need to handle success status if there are more commands */
+	if (!transaction_is_complete(hdev))
+		return;
+
+	/* If the transaction doesn't have a complete callback or there
+	 * are other commands/transactions in the hdev queue we consider
+	 * this transaction as completed.
+	 */
+	if (!hdev->transaction_complete || !skb_queue_empty(&hdev->cmd_q))
+		hci_transaction_cmd_complete(hdev, opcode, status);
+}
+
 static void hci_rx_work(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev, rx_work);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 14e872a..6dd5fd4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -53,6 +53,7 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 	hci_dev_unlock(hdev);
 
+	hci_transaction_cmd_complete(hdev, HCI_OP_INQUIRY, status);
 	hci_req_complete(hdev, HCI_OP_INQUIRY_CANCEL, status);
 
 	hci_conn_check_pending(hdev);
@@ -1692,6 +1693,7 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
+	hci_transaction_cmd_complete(hdev, HCI_OP_INQUIRY, status);
 	hci_req_complete(hdev, HCI_OP_INQUIRY, status);
 
 	hci_conn_check_pending(hdev);
@@ -2254,6 +2256,7 @@ static void hci_qos_setup_complete_evt(struct hci_dev *hdev,
 static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_cmd_complete *ev = (void *) skb->data;
+	u8 status = skb->data[sizeof(*ev)];
 	__u16 opcode;
 
 	skb_pull(skb, sizeof(*ev));
@@ -2497,6 +2500,8 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (ev->opcode != HCI_OP_NOP)
 		del_timer(&hdev->cmd_timer);
 
+	hci_transaction_cmd_complete(hdev, ev->opcode, status);
+
 	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags)) {
 		atomic_set(&hdev->cmd_cnt, 1);
 		if (!skb_queue_empty(&hdev->cmd_q))
@@ -2590,6 +2595,8 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (ev->opcode != HCI_OP_NOP)
 		del_timer(&hdev->cmd_timer);
 
+	hci_transaction_cmd_status(hdev, ev->opcode, ev->status);
+
 	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags)) {
 		atomic_set(&hdev->cmd_cnt, 1);
 		if (!skb_queue_empty(&hdev->cmd_q))
-- 
1.7.10.4

