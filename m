Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Check hci_req_run error code in __hci_req_sync
Date: Wed,  6 Mar 2013 20:45:14 -0300
Message-Id: <1362613517-1761-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1362613517-1761-1-git-send-email-andre.guedes@openbossa.org>
References: <1362613517-1761-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since hci_req_run will be returning more than one error code, we
should check its returning value in __hci_req_sync.

This patch also changes the returning value of hci_req_run in case
the HCI request is empty.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b6d44a2..a1bbf6d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -101,7 +101,7 @@ static int __hci_req_sync(struct hci_dev *hdev,
 	func(&req, opt);
 
 	err = hci_req_run(&req, hci_req_sync_complete);
-	if (err < 0) {
+	if (err == -ENODATA) {
 		hdev->req_status = 0;
 		remove_wait_queue(&hdev->req_wait_q, &wait);
 		/* req_run will fail if the request did not add any
@@ -112,6 +112,11 @@ static int __hci_req_sync(struct hci_dev *hdev,
 		 */
 		return 0;
 	}
+	if (err < 0) {
+		hdev->req_status = HCI_REQ_CANCELED;
+		remove_wait_queue(&hdev->req_wait_q, &wait);
+		return err;
+	}
 
 	schedule_timeout(timeout);
 
@@ -2453,7 +2458,7 @@ int hci_req_run(struct hci_request *req, hci_req_complete_t complete)
 
 	/* Do not allow empty requests */
 	if (skb_queue_empty(&req->cmd_q))
-		return -EINVAL;
+		return -ENODATA;
 
 	skb = skb_peek_tail(&req->cmd_q);
 	bt_cb(skb)->req.complete = complete;
-- 
1.8.1.2

