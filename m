Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH -v2 2/2] Bluetooth: Use bit operations on conn_state
Date: Tue, 14 Jun 2011 17:39:29 -0300
Message-Id: <1308083969-16502-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1308083969-16502-1-git-send-email-padovan@profusion.mobi>
References: <1308083969-16502-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of setting bits manually we use set_bit, test_bit, etc.
Also remove L2CAP_ prefix from macros.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |   26 ++++---
 net/bluetooth/l2cap_core.c    |  161 +++++++++++++++++++----------------------
 2 files changed, 88 insertions(+), 99 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 791e6d5..8ab4de5 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -325,7 +325,7 @@ struct l2cap_chan {
 	__u16		mps;
 
 	unsigned long	conf_state;
-	__u16		conn_state;
+	unsigned long	conn_state;
 
 	__u8		next_tx_seq;
 	__u8		expected_ack_seq;
@@ -435,17 +435,19 @@ enum {
 #define L2CAP_CONF_MAX_CONF_REQ 2
 #define L2CAP_CONF_MAX_CONF_RSP 2
 
-#define L2CAP_CONN_SAR_SDU         0x0001
-#define L2CAP_CONN_SREJ_SENT       0x0002
-#define L2CAP_CONN_WAIT_F          0x0004
-#define L2CAP_CONN_SREJ_ACT        0x0008
-#define L2CAP_CONN_SEND_PBIT       0x0010
-#define L2CAP_CONN_REMOTE_BUSY     0x0020
-#define L2CAP_CONN_LOCAL_BUSY      0x0040
-#define L2CAP_CONN_REJ_ACT         0x0080
-#define L2CAP_CONN_SEND_FBIT       0x0100
-#define L2CAP_CONN_RNR_SENT        0x0200
-#define L2CAP_CONN_SAR_RETRY       0x0400
+enum {
+	CONN_SAR_SDU,
+	CONN_SREJ_SENT,
+	CONN_WAIT_F,
+	CONN_SREJ_ACT,
+	CONN_SEND_PBIT,
+	CONN_REMOTE_BUSY,
+	CONN_LOCAL_BUSY,
+	CONN_REJ_ACT,
+	CONN_SEND_FBIT,
+	CONN_RNR_SENT,
+	CONN_SAR_RETRY,
+};
 
 #define __set_chan_timer(c, t) l2cap_set_timer(c, &c->chan_timer, (t))
 #define __clear_chan_timer(c) l2cap_clear_timer(c, &c->chan_timer)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index aa203b5..3be8668 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -584,15 +584,11 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u16 control)
 	count = min_t(unsigned int, conn->mtu, hlen);
 	control |= L2CAP_CTRL_FRAME_TYPE;
 
-	if (chan->conn_state & L2CAP_CONN_SEND_FBIT) {
+	if (test_and_clear_bit(CONN_SEND_FBIT, &chan->conn_state))
 		control |= L2CAP_CTRL_FINAL;
-		chan->conn_state &= ~L2CAP_CONN_SEND_FBIT;
-	}
 
-	if (chan->conn_state & L2CAP_CONN_SEND_PBIT) {
+	if (test_and_clear_bit(CONN_SEND_PBIT, &chan->conn_state))
 		control |= L2CAP_CTRL_POLL;
-		chan->conn_state &= ~L2CAP_CONN_SEND_PBIT;
-	}
 
 	skb = bt_skb_alloc(count, GFP_ATOMIC);
 	if (!skb)
@@ -620,9 +616,9 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u16 control)
 
 static inline void l2cap_send_rr_or_rnr(struct l2cap_chan *chan, u16 control)
 {
-	if (chan->conn_state & L2CAP_CONN_LOCAL_BUSY) {
+	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
 		control |= L2CAP_SUPER_RCV_NOT_READY;
-		chan->conn_state |= L2CAP_CONN_RNR_SENT;
+		set_bit(CONN_RNR_SENT, &chan->conn_state);
 	} else
 		control |= L2CAP_SUPER_RCV_READY;
 
@@ -1210,7 +1206,7 @@ static void l2cap_retrans_timeout(unsigned long arg)
 	chan->retry_count = 1;
 	__set_monitor_timer(chan);
 
-	chan->conn_state |= L2CAP_CONN_WAIT_F;
+	set_bit(CONN_WAIT_F, &chan->conn_state);
 
 	l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_POLL);
 	bh_unlock_sock(sk);
@@ -1301,10 +1297,8 @@ static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u8 tx_seq)
 	control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
 	control &= L2CAP_CTRL_SAR;
 
-	if (chan->conn_state & L2CAP_CONN_SEND_FBIT) {
+	if (test_and_clear_bit(CONN_SEND_FBIT, &chan->conn_state))
 		control |= L2CAP_CTRL_FINAL;
-		chan->conn_state &= ~L2CAP_CONN_SEND_FBIT;
-	}
 
 	control |= (chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT)
 			| (tx_seq << L2CAP_CTRL_TXSEQ_SHIFT);
@@ -1343,10 +1337,9 @@ int l2cap_ertm_send(struct l2cap_chan *chan)
 		control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
 		control &= L2CAP_CTRL_SAR;
 
-		if (chan->conn_state & L2CAP_CONN_SEND_FBIT) {
+		if (test_and_clear_bit(CONN_SEND_FBIT, &chan->conn_state))
 			control |= L2CAP_CTRL_FINAL;
-			chan->conn_state &= ~L2CAP_CONN_SEND_FBIT;
-		}
+
 		control |= (chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT)
 				| (chan->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT);
 		put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
@@ -1398,9 +1391,9 @@ static void l2cap_send_ack(struct l2cap_chan *chan)
 
 	control |= chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 
-	if (chan->conn_state & L2CAP_CONN_LOCAL_BUSY) {
+	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
 		control |= L2CAP_SUPER_RCV_NOT_READY;
-		chan->conn_state |= L2CAP_CONN_RNR_SENT;
+		set_bit(CONN_RNR_SENT, &chan->conn_state);
 		l2cap_send_sframe(chan, control);
 		return;
 	}
@@ -1667,8 +1660,8 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 			break;
 		}
 
-		if ((chan->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
-				(chan->conn_state & L2CAP_CONN_WAIT_F)) {
+		if (test_bit(CONN_REMOTE_BUSY, &chan->conn_state) &&
+				test_bit(CONN_WAIT_F, &chan->conn_state)) {
 			err = len;
 			break;
 		}
@@ -3058,18 +3051,18 @@ static inline void l2cap_send_i_or_rr_or_rnr(struct l2cap_chan *chan)
 
 	control |= chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 
-	if (chan->conn_state & L2CAP_CONN_LOCAL_BUSY) {
+	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
 		control |= L2CAP_SUPER_RCV_NOT_READY;
 		l2cap_send_sframe(chan, control);
-		chan->conn_state |= L2CAP_CONN_RNR_SENT;
+		set_bit(CONN_RNR_SENT, &chan->conn_state);
 	}
 
-	if (chan->conn_state & L2CAP_CONN_REMOTE_BUSY)
+	if (test_bit(CONN_REMOTE_BUSY, &chan->conn_state))
 		l2cap_retransmit_frames(chan);
 
 	l2cap_ertm_send(chan);
 
-	if (!(chan->conn_state & L2CAP_CONN_LOCAL_BUSY) &&
+	if (!test_bit(CONN_LOCAL_BUSY, &chan->conn_state) &&
 			chan->frames_sent == 0) {
 		control |= L2CAP_SUPER_RCV_READY;
 		l2cap_send_sframe(chan, control);
@@ -3125,13 +3118,13 @@ static int l2cap_ertm_reassembly_sdu(struct l2cap_chan *chan, struct sk_buff *sk
 
 	switch (control & L2CAP_CTRL_SAR) {
 	case L2CAP_SDU_UNSEGMENTED:
-		if (chan->conn_state & L2CAP_CONN_SAR_SDU)
+		if (test_bit(CONN_SAR_SDU, &chan->conn_state))
 			goto drop;
 
 		return chan->ops->recv(chan->data, skb);
 
 	case L2CAP_SDU_START:
-		if (chan->conn_state & L2CAP_CONN_SAR_SDU)
+		if (test_bit(CONN_SAR_SDU, &chan->conn_state))
 			goto drop;
 
 		chan->sdu_len = get_unaligned_le16(skb->data);
@@ -3150,12 +3143,12 @@ static int l2cap_ertm_reassembly_sdu(struct l2cap_chan *chan, struct sk_buff *sk
 
 		memcpy(skb_put(chan->sdu, skb->len), skb->data, skb->len);
 
-		chan->conn_state |= L2CAP_CONN_SAR_SDU;
+		set_bit(CONN_SAR_SDU, &chan->conn_state);
 		chan->partial_sdu_len = skb->len;
 		break;
 
 	case L2CAP_SDU_CONTINUE:
-		if (!(chan->conn_state & L2CAP_CONN_SAR_SDU))
+		if (!test_bit(CONN_SAR_SDU, &chan->conn_state))
 			goto disconnect;
 
 		if (!chan->sdu)
@@ -3170,13 +3163,13 @@ static int l2cap_ertm_reassembly_sdu(struct l2cap_chan *chan, struct sk_buff *sk
 		break;
 
 	case L2CAP_SDU_END:
-		if (!(chan->conn_state & L2CAP_CONN_SAR_SDU))
+		if (!test_bit(CONN_SAR_SDU, &chan->conn_state))
 			goto disconnect;
 
 		if (!chan->sdu)
 			goto disconnect;
 
-		if (!(chan->conn_state & L2CAP_CONN_SAR_RETRY)) {
+		if (!test_bit(CONN_SAR_RETRY, &chan->conn_state)) {
 			chan->partial_sdu_len += skb->len;
 
 			if (chan->partial_sdu_len > chan->imtu)
@@ -3190,19 +3183,19 @@ static int l2cap_ertm_reassembly_sdu(struct l2cap_chan *chan, struct sk_buff *sk
 
 		_skb = skb_clone(chan->sdu, GFP_ATOMIC);
 		if (!_skb) {
-			chan->conn_state |= L2CAP_CONN_SAR_RETRY;
+			set_bit(CONN_SAR_RETRY, &chan->conn_state);
 			return -ENOMEM;
 		}
 
 		err = chan->ops->recv(chan->data, _skb);
 		if (err < 0) {
 			kfree_skb(_skb);
-			chan->conn_state |= L2CAP_CONN_SAR_RETRY;
+			set_bit(CONN_SAR_RETRY, &chan->conn_state);
 			return err;
 		}
 
-		chan->conn_state &= ~L2CAP_CONN_SAR_RETRY;
-		chan->conn_state &= ~L2CAP_CONN_SAR_SDU;
+		clear_bit(CONN_SAR_RETRY, &chan->conn_state);
+		clear_bit(CONN_SAR_SDU, &chan->conn_state);
 
 		kfree_skb(chan->sdu);
 		break;
@@ -3238,7 +3231,7 @@ static int l2cap_try_push_rx_skb(struct l2cap_chan *chan)
 		chan->buffer_seq = (chan->buffer_seq + 1) % 64;
 	}
 
-	if (!(chan->conn_state & L2CAP_CONN_RNR_SENT))
+	if (!test_bit(CONN_RNR_SENT, &chan->conn_state))
 		goto done;
 
 	control = chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
@@ -3249,11 +3242,11 @@ static int l2cap_try_push_rx_skb(struct l2cap_chan *chan)
 	__clear_retrans_timer(chan);
 	__set_monitor_timer(chan);
 
-	chan->conn_state |= L2CAP_CONN_WAIT_F;
+	set_bit(CONN_WAIT_F, &chan->conn_state);
 
 done:
-	chan->conn_state &= ~L2CAP_CONN_LOCAL_BUSY;
-	chan->conn_state &= ~L2CAP_CONN_RNR_SENT;
+	clear_bit(CONN_LOCAL_BUSY, &chan->conn_state);
+	clear_bit(CONN_RNR_SENT, &chan->conn_state);
 
 	BT_DBG("chan %p, Exit local busy", chan);
 
@@ -3311,7 +3304,7 @@ static int l2cap_push_rx_skb(struct l2cap_chan *chan, struct sk_buff *skb, u16 c
 {
 	int sctrl, err;
 
-	if (chan->conn_state & L2CAP_CONN_LOCAL_BUSY) {
+	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
 		bt_cb(skb)->sar = control >> L2CAP_CTRL_SAR_SHIFT;
 		__skb_queue_tail(&chan->busy_q, skb);
 		return l2cap_try_push_rx_skb(chan);
@@ -3328,7 +3321,7 @@ static int l2cap_push_rx_skb(struct l2cap_chan *chan, struct sk_buff *skb, u16 c
 	/* Busy Condition */
 	BT_DBG("chan %p, Enter local busy", chan);
 
-	chan->conn_state |= L2CAP_CONN_LOCAL_BUSY;
+	set_bit(CONN_LOCAL_BUSY, &chan->conn_state);
 	bt_cb(skb)->sar = control >> L2CAP_CTRL_SAR_SHIFT;
 	__skb_queue_tail(&chan->busy_q, skb);
 
@@ -3336,7 +3329,7 @@ static int l2cap_push_rx_skb(struct l2cap_chan *chan, struct sk_buff *skb, u16 c
 	sctrl |= L2CAP_SUPER_RCV_NOT_READY;
 	l2cap_send_sframe(chan, sctrl);
 
-	chan->conn_state |= L2CAP_CONN_RNR_SENT;
+	set_bit(CONN_RNR_SENT, &chan->conn_state);
 
 	__clear_ack_timer(chan);
 
@@ -3357,7 +3350,7 @@ static int l2cap_streaming_reassembly_sdu(struct l2cap_chan *chan, struct sk_buf
 
 	switch (control & L2CAP_CTRL_SAR) {
 	case L2CAP_SDU_UNSEGMENTED:
-		if (chan->conn_state & L2CAP_CONN_SAR_SDU) {
+		if (test_bit(CONN_SAR_SDU, &chan->conn_state)) {
 			kfree_skb(chan->sdu);
 			break;
 		}
@@ -3369,7 +3362,7 @@ static int l2cap_streaming_reassembly_sdu(struct l2cap_chan *chan, struct sk_buf
 		break;
 
 	case L2CAP_SDU_START:
-		if (chan->conn_state & L2CAP_CONN_SAR_SDU) {
+		if (test_bit(CONN_SAR_SDU, &chan->conn_state)) {
 			kfree_skb(chan->sdu);
 			break;
 		}
@@ -3390,13 +3383,13 @@ static int l2cap_streaming_reassembly_sdu(struct l2cap_chan *chan, struct sk_buf
 
 		memcpy(skb_put(chan->sdu, skb->len), skb->data, skb->len);
 
-		chan->conn_state |= L2CAP_CONN_SAR_SDU;
+		set_bit(CONN_SAR_SDU, &chan->conn_state);
 		chan->partial_sdu_len = skb->len;
 		err = 0;
 		break;
 
 	case L2CAP_SDU_CONTINUE:
-		if (!(chan->conn_state & L2CAP_CONN_SAR_SDU))
+		if (!test_bit(CONN_SAR_SDU, &chan->conn_state))
 			break;
 
 		memcpy(skb_put(chan->sdu, skb->len), skb->data, skb->len);
@@ -3410,12 +3403,12 @@ static int l2cap_streaming_reassembly_sdu(struct l2cap_chan *chan, struct sk_buf
 		break;
 
 	case L2CAP_SDU_END:
-		if (!(chan->conn_state & L2CAP_CONN_SAR_SDU))
+		if (!test_bit(CONN_SAR_SDU, &chan->conn_state))
 			break;
 
 		memcpy(skb_put(chan->sdu, skb->len), skb->data, skb->len);
 
-		chan->conn_state &= ~L2CAP_CONN_SAR_SDU;
+		clear_bit(CONN_SAR_SDU, &chan->conn_state);
 		chan->partial_sdu_len += skb->len;
 
 		if (chan->partial_sdu_len > chan->imtu)
@@ -3506,11 +3499,11 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 							tx_seq, rx_control);
 
 	if (L2CAP_CTRL_FINAL & rx_control &&
-			chan->conn_state & L2CAP_CONN_WAIT_F) {
+			test_bit(CONN_WAIT_F, &chan->conn_state)) {
 		__clear_monitor_timer(chan);
 		if (chan->unacked_frames > 0)
 			__set_retrans_timer(chan);
-		chan->conn_state &= ~L2CAP_CONN_WAIT_F;
+		clear_bit(CONN_WAIT_F, &chan->conn_state);
 	}
 
 	chan->expected_ack_seq = req_seq;
@@ -3529,10 +3522,10 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 		goto drop;
 	}
 
-	if (chan->conn_state & L2CAP_CONN_LOCAL_BUSY)
+	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state))
 		goto drop;
 
-	if (chan->conn_state & L2CAP_CONN_SREJ_SENT) {
+	if (test_bit(CONN_SREJ_SENT, &chan->conn_state)) {
 		struct srej_list *first;
 
 		first = list_first_entry(&chan->srej_l,
@@ -3546,7 +3539,7 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 
 			if (list_empty(&chan->srej_l)) {
 				chan->buffer_seq = chan->buffer_seq_srej;
-				chan->conn_state &= ~L2CAP_CONN_SREJ_SENT;
+				clear_bit(CONN_SREJ_SENT, &chan->conn_state);
 				l2cap_send_ack(chan);
 				BT_DBG("chan %p, Exit SREJ_SENT", chan);
 			}
@@ -3575,7 +3568,7 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 		if (tx_seq_offset < expected_tx_seq_offset)
 			goto drop;
 
-		chan->conn_state |= L2CAP_CONN_SREJ_SENT;
+		set_bit(CONN_SREJ_SENT, &chan->conn_state);
 
 		BT_DBG("chan %p, Enter SREJ", chan);
 
@@ -3586,7 +3579,7 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 		__skb_queue_head_init(&chan->busy_q);
 		l2cap_add_to_srej_queue(chan, skb, tx_seq, sar);
 
-		chan->conn_state |= L2CAP_CONN_SEND_PBIT;
+		set_bit(CONN_SEND_PBIT, &chan->conn_state);
 
 		l2cap_send_srejframe(chan, tx_seq);
 
@@ -3597,7 +3590,7 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 expected:
 	chan->expected_tx_seq = (chan->expected_tx_seq + 1) % 64;
 
-	if (chan->conn_state & L2CAP_CONN_SREJ_SENT) {
+	if (test_bit(CONN_SREJ_SENT, &chan->conn_state)) {
 		bt_cb(skb)->tx_seq = tx_seq;
 		bt_cb(skb)->sar = sar;
 		__skb_queue_tail(&chan->srej_q, skb);
@@ -3609,9 +3602,7 @@ expected:
 		return 0;
 
 	if (rx_control & L2CAP_CTRL_FINAL) {
-		if (chan->conn_state & L2CAP_CONN_REJ_ACT)
-			chan->conn_state &= ~L2CAP_CONN_REJ_ACT;
-		else
+		if (!test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state))
 			l2cap_retransmit_frames(chan);
 	}
 
@@ -3637,33 +3628,31 @@ static inline void l2cap_data_channel_rrframe(struct l2cap_chan *chan, u16 rx_co
 	l2cap_drop_acked_frames(chan);
 
 	if (rx_control & L2CAP_CTRL_POLL) {
-		chan->conn_state |= L2CAP_CONN_SEND_FBIT;
-		if (chan->conn_state & L2CAP_CONN_SREJ_SENT) {
-			if ((chan->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
+		set_bit(CONN_SEND_FBIT, &chan->conn_state);
+		if (test_bit(CONN_SREJ_SENT, &chan->conn_state)) {
+			if (test_bit(CONN_REMOTE_BUSY, &chan->conn_state) &&
 					(chan->unacked_frames > 0))
 				__set_retrans_timer(chan);
 
-			chan->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
+			clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
 			l2cap_send_srejtail(chan);
 		} else {
 			l2cap_send_i_or_rr_or_rnr(chan);
 		}
 
 	} else if (rx_control & L2CAP_CTRL_FINAL) {
-		chan->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
+		clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
 
-		if (chan->conn_state & L2CAP_CONN_REJ_ACT)
-			chan->conn_state &= ~L2CAP_CONN_REJ_ACT;
-		else
+		if (!test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state))
 			l2cap_retransmit_frames(chan);
 
 	} else {
-		if ((chan->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
+		if (test_bit(CONN_REMOTE_BUSY, &chan->conn_state) &&
 				(chan->unacked_frames > 0))
 			__set_retrans_timer(chan);
 
-		chan->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
-		if (chan->conn_state & L2CAP_CONN_SREJ_SENT)
+		clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
+		if (test_bit(CONN_SREJ_SENT, &chan->conn_state))
 			l2cap_send_ack(chan);
 		else
 			l2cap_ertm_send(chan);
@@ -3676,21 +3665,19 @@ static inline void l2cap_data_channel_rejframe(struct l2cap_chan *chan, u16 rx_c
 
 	BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan, tx_seq, rx_control);
 
-	chan->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
+	clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
 
 	chan->expected_ack_seq = tx_seq;
 	l2cap_drop_acked_frames(chan);
 
 	if (rx_control & L2CAP_CTRL_FINAL) {
-		if (chan->conn_state & L2CAP_CONN_REJ_ACT)
-			chan->conn_state &= ~L2CAP_CONN_REJ_ACT;
-		else
+		if (!test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state))
 			l2cap_retransmit_frames(chan);
 	} else {
 		l2cap_retransmit_frames(chan);
 
-		if (chan->conn_state & L2CAP_CONN_WAIT_F)
-			chan->conn_state |= L2CAP_CONN_REJ_ACT;
+		if (test_bit(CONN_WAIT_F, &chan->conn_state))
+			set_bit(CONN_REJ_ACT, &chan->conn_state);
 	}
 }
 static inline void l2cap_data_channel_srejframe(struct l2cap_chan *chan, u16 rx_control)
@@ -3699,32 +3686,32 @@ static inline void l2cap_data_channel_srejframe(struct l2cap_chan *chan, u16 rx_
 
 	BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan, tx_seq, rx_control);
 
-	chan->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
+	clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
 
 	if (rx_control & L2CAP_CTRL_POLL) {
 		chan->expected_ack_seq = tx_seq;
 		l2cap_drop_acked_frames(chan);
 
-		chan->conn_state |= L2CAP_CONN_SEND_FBIT;
+		set_bit(CONN_SEND_FBIT, &chan->conn_state);
 		l2cap_retransmit_one_frame(chan, tx_seq);
 
 		l2cap_ertm_send(chan);
 
-		if (chan->conn_state & L2CAP_CONN_WAIT_F) {
+		if (test_bit(CONN_WAIT_F, &chan->conn_state)) {
 			chan->srej_save_reqseq = tx_seq;
-			chan->conn_state |= L2CAP_CONN_SREJ_ACT;
+			set_bit(CONN_SREJ_ACT, &chan->conn_state);
 		}
 	} else if (rx_control & L2CAP_CTRL_FINAL) {
-		if ((chan->conn_state & L2CAP_CONN_SREJ_ACT) &&
+		if (test_bit(CONN_SREJ_ACT, &chan->conn_state) &&
 				chan->srej_save_reqseq == tx_seq)
-			chan->conn_state &= ~L2CAP_CONN_SREJ_ACT;
+			clear_bit(CONN_SREJ_ACT, &chan->conn_state);
 		else
 			l2cap_retransmit_one_frame(chan, tx_seq);
 	} else {
 		l2cap_retransmit_one_frame(chan, tx_seq);
-		if (chan->conn_state & L2CAP_CONN_WAIT_F) {
+		if (test_bit(CONN_WAIT_F, &chan->conn_state)) {
 			chan->srej_save_reqseq = tx_seq;
-			chan->conn_state |= L2CAP_CONN_SREJ_ACT;
+			set_bit(CONN_SREJ_ACT, &chan->conn_state);
 		}
 	}
 }
@@ -3735,14 +3722,14 @@ static inline void l2cap_data_channel_rnrframe(struct l2cap_chan *chan, u16 rx_c
 
 	BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan, tx_seq, rx_control);
 
-	chan->conn_state |= L2CAP_CONN_REMOTE_BUSY;
+	set_bit(CONN_REMOTE_BUSY, &chan->conn_state);
 	chan->expected_ack_seq = tx_seq;
 	l2cap_drop_acked_frames(chan);
 
 	if (rx_control & L2CAP_CTRL_POLL)
-		chan->conn_state |= L2CAP_CONN_SEND_FBIT;
+		set_bit(CONN_SEND_FBIT, &chan->conn_state);
 
-	if (!(chan->conn_state & L2CAP_CONN_SREJ_SENT)) {
+	if (!test_bit(CONN_SREJ_SENT, &chan->conn_state)) {
 		__clear_retrans_timer(chan);
 		if (rx_control & L2CAP_CTRL_POLL)
 			l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_FINAL);
@@ -3760,11 +3747,11 @@ static inline int l2cap_data_channel_sframe(struct l2cap_chan *chan, u16 rx_cont
 	BT_DBG("chan %p rx_control 0x%4.4x len %d", chan, rx_control, skb->len);
 
 	if (L2CAP_CTRL_FINAL & rx_control &&
-			chan->conn_state & L2CAP_CONN_WAIT_F) {
+			test_bit(CONN_WAIT_F, &chan->conn_state)) {
 		__clear_monitor_timer(chan);
 		if (chan->unacked_frames > 0)
 			__set_retrans_timer(chan);
-		chan->conn_state &= ~L2CAP_CONN_WAIT_F;
+		clear_bit(CONN_WAIT_F, &chan->conn_state);
 	}
 
 	switch (rx_control & L2CAP_CTRL_SUPERVISE) {
-- 
1.7.5.1

