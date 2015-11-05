Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Compress the size of struct hci_ctrl
Date: Thu,  5 Nov 2015 09:31:40 +0200
Message-Id: <1446708701-1387-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1446708701-1387-1-git-send-email-johan.hedberg@gmail.com>
References: <1446708701-1387-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We can reduce the size of the hci_ctrl struct by converting
'bool req_start' to 'u8 req_flags' and making the two function
pointers a union (since only one is ever set at a time).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/bluetooth.h | 11 ++++++++---
 net/bluetooth/hci_core.c          | 14 +++++++-------
 net/bluetooth/hci_request.c       | 10 +++++++---
 net/bluetooth/hci_sock.c          |  2 +-
 4 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index a85e6d3d75ef..8d38f411009c 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -296,12 +296,17 @@ typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status, u16 opcode);
 typedef void (*hci_req_complete_skb_t)(struct hci_dev *hdev, u8 status,
 				       u16 opcode, struct sk_buff *skb);
 
+#define HCI_REQ_START	BIT(0)
+#define HCI_REQ_SKB	BIT(1)
+
 struct hci_ctrl {
 	__u16 opcode;
-	bool req_start;
+	u8 req_flags;
 	u8 req_event;
-	hci_req_complete_t req_complete;
-	hci_req_complete_skb_t req_complete_skb;
+	union {
+		hci_req_complete_t req_complete;
+		hci_req_complete_skb_t req_complete_skb;
+	};
 };
 
 struct bt_skb_cb {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index aa4df13a8139..c270feaac8a1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3690,7 +3690,7 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
 	/* Stand-alone HCI commands must be flagged as
 	 * single-command requests.
 	 */
-	bt_cb(skb)->hci.req_start = true;
+	bt_cb(skb)->hci.req_flags |= HCI_REQ_START;
 
 	skb_queue_tail(&hdev->cmd_q, skb);
 	queue_work(hdev->workqueue, &hdev->cmd_work);
@@ -4387,7 +4387,7 @@ static bool hci_req_is_complete(struct hci_dev *hdev)
 	if (!skb)
 		return true;
 
-	return bt_cb(skb)->hci.req_start;
+	return (bt_cb(skb)->hci.req_flags & HCI_REQ_START);
 }
 
 static void hci_resend_last(struct hci_dev *hdev)
@@ -4447,20 +4447,20 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status,
 	 * callback would be found in hdev->sent_cmd instead of the
 	 * command queue (hdev->cmd_q).
 	 */
-	if (bt_cb(hdev->sent_cmd)->hci.req_complete) {
-		*req_complete = bt_cb(hdev->sent_cmd)->hci.req_complete;
+	if (bt_cb(hdev->sent_cmd)->hci.req_flags & HCI_REQ_SKB) {
+		*req_complete_skb = bt_cb(hdev->sent_cmd)->hci.req_complete_skb;
 		return;
 	}
 
-	if (bt_cb(hdev->sent_cmd)->hci.req_complete_skb) {
-		*req_complete_skb = bt_cb(hdev->sent_cmd)->hci.req_complete_skb;
+	if (bt_cb(hdev->sent_cmd)->hci.req_complete) {
+		*req_complete = bt_cb(hdev->sent_cmd)->hci.req_complete;
 		return;
 	}
 
 	/* Remove all pending commands belonging to this request */
 	spin_lock_irqsave(&hdev->cmd_q.lock, flags);
 	while ((skb = __skb_dequeue(&hdev->cmd_q))) {
-		if (bt_cb(skb)->hci.req_start) {
+		if (bt_cb(skb)->hci.req_flags & HCI_REQ_START) {
 			__skb_queue_head(&hdev->cmd_q, skb);
 			break;
 		}
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index bdb170995966..5ba27c30e8f2 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -56,8 +56,12 @@ static int req_run(struct hci_request *req, hci_req_complete_t complete,
 		return -ENODATA;
 
 	skb = skb_peek_tail(&req->cmd_q);
-	bt_cb(skb)->hci.req_complete = complete;
-	bt_cb(skb)->hci.req_complete_skb = complete_skb;
+	if (complete) {
+		bt_cb(skb)->hci.req_complete = complete;
+	} else if (complete_skb) {
+		bt_cb(skb)->hci.req_complete_skb = complete_skb;
+		bt_cb(skb)->hci.req_flags |= HCI_REQ_SKB;
+	}
 
 	spin_lock_irqsave(&hdev->cmd_q.lock, flags);
 	skb_queue_splice_tail(&req->cmd_q, &hdev->cmd_q);
@@ -128,7 +132,7 @@ void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen,
 	}
 
 	if (skb_queue_empty(&req->cmd_q))
-		bt_cb(skb)->hci.req_start = true;
+		bt_cb(skb)->hci.req_flags |= HCI_REQ_START;
 
 	bt_cb(skb)->hci.req_event = event;
 
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 235ad0fa3571..19b23013c4f6 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1249,7 +1249,7 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 			/* Stand-alone HCI commands must be flagged as
 			 * single-command requests.
 			 */
-			bt_cb(skb)->hci.req_start = true;
+			bt_cb(skb)->hci.req_flags |= HCI_REQ_START;
 
 			skb_queue_tail(&hdev->cmd_q, skb);
 			queue_work(hdev->workqueue, &hdev->cmd_work);
-- 
2.5.0

