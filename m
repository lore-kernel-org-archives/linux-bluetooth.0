Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix setting state back to TASK_RUNNING
Date: Wed, 19 Nov 2014 13:16:41 +0200
Message-Id: <1416395801-9062-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In __hci_cmd_sync_ev() and __hci_req_sync() if the hci_req_run() call
fails and we return from the functions we should ensure that the state
doesn't remain in TASK_INTERRUPTIBLE that we just set it to. This patch
fixes missing calls to set_current_state(TASK_RUNNING) in both places.

Reported-by: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Tested-by: Kirill A. Shutemov <kirill@shutemov.name>
---
 net/bluetooth/hci_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d786958a1dec..a67a4b8e4e1c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1128,6 +1128,7 @@ struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
 	err = hci_req_run(&req, hci_req_sync_complete);
 	if (err < 0) {
 		remove_wait_queue(&hdev->req_wait_q, &wait);
+		set_current_state(TASK_RUNNING);
 		return ERR_PTR(err);
 	}
 
@@ -1196,6 +1197,7 @@ static int __hci_req_sync(struct hci_dev *hdev,
 		hdev->req_status = 0;
 
 		remove_wait_queue(&hdev->req_wait_q, &wait);
+		set_current_state(TASK_RUNNING);
 
 		/* ENODATA means the HCI request command queue is empty.
 		 * This can happen when a request with conditionals doesn't
-- 
2.1.0

