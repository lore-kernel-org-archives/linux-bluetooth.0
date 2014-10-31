Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2] Bluetooth : Fix hci_sync miss wakeup interrupt
Date: Fri, 31 Oct 2014 14:23:06 +0900
Message-id: <1414732986-20487-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

__hci_cmd_sync_ev(), __hci_req_sync() could miss wake_up_interrupt from
hci_req_sync_complete() because hci_cmd_work() workquee and its reponse
could be completed before they are ready to get the signal through
add_wait_queue(), set_current_state(TASK_INTERRUPTIBLE).

Signed-off-by: Chan-yeol Park <chanyeol.park@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 net/bluetooth/hci_core.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cb05d7f..c008f1f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1147,13 +1147,15 @@ struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
 
 	hdev->req_status = HCI_REQ_PEND;
 
-	err = hci_req_run(&req, hci_req_sync_complete);
-	if (err < 0)
-		return ERR_PTR(err);
-
 	add_wait_queue(&hdev->req_wait_q, &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
 
+	err = hci_req_run(&req, hci_req_sync_complete);
+	if (err < 0) {
+		remove_wait_queue(&hdev->req_wait_q, &wait);
+		return ERR_PTR(err);
+	}
+
 	schedule_timeout(timeout);
 
 	remove_wait_queue(&hdev->req_wait_q, &wait);
@@ -1211,10 +1213,15 @@ static int __hci_req_sync(struct hci_dev *hdev,
 
 	func(&req, opt);
 
+	add_wait_queue(&hdev->req_wait_q, &wait);
+	set_current_state(TASK_INTERRUPTIBLE);
+
 	err = hci_req_run(&req, hci_req_sync_complete);
 	if (err < 0) {
 		hdev->req_status = 0;
 
+		remove_wait_queue(&hdev->req_wait_q, &wait);
+
 		/* ENODATA means the HCI request command queue is empty.
 		 * This can happen when a request with conditionals doesn't
 		 * trigger any commands to be sent. This is normal behavior
@@ -1226,9 +1233,6 @@ static int __hci_req_sync(struct hci_dev *hdev,
 		return err;
 	}
 
-	add_wait_queue(&hdev->req_wait_q, &wait);
-	set_current_state(TASK_INTERRUPTIBLE);
-
 	schedule_timeout(timeout);
 
 	remove_wait_queue(&hdev->req_wait_q, &wait);
-- 
1.9.1

