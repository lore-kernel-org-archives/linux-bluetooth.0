Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 05/15] Bluetooth: Introduce new hci_transaction_cmd function
Date: Fri, 22 Feb 2013 16:48:22 +0200
Message-Id: <1361544512-4056-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1361544512-4056-1-git-send-email-johan.hedberg@gmail.com>
References: <1361544512-4056-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This function is analogous to hci_send_cmd() but instead of directly
queuing the command to hdev->cmd_q it adds it to the local queue of the
transaction being build (in struct hci_transaction).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_core.c         |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e97d8e5..777005c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1053,6 +1053,8 @@ void hci_transaction_init(struct hci_transaction *transaction,
 			  struct hci_dev *hdev,
 			  transaction_complete_t complete);
 int hci_transaction_run(struct hci_transaction *transaction);
+int hci_transaction_cmd(struct hci_transaction *transaction, u16 opcode,
+			u32 plen, void *param);
 
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
 void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 73fb344..561d574 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -175,6 +175,16 @@ static int hci_request(struct hci_dev *hdev,
 	return ret;
 }
 
+/* Mark an skb as the starting point for a transaction */
+static void transaction_start(struct sk_buff *skb,
+			      transaction_complete_t complete)
+{
+	struct transaction_ctrl *cb = &bt_cb(skb)->transaction;
+
+	cb->start = 1;
+	cb->complete = complete;
+}
+
 static void hci_reset_req(struct hci_dev *hdev, unsigned long opt)
 {
 	BT_DBG("%s %ld", hdev->name, opt);
@@ -2513,6 +2523,29 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 	return 0;
 }
 
+/* Queue a command to a HCI transaction */
+int hci_transaction_cmd(struct hci_transaction *transaction, u16 opcode,
+			u32 plen, void *param)
+{
+	struct hci_dev *hdev = transaction->hdev;
+	struct sk_buff *skb;
+
+	BT_DBG("%s opcode 0x%4.4x plen %d", hdev->name, opcode, plen);
+
+	skb = prepare_cmd(hdev, opcode, plen, param);
+	if (!skb) {
+		BT_ERR("%s no memory for command", hdev->name);
+		return -ENOMEM;
+	}
+
+	if (skb_queue_empty(&transaction->cmd_q))
+		transaction_start(skb, transaction->complete);
+
+	skb_queue_tail(&transaction->cmd_q, skb);
+
+	return 0;
+}
+
 /* Get data from the previously sent command */
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
 {
-- 
1.7.10.4

