Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/12 v3] Bluetooth: Enable HCI transaction support cmd_status 0
Date: Fri, 15 Feb 2013 11:51:56 +0200
Message-Id: <1360921920-14080-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1360921920-14080-1-git-send-email-johan.hedberg@gmail.com>
References: <1360921920-14080-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Some HCI commands do not result in a command complete event and generate
an intermediate command status 0 in between. Inquiry is one of these
procedures and needs to be handled properly since the legacy ioctl for
it uses hci_request which in turn will make use of the HCI transaction
framework.

If the ncmd HCI event parameter indicates that we can send more commands
to the controller we should do it if we have any commands in our queue.
However, for the ongoing HCI transaction to be properly notified for
completion we need to hold off this notification if possible when the
command status event comes.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |   28 ++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |    8 ++++++--
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fd8d305..ce7fbf7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1062,6 +1062,7 @@ int hci_complete_transaction(struct hci_dev *hdev,
 			     void (*complete)(struct hci_dev *hdev,
 					      __u16 last_cmd, int status));
 bool hci_transaction_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status);
+bool hci_transaction_cmd_status(struct hci_dev *hdev, u16 opcode, u8 status);
 int hci_transaction_from_skb(struct hci_dev *hdev, struct sk_buff *skb);
 
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bc2d7f2..2565bb1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3091,6 +3091,8 @@ bool hci_transaction_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status)
 {
 	bool queue_empty;
 
+	BT_DBG("opcode 0x%04x status 0x%02x", opcode, status);
+
 	/* Ignore this event if it doesn't match the last HCI command
 	 * that was sent
 	 */
@@ -3114,6 +3116,32 @@ unlock:
 	return queue_empty;
 }
 
+bool hci_transaction_cmd_status(struct hci_dev *hdev, u16 opcode, u8 status)
+{
+	struct hci_transaction *transaction = hdev->current_transaction;
+
+	BT_DBG("opcode 0x%04x status 0x%02x", opcode, status);
+
+	if (status)
+		return hci_transaction_cmd_complete(hdev, opcode, status);
+
+	if (!transaction)
+		return true;
+
+	/* If there are no more commands for this transaction and it *
+	 * doesn't have a complete callback or there are other
+	 * commands/transactions in the hdev queue we consider this
+	 * transaction as completed. Otherwise reply that the queue is
+	 * empty so that we wait for the event that really indicates
+	 * that the pending command is complete.
+	 */
+	if (skb_queue_empty(&transaction->cmd_q) &&
+	    (!transaction->complete || !list_empty(&hdev->transaction_q)))
+		return hci_transaction_cmd_complete(hdev, opcode, status);
+
+	return true;
+}
+
 static void hci_rx_work(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev, rx_work);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7f198ba..1045a31 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -40,6 +40,8 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
+	hci_transaction_cmd_complete(hdev, HCI_OP_INQUIRY, status);
+
 	if (status) {
 		hci_dev_lock(hdev);
 		mgmt_stop_discovery_failed(hdev, status);
@@ -1944,6 +1946,7 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
 	hci_req_complete(hdev, HCI_OP_INQUIRY, status);
+	hci_transaction_cmd_complete(hdev, HCI_OP_INQUIRY, status);
 
 	hci_conn_check_pending(hdev);
 
@@ -2846,8 +2849,9 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (ev->opcode != HCI_OP_NOP)
 		del_timer(&hdev->cmd_timer);
 
-	queue_empty = hci_transaction_cmd_complete(hdev, ev->opcode,
-						   ev->status);
+	queue_empty = hci_transaction_cmd_status(hdev, ev->opcode, ev->status);
+
+	BT_DBG("queue_empty %u, ev->ncmd %u", queue_empty, ev->ncmd);
 
 	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags)) {
 		atomic_set(&hdev->cmd_cnt, 1);
-- 
1.7.10.4

