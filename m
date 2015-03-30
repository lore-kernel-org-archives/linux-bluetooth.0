Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: Refactor HCI request variables into own struct
Date: Mon, 30 Mar 2015 21:45:57 +0300
Message-Id: <1427741157-6320-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1427741157-6320-1-git-send-email-johan.hedberg@gmail.com>
References: <1427741157-6320-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In order to shrink the size of bt_skb_cb, this patch moves the HCI
request related variables into their own req_ctrl struct. Additionall
the L2CAP and HCI request structs are placed inside the same union since
they will never be used at the same time for the same skb.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/bluetooth.h | 14 ++++++++++----
 net/bluetooth/hci_core.c          | 12 ++++++------
 net/bluetooth/hci_event.c         |  4 ++--
 net/bluetooth/hci_request.c       |  6 +++---
 net/bluetooth/hci_sock.c          |  2 +-
 5 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index d8367cc7c76e..eeaff4b5cb62 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -278,16 +278,22 @@ struct hci_dev;
 
 typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status, u16 opcode);
 
+struct req_ctrl {
+	bool start;
+	u8 event;
+	hci_req_complete_t complete;
+};
+
 struct bt_skb_cb {
 	__u8 pkt_type;
 	__u8 force_active;
 	__u16 opcode;
 	__u16 expect;
 	__u8 incoming:1;
-	__u8 req_start:1;
-	u8 req_event;
-	hci_req_complete_t req_complete;
-	struct l2cap_ctrl l2cap;
+	union {
+		struct l2cap_ctrl l2cap;
+		struct req_ctrl req;
+	};
 };
 #define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e6bfeb7b4415..9eaa26754b2d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3585,7 +3585,7 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
 	/* Stand-alone HCI commands must be flagged as
 	 * single-command requests.
 	 */
-	bt_cb(skb)->req_start = 1;
+	bt_cb(skb)->req.start = 1;
 
 	skb_queue_tail(&hdev->cmd_q, skb);
 	queue_work(hdev->workqueue, &hdev->cmd_work);
@@ -4263,7 +4263,7 @@ static bool hci_req_is_complete(struct hci_dev *hdev)
 	if (!skb)
 		return true;
 
-	return bt_cb(skb)->req_start;
+	return bt_cb(skb)->req.start;
 }
 
 static void hci_resend_last(struct hci_dev *hdev)
@@ -4323,14 +4323,14 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status)
 	 * command queue (hdev->cmd_q).
 	 */
 	if (hdev->sent_cmd) {
-		req_complete = bt_cb(hdev->sent_cmd)->req_complete;
+		req_complete = bt_cb(hdev->sent_cmd)->req.complete;
 
 		if (req_complete) {
 			/* We must set the complete callback to NULL to
 			 * avoid calling the callback more than once if
 			 * this function gets called again.
 			 */
-			bt_cb(hdev->sent_cmd)->req_complete = NULL;
+			bt_cb(hdev->sent_cmd)->req.complete = NULL;
 
 			goto call_complete;
 		}
@@ -4339,12 +4339,12 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status)
 	/* Remove all pending commands belonging to this request */
 	spin_lock_irqsave(&hdev->cmd_q.lock, flags);
 	while ((skb = __skb_dequeue(&hdev->cmd_q))) {
-		if (bt_cb(skb)->req_start) {
+		if (bt_cb(skb)->req.start) {
 			__skb_queue_head(&hdev->cmd_q, skb);
 			break;
 		}
 
-		req_complete = bt_cb(skb)->req_complete;
+		req_complete = bt_cb(skb)->req.complete;
 		kfree_skb(skb);
 	}
 	spin_unlock_irqrestore(&hdev->cmd_q.lock, flags);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 20f34b861426..7c0f992602f5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3125,7 +3125,7 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		atomic_set(&hdev->cmd_cnt, 1);
 
 	if (ev->status ||
-	    (hdev->sent_cmd && !bt_cb(hdev->sent_cmd)->req_event))
+	    (hdev->sent_cmd && !bt_cb(hdev->sent_cmd)->req.event))
 		hci_req_cmd_complete(hdev, opcode, ev->status);
 
 	if (atomic_read(&hdev->cmd_cnt) && !skb_queue_empty(&hdev->cmd_q))
@@ -5049,7 +5049,7 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	skb_pull(skb, HCI_EVENT_HDR_SIZE);
 
-	if (hdev->sent_cmd && bt_cb(hdev->sent_cmd)->req_event == event) {
+	if (hdev->sent_cmd && bt_cb(hdev->sent_cmd)->req.event == event) {
 		struct hci_command_hdr *cmd_hdr = (void *) hdev->sent_cmd->data;
 		u16 opcode = __le16_to_cpu(cmd_hdr->opcode);
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 55e096d20a0f..8a0b7e319523 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -55,7 +55,7 @@ int hci_req_run(struct hci_request *req, hci_req_complete_t complete)
 		return -ENODATA;
 
 	skb = skb_peek_tail(&req->cmd_q);
-	bt_cb(skb)->req_complete = complete;
+	bt_cb(skb)->req.complete = complete;
 
 	spin_lock_irqsave(&hdev->cmd_q.lock, flags);
 	skb_queue_splice_tail(&req->cmd_q, &hdev->cmd_q);
@@ -116,9 +116,9 @@ void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen,
 	}
 
 	if (skb_queue_empty(&req->cmd_q))
-		bt_cb(skb)->req_start = 1;
+		bt_cb(skb)->req.start = 1;
 
-	bt_cb(skb)->req_event = event;
+	bt_cb(skb)->req.event = event;
 
 	skb_queue_tail(&req->cmd_q, skb);
 }
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 85a44a7dc150..2c0abef1aa83 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1164,7 +1164,7 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 			/* Stand-alone HCI commands must be flagged as
 			 * single-command requests.
 			 */
-			bt_cb(skb)->req_start = 1;
+			bt_cb(skb)->req.start = 1;
 
 			skb_queue_tail(&hdev->cmd_q, skb);
 			queue_work(hdev->workqueue, &hdev->cmd_work);
-- 
2.1.0

