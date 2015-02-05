Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] Bluetooth: Add second hci_request callback option for full skb
Date: Thu,  5 Feb 2015 11:18:20 +0200
Message-Id: <1423127905-27281-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1423127905-27281-1-git-send-email-johan.hedberg@gmail.com>
References: <1423127905-27281-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds a second possible callback for HCI requests where the
callback will receive the full skb of the last successfully completed
HCI command. This API is useful for cases where we want to use a request
to read some data and the existing hci_event.c handlers do not store it
e.g. in the hci_dev struct.

The reason the patch is a bit bigger than just adding the new API is
because the hci_req_cmd_complete() functions required some refactoring
to enable it: now hci_req_cmd_complete() is simply used to request the
callback pointers if any, and the actual calling of them happens from a
single place at the end of hci_event_packet(). The reason for this is
that we need to pass the original skb (without any skb_pull, etc
modifications done to it) and it's simplest to keep track of it within
the hci_event_packet() function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/bluetooth.h |  3 ++
 net/bluetooth/hci_core.c          | 30 +++++++---------
 net/bluetooth/hci_event.c         | 76 ++++++++++++++++++++++++++-------------
 net/bluetooth/hci_request.c       | 14 +++++++-
 net/bluetooth/hci_request.h       |  5 ++-
 5 files changed, 84 insertions(+), 44 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index e00455aab18c..aabd8960ed73 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -274,11 +274,14 @@ struct l2cap_ctrl {
 struct hci_dev;
 
 typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status, u16 opcode);
+typedef void (*hci_req_complete_skb_t)(struct hci_dev *hdev, u8 status,
+				       u16 opcode, struct sk_buff *skb);
 
 struct hci_req_ctrl {
 	bool			start;
 	u8			event;
 	hci_req_complete_t	complete;
+	hci_req_complete_skb_t	complete_skb;
 };
 
 struct bt_skb_cb {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3322d3f4c85a..26e69db36199 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4220,9 +4220,10 @@ static void hci_resend_last(struct hci_dev *hdev)
 	queue_work(hdev->workqueue, &hdev->cmd_work);
 }
 
-void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status)
+void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status,
+			  hci_req_complete_t *req_complete,
+			  hci_req_complete_skb_t *req_complete_skb)
 {
-	hci_req_complete_t req_complete = NULL;
 	struct sk_buff *skb;
 	unsigned long flags;
 
@@ -4254,18 +4255,14 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status)
 	 * callback would be found in hdev->sent_cmd instead of the
 	 * command queue (hdev->cmd_q).
 	 */
-	if (hdev->sent_cmd) {
-		req_complete = bt_cb(hdev->sent_cmd)->req.complete;
-
-		if (req_complete) {
-			/* We must set the complete callback to NULL to
-			 * avoid calling the callback more than once if
-			 * this function gets called again.
-			 */
-			bt_cb(hdev->sent_cmd)->req.complete = NULL;
+	if (bt_cb(hdev->sent_cmd)->req.complete) {
+		*req_complete = bt_cb(hdev->sent_cmd)->req.complete;
+		return;
+	}
 
-			goto call_complete;
-		}
+	if (bt_cb(hdev->sent_cmd)->req.complete_skb) {
+		*req_complete_skb = bt_cb(hdev->sent_cmd)->req.complete_skb;
+		return;
 	}
 
 	/* Remove all pending commands belonging to this request */
@@ -4276,14 +4273,11 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status)
 			break;
 		}
 
-		req_complete = bt_cb(skb)->req.complete;
+		*req_complete = bt_cb(skb)->req.complete;
+		*req_complete_skb = bt_cb(skb)->req.complete_skb;
 		kfree_skb(skb);
 	}
 	spin_unlock_irqrestore(&hdev->cmd_q.lock, flags);
-
-call_complete:
-	if (req_complete)
-		req_complete(hdev, status, status ? opcode : HCI_OP_NOP);
 }
 
 static void hci_rx_work(struct work_struct *work)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1ffabd96f30d..52f13f8f4234 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2715,17 +2715,19 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
+				 u16 *opcode, u8 *status,
+				 hci_req_complete_t *req_complete,
+				 hci_req_complete_skb_t *req_complete_skb)
 {
 	struct hci_ev_cmd_complete *ev = (void *) skb->data;
-	u8 status = skb->data[sizeof(*ev)];
-	__u16 opcode;
 
-	skb_pull(skb, sizeof(*ev));
+	*opcode = __le16_to_cpu(ev->opcode);
+	*status = skb->data[sizeof(*ev)];
 
-	opcode = __le16_to_cpu(ev->opcode);
+	skb_pull(skb, sizeof(*ev));
 
-	switch (opcode) {
+	switch (*opcode) {
 	case HCI_OP_INQUIRY_CANCEL:
 		hci_cc_inquiry_cancel(hdev, skb);
 		break;
@@ -3003,14 +3005,15 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		break;
 
 	default:
-		BT_DBG("%s opcode 0x%4.4x", hdev->name, opcode);
+		BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
 		break;
 	}
 
-	if (opcode != HCI_OP_NOP)
+	if (*opcode != HCI_OP_NOP)
 		cancel_delayed_work(&hdev->cmd_timer);
 
-	hci_req_cmd_complete(hdev, opcode, status);
+	hci_req_cmd_complete(hdev, *opcode, *status, req_complete,
+			     req_complete_skb);
 
 	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags)) {
 		atomic_set(&hdev->cmd_cnt, 1);
@@ -3019,16 +3022,19 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 }
 
-static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
+			       u16 *opcode, u8 *status,
+			       hci_req_complete_t *req_complete,
+			       hci_req_complete_skb_t *req_complete_skb)
 {
 	struct hci_ev_cmd_status *ev = (void *) skb->data;
-	__u16 opcode;
 
 	skb_pull(skb, sizeof(*ev));
 
-	opcode = __le16_to_cpu(ev->opcode);
+	*opcode = __le16_to_cpu(ev->opcode);
+	*status = ev->status;
 
-	switch (opcode) {
+	switch (*opcode) {
 	case HCI_OP_INQUIRY:
 		hci_cs_inquiry(hdev, ev->status);
 		break;
@@ -3098,11 +3104,11 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		break;
 
 	default:
-		BT_DBG("%s opcode 0x%4.4x", hdev->name, opcode);
+		BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
 		break;
 	}
 
-	if (opcode != HCI_OP_NOP)
+	if (*opcode != HCI_OP_NOP)
 		cancel_delayed_work(&hdev->cmd_timer);
 
 	/* Indicate request completion if the command failed. Also, if
@@ -3113,7 +3119,8 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	 */
 	if (ev->status ||
 	    (hdev->sent_cmd && !bt_cb(hdev->sent_cmd)->req.event))
-		hci_req_cmd_complete(hdev, opcode, ev->status);
+		hci_req_cmd_complete(hdev, *opcode, ev->status, req_complete,
+				     req_complete_skb);
 
 	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags)) {
 		atomic_set(&hdev->cmd_cnt, 1);
@@ -5029,7 +5036,11 @@ static void hci_chan_selected_evt(struct hci_dev *hdev, struct sk_buff *skb)
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_event_hdr *hdr = (void *) skb->data;
-	__u8 event = hdr->evt;
+	hci_req_complete_t req_complete = NULL;
+	hci_req_complete_skb_t req_complete_skb = NULL;
+	struct sk_buff *orig_skb = NULL;
+	u8 status = 0, event = hdr->evt;
+	u16 opcode = HCI_OP_NOP;
 
 	hci_dev_lock(hdev);
 
@@ -5043,15 +5054,24 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_unlock(hdev);
 
-	skb_pull(skb, HCI_EVENT_HDR_SIZE);
-
 	if (hdev->sent_cmd && bt_cb(hdev->sent_cmd)->req.event == event) {
 		struct hci_command_hdr *cmd_hdr = (void *) hdev->sent_cmd->data;
-		u16 opcode = __le16_to_cpu(cmd_hdr->opcode);
-
-		hci_req_cmd_complete(hdev, opcode, 0);
+		opcode = __le16_to_cpu(cmd_hdr->opcode);
+		hci_req_cmd_complete(hdev, opcode, status, &req_complete,
+				     &req_complete_skb);
 	}
 
+	/* If it looks like we might end up having to call
+	 * req_complete_skb, store a pristine copy of the skb since the
+	 * various handlers may modify the original one through
+	 * skb_pull() calls, etc.
+	 */
+	if (req_complete_skb || event == HCI_EV_CMD_STATUS ||
+	    event == HCI_EV_CMD_COMPLETE)
+		orig_skb = skb_clone(skb, GFP_KERNEL);
+
+	skb_pull(skb, HCI_EVENT_HDR_SIZE);
+
 	switch (event) {
 	case HCI_EV_INQUIRY_COMPLETE:
 		hci_inquiry_complete_evt(hdev, skb);
@@ -5094,11 +5114,13 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		break;
 
 	case HCI_EV_CMD_COMPLETE:
-		hci_cmd_complete_evt(hdev, skb);
+		hci_cmd_complete_evt(hdev, skb, &opcode, &status,
+				     &req_complete, &req_complete_skb);
 		break;
 
 	case HCI_EV_CMD_STATUS:
-		hci_cmd_status_evt(hdev, skb);
+		hci_cmd_status_evt(hdev, skb, &opcode, &status, &req_complete,
+				   &req_complete_skb);
 		break;
 
 	case HCI_EV_HARDWARE_ERROR:
@@ -5230,6 +5252,12 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		break;
 	}
 
+	if (req_complete)
+		req_complete(hdev, status, opcode);
+	else if (req_complete_skb)
+		req_complete_skb(hdev, status, opcode, orig_skb);
+
+	kfree_skb(orig_skb);
 	kfree_skb(skb);
 	hdev->stat.evt_rx++;
 }
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index b59f92c6df0c..39ea96e7b135 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -34,7 +34,8 @@ void hci_req_init(struct hci_request *req, struct hci_dev *hdev)
 	req->err = 0;
 }
 
-int hci_req_run(struct hci_request *req, hci_req_complete_t complete)
+static int req_run(struct hci_request *req, hci_req_complete_t complete,
+		   hci_req_complete_skb_t complete_skb)
 {
 	struct hci_dev *hdev = req->hdev;
 	struct sk_buff *skb;
@@ -56,6 +57,7 @@ int hci_req_run(struct hci_request *req, hci_req_complete_t complete)
 
 	skb = skb_peek_tail(&req->cmd_q);
 	bt_cb(skb)->req.complete = complete;
+	bt_cb(skb)->req.complete_skb = complete_skb;
 
 	spin_lock_irqsave(&hdev->cmd_q.lock, flags);
 	skb_queue_splice_tail(&req->cmd_q, &hdev->cmd_q);
@@ -66,6 +68,16 @@ int hci_req_run(struct hci_request *req, hci_req_complete_t complete)
 	return 0;
 }
 
+int hci_req_run(struct hci_request *req, hci_req_complete_t complete)
+{
+	return req_run(req, complete, NULL);
+}
+
+int hci_req_run_skb(struct hci_request *req, hci_req_complete_skb_t complete)
+{
+	return req_run(req, NULL, complete);
+}
+
 struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 				const void *param)
 {
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index adf074d33544..bf6df92f42db 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -32,11 +32,14 @@ struct hci_request {
 
 void hci_req_init(struct hci_request *req, struct hci_dev *hdev);
 int hci_req_run(struct hci_request *req, hci_req_complete_t complete);
+int hci_req_run_skb(struct hci_request *req, hci_req_complete_skb_t complete);
 void hci_req_add(struct hci_request *req, u16 opcode, u32 plen,
 		 const void *param);
 void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen,
 		    const void *param, u8 event);
-void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status);
+void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status,
+			  hci_req_complete_t *req_complete,
+			  hci_req_complete_skb_t *req_complete_skb);
 
 struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 				const void *param);
-- 
2.1.0

