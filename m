Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix race condition with HCI_RESET flag
Date: Sat, 28 Mar 2015 11:17:36 +0200
Message-Id: <1427534256-2395-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

During the HCI init phase a completed request might be the last part of
the setup procedure after which the actual init procedure starts. The
init procedure begins with a call to hci_reset_req() which sets the
HCI_RESET flag. The purpose of this flag is to make us ignore any
updates to ncmd/cmd_cnt as long as we haven't received the command
complete event for the HCI_Reset. There's a potential race with this
however:

	hci_req_cmd_complete(hdev, opcode, status);

	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags)) {
		atomic_set(&hdev->cmd_cnt, 1);
		if (!skb_queue_empty(&hdev->cmd_q))
			queue_work(hdev->workqueue, &hdev->cmd_work);
	}

Since the hci_req_cmd_complete() will trigger the completion of the
setup stage, it's possible that hci_reset_req() gets called before we
try to read ev->ncmd and the HCI_RESET flag. Because of this the cmd_cnt
would never be updated and the hci_reset_req() in practice ends up
blocking itself.

This patch fixes the issue by updating cmd_cnt before notifying the
request completion, and then reading it again to determine whether the
cmd_work should be queued or not.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 62f92a508961..3ac23964e108 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3027,13 +3027,13 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (opcode != HCI_OP_NOP)
 		cancel_delayed_work(&hdev->cmd_timer);
 
+	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags))
+		atomic_set(&hdev->cmd_cnt, 1);
+
 	hci_req_cmd_complete(hdev, opcode, status);
 
-	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags)) {
-		atomic_set(&hdev->cmd_cnt, 1);
-		if (!skb_queue_empty(&hdev->cmd_q))
-			queue_work(hdev->workqueue, &hdev->cmd_work);
-	}
+	if (atomic_read(&hdev->cmd_cnt) && !skb_queue_empty(&hdev->cmd_q))
+		queue_work(hdev->workqueue, &hdev->cmd_work);
 }
 
 static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
@@ -3122,15 +3122,15 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (opcode != HCI_OP_NOP)
 		cancel_delayed_work(&hdev->cmd_timer);
 
+	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags))
+		atomic_set(&hdev->cmd_cnt, 1);
+
 	if (ev->status ||
 	    (hdev->sent_cmd && !bt_cb(hdev->sent_cmd)->req_event))
 		hci_req_cmd_complete(hdev, opcode, ev->status);
 
-	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags)) {
-		atomic_set(&hdev->cmd_cnt, 1);
-		if (!skb_queue_empty(&hdev->cmd_q))
-			queue_work(hdev->workqueue, &hdev->cmd_work);
-	}
+	if (atomic_read(&hdev->cmd_cnt) && !skb_queue_empty(&hdev->cmd_q))
+		queue_work(hdev->workqueue, &hdev->cmd_work);
 }
 
 static void hci_hardware_error_evt(struct hci_dev *hdev, struct sk_buff *skb)
-- 
2.1.0

