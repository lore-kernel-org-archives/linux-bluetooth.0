Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: Refactor L2CAP variables into l2cap_ctrl
Date: Mon, 30 Mar 2015 23:21:01 +0300
Message-Id: <1427746862-11078-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We're getting very close to the maximum possible size of bt_skb_cb. To
prepare to shrink the struct with the help of a union this patch moves
all L2CAP related variables into the l2cap_ctrl struct. To later add
other 'ctrl' structs the L2CAP one is renamed simple 'l2cap' instead
of 'control'.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/bluetooth.h |  8 +++----
 net/bluetooth/l2cap_core.c        | 48 +++++++++++++++++++--------------------
 net/bluetooth/l2cap_sock.c        |  6 ++---
 net/bluetooth/smp.c               |  2 +-
 4 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 33a5e00025aa..d8367cc7c76e 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -269,6 +269,9 @@ struct l2cap_ctrl {
 	__u16	reqseq;
 	__u16	txseq;
 	__u8	retries;
+	__le16  psm;
+	bdaddr_t bdaddr;
+	struct l2cap_chan *chan;
 };
 
 struct hci_dev;
@@ -284,10 +287,7 @@ struct bt_skb_cb {
 	__u8 req_start:1;
 	u8 req_event;
 	hci_req_complete_t req_complete;
-	struct l2cap_chan *chan;
-	struct l2cap_ctrl control;
-	bdaddr_t bdaddr;
-	__le16 psm;
+	struct l2cap_ctrl l2cap;
 };
 #define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
 
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

