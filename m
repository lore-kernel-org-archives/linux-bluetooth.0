Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
        <frederic.dalleau@collabora.co.uk>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
        <frederic.dalleau@collabora.co.uk>
Subject: [RFC] Bluetooth: Do not allocate skb for hci requests
Date: Thu, 25 Aug 2016 22:16:02 +0200
Message-Id: <1472156162-2300-1-git-send-email-frederic.dalleau@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If hci request do not use the skb they are provided with, it could be
interesting to avoid the allocation. Using hci_req_run provides the
expected result. As that implementation adds a few duplicate lines
of code, and it still needs more tests, I send this as RFC.
Let me know what you think.
Fred

Signed-off-by: Frédéric Dalleau <frederic.dalleau@collabora.co.uk>
---
 net/bluetooth/hci_request.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index b0e23df..a40a3fe 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -89,7 +89,7 @@ int hci_req_run_skb(struct hci_request *req, hci_req_complete_skb_t complete)
 	return req_run(req, NULL, complete);
 }
 
-static void hci_req_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
+static void hci_cmd_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 				  struct sk_buff *skb)
 {
 	BT_DBG("%s result 0x%2.2x", hdev->name, result);
@@ -103,6 +103,17 @@ static void hci_req_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 	}
 }
 
+static void hci_req_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode)
+{
+	BT_DBG("%s result 0x%2.2x", hdev->name, result);
+
+	if (hdev->req_status == HCI_REQ_PEND) {
+		hdev->req_result = result;
+		hdev->req_status = HCI_REQ_DONE;
+		wake_up_interruptible(&hdev->req_wait_q);
+	}
+}
+
 void hci_req_sync_cancel(struct hci_dev *hdev, int err)
 {
 	BT_DBG("%s err 0x%2.2x", hdev->name, err);
@@ -133,7 +144,7 @@ struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
 	add_wait_queue(&hdev->req_wait_q, &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
 
-	err = hci_req_run_skb(&req, hci_req_sync_complete);
+	err = hci_req_run_skb(&req, hci_cmd_sync_complete);
 	if (err < 0) {
 		remove_wait_queue(&hdev->req_wait_q, &wait);
 		set_current_state(TASK_RUNNING);
@@ -211,7 +222,7 @@ int __hci_req_sync(struct hci_dev *hdev, int (*func)(struct hci_request *req,
 	add_wait_queue(&hdev->req_wait_q, &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
 
-	err = hci_req_run_skb(&req, hci_req_sync_complete);
+	err = hci_req_run(&req, hci_req_sync_complete);
 	if (err < 0) {
 		hdev->req_status = 0;
 
-- 
2.7.4

