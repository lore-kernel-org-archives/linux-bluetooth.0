Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/15] Bluetooth: Move of ERTM *_seq vars to struct l2cap_chan
Date: Fri,  1 Apr 2011 19:33:13 -0300
Message-Id: <1301697200-2446-9-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1301697200-2446-8-git-send-email-padovan@profusion.mobi>
References: <1301697200-2446-1-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-2-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-3-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-4-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-5-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-6-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-7-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-8-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As part of the moving channel to stuff to struct l2cap_chan.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |   20 +++---
 net/bluetooth/l2cap_core.c    |  128 ++++++++++++++++++++---------------------
 net/bluetooth/l2cap_sock.c    |    2 +-
 3 files changed, 73 insertions(+), 77 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 82d5b81..9b43874 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -288,6 +288,12 @@ struct l2cap_chan {
 
 	__u16		conn_state;
 
+	__u8		next_tx_seq;
+	__u8		expected_ack_seq;
+	__u8		expected_tx_seq;
+	__u8		buffer_seq;
+	__u8		buffer_seq_srej;
+
 	struct list_head list;
 };
 
@@ -353,11 +359,6 @@ struct l2cap_pinfo {
 
 	__u8		conf_state;
 
-	__u8		next_tx_seq;
-	__u8		expected_ack_seq;
-	__u8		expected_tx_seq;
-	__u8		buffer_seq;
-	__u8		buffer_seq_srej;
 	__u8		srej_save_reqseq;
 	__u8		frames_sent;
 	__u8		unacked_frames;
@@ -421,17 +422,16 @@ struct l2cap_pinfo {
 #define __mod_ack_timer() mod_timer(&l2cap_pi(sk)->ack_timer, \
 		jiffies + msecs_to_jiffies(L2CAP_DEFAULT_ACK_TO));
 
-static inline int l2cap_tx_window_full(struct sock *sk)
+static inline int l2cap_tx_window_full(struct l2cap_chan *ch)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	int sub;
 
-	sub = (pi->next_tx_seq - pi->expected_ack_seq) % 64;
+	sub = (ch->next_tx_seq - ch->expected_ack_seq) % 64;
 
 	if (sub < 0)
 		sub += 64;
 
-	return sub == pi->remote_tx_win;
+	return sub == l2cap_pi(ch->sk)->remote_tx_win;
 }
 
 #define __get_txseq(ctrl)	(((ctrl) & L2CAP_CTRL_TXSEQ) >> 1)
@@ -456,7 +456,7 @@ struct sk_buff *l2cap_create_basic_pdu(struct sock *sk, struct msghdr *msg, size
 struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *msg, size_t len, u16 control, u16 sdulen);
 int l2cap_sar_segment_sdu(struct sock *sk, struct msghdr *msg, size_t len);
 void l2cap_do_send(struct sock *sk, struct sk_buff *skb);
-void l2cap_streaming_send(struct sock *sk);
+void l2cap_streaming_send(struct l2cap_chan *chan);
 int l2cap_ertm_send(struct l2cap_chan *chan);
 
 void l2cap_sock_set_timer(struct sock *sk, long timeout);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 695f42b..e00856d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -395,15 +395,13 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u16 control)
 
 static inline void l2cap_send_rr_or_rnr(struct l2cap_chan *chan, u16 control)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
-
 	if (chan->conn_state & L2CAP_CONN_LOCAL_BUSY) {
 		control |= L2CAP_SUPER_RCV_NOT_READY;
 		chan->conn_state |= L2CAP_CONN_RNR_SENT;
 	} else
 		control |= L2CAP_SUPER_RCV_READY;
 
-	control |= pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+	control |= chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 
 	l2cap_send_sframe(chan, control);
 }
@@ -989,13 +987,14 @@ static void l2cap_retrans_timeout(unsigned long arg)
 	bh_unlock_sock(sk);
 }
 
-static void l2cap_drop_acked_frames(struct sock *sk)
+static void l2cap_drop_acked_frames(struct l2cap_chan *chan)
 {
+	struct sock *sk = chan->sk;
 	struct sk_buff *skb;
 
 	while ((skb = skb_peek(TX_QUEUE(sk))) &&
 			l2cap_pi(sk)->unacked_frames) {
-		if (bt_cb(skb)->tx_seq == l2cap_pi(sk)->expected_ack_seq)
+		if (bt_cb(skb)->tx_seq == chan->expected_ack_seq)
 			break;
 
 		skb = skb_dequeue(TX_QUEUE(sk));
@@ -1024,15 +1023,16 @@ void l2cap_do_send(struct sock *sk, struct sk_buff *skb)
 	hci_send_acl(hcon, skb, flags);
 }
 
-void l2cap_streaming_send(struct sock *sk)
+void l2cap_streaming_send(struct l2cap_chan *chan)
 {
+	struct sock *sk = chan->sk;
 	struct sk_buff *skb;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	u16 control, fcs;
 
 	while ((skb = skb_dequeue(TX_QUEUE(sk)))) {
 		control = get_unaligned_le16(skb->data + L2CAP_HDR_SIZE);
-		control |= pi->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT;
+		control |= chan->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT;
 		put_unaligned_le16(control, skb->data + L2CAP_HDR_SIZE);
 
 		if (pi->fcs == L2CAP_FCS_CRC16) {
@@ -1042,7 +1042,7 @@ void l2cap_streaming_send(struct sock *sk)
 
 		l2cap_do_send(sk, skb);
 
-		pi->next_tx_seq = (pi->next_tx_seq + 1) % 64;
+		chan->next_tx_seq = (chan->next_tx_seq + 1) % 64;
 	}
 }
 
@@ -1081,7 +1081,7 @@ static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u8 tx_seq)
 		chan->conn_state &= ~L2CAP_CONN_SEND_FBIT;
 	}
 
-	control |= (pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT)
+	control |= (chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT)
 			| (tx_seq << L2CAP_CTRL_TXSEQ_SHIFT);
 
 	put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
@@ -1105,7 +1105,7 @@ int l2cap_ertm_send(struct l2cap_chan *chan)
 	if (sk->sk_state != BT_CONNECTED)
 		return -ENOTCONN;
 
-	while ((skb = sk->sk_send_head) && (!l2cap_tx_window_full(sk))) {
+	while ((skb = sk->sk_send_head) && (!l2cap_tx_window_full(chan))) {
 
 		if (pi->remote_max_tx &&
 				bt_cb(skb)->retries == pi->remote_max_tx) {
@@ -1124,8 +1124,8 @@ int l2cap_ertm_send(struct l2cap_chan *chan)
 			control |= L2CAP_CTRL_FINAL;
 			chan->conn_state &= ~L2CAP_CONN_SEND_FBIT;
 		}
-		control |= (pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT)
-				| (pi->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT);
+		control |= (chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT)
+				| (chan->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT);
 		put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
 
 
@@ -1138,8 +1138,8 @@ int l2cap_ertm_send(struct l2cap_chan *chan)
 
 		__mod_retrans_timer();
 
-		bt_cb(skb)->tx_seq = pi->next_tx_seq;
-		pi->next_tx_seq = (pi->next_tx_seq + 1) % 64;
+		bt_cb(skb)->tx_seq = chan->next_tx_seq;
+		chan->next_tx_seq = (chan->next_tx_seq + 1) % 64;
 
 		if (bt_cb(skb)->retries == 1)
 			pi->unacked_frames++;
@@ -1160,23 +1160,21 @@ int l2cap_ertm_send(struct l2cap_chan *chan)
 static int l2cap_retransmit_frames(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->sk;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	int ret;
 
 	if (!skb_queue_empty(TX_QUEUE(sk)))
 		sk->sk_send_head = TX_QUEUE(sk)->next;
 
-	pi->next_tx_seq = pi->expected_ack_seq;
+	chan->next_tx_seq = chan->expected_ack_seq;
 	ret = l2cap_ertm_send(chan);
 	return ret;
 }
 
 static void l2cap_send_ack(struct l2cap_chan *chan)
 {
-	struct sock *sk = chan->sk;
 	u16 control = 0;
 
-	control |= l2cap_pi(sk)->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+	control |= chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 
 	if (chan->conn_state & L2CAP_CONN_LOCAL_BUSY) {
 		control |= L2CAP_SUPER_RCV_NOT_READY;
@@ -1576,9 +1574,9 @@ static inline void l2cap_ertm_init(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->sk;
 
-	l2cap_pi(sk)->expected_ack_seq = 0;
+	chan->expected_ack_seq = 0;
 	l2cap_pi(sk)->unacked_frames = 0;
-	l2cap_pi(sk)->buffer_seq = 0;
+	chan->buffer_seq = 0;
 	l2cap_pi(sk)->num_acked = 0;
 	l2cap_pi(sk)->frames_sent = 0;
 
@@ -2312,8 +2310,8 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 		sk->sk_state = BT_CONNECTED;
 
-		l2cap_pi(sk)->next_tx_seq = 0;
-		l2cap_pi(sk)->expected_tx_seq = 0;
+		chan->next_tx_seq = 0;
+		chan->expected_tx_seq = 0;
 		__skb_queue_head_init(TX_QUEUE(sk));
 		if (l2cap_pi(sk)->mode == L2CAP_MODE_ERTM)
 			l2cap_ertm_init(chan);
@@ -2403,8 +2401,8 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		set_default_fcs(l2cap_pi(sk));
 
 		sk->sk_state = BT_CONNECTED;
-		l2cap_pi(sk)->next_tx_seq = 0;
-		l2cap_pi(sk)->expected_tx_seq = 0;
+		chan->next_tx_seq = 0;
+		chan->expected_tx_seq = 0;
 		__skb_queue_head_init(TX_QUEUE(sk));
 		if (l2cap_pi(sk)->mode ==  L2CAP_MODE_ERTM)
 			l2cap_ertm_init(chan);
@@ -2795,7 +2793,7 @@ static inline void l2cap_send_i_or_rr_or_rnr(struct l2cap_chan *chan)
 
 	pi->frames_sent = 0;
 
-	control |= pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+	control |= chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 
 	if (chan->conn_state & L2CAP_CONN_LOCAL_BUSY) {
 		control |= L2CAP_SUPER_RCV_NOT_READY;
@@ -2815,10 +2813,10 @@ static inline void l2cap_send_i_or_rr_or_rnr(struct l2cap_chan *chan)
 	}
 }
 
-static int l2cap_add_to_srej_queue(struct sock *sk, struct sk_buff *skb, u8 tx_seq, u8 sar)
+static int l2cap_add_to_srej_queue(struct l2cap_chan *chan, struct sk_buff *skb, u8 tx_seq, u8 sar)
 {
+	struct sock *sk = chan->sk;
 	struct sk_buff *next_skb;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	int tx_seq_offset, next_tx_seq_offset;
 
 	bt_cb(skb)->tx_seq = tx_seq;
@@ -2830,7 +2828,7 @@ static int l2cap_add_to_srej_queue(struct sock *sk, struct sk_buff *skb, u8 tx_s
 		return 0;
 	}
 
-	tx_seq_offset = (tx_seq - pi->buffer_seq) % 64;
+	tx_seq_offset = (tx_seq - chan->buffer_seq) % 64;
 	if (tx_seq_offset < 0)
 		tx_seq_offset += 64;
 
@@ -2839,7 +2837,7 @@ static int l2cap_add_to_srej_queue(struct sock *sk, struct sk_buff *skb, u8 tx_s
 			return -EINVAL;
 
 		next_tx_seq_offset = (bt_cb(next_skb)->tx_seq -
-						pi->buffer_seq) % 64;
+						chan->buffer_seq) % 64;
 		if (next_tx_seq_offset < 0)
 			next_tx_seq_offset += 64;
 
@@ -2982,13 +2980,13 @@ static int l2cap_try_push_rx_skb(struct l2cap_chan *chan)
 			return -EBUSY;
 		}
 
-		pi->buffer_seq = (pi->buffer_seq + 1) % 64;
+		chan->buffer_seq = (chan->buffer_seq + 1) % 64;
 	}
 
 	if (!(chan->conn_state & L2CAP_CONN_RNR_SENT))
 		goto done;
 
-	control = pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+	control = chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 	control |= L2CAP_SUPER_RCV_READY | L2CAP_CTRL_POLL;
 	l2cap_send_sframe(chan, control);
 	l2cap_pi(sk)->retry_count = 1;
@@ -3070,7 +3068,7 @@ static int l2cap_push_rx_skb(struct l2cap_chan *chan, struct sk_buff *skb, u16 c
 
 	err = l2cap_ertm_reassembly_sdu(chan, skb, control);
 	if (err >= 0) {
-		pi->buffer_seq = (pi->buffer_seq + 1) % 64;
+		chan->buffer_seq = (chan->buffer_seq + 1) % 64;
 		return err;
 	}
 
@@ -3081,7 +3079,7 @@ static int l2cap_push_rx_skb(struct l2cap_chan *chan, struct sk_buff *skb, u16 c
 	bt_cb(skb)->sar = control >> L2CAP_CTRL_SAR_SHIFT;
 	__skb_queue_tail(BUSY_QUEUE(sk), skb);
 
-	sctrl = pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+	sctrl = chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 	sctrl |= L2CAP_SUPER_RCV_NOT_READY;
 	l2cap_send_sframe(chan, sctrl);
 
@@ -3201,8 +3199,8 @@ static void l2cap_check_srej_gap(struct l2cap_chan *chan, u8 tx_seq)
 		skb = skb_dequeue(SREJ_QUEUE(sk));
 		control = bt_cb(skb)->sar << L2CAP_CTRL_SAR_SHIFT;
 		l2cap_ertm_reassembly_sdu(chan, skb, control);
-		l2cap_pi(sk)->buffer_seq_srej =
-			(l2cap_pi(sk)->buffer_seq_srej + 1) % 64;
+		chan->buffer_seq_srej =
+			(chan->buffer_seq_srej + 1) % 64;
 		tx_seq = (tx_seq + 1) % 64;
 	}
 }
@@ -3230,21 +3228,20 @@ static void l2cap_resend_srejframe(struct l2cap_chan *chan, u8 tx_seq)
 static void l2cap_send_srejframe(struct l2cap_chan *chan, u8 tx_seq)
 {
 	struct sock *sk = chan->sk;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct srej_list *new;
 	u16 control;
 
-	while (tx_seq != pi->expected_tx_seq) {
+	while (tx_seq != chan->expected_tx_seq) {
 		control = L2CAP_SUPER_SELECT_REJECT;
-		control |= pi->expected_tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+		control |= chan->expected_tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 		l2cap_send_sframe(chan, control);
 
 		new = kzalloc(sizeof(struct srej_list), GFP_ATOMIC);
-		new->tx_seq = pi->expected_tx_seq;
-		pi->expected_tx_seq = (pi->expected_tx_seq + 1) % 64;
+		new->tx_seq = chan->expected_tx_seq;
+		chan->expected_tx_seq = (chan->expected_tx_seq + 1) % 64;
 		list_add_tail(&new->list, SREJ_LIST(sk));
 	}
-	pi->expected_tx_seq = (pi->expected_tx_seq + 1) % 64;
+	chan->expected_tx_seq = (chan->expected_tx_seq + 1) % 64;
 }
 
 static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_control, struct sk_buff *skb)
@@ -3269,13 +3266,13 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 		chan->conn_state &= ~L2CAP_CONN_WAIT_F;
 	}
 
-	pi->expected_ack_seq = req_seq;
-	l2cap_drop_acked_frames(sk);
+	chan->expected_ack_seq = req_seq;
+	l2cap_drop_acked_frames(chan);
 
-	if (tx_seq == pi->expected_tx_seq)
+	if (tx_seq == chan->expected_tx_seq)
 		goto expected;
 
-	tx_seq_offset = (tx_seq - pi->buffer_seq) % 64;
+	tx_seq_offset = (tx_seq - chan->buffer_seq) % 64;
 	if (tx_seq_offset < 0)
 		tx_seq_offset += 64;
 
@@ -3294,14 +3291,14 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 		first = list_first_entry(SREJ_LIST(sk),
 				struct srej_list, list);
 		if (tx_seq == first->tx_seq) {
-			l2cap_add_to_srej_queue(sk, skb, tx_seq, sar);
+			l2cap_add_to_srej_queue(chan, skb, tx_seq, sar);
 			l2cap_check_srej_gap(chan, tx_seq);
 
 			list_del(&first->list);
 			kfree(first);
 
 			if (list_empty(SREJ_LIST(sk))) {
-				pi->buffer_seq = pi->buffer_seq_srej;
+				chan->buffer_seq = chan->buffer_seq_srej;
 				chan->conn_state &= ~L2CAP_CONN_SREJ_SENT;
 				l2cap_send_ack(chan);
 				BT_DBG("sk %p, Exit SREJ_SENT", sk);
@@ -3310,7 +3307,7 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 			struct srej_list *l;
 
 			/* duplicated tx_seq */
-			if (l2cap_add_to_srej_queue(sk, skb, tx_seq, sar) < 0)
+			if (l2cap_add_to_srej_queue(chan, skb, tx_seq, sar) < 0)
 				goto drop;
 
 			list_for_each_entry(l, SREJ_LIST(sk), list) {
@@ -3323,7 +3320,7 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 		}
 	} else {
 		expected_tx_seq_offset =
-			(pi->expected_tx_seq - pi->buffer_seq) % 64;
+			(chan->expected_tx_seq - chan->buffer_seq) % 64;
 		if (expected_tx_seq_offset < 0)
 			expected_tx_seq_offset += 64;
 
@@ -3336,11 +3333,11 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 		BT_DBG("sk %p, Enter SREJ", sk);
 
 		INIT_LIST_HEAD(SREJ_LIST(sk));
-		pi->buffer_seq_srej = pi->buffer_seq;
+		chan->buffer_seq_srej = chan->buffer_seq;
 
 		__skb_queue_head_init(SREJ_QUEUE(sk));
 		__skb_queue_head_init(BUSY_QUEUE(sk));
-		l2cap_add_to_srej_queue(sk, skb, tx_seq, sar);
+		l2cap_add_to_srej_queue(chan, skb, tx_seq, sar);
 
 		chan->conn_state |= L2CAP_CONN_SEND_PBIT;
 
@@ -3351,7 +3348,7 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 	return 0;
 
 expected:
-	pi->expected_tx_seq = (pi->expected_tx_seq + 1) % 64;
+	chan->expected_tx_seq = (chan->expected_tx_seq + 1) % 64;
 
 	if (chan->conn_state & L2CAP_CONN_SREJ_SENT) {
 		bt_cb(skb)->tx_seq = tx_seq;
@@ -3392,8 +3389,8 @@ static inline void l2cap_data_channel_rrframe(struct l2cap_chan *chan, u16 rx_co
 	BT_DBG("sk %p, req_seq %d ctrl 0x%4.4x", sk, __get_reqseq(rx_control),
 						rx_control);
 
-	pi->expected_ack_seq = __get_reqseq(rx_control);
-	l2cap_drop_acked_frames(sk);
+	chan->expected_ack_seq = __get_reqseq(rx_control);
+	l2cap_drop_acked_frames(chan);
 
 	if (rx_control & L2CAP_CTRL_POLL) {
 		chan->conn_state |= L2CAP_CONN_SEND_FBIT;
@@ -3431,15 +3428,14 @@ static inline void l2cap_data_channel_rrframe(struct l2cap_chan *chan, u16 rx_co
 
 static inline void l2cap_data_channel_rejframe(struct l2cap_chan *chan, u16 rx_control)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
 	u8 tx_seq = __get_reqseq(rx_control);
 
 	BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan, tx_seq, rx_control);
 
 	chan->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
 
-	pi->expected_ack_seq = tx_seq;
-	l2cap_drop_acked_frames(chan->sk);
+	chan->expected_ack_seq = tx_seq;
+	l2cap_drop_acked_frames(chan);
 
 	if (rx_control & L2CAP_CTRL_FINAL) {
 		if (chan->conn_state & L2CAP_CONN_REJ_ACT)
@@ -3463,8 +3459,8 @@ static inline void l2cap_data_channel_srejframe(struct l2cap_chan *chan, u16 rx_
 	chan->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
 
 	if (rx_control & L2CAP_CTRL_POLL) {
-		pi->expected_ack_seq = tx_seq;
-		l2cap_drop_acked_frames(chan->sk);
+		chan->expected_ack_seq = tx_seq;
+		l2cap_drop_acked_frames(chan);
 
 		chan->conn_state |= L2CAP_CONN_SEND_FBIT;
 		l2cap_retransmit_one_frame(chan, tx_seq);
@@ -3498,8 +3494,8 @@ static inline void l2cap_data_channel_rnrframe(struct l2cap_chan *chan, u16 rx_c
 	BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan, tx_seq, rx_control);
 
 	chan->conn_state |= L2CAP_CONN_REMOTE_BUSY;
-	pi->expected_ack_seq = tx_seq;
-	l2cap_drop_acked_frames(chan->sk);
+	chan->expected_ack_seq = tx_seq;
+	l2cap_drop_acked_frames(chan);
 
 	if (rx_control & L2CAP_CTRL_POLL)
 		chan->conn_state |= L2CAP_CONN_SEND_FBIT;
@@ -3585,12 +3581,12 @@ static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 	}
 
 	req_seq = __get_reqseq(control);
-	req_seq_offset = (req_seq - pi->expected_ack_seq) % 64;
+	req_seq_offset = (req_seq - chan->expected_ack_seq) % 64;
 	if (req_seq_offset < 0)
 		req_seq_offset += 64;
 
 	next_tx_seq_offset =
-		(pi->next_tx_seq - pi->expected_ack_seq) % 64;
+		(chan->next_tx_seq - chan->expected_ack_seq) % 64;
 	if (next_tx_seq_offset < 0)
 		next_tx_seq_offset += 64;
 
@@ -3690,10 +3686,10 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 
 		tx_seq = __get_txseq(control);
 
-		if (pi->expected_tx_seq == tx_seq)
-			pi->expected_tx_seq = (pi->expected_tx_seq + 1) % 64;
+		if (chan->expected_tx_seq == tx_seq)
+			chan->expected_tx_seq = (chan->expected_tx_seq + 1) % 64;
 		else
-			pi->expected_tx_seq = (tx_seq + 1) % 64;
+			chan->expected_tx_seq = (tx_seq + 1) % 64;
 
 		l2cap_streaming_reassembly_sdu(chan, skb, control);
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 66ec966..19574e4 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -777,7 +777,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 		}
 
 		if (pi->mode == L2CAP_MODE_STREAMING) {
-			l2cap_streaming_send(sk);
+			l2cap_streaming_send(pi->chan);
 			err = len;
 			break;
 		}
-- 
1.7.4.1

