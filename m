Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	marcel@holtmann.org
Cc: pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Subject: [RFC 3/8] Bluetooth: Remove duplicate structure members from bt_skb_cb
Date: Wed, 25 Apr 2012 16:36:14 -0700
Message-Id: <1335396979-11692-4-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1335396979-11692-1-git-send-email-mathewm@codeaurora.org>
References: <1335396979-11692-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These values are now in the nested l2cap_ctrl struct.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/bluetooth.h |    3 ---
 net/bluetooth/l2cap_core.c        |   34 +++++++++++++++++-----------------
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 27a6a93..2fb268f 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -235,9 +235,6 @@ struct bt_skb_cb {
 	__u8 pkt_type;
 	__u8 incoming;
 	__u16 expect;
-	__u16 tx_seq;
-	__u8 retries;
-	__u8 sar;
 	__u8 force_active;
 	struct l2cap_ctrl control;
 };
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 35c0a29..9a33f21 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1621,7 +1621,7 @@ static void l2cap_drop_acked_frames(struct l2cap_chan *chan)
 
 	while ((skb = skb_peek(&chan->tx_q)) &&
 			chan->unacked_frames) {
-		if (bt_cb(skb)->tx_seq == chan->expected_ack_seq)
+		if (bt_cb(skb)->control.txseq == chan->expected_ack_seq)
 			break;
 
 		skb = skb_dequeue(&chan->tx_q);
@@ -1668,7 +1668,7 @@ static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u16 tx_seq)
 	if (!skb)
 		return;
 
-	while (bt_cb(skb)->tx_seq != tx_seq) {
+	while (bt_cb(skb)->control.txseq != tx_seq) {
 		if (skb_queue_is_last(&chan->tx_q, skb))
 			return;
 
@@ -1676,13 +1676,13 @@ static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u16 tx_seq)
 	}
 
 	if (chan->remote_max_tx &&
-			bt_cb(skb)->retries == chan->remote_max_tx) {
+			bt_cb(skb)->control.retries == chan->remote_max_tx) {
 		l2cap_send_disconn_req(chan->conn, chan, ECONNABORTED);
 		return;
 	}
 
 	tx_skb = skb_clone(skb, GFP_ATOMIC);
-	bt_cb(skb)->retries++;
+	bt_cb(skb)->control.retries++;
 
 	control = __get_control(chan, tx_skb->data + L2CAP_HDR_SIZE);
 	control &= __get_sar_mask(chan);
@@ -1718,14 +1718,14 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
 	while ((skb = chan->tx_send_head) && (!l2cap_tx_window_full(chan))) {
 
 		if (chan->remote_max_tx &&
-				bt_cb(skb)->retries == chan->remote_max_tx) {
+			bt_cb(skb)->control.retries == chan->remote_max_tx) {
 			l2cap_send_disconn_req(chan->conn, chan, ECONNABORTED);
 			break;
 		}
 
 		tx_skb = skb_clone(skb, GFP_ATOMIC);
 
-		bt_cb(skb)->retries++;
+		bt_cb(skb)->control.retries++;
 
 		control = __get_control(chan, tx_skb->data + L2CAP_HDR_SIZE);
 		control &= __get_sar_mask(chan);
@@ -1749,11 +1749,11 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
 
 		__set_retrans_timer(chan);
 
-		bt_cb(skb)->tx_seq = chan->next_tx_seq;
+		bt_cb(skb)->control.txseq = chan->next_tx_seq;
 
 		chan->next_tx_seq = __next_seq(chan, chan->next_tx_seq);
 
-		if (bt_cb(skb)->retries == 1) {
+		if (bt_cb(skb)->control.retries == 1) {
 			chan->unacked_frames++;
 
 			if (!nsent++)
@@ -1979,7 +1979,7 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 	if (chan->fcs == L2CAP_FCS_CRC16)
 		put_unaligned_le16(0, skb_put(skb, L2CAP_FCS_SIZE));
 
-	bt_cb(skb)->retries = 0;
+	bt_cb(skb)->control.retries = 0;
 	return skb;
 }
 
@@ -3960,19 +3960,19 @@ static int l2cap_add_to_srej_queue(struct l2cap_chan *chan, struct sk_buff *skb,
 	struct sk_buff *next_skb;
 	int tx_seq_offset, next_tx_seq_offset;
 
-	bt_cb(skb)->tx_seq = tx_seq;
-	bt_cb(skb)->sar = sar;
+	bt_cb(skb)->control.txseq = tx_seq;
+	bt_cb(skb)->control.sar = sar;
 
 	next_skb = skb_peek(&chan->srej_q);
 
 	tx_seq_offset = __seq_offset(chan, tx_seq, chan->buffer_seq);
 
 	while (next_skb) {
-		if (bt_cb(next_skb)->tx_seq == tx_seq)
+		if (bt_cb(next_skb)->control.txseq == tx_seq)
 			return -EINVAL;
 
 		next_tx_seq_offset = __seq_offset(chan,
-				bt_cb(next_skb)->tx_seq, chan->buffer_seq);
+			bt_cb(next_skb)->control.txseq, chan->buffer_seq);
 
 		if (next_tx_seq_offset > tx_seq_offset) {
 			__skb_queue_before(&chan->srej_q, next_skb, skb);
@@ -4144,11 +4144,11 @@ static void l2cap_check_srej_gap(struct l2cap_chan *chan, u16 tx_seq)
 			!test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
 		int err;
 
-		if (bt_cb(skb)->tx_seq != tx_seq)
+		if (bt_cb(skb)->control.txseq != tx_seq)
 			break;
 
 		skb = skb_dequeue(&chan->srej_q);
-		control = __set_ctrl_sar(chan, bt_cb(skb)->sar);
+		control = __set_ctrl_sar(chan, bt_cb(skb)->control.sar);
 		err = l2cap_reassemble_sdu(chan, skb, control);
 
 		if (err < 0) {
@@ -4319,8 +4319,8 @@ expected:
 	chan->expected_tx_seq = __next_seq(chan, chan->expected_tx_seq);
 
 	if (test_bit(CONN_SREJ_SENT, &chan->conn_state)) {
-		bt_cb(skb)->tx_seq = tx_seq;
-		bt_cb(skb)->sar = sar;
+		bt_cb(skb)->control.txseq = tx_seq;
+		bt_cb(skb)->control.sar = sar;
 		__skb_queue_tail(&chan->srej_q, skb);
 		return 0;
 	}
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
