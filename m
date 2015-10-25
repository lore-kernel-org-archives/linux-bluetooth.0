Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Rename bt_cb()->req into bt_cb()->hci
Date: Sun, 25 Oct 2015 22:45:53 +0100
Message-Id: <1445809553-44582-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The SKB context buffer for HCI request is really not just for requests,
information in their are preserved for the whole HCI layer. So it makes
more sense to actually rename it into bt_cb()->hci and also call it then
struct hci_ctrl.

In addition that allows moving the decoded opcode for outgoing packets
into that struct. So far it was just consuming valuable space from the
main shared items. And opcode are not valid for L2CAP packets.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/bluetooth.h | 14 +++++++-------
 net/bluetooth/hci_core.c          | 18 +++++++++---------
 net/bluetooth/hci_event.c         |  4 ++--
 net/bluetooth/hci_request.c       | 10 +++++-----
 net/bluetooth/hci_sock.c          |  2 +-
 5 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index c4defef319d5..42844d7b154a 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -296,22 +296,22 @@ typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status, u16 opcode);
 typedef void (*hci_req_complete_skb_t)(struct hci_dev *hdev, u8 status,
 				       u16 opcode, struct sk_buff *skb);
 
-struct req_ctrl {
-	bool start;
-	u8 event;
-	hci_req_complete_t complete;
-	hci_req_complete_skb_t complete_skb;
+struct hci_ctrl {
+	__u16 opcode;
+	bool req_start;
+	u8 req_event;
+	hci_req_complete_t req_complete;
+	hci_req_complete_skb_t req_complete_skb;
 };
 
 struct bt_skb_cb {
 	__u8 pkt_type;
 	__u8 force_active;
-	__u16 opcode;
 	__u16 expect;
 	__u8 incoming:1;
 	union {
 		struct l2cap_ctrl l2cap;
-		struct req_ctrl req;
+		struct hci_ctrl hci;
 	};
 };
 #define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 086ed9389da1..3604e0194f87 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3650,7 +3650,7 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
 	/* Stand-alone HCI commands must be flagged as
 	 * single-command requests.
 	 */
-	bt_cb(skb)->req.start = true;
+	bt_cb(skb)->hci.req_start = true;
 
 	skb_queue_tail(&hdev->cmd_q, skb);
 	queue_work(hdev->workqueue, &hdev->cmd_work);
@@ -4347,7 +4347,7 @@ static bool hci_req_is_complete(struct hci_dev *hdev)
 	if (!skb)
 		return true;
 
-	return bt_cb(skb)->req.start;
+	return bt_cb(skb)->hci.req_start;
 }
 
 static void hci_resend_last(struct hci_dev *hdev)
@@ -4407,26 +4407,26 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status,
 	 * callback would be found in hdev->sent_cmd instead of the
 	 * command queue (hdev->cmd_q).
 	 */
-	if (bt_cb(hdev->sent_cmd)->req.complete) {
-		*req_complete = bt_cb(hdev->sent_cmd)->req.complete;
+	if (bt_cb(hdev->sent_cmd)->hci.req_complete) {
+		*req_complete = bt_cb(hdev->sent_cmd)->hci.req_complete;
 		return;
 	}
 
-	if (bt_cb(hdev->sent_cmd)->req.complete_skb) {
-		*req_complete_skb = bt_cb(hdev->sent_cmd)->req.complete_skb;
+	if (bt_cb(hdev->sent_cmd)->hci.req_complete_skb) {
+		*req_complete_skb = bt_cb(hdev->sent_cmd)->hci.req_complete_skb;
 		return;
 	}
 
 	/* Remove all pending commands belonging to this request */
 	spin_lock_irqsave(&hdev->cmd_q.lock, flags);
 	while ((skb = __skb_dequeue(&hdev->cmd_q))) {
-		if (bt_cb(skb)->req.start) {
+		if (bt_cb(skb)->hci.req_start) {
 			__skb_queue_head(&hdev->cmd_q, skb);
 			break;
 		}
 
-		*req_complete = bt_cb(skb)->req.complete;
-		*req_complete_skb = bt_cb(skb)->req.complete_skb;
+		*req_complete = bt_cb(skb)->hci.req_complete;
+		*req_complete_skb = bt_cb(skb)->hci.req_complete_skb;
 		kfree_skb(skb);
 	}
 	spin_unlock_irqrestore(&hdev->cmd_q.lock, flags);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 504892cfb25a..d57c11c1c6b5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3138,7 +3138,7 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
 	 * complete event).
 	 */
 	if (ev->status ||
-	    (hdev->sent_cmd && !bt_cb(hdev->sent_cmd)->req.event))
+	    (hdev->sent_cmd && !bt_cb(hdev->sent_cmd)->hci.req_event))
 		hci_req_cmd_complete(hdev, *opcode, ev->status, req_complete,
 				     req_complete_skb);
 
@@ -5209,7 +5209,7 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	u8 status = 0, event = hdr->evt, req_evt = 0;
 	u16 opcode = HCI_OP_NOP;
 
-	if (hdev->sent_cmd && bt_cb(hdev->sent_cmd)->req.event == event) {
+	if (hdev->sent_cmd && bt_cb(hdev->sent_cmd)->hci.req_event == event) {
 		struct hci_command_hdr *cmd_hdr = (void *) hdev->sent_cmd->data;
 		opcode = __le16_to_cpu(cmd_hdr->opcode);
 		hci_req_cmd_complete(hdev, opcode, status, &req_complete,
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 739f966e5d67..981f8a202c27 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -56,8 +56,8 @@ static int req_run(struct hci_request *req, hci_req_complete_t complete,
 		return -ENODATA;
 
 	skb = skb_peek_tail(&req->cmd_q);
-	bt_cb(skb)->req.complete = complete;
-	bt_cb(skb)->req.complete_skb = complete_skb;
+	bt_cb(skb)->hci.req_complete = complete;
+	bt_cb(skb)->hci.req_complete_skb = complete_skb;
 
 	spin_lock_irqsave(&hdev->cmd_q.lock, flags);
 	skb_queue_splice_tail(&req->cmd_q, &hdev->cmd_q);
@@ -99,7 +99,7 @@ struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 	BT_DBG("skb len %d", skb->len);
 
 	bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
-	bt_cb(skb)->opcode = opcode;
+	bt_cb(skb)->hci.opcode = opcode;
 
 	return skb;
 }
@@ -128,9 +128,9 @@ void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen,
 	}
 
 	if (skb_queue_empty(&req->cmd_q))
-		bt_cb(skb)->req.start = true;
+		bt_cb(skb)->hci.req_start = true;
 
-	bt_cb(skb)->req.event = event;
+	bt_cb(skb)->hci.req_event = event;
 
 	skb_queue_tail(&req->cmd_q, skb);
 }
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index b9327e8c2d34..77e816f91a61 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1249,7 +1249,7 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 			/* Stand-alone HCI commands must be flagged as
 			 * single-command requests.
 			 */
-			bt_cb(skb)->req.start = true;
+			bt_cb(skb)->hci.req_start = true;
 
 			skb_queue_tail(&hdev->cmd_q, skb);
 			queue_work(hdev->workqueue, &hdev->cmd_work);
-- 
2.4.3

