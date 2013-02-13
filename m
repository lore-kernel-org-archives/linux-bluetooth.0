Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/12] Bluetooth: Add HCI init sequence support for HCI transactions
Date: Wed, 13 Feb 2013 16:50:42 +0200
Message-Id: <1360767045-26958-10-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1360767045-26958-1-git-send-email-johan.hedberg@gmail.com>
References: <1360767045-26958-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There's a special quirk needed for unexpected HCI reset command
completes during the init process. This patch adds this quirk to the HCI
transaction code so that hci_init_req can be converted to use the HCI
transaction framework.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c |   45 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 05914d8..c75acb2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3089,17 +3089,56 @@ next_in_queue:
 	hdev->current_transaction = transaction;
 }
 
+static void hci_resend_last(struct hci_dev *hdev)
+{
+	struct hci_transaction *transaction;
+	struct hci_command_hdr *sent;
+	struct sk_buff *skb;
+	u16 opcode;
+
+	if (!hdev->sent_cmd)
+		return;
+
+	sent = (void *) hdev->sent_cmd->data;
+	opcode = __le16_to_cpu(sent->opcode);
+
+	skb = skb_clone(hdev->sent_cmd, GFP_ATOMIC);
+	if (!skb)
+		return;
+
+	hci_transaction_lock(hdev);
+
+	transaction = hdev->current_transaction;
+	if (transaction) {
+		skb_queue_head(&transaction->cmd_q, skb);
+		queue_work(hdev->workqueue, &hdev->cmd_work);
+	} else {
+		kfree_skb(skb);
+	}
+
+	hci_transaction_unlock(hdev);
+}
+
 bool hci_transaction_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status)
 {
 	bool queue_empty;
 
 	BT_DBG("opcode 0x%04x status 0x%02x", opcode, status);
 
-	/* Ignore this event if it doesn't match the last HCI command
-	 * that was sent
+	/* If the completed command doesn't match the last one that was
+	 * sent we need to do special handling of it.
 	 */
-	if (!hci_sent_cmd_data(hdev, opcode))
+	if (!hci_sent_cmd_data(hdev, opcode)) {
+		/* Some CSR based controllers generate a spontaneous
+		 * reset complete event during init and any pending
+		 * command will never be completed. In such a case we
+		 * need to resend whatever was the last sent
+		 * command.
+		 */
+		if (test_bit(HCI_INIT, &hdev->flags) && opcode == HCI_OP_RESET)
+			hci_resend_last(hdev);
 		return false;
+	}
 
 	hci_transaction_lock(hdev);
 
-- 
1.7.10.4

