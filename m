Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] Bluetooth: Remove unneeded recv_event variable
Date: Thu,  5 Feb 2015 11:18:22 +0200
Message-Id: <1423127905-27281-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1423127905-27281-1-git-send-email-johan.hedberg@gmail.com>
References: <1423127905-27281-1-git-send-email-johan.hedberg@gmail.com>
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
index c2952660981e..ed2220e607e4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -314,7 +314,6 @@ struct hci_dev {
 	struct sk_buff_head	raw_q;
 	struct sk_buff_head	cmd_q;
 
-	struct sk_buff		*recv_evt;
 	struct sk_buff		*sent_cmd;
 	struct sk_buff		*reassembly[NUM_REASSEMBLY];
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2c4caa9f9f93..47129ef01c0f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1674,9 +1674,6 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		hdev->sent_cmd = NULL;
 	}
 
-	kfree_skb(hdev->recv_evt);
-	hdev->recv_evt = NULL;
-
 	/* After this point our queues are empty
 	 * and no tasks are scheduled. */
 	hdev->close(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 52f13f8f4234..791dfdfc18a4 100644
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
 	if (hdev->sent_cmd && bt_cb(hdev->sent_cmd)->req.event == event) {
 		struct hci_command_hdr *cmd_hdr = (void *) hdev->sent_cmd->data;
 		opcode = __le16_to_cpu(cmd_hdr->opcode);
-- 
2.1.0

