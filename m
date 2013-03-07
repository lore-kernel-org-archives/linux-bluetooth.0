Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/6] Bluetooth: Fix __hci_req_sync
Date: Thu,  7 Mar 2013 18:48:07 -0300
Message-Id: <1362692892-28716-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1362692892-28716-1-git-send-email-andre.guedes@openbossa.org>
References: <1362692892-28716-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If hci_req_run returns error, we erroneously leave the current
process in TASK_INTERRUPTABLE state. If we leave the process in
TASK_INTERRUPTABLE and it is preempted, this process will never
be scheduled again.

This patch fixes this issue by moving the preparation for scheduling
(add to waitqueue and set process state) to just after the hci_req_run
call.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b6d44a2..a3e3c96 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -95,15 +95,11 @@ static int __hci_req_sync(struct hci_dev *hdev,
 
 	hdev->req_status = HCI_REQ_PEND;
 
-	add_wait_queue(&hdev->req_wait_q, &wait);
-	set_current_state(TASK_INTERRUPTIBLE);
-
 	func(&req, opt);
 
 	err = hci_req_run(&req, hci_req_sync_complete);
 	if (err < 0) {
 		hdev->req_status = 0;
-		remove_wait_queue(&hdev->req_wait_q, &wait);
 		/* req_run will fail if the request did not add any
 		 * commands to the queue, something that can happen when
 		 * a request with conditionals doesn't trigger any
@@ -113,6 +109,9 @@ static int __hci_req_sync(struct hci_dev *hdev,
 		return 0;
 	}
 
+	add_wait_queue(&hdev->req_wait_q, &wait);
+	set_current_state(TASK_INTERRUPTIBLE);
+
 	schedule_timeout(timeout);
 
 	remove_wait_queue(&hdev->req_wait_q, &wait);
-- 
1.8.1.2

