Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Refactor HCI request & L2CAP bt_skb_cb members to use union
Date: Sun, 29 Mar 2015 21:06:47 +0300
Message-Id: <1427652407-30345-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The HCI request and L2CAP related members of the bt_skb_cb struct will
never be in use at the same time. Since space available for the skb cb
is limited this patch splits the members to the existing l2cap_ctrl and
a new req_ctrl struct, both behind the same union.

This paves the way to extend the req_ctrl with another callback option
without hitting the limits of the skb cb size.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/bluetooth.h | 20 ++++++++++------
 net/bluetooth/hci_core.c          | 12 +++++-----
 net/bluetooth/hci_event.c         |  4 ++--
 net/bluetooth/hci_request.c       |  6 ++---
 net/bluetooth/hci_sock.c          |  2 +-
 net/bluetooth/l2cap_core.c        | 48 +++++++++++++++++++--------------------
 net/bluetooth/l2cap_sock.c        |  6 ++---
 net/bluetooth/smp.c               |  2 +-
 8 files changed, 53 insertions(+), 47 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 33a5e00025aa..8b2840d8e974 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -269,25 +269,31 @@ struct l2cap_ctrl {
 	__u16	reqseq;
 	__u16	txseq;
 	__u8	retries;
+	__le16  psm;
+	struct l2cap_chan *chan;
+	bdaddr_t bdaddr;
 };
 
 struct hci_dev;
 
 typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status, u16 opcode);
 
+struct req_ctrl {
+	__u8 start:1;
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
-	struct l2cap_chan *chan;
-	struct l2cap_ctrl control;
-	bdaddr_t bdaddr;
-	__le16 psm;
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
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d69861c89bb5..dad419782a12 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -292,7 +292,7 @@ static struct sk_buff *l2cap_ertm_seq_in_queue(struct sk_buff_head *head,
 	struct sk_buff *skb;
 
 	skb_queue_walk(head, skb) {
-		if (bt_cb(skb)->control.txseq == seq)
+		if (bt_cb(skb)->l2cap.txseq == seq)
 			return skb;
 	}
 
@@ -954,11 +954,11 @@ static inline void __unpack_control(struct l2cap_chan *chan,
 {
 	if (test_bit(FLAG_EXT_CTRL, &chan->flags)) {
 		__unpack_extended_control(get_unaligned_le32(skb->data),
-					  &bt_cb(skb)->control);
+					  &bt_cb(skb)->l2cap);
 		skb_pull(skb, L2CAP_EXT_CTRL_SIZE);
 	} else {
 		__unpack_enhanced_control(get_unaligned_le16(skb->data),
-					  &bt_cb(skb)->control);
+					  &bt_cb(skb)->l2cap);
 		skb_pull(skb, L2CAP_ENH_CTRL_SIZE);
 	}
 }
@@ -1200,8 +1200,8 @@ static void l2cap_move_setup(struct l2cap_chan *chan)
 
 	chan->retry_count = 0;
 	skb_queue_walk(&chan->tx_q, skb) {
-		if (bt_cb(skb)->control.retries)
-			bt_cb(skb)->control.retries = 1;
+		if (bt_cb(skb)->l2cap.retries)
+			bt_cb(skb)->l2cap.retries = 1;
 		else
 			break;
 	}
@@ -1846,8 +1846,8 @@ static void l2cap_streaming_send(struct l2cap_chan *chan,
 
 		skb = skb_dequeue(&chan->tx_q);
 
-		bt_cb(skb)->control.retries = 1;
-		control = &bt_cb(skb)->control;
+		bt_cb(skb)->l2cap.retries = 1;
+		control = &bt_cb(skb)->l2cap;
 
 		control->reqseq = 0;
 		control->txseq = chan->next_tx_seq;
@@ -1891,8 +1891,8 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
 
 		skb = chan->tx_send_head;
 
-		bt_cb(skb)->control.retries = 1;
-		control = &bt_cb(skb)->control;
+		bt_cb(skb)->l2cap.retries = 1;
+		control = &bt_cb(skb)->l2cap;
 
 		if (test_and_clear_bit(CONN_SEND_FBIT, &chan->conn_state))
 			control->final = 1;
@@ -1963,11 +1963,11 @@ static void l2cap_ertm_resend(struct l2cap_chan *chan)
 			continue;
 		}
 
-		bt_cb(skb)->control.retries++;
-		control = bt_cb(skb)->control;
+		bt_cb(skb)->l2cap.retries++;
+		control = bt_cb(skb)->l2cap;
 
 		if (chan->max_tx != 0 &&
-		    bt_cb(skb)->control.retries > chan->max_tx) {
+		    bt_cb(skb)->l2cap.retries > chan->max_tx) {
 			BT_DBG("Retry limit exceeded (%d)", chan->max_tx);
 			l2cap_send_disconn_req(chan, ECONNRESET);
 			l2cap_seq_list_clear(&chan->retrans_list);
@@ -2045,7 +2045,7 @@ static void l2cap_retransmit_all(struct l2cap_chan *chan,
 
 	if (chan->unacked_frames) {
 		skb_queue_walk(&chan->tx_q, skb) {
-			if (bt_cb(skb)->control.txseq == control->reqseq ||
+			if (bt_cb(skb)->l2cap.txseq == control->reqseq ||
 			    skb == chan->tx_send_head)
 				break;
 		}
@@ -2055,7 +2055,7 @@ static void l2cap_retransmit_all(struct l2cap_chan *chan,
 				break;
 
 			l2cap_seq_list_append(&chan->retrans_list,
-					      bt_cb(skb)->control.txseq);
+					      bt_cb(skb)->l2cap.txseq);
 		}
 
 		l2cap_ertm_resend(chan);
@@ -2267,8 +2267,8 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 		return ERR_PTR(err);
 	}
 
-	bt_cb(skb)->control.fcs = chan->fcs;
-	bt_cb(skb)->control.retries = 0;
+	bt_cb(skb)->l2cap.fcs = chan->fcs;
+	bt_cb(skb)->l2cap.retries = 0;
 	return skb;
 }
 
@@ -2321,7 +2321,7 @@ static int l2cap_segment_sdu(struct l2cap_chan *chan,
 			return PTR_ERR(skb);
 		}
 
-		bt_cb(skb)->control.sar = sar;
+		bt_cb(skb)->l2cap.sar = sar;
 		__skb_queue_tail(seg_queue, skb);
 
 		len -= pdu_len;
@@ -2856,7 +2856,7 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
 			continue;
 
 		/* Don't send frame to the channel it came from */
-		if (bt_cb(skb)->chan == chan)
+		if (bt_cb(skb)->l2cap.chan == chan)
 			continue;
 
 		nskb = skb_clone(skb, GFP_KERNEL);
@@ -5918,7 +5918,7 @@ static int l2cap_rx_queued_iframes(struct l2cap_chan *chan)
 
 		skb_unlink(skb, &chan->srej_q);
 		chan->buffer_seq = __next_seq(chan, chan->buffer_seq);
-		err = l2cap_reassemble_sdu(chan, skb, &bt_cb(skb)->control);
+		err = l2cap_reassemble_sdu(chan, skb, &bt_cb(skb)->l2cap);
 		if (err)
 			break;
 	}
@@ -5952,7 +5952,7 @@ static void l2cap_handle_srej(struct l2cap_chan *chan,
 		return;
 	}
 
-	if (chan->max_tx != 0 && bt_cb(skb)->control.retries >= chan->max_tx) {
+	if (chan->max_tx != 0 && bt_cb(skb)->l2cap.retries >= chan->max_tx) {
 		BT_DBG("Retry limit exceeded (%d)", chan->max_tx);
 		l2cap_send_disconn_req(chan, ECONNRESET);
 		return;
@@ -6005,7 +6005,7 @@ static void l2cap_handle_rej(struct l2cap_chan *chan,
 	skb = l2cap_ertm_seq_in_queue(&chan->tx_q, control->reqseq);
 
 	if (chan->max_tx && skb &&
-	    bt_cb(skb)->control.retries >= chan->max_tx) {
+	    bt_cb(skb)->l2cap.retries >= chan->max_tx) {
 		BT_DBG("Retry limit exceeded (%d)", chan->max_tx);
 		l2cap_send_disconn_req(chan, ECONNRESET);
 		return;
@@ -6565,7 +6565,7 @@ static int l2cap_stream_rx(struct l2cap_chan *chan, struct l2cap_ctrl *control,
 
 static int l2cap_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 {
-	struct l2cap_ctrl *control = &bt_cb(skb)->control;
+	struct l2cap_ctrl *control = &bt_cb(skb)->l2cap;
 	u16 len;
 	u8 event;
 
@@ -6864,8 +6864,8 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 		goto drop;
 
 	/* Store remote BD_ADDR and PSM for msg_name */
-	bacpy(&bt_cb(skb)->bdaddr, &hcon->dst);
-	bt_cb(skb)->psm = psm;
+	bacpy(&bt_cb(skb)->l2cap.bdaddr, &hcon->dst);
+	bt_cb(skb)->l2cap.psm = psm;
 
 	if (!chan->ops->recv(chan, skb)) {
 		l2cap_chan_put(chan);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 9070720eedc8..a7278f05eafb 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1330,7 +1330,7 @@ static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
 
 	skb->priority = sk->sk_priority;
 
-	bt_cb(skb)->chan = chan;
+	bt_cb(skb)->l2cap.chan = chan;
 
 	return skb;
 }
@@ -1444,8 +1444,8 @@ static void l2cap_skb_msg_name(struct sk_buff *skb, void *msg_name,
 
 	memset(la, 0, sizeof(struct sockaddr_l2));
 	la->l2_family = AF_BLUETOOTH;
-	la->l2_psm = bt_cb(skb)->psm;
-	bacpy(&la->l2_bdaddr, &bt_cb(skb)->bdaddr);
+	la->l2_psm = bt_cb(skb)->l2cap.psm;
+	bacpy(&la->l2_bdaddr, &bt_cb(skb)->l2cap.bdaddr);
 
 	*msg_namelen = sizeof(struct sockaddr_l2);
 }
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 1ec3f66b5a74..1910c5806974 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3017,7 +3017,7 @@ static struct sk_buff *smp_alloc_skb_cb(struct l2cap_chan *chan,
 		return ERR_PTR(-ENOMEM);
 
 	skb->priority = HCI_PRIO_MAX;
-	bt_cb(skb)->chan = chan;
+	bt_cb(skb)->l2cap.chan = chan;
 
 	return skb;
 }
-- 
2.1.0

