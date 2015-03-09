Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/7] Bluetooth: Remove unneeded recv_event variable
Date: Mon,  9 Mar 2015 13:03:38 +0200
Message-Id: <1425899021-16414-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1425899021-16414-1-git-send-email-johan.hedberg@gmail.com>
References: <1425899021-16414-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that the synchronous HCI requests use the new API and a new private
variable the recv_evt member of hci_dev is no-longer needed. This patch
removes it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_core.c         |  3 ---
 net/bluetooth/hci_event.c        | 12 ------------
 3 files changed, 16 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 65215245c913..e340cc96bc5c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -315,7 +315,6 @@ struct hci_dev {
 	struct sk_buff_head	raw_q;
 	struct sk_buff_head	cmd_q;
 
-	struct sk_buff		*recv_evt;
 	struct sk_buff		*sent_cmd;
 	struct sk_buff		*reassembly[NUM_REASSEMBLY];
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2619bff1bdfb..f8f1401d5dd7 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1690,9 +1690,6 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		hdev->sent_cmd = NULL;
 	}
 
-	kfree_skb(hdev->recv_evt);
-	hdev->recv_evt = NULL;
-
 	/* After this point our queues are empty
 	 * and no tasks are scheduled. */
 	hdev->close(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index dbaf8159c4ad..380e38a1a3c9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5042,18 +5042,6 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	u8 status = 0, event = hdr->evt;
 	u16 opcode = HCI_OP_NOP;
 
-	hci_dev_lock(hdev);
-
-	/* Received events are (currently) only needed when a request is
-	 * ongoing so avoid unnecessary memory allocation.
-	 */
-	if (hci_req_pending(hdev)) {
-		kfree_skb(hdev->recv_evt);
-		hdev->recv_evt = skb_clone(skb, GFP_KERNEL);
-	}
-
-	hci_dev_unlock(hdev);
-
 	if (hdev->sent_cmd && bt_cb(hdev->sent_cmd)->req_event == event) {
 		struct hci_command_hdr *cmd_hdr = (void *) hdev->sent_cmd->data;
 		opcode = __le16_to_cpu(cmd_hdr->opcode);
-- 
2.1.0

