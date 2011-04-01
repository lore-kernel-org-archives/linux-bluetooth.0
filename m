Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/15] Bluetooth: Move conn_state to struct l2cap_chan
Date: Fri,  1 Apr 2011 19:33:12 -0300
Message-Id: <1301697200-2446-8-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1301697200-2446-7-git-send-email-padovan@profusion.mobi>
References: <1301697200-2446-1-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-2-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-3-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-4-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-5-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-6-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-7-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is part of "moving things to l2cap_chan". As one the first move it
triggered a big number of changes in the funcions parameters, basically
changing the struct sock param to struct l2cap_chan.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    5 +-
 net/bluetooth/l2cap_core.c    |  391 +++++++++++++++++++++-------------------
 net/bluetooth/l2cap_sock.c    |   16 +-
 3 files changed, 217 insertions(+), 195 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 4692413..82d5b81 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -286,6 +286,8 @@ struct l2cap_chan {
 	__u8		num_conf_req;
 	__u8		num_conf_rsp;
 
+	__u16		conn_state;
+
 	struct list_head list;
 };
 
@@ -350,7 +352,6 @@ struct l2cap_pinfo {
 	__u8		flushable;
 
 	__u8		conf_state;
-	__u16		conn_state;
 
 	__u8		next_tx_seq;
 	__u8		expected_ack_seq;
@@ -456,7 +457,7 @@ struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *msg, siz
 int l2cap_sar_segment_sdu(struct sock *sk, struct msghdr *msg, size_t len);
 void l2cap_do_send(struct sock *sk, struct sk_buff *skb);
 void l2cap_streaming_send(struct sock *sk);
-int l2cap_ertm_send(struct sock *sk);
+int l2cap_ertm_send(struct l2cap_chan *chan);
 
 void l2cap_sock_set_timer(struct sock *sk, long timeout);
 void l2cap_sock_clear_timer(struct sock *sk);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 26c187e..695f42b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -340,10 +340,11 @@ void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len, void *d
 	hci_send_acl(conn->hcon, skb, flags);
 }
 
-static inline void l2cap_send_sframe(struct l2cap_pinfo *pi, u16 control)
+static inline void l2cap_send_sframe(struct l2cap_chan *chan, u16 control)
 {
 	struct sk_buff *skb;
 	struct l2cap_hdr *lh;
+	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
 	struct l2cap_conn *conn = pi->conn;
 	struct sock *sk = (struct sock *)pi;
 	int count, hlen = L2CAP_HDR_SIZE + 2;
@@ -360,14 +361,14 @@ static inline void l2cap_send_sframe(struct l2cap_pinfo *pi, u16 control)
 	count = min_t(unsigned int, conn->mtu, hlen);
 	control |= L2CAP_CTRL_FRAME_TYPE;
 
-	if (pi->conn_state & L2CAP_CONN_SEND_FBIT) {
+	if (chan->conn_state & L2CAP_CONN_SEND_FBIT) {
 		control |= L2CAP_CTRL_FINAL;
-		pi->conn_state &= ~L2CAP_CONN_SEND_FBIT;
+		chan->conn_state &= ~L2CAP_CONN_SEND_FBIT;
 	}
 
-	if (pi->conn_state & L2CAP_CONN_SEND_PBIT) {
+	if (chan->conn_state & L2CAP_CONN_SEND_PBIT) {
 		control |= L2CAP_CTRL_POLL;
-		pi->conn_state &= ~L2CAP_CONN_SEND_PBIT;
+		chan->conn_state &= ~L2CAP_CONN_SEND_PBIT;
 	}
 
 	skb = bt_skb_alloc(count, GFP_ATOMIC);
@@ -392,17 +393,19 @@ static inline void l2cap_send_sframe(struct l2cap_pinfo *pi, u16 control)
 	hci_send_acl(pi->conn->hcon, skb, flags);
 }
 
-static inline void l2cap_send_rr_or_rnr(struct l2cap_pinfo *pi, u16 control)
+static inline void l2cap_send_rr_or_rnr(struct l2cap_chan *chan, u16 control)
 {
-	if (pi->conn_state & L2CAP_CONN_LOCAL_BUSY) {
+	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
+
+	if (chan->conn_state & L2CAP_CONN_LOCAL_BUSY) {
 		control |= L2CAP_SUPER_RCV_NOT_READY;
-		pi->conn_state |= L2CAP_CONN_RNR_SENT;
+		chan->conn_state |= L2CAP_CONN_RNR_SENT;
 	} else
 		control |= L2CAP_SUPER_RCV_READY;
 
 	control |= pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 
-	l2cap_send_sframe(pi, control);
+	l2cap_send_sframe(chan, control);
 }
 
 static inline int __l2cap_no_conn_pending(struct sock *sk)
@@ -950,9 +953,10 @@ int __l2cap_wait_ack(struct sock *sk)
 
 static void l2cap_monitor_timeout(unsigned long arg)
 {
-	struct sock *sk = (void *) arg;
+	struct l2cap_chan *chan = (void *) arg;
+	struct sock *sk = chan->sk;
 
-	BT_DBG("sk %p", sk);
+	BT_DBG("chan %p", chan);
 
 	bh_lock_sock(sk);
 	if (l2cap_pi(sk)->retry_count >= l2cap_pi(sk)->remote_max_tx) {
@@ -964,13 +968,14 @@ static void l2cap_monitor_timeout(unsigned long arg)
 	l2cap_pi(sk)->retry_count++;
 	__mod_monitor_timer();
 
-	l2cap_send_rr_or_rnr(l2cap_pi(sk), L2CAP_CTRL_POLL);
+	l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_POLL);
 	bh_unlock_sock(sk);
 }
 
 static void l2cap_retrans_timeout(unsigned long arg)
 {
-	struct sock *sk = (void *) arg;
+	struct l2cap_chan *chan = (void *) arg;
+	struct sock *sk = chan->sk;
 
 	BT_DBG("sk %p", sk);
 
@@ -978,9 +983,9 @@ static void l2cap_retrans_timeout(unsigned long arg)
 	l2cap_pi(sk)->retry_count = 1;
 	__mod_monitor_timer();
 
-	l2cap_pi(sk)->conn_state |= L2CAP_CONN_WAIT_F;
+	chan->conn_state |= L2CAP_CONN_WAIT_F;
 
-	l2cap_send_rr_or_rnr(l2cap_pi(sk), L2CAP_CTRL_POLL);
+	l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_POLL);
 	bh_unlock_sock(sk);
 }
 
@@ -1041,8 +1046,9 @@ void l2cap_streaming_send(struct sock *sk)
 	}
 }
 
-static void l2cap_retransmit_one_frame(struct sock *sk, u8 tx_seq)
+static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u8 tx_seq)
 {
+	struct sock *sk = chan->sk;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct sk_buff *skb, *tx_skb;
 	u16 control, fcs;
@@ -1070,9 +1076,9 @@ static void l2cap_retransmit_one_frame(struct sock *sk, u8 tx_seq)
 	bt_cb(skb)->retries++;
 	control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
 
-	if (pi->conn_state & L2CAP_CONN_SEND_FBIT) {
+	if (chan->conn_state & L2CAP_CONN_SEND_FBIT) {
 		control |= L2CAP_CTRL_FINAL;
-		pi->conn_state &= ~L2CAP_CONN_SEND_FBIT;
+		chan->conn_state &= ~L2CAP_CONN_SEND_FBIT;
 	}
 
 	control |= (pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT)
@@ -1088,9 +1094,10 @@ static void l2cap_retransmit_one_frame(struct sock *sk, u8 tx_seq)
 	l2cap_do_send(sk, tx_skb);
 }
 
-int l2cap_ertm_send(struct sock *sk)
+int l2cap_ertm_send(struct l2cap_chan *chan)
 {
 	struct sk_buff *skb, *tx_skb;
+	struct sock *sk = chan->sk;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	u16 control, fcs;
 	int nsent = 0;
@@ -1113,9 +1120,9 @@ int l2cap_ertm_send(struct sock *sk)
 		control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
 		control &= L2CAP_CTRL_SAR;
 
-		if (pi->conn_state & L2CAP_CONN_SEND_FBIT) {
+		if (chan->conn_state & L2CAP_CONN_SEND_FBIT) {
 			control |= L2CAP_CTRL_FINAL;
-			pi->conn_state &= ~L2CAP_CONN_SEND_FBIT;
+			chan->conn_state &= ~L2CAP_CONN_SEND_FBIT;
 		}
 		control |= (pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT)
 				| (pi->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT);
@@ -1150,8 +1157,9 @@ int l2cap_ertm_send(struct sock *sk)
 	return nsent;
 }
 
-static int l2cap_retransmit_frames(struct sock *sk)
+static int l2cap_retransmit_frames(struct l2cap_chan *chan)
 {
+	struct sock *sk = chan->sk;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	int ret;
 
@@ -1159,32 +1167,32 @@ static int l2cap_retransmit_frames(struct sock *sk)
 		sk->sk_send_head = TX_QUEUE(sk)->next;
 
 	pi->next_tx_seq = pi->expected_ack_seq;
-	ret = l2cap_ertm_send(sk);
+	ret = l2cap_ertm_send(chan);
 	return ret;
 }
 
-static void l2cap_send_ack(struct l2cap_pinfo *pi)
+static void l2cap_send_ack(struct l2cap_chan *chan)
 {
-	struct sock *sk = (struct sock *)pi;
+	struct sock *sk = chan->sk;
 	u16 control = 0;
 
-	control |= pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+	control |= l2cap_pi(sk)->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 
-	if (pi->conn_state & L2CAP_CONN_LOCAL_BUSY) {
+	if (chan->conn_state & L2CAP_CONN_LOCAL_BUSY) {
 		control |= L2CAP_SUPER_RCV_NOT_READY;
-		pi->conn_state |= L2CAP_CONN_RNR_SENT;
-		l2cap_send_sframe(pi, control);
+		chan->conn_state |= L2CAP_CONN_RNR_SENT;
+		l2cap_send_sframe(chan, control);
 		return;
 	}
 
-	if (l2cap_ertm_send(sk) > 0)
+	if (l2cap_ertm_send(chan) > 0)
 		return;
 
 	control |= L2CAP_SUPER_RCV_READY;
-	l2cap_send_sframe(pi, control);
+	l2cap_send_sframe(chan, control);
 }
 
-static void l2cap_send_srejtail(struct sock *sk)
+static void l2cap_send_srejtail(struct l2cap_chan *chan)
 {
 	struct srej_list *tail;
 	u16 control;
@@ -1192,10 +1200,10 @@ static void l2cap_send_srejtail(struct sock *sk)
 	control = L2CAP_SUPER_SELECT_REJECT;
 	control |= L2CAP_CTRL_FINAL;
 
-	tail = list_entry(SREJ_LIST(sk)->prev, struct srej_list, list);
+	tail = list_entry(SREJ_LIST(chan->sk)->prev, struct srej_list, list);
 	control |= tail->tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 
-	l2cap_send_sframe(l2cap_pi(sk), control);
+	l2cap_send_sframe(chan, control);
 }
 
 static inline int l2cap_skbuff_fromiovec(struct sock *sk, struct msghdr *msg, int len, int count, struct sk_buff *skb)
@@ -1557,15 +1565,17 @@ static void l2cap_add_conf_opt(void **ptr, u8 type, u8 len, unsigned long val)
 
 static void l2cap_ack_timeout(unsigned long arg)
 {
-	struct sock *sk = (void *) arg;
+	struct l2cap_chan *chan = (void *) arg;
 
-	bh_lock_sock(sk);
-	l2cap_send_ack(l2cap_pi(sk));
-	bh_unlock_sock(sk);
+	bh_lock_sock(chan->sk);
+	l2cap_send_ack(chan);
+	bh_unlock_sock(chan->sk);
 }
 
-static inline void l2cap_ertm_init(struct sock *sk)
+static inline void l2cap_ertm_init(struct l2cap_chan *chan)
 {
+	struct sock *sk = chan->sk;
+
 	l2cap_pi(sk)->expected_ack_seq = 0;
 	l2cap_pi(sk)->unacked_frames = 0;
 	l2cap_pi(sk)->buffer_seq = 0;
@@ -1573,11 +1583,11 @@ static inline void l2cap_ertm_init(struct sock *sk)
 	l2cap_pi(sk)->frames_sent = 0;
 
 	setup_timer(&l2cap_pi(sk)->retrans_timer,
-			l2cap_retrans_timeout, (unsigned long) sk);
+			l2cap_retrans_timeout, (unsigned long) chan);
 	setup_timer(&l2cap_pi(sk)->monitor_timer,
-			l2cap_monitor_timeout, (unsigned long) sk);
+			l2cap_monitor_timeout, (unsigned long) chan);
 	setup_timer(&l2cap_pi(sk)->ack_timer,
-			l2cap_ack_timeout, (unsigned long) sk);
+			l2cap_ack_timeout, (unsigned long) chan);
 
 	__skb_queue_head_init(SREJ_QUEUE(sk));
 	__skb_queue_head_init(BUSY_QUEUE(sk));
@@ -2306,7 +2316,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		l2cap_pi(sk)->expected_tx_seq = 0;
 		__skb_queue_head_init(TX_QUEUE(sk));
 		if (l2cap_pi(sk)->mode == L2CAP_MODE_ERTM)
-			l2cap_ertm_init(sk);
+			l2cap_ertm_init(chan);
 
 		l2cap_chan_ready(sk);
 		goto unlock;
@@ -2397,7 +2407,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		l2cap_pi(sk)->expected_tx_seq = 0;
 		__skb_queue_head_init(TX_QUEUE(sk));
 		if (l2cap_pi(sk)->mode ==  L2CAP_MODE_ERTM)
-			l2cap_ertm_init(sk);
+			l2cap_ertm_init(chan);
 
 		l2cap_chan_ready(sk);
 	}
@@ -2778,30 +2788,30 @@ static int l2cap_check_fcs(struct l2cap_pinfo *pi,  struct sk_buff *skb)
 	return 0;
 }
 
-static inline void l2cap_send_i_or_rr_or_rnr(struct sock *sk)
+static inline void l2cap_send_i_or_rr_or_rnr(struct l2cap_chan *chan)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
 	u16 control = 0;
 
 	pi->frames_sent = 0;
 
 	control |= pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 
-	if (pi->conn_state & L2CAP_CONN_LOCAL_BUSY) {
+	if (chan->conn_state & L2CAP_CONN_LOCAL_BUSY) {
 		control |= L2CAP_SUPER_RCV_NOT_READY;
-		l2cap_send_sframe(pi, control);
-		pi->conn_state |= L2CAP_CONN_RNR_SENT;
+		l2cap_send_sframe(chan, control);
+		chan->conn_state |= L2CAP_CONN_RNR_SENT;
 	}
 
-	if (pi->conn_state & L2CAP_CONN_REMOTE_BUSY)
-		l2cap_retransmit_frames(sk);
+	if (chan->conn_state & L2CAP_CONN_REMOTE_BUSY)
+		l2cap_retransmit_frames(chan);
 
-	l2cap_ertm_send(sk);
+	l2cap_ertm_send(chan);
 
-	if (!(pi->conn_state & L2CAP_CONN_LOCAL_BUSY) &&
+	if (!(chan->conn_state & L2CAP_CONN_LOCAL_BUSY) &&
 			pi->frames_sent == 0) {
 		control |= L2CAP_SUPER_RCV_READY;
-		l2cap_send_sframe(pi, control);
+		l2cap_send_sframe(chan, control);
 	}
 }
 
@@ -2848,25 +2858,25 @@ static int l2cap_add_to_srej_queue(struct sock *sk, struct sk_buff *skb, u8 tx_s
 	return 0;
 }
 
-static int l2cap_ertm_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 control)
+static int l2cap_ertm_reassembly_sdu(struct l2cap_chan *chan, struct sk_buff *skb, u16 control)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
 	struct sk_buff *_skb;
 	int err;
 
 	switch (control & L2CAP_CTRL_SAR) {
 	case L2CAP_SDU_UNSEGMENTED:
-		if (pi->conn_state & L2CAP_CONN_SAR_SDU)
+		if (chan->conn_state & L2CAP_CONN_SAR_SDU)
 			goto drop;
 
-		err = sock_queue_rcv_skb(sk, skb);
+		err = sock_queue_rcv_skb(chan->sk, skb);
 		if (!err)
 			return err;
 
 		break;
 
 	case L2CAP_SDU_START:
-		if (pi->conn_state & L2CAP_CONN_SAR_SDU)
+		if (chan->conn_state & L2CAP_CONN_SAR_SDU)
 			goto drop;
 
 		pi->sdu_len = get_unaligned_le16(skb->data);
@@ -2885,12 +2895,12 @@ static int l2cap_ertm_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 c
 
 		memcpy(skb_put(pi->sdu, skb->len), skb->data, skb->len);
 
-		pi->conn_state |= L2CAP_CONN_SAR_SDU;
+		chan->conn_state |= L2CAP_CONN_SAR_SDU;
 		pi->partial_sdu_len = skb->len;
 		break;
 
 	case L2CAP_SDU_CONTINUE:
-		if (!(pi->conn_state & L2CAP_CONN_SAR_SDU))
+		if (!(chan->conn_state & L2CAP_CONN_SAR_SDU))
 			goto disconnect;
 
 		if (!pi->sdu)
@@ -2905,13 +2915,13 @@ static int l2cap_ertm_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 c
 		break;
 
 	case L2CAP_SDU_END:
-		if (!(pi->conn_state & L2CAP_CONN_SAR_SDU))
+		if (!(chan->conn_state & L2CAP_CONN_SAR_SDU))
 			goto disconnect;
 
 		if (!pi->sdu)
 			goto disconnect;
 
-		if (!(pi->conn_state & L2CAP_CONN_SAR_RETRY)) {
+		if (!(chan->conn_state & L2CAP_CONN_SAR_RETRY)) {
 			pi->partial_sdu_len += skb->len;
 
 			if (pi->partial_sdu_len > pi->imtu)
@@ -2925,19 +2935,19 @@ static int l2cap_ertm_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 c
 
 		_skb = skb_clone(pi->sdu, GFP_ATOMIC);
 		if (!_skb) {
-			pi->conn_state |= L2CAP_CONN_SAR_RETRY;
+			chan->conn_state |= L2CAP_CONN_SAR_RETRY;
 			return -ENOMEM;
 		}
 
-		err = sock_queue_rcv_skb(sk, _skb);
+		err = sock_queue_rcv_skb(chan->sk, _skb);
 		if (err < 0) {
 			kfree_skb(_skb);
-			pi->conn_state |= L2CAP_CONN_SAR_RETRY;
+			chan->conn_state |= L2CAP_CONN_SAR_RETRY;
 			return err;
 		}
 
-		pi->conn_state &= ~L2CAP_CONN_SAR_RETRY;
-		pi->conn_state &= ~L2CAP_CONN_SAR_SDU;
+		chan->conn_state &= ~L2CAP_CONN_SAR_RETRY;
+		chan->conn_state &= ~L2CAP_CONN_SAR_SDU;
 
 		kfree_skb(pi->sdu);
 		break;
@@ -2951,13 +2961,14 @@ drop:
 	pi->sdu = NULL;
 
 disconnect:
-	l2cap_send_disconn_req(pi->conn, sk, ECONNRESET);
+	l2cap_send_disconn_req(pi->conn, chan->sk, ECONNRESET);
 	kfree_skb(skb);
 	return 0;
 }
 
-static int l2cap_try_push_rx_skb(struct sock *sk)
+static int l2cap_try_push_rx_skb(struct l2cap_chan *chan)
 {
+	struct sock *sk = chan->sk;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct sk_buff *skb;
 	u16 control;
@@ -2965,7 +2976,7 @@ static int l2cap_try_push_rx_skb(struct sock *sk)
 
 	while ((skb = skb_dequeue(BUSY_QUEUE(sk)))) {
 		control = bt_cb(skb)->sar << L2CAP_CTRL_SAR_SHIFT;
-		err = l2cap_ertm_reassembly_sdu(sk, skb, control);
+		err = l2cap_ertm_reassembly_sdu(chan, skb, control);
 		if (err < 0) {
 			skb_queue_head(BUSY_QUEUE(sk), skb);
 			return -EBUSY;
@@ -2974,22 +2985,22 @@ static int l2cap_try_push_rx_skb(struct sock *sk)
 		pi->buffer_seq = (pi->buffer_seq + 1) % 64;
 	}
 
-	if (!(pi->conn_state & L2CAP_CONN_RNR_SENT))
+	if (!(chan->conn_state & L2CAP_CONN_RNR_SENT))
 		goto done;
 
 	control = pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 	control |= L2CAP_SUPER_RCV_READY | L2CAP_CTRL_POLL;
-	l2cap_send_sframe(pi, control);
+	l2cap_send_sframe(chan, control);
 	l2cap_pi(sk)->retry_count = 1;
 
 	del_timer(&pi->retrans_timer);
 	__mod_monitor_timer();
 
-	l2cap_pi(sk)->conn_state |= L2CAP_CONN_WAIT_F;
+	chan->conn_state |= L2CAP_CONN_WAIT_F;
 
 done:
-	pi->conn_state &= ~L2CAP_CONN_LOCAL_BUSY;
-	pi->conn_state &= ~L2CAP_CONN_RNR_SENT;
+	chan->conn_state &= ~L2CAP_CONN_LOCAL_BUSY;
+	chan->conn_state &= ~L2CAP_CONN_RNR_SENT;
 
 	BT_DBG("sk %p, Exit local busy", sk);
 
@@ -3033,7 +3044,7 @@ static void l2cap_busy_work(struct work_struct *work)
 		if (err)
 			break;
 
-		if (l2cap_try_push_rx_skb(sk) == 0)
+		if (l2cap_try_push_rx_skb(l2cap_pi(sk)->chan) == 0)
 			break;
 	}
 
@@ -3043,20 +3054,21 @@ static void l2cap_busy_work(struct work_struct *work)
 	release_sock(sk);
 }
 
-static int l2cap_push_rx_skb(struct sock *sk, struct sk_buff *skb, u16 control)
+static int l2cap_push_rx_skb(struct l2cap_chan *chan, struct sk_buff *skb, u16 control)
 {
+	struct sock *sk = chan->sk;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	int sctrl, err;
 
-	if (pi->conn_state & L2CAP_CONN_LOCAL_BUSY) {
+	if (chan->conn_state & L2CAP_CONN_LOCAL_BUSY) {
 		bt_cb(skb)->sar = control >> L2CAP_CTRL_SAR_SHIFT;
 		__skb_queue_tail(BUSY_QUEUE(sk), skb);
-		return l2cap_try_push_rx_skb(sk);
+		return l2cap_try_push_rx_skb(chan);
 
 
 	}
 
-	err = l2cap_ertm_reassembly_sdu(sk, skb, control);
+	err = l2cap_ertm_reassembly_sdu(chan, skb, control);
 	if (err >= 0) {
 		pi->buffer_seq = (pi->buffer_seq + 1) % 64;
 		return err;
@@ -3065,15 +3077,15 @@ static int l2cap_push_rx_skb(struct sock *sk, struct sk_buff *skb, u16 control)
 	/* Busy Condition */
 	BT_DBG("sk %p, Enter local busy", sk);
 
-	pi->conn_state |= L2CAP_CONN_LOCAL_BUSY;
+	chan->conn_state |= L2CAP_CONN_LOCAL_BUSY;
 	bt_cb(skb)->sar = control >> L2CAP_CTRL_SAR_SHIFT;
 	__skb_queue_tail(BUSY_QUEUE(sk), skb);
 
 	sctrl = pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 	sctrl |= L2CAP_SUPER_RCV_NOT_READY;
-	l2cap_send_sframe(pi, sctrl);
+	l2cap_send_sframe(chan, sctrl);
 
-	pi->conn_state |= L2CAP_CONN_RNR_SENT;
+	chan->conn_state |= L2CAP_CONN_RNR_SENT;
 
 	del_timer(&pi->ack_timer);
 
@@ -3082,9 +3094,9 @@ static int l2cap_push_rx_skb(struct sock *sk, struct sk_buff *skb, u16 control)
 	return err;
 }
 
-static int l2cap_streaming_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 control)
+static int l2cap_streaming_reassembly_sdu(struct l2cap_chan *chan, struct sk_buff *skb, u16 control)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
 	struct sk_buff *_skb;
 	int err = -EINVAL;
 
@@ -3095,19 +3107,19 @@ static int l2cap_streaming_reassembly_sdu(struct sock *sk, struct sk_buff *skb,
 
 	switch (control & L2CAP_CTRL_SAR) {
 	case L2CAP_SDU_UNSEGMENTED:
-		if (pi->conn_state & L2CAP_CONN_SAR_SDU) {
+		if (chan->conn_state & L2CAP_CONN_SAR_SDU) {
 			kfree_skb(pi->sdu);
 			break;
 		}
 
-		err = sock_queue_rcv_skb(sk, skb);
+		err = sock_queue_rcv_skb(chan->sk, skb);
 		if (!err)
 			return 0;
 
 		break;
 
 	case L2CAP_SDU_START:
-		if (pi->conn_state & L2CAP_CONN_SAR_SDU) {
+		if (chan->conn_state & L2CAP_CONN_SAR_SDU) {
 			kfree_skb(pi->sdu);
 			break;
 		}
@@ -3128,13 +3140,13 @@ static int l2cap_streaming_reassembly_sdu(struct sock *sk, struct sk_buff *skb,
 
 		memcpy(skb_put(pi->sdu, skb->len), skb->data, skb->len);
 
-		pi->conn_state |= L2CAP_CONN_SAR_SDU;
+		chan->conn_state |= L2CAP_CONN_SAR_SDU;
 		pi->partial_sdu_len = skb->len;
 		err = 0;
 		break;
 
 	case L2CAP_SDU_CONTINUE:
-		if (!(pi->conn_state & L2CAP_CONN_SAR_SDU))
+		if (!(chan->conn_state & L2CAP_CONN_SAR_SDU))
 			break;
 
 		memcpy(skb_put(pi->sdu, skb->len), skb->data, skb->len);
@@ -3148,12 +3160,12 @@ static int l2cap_streaming_reassembly_sdu(struct sock *sk, struct sk_buff *skb,
 		break;
 
 	case L2CAP_SDU_END:
-		if (!(pi->conn_state & L2CAP_CONN_SAR_SDU))
+		if (!(chan->conn_state & L2CAP_CONN_SAR_SDU))
 			break;
 
 		memcpy(skb_put(pi->sdu, skb->len), skb->data, skb->len);
 
-		pi->conn_state &= ~L2CAP_CONN_SAR_SDU;
+		chan->conn_state &= ~L2CAP_CONN_SAR_SDU;
 		pi->partial_sdu_len += skb->len;
 
 		if (pi->partial_sdu_len > pi->imtu)
@@ -3161,7 +3173,7 @@ static int l2cap_streaming_reassembly_sdu(struct sock *sk, struct sk_buff *skb,
 
 		if (pi->partial_sdu_len == pi->sdu_len) {
 			_skb = skb_clone(pi->sdu, GFP_ATOMIC);
-			err = sock_queue_rcv_skb(sk, _skb);
+			err = sock_queue_rcv_skb(chan->sk, _skb);
 			if (err < 0)
 				kfree_skb(_skb);
 		}
@@ -3176,8 +3188,9 @@ drop:
 	return err;
 }
 
-static void l2cap_check_srej_gap(struct sock *sk, u8 tx_seq)
+static void l2cap_check_srej_gap(struct l2cap_chan *chan, u8 tx_seq)
 {
+	struct sock *sk = chan->sk;
 	struct sk_buff *skb;
 	u16 control;
 
@@ -3187,16 +3200,16 @@ static void l2cap_check_srej_gap(struct sock *sk, u8 tx_seq)
 
 		skb = skb_dequeue(SREJ_QUEUE(sk));
 		control = bt_cb(skb)->sar << L2CAP_CTRL_SAR_SHIFT;
-		l2cap_ertm_reassembly_sdu(sk, skb, control);
+		l2cap_ertm_reassembly_sdu(chan, skb, control);
 		l2cap_pi(sk)->buffer_seq_srej =
 			(l2cap_pi(sk)->buffer_seq_srej + 1) % 64;
 		tx_seq = (tx_seq + 1) % 64;
 	}
 }
 
-static void l2cap_resend_srejframe(struct sock *sk, u8 tx_seq)
+static void l2cap_resend_srejframe(struct l2cap_chan *chan, u8 tx_seq)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct sock *sk = chan->sk;
 	struct srej_list *l, *tmp;
 	u16 control;
 
@@ -3208,14 +3221,15 @@ static void l2cap_resend_srejframe(struct sock *sk, u8 tx_seq)
 		}
 		control = L2CAP_SUPER_SELECT_REJECT;
 		control |= l->tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
-		l2cap_send_sframe(pi, control);
+		l2cap_send_sframe(chan, control);
 		list_del(&l->list);
 		list_add_tail(&l->list, SREJ_LIST(sk));
 	}
 }
 
-static void l2cap_send_srejframe(struct sock *sk, u8 tx_seq)
+static void l2cap_send_srejframe(struct l2cap_chan *chan, u8 tx_seq)
 {
+	struct sock *sk = chan->sk;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct srej_list *new;
 	u16 control;
@@ -3223,7 +3237,7 @@ static void l2cap_send_srejframe(struct sock *sk, u8 tx_seq)
 	while (tx_seq != pi->expected_tx_seq) {
 		control = L2CAP_SUPER_SELECT_REJECT;
 		control |= pi->expected_tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
-		l2cap_send_sframe(pi, control);
+		l2cap_send_sframe(chan, control);
 
 		new = kzalloc(sizeof(struct srej_list), GFP_ATOMIC);
 		new->tx_seq = pi->expected_tx_seq;
@@ -3233,8 +3247,9 @@ static void l2cap_send_srejframe(struct sock *sk, u8 tx_seq)
 	pi->expected_tx_seq = (pi->expected_tx_seq + 1) % 64;
 }
 
-static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, struct sk_buff *skb)
+static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_control, struct sk_buff *skb)
 {
+	struct sock *sk = chan->sk;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	u8 tx_seq = __get_txseq(rx_control);
 	u8 req_seq = __get_reqseq(rx_control);
@@ -3243,15 +3258,15 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 	int num_to_ack = (pi->tx_win/6) + 1;
 	int err = 0;
 
-	BT_DBG("sk %p len %d tx_seq %d rx_control 0x%4.4x", sk, skb->len, tx_seq,
-								rx_control);
+	BT_DBG("chan %p len %d tx_seq %d rx_control 0x%4.4x", chan, skb->len,
+							tx_seq, rx_control);
 
 	if (L2CAP_CTRL_FINAL & rx_control &&
-			l2cap_pi(sk)->conn_state & L2CAP_CONN_WAIT_F) {
+			chan->conn_state & L2CAP_CONN_WAIT_F) {
 		del_timer(&pi->monitor_timer);
 		if (pi->unacked_frames > 0)
 			__mod_retrans_timer();
-		pi->conn_state &= ~L2CAP_CONN_WAIT_F;
+		chan->conn_state &= ~L2CAP_CONN_WAIT_F;
 	}
 
 	pi->expected_ack_seq = req_seq;
@@ -3270,25 +3285,25 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 		goto drop;
 	}
 
-	if (pi->conn_state == L2CAP_CONN_LOCAL_BUSY)
+	if (chan->conn_state == L2CAP_CONN_LOCAL_BUSY)
 		goto drop;
 
-	if (pi->conn_state & L2CAP_CONN_SREJ_SENT) {
+	if (chan->conn_state & L2CAP_CONN_SREJ_SENT) {
 		struct srej_list *first;
 
 		first = list_first_entry(SREJ_LIST(sk),
 				struct srej_list, list);
 		if (tx_seq == first->tx_seq) {
 			l2cap_add_to_srej_queue(sk, skb, tx_seq, sar);
-			l2cap_check_srej_gap(sk, tx_seq);
+			l2cap_check_srej_gap(chan, tx_seq);
 
 			list_del(&first->list);
 			kfree(first);
 
 			if (list_empty(SREJ_LIST(sk))) {
 				pi->buffer_seq = pi->buffer_seq_srej;
-				pi->conn_state &= ~L2CAP_CONN_SREJ_SENT;
-				l2cap_send_ack(pi);
+				chan->conn_state &= ~L2CAP_CONN_SREJ_SENT;
+				l2cap_send_ack(chan);
 				BT_DBG("sk %p, Exit SREJ_SENT", sk);
 			}
 		} else {
@@ -3300,11 +3315,11 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 
 			list_for_each_entry(l, SREJ_LIST(sk), list) {
 				if (l->tx_seq == tx_seq) {
-					l2cap_resend_srejframe(sk, tx_seq);
+					l2cap_resend_srejframe(chan, tx_seq);
 					return 0;
 				}
 			}
-			l2cap_send_srejframe(sk, tx_seq);
+			l2cap_send_srejframe(chan, tx_seq);
 		}
 	} else {
 		expected_tx_seq_offset =
@@ -3316,7 +3331,7 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 		if (tx_seq_offset < expected_tx_seq_offset)
 			goto drop;
 
-		pi->conn_state |= L2CAP_CONN_SREJ_SENT;
+		chan->conn_state |= L2CAP_CONN_SREJ_SENT;
 
 		BT_DBG("sk %p, Enter SREJ", sk);
 
@@ -3327,9 +3342,9 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 		__skb_queue_head_init(BUSY_QUEUE(sk));
 		l2cap_add_to_srej_queue(sk, skb, tx_seq, sar);
 
-		pi->conn_state |= L2CAP_CONN_SEND_PBIT;
+		chan->conn_state |= L2CAP_CONN_SEND_PBIT;
 
-		l2cap_send_srejframe(sk, tx_seq);
+		l2cap_send_srejframe(chan, tx_seq);
 
 		del_timer(&pi->ack_timer);
 	}
@@ -3338,29 +3353,29 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 expected:
 	pi->expected_tx_seq = (pi->expected_tx_seq + 1) % 64;
 
-	if (pi->conn_state & L2CAP_CONN_SREJ_SENT) {
+	if (chan->conn_state & L2CAP_CONN_SREJ_SENT) {
 		bt_cb(skb)->tx_seq = tx_seq;
 		bt_cb(skb)->sar = sar;
 		__skb_queue_tail(SREJ_QUEUE(sk), skb);
 		return 0;
 	}
 
-	err = l2cap_push_rx_skb(sk, skb, rx_control);
+	err = l2cap_push_rx_skb(chan, skb, rx_control);
 	if (err < 0)
 		return 0;
 
 	if (rx_control & L2CAP_CTRL_FINAL) {
-		if (pi->conn_state & L2CAP_CONN_REJ_ACT)
-			pi->conn_state &= ~L2CAP_CONN_REJ_ACT;
+		if (chan->conn_state & L2CAP_CONN_REJ_ACT)
+			chan->conn_state &= ~L2CAP_CONN_REJ_ACT;
 		else
-			l2cap_retransmit_frames(sk);
+			l2cap_retransmit_frames(chan);
 	}
 
 	__mod_ack_timer();
 
 	pi->num_acked = (pi->num_acked + 1) % num_to_ack;
 	if (pi->num_acked == num_to_ack - 1)
-		l2cap_send_ack(pi);
+		l2cap_send_ack(chan);
 
 	return 0;
 
@@ -3369,8 +3384,9 @@ drop:
 	return 0;
 }
 
-static inline void l2cap_data_channel_rrframe(struct sock *sk, u16 rx_control)
+static inline void l2cap_data_channel_rrframe(struct l2cap_chan *chan, u16 rx_control)
 {
+	struct sock *sk = chan->sk;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 
 	BT_DBG("sk %p, req_seq %d ctrl 0x%4.4x", sk, __get_reqseq(rx_control),
@@ -3380,154 +3396,156 @@ static inline void l2cap_data_channel_rrframe(struct sock *sk, u16 rx_control)
 	l2cap_drop_acked_frames(sk);
 
 	if (rx_control & L2CAP_CTRL_POLL) {
-		pi->conn_state |= L2CAP_CONN_SEND_FBIT;
-		if (pi->conn_state & L2CAP_CONN_SREJ_SENT) {
-			if ((pi->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
+		chan->conn_state |= L2CAP_CONN_SEND_FBIT;
+		if (chan->conn_state & L2CAP_CONN_SREJ_SENT) {
+			if ((chan->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
 					(pi->unacked_frames > 0))
 				__mod_retrans_timer();
 
-			pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
-			l2cap_send_srejtail(sk);
+			chan->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
+			l2cap_send_srejtail(chan);
 		} else {
-			l2cap_send_i_or_rr_or_rnr(sk);
+			l2cap_send_i_or_rr_or_rnr(chan);
 		}
 
 	} else if (rx_control & L2CAP_CTRL_FINAL) {
-		pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
+		chan->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
 
-		if (pi->conn_state & L2CAP_CONN_REJ_ACT)
-			pi->conn_state &= ~L2CAP_CONN_REJ_ACT;
+		if (chan->conn_state & L2CAP_CONN_REJ_ACT)
+			chan->conn_state &= ~L2CAP_CONN_REJ_ACT;
 		else
-			l2cap_retransmit_frames(sk);
+			l2cap_retransmit_frames(chan);
 
 	} else {
-		if ((pi->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
+		if ((chan->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
 				(pi->unacked_frames > 0))
 			__mod_retrans_timer();
 
-		pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
-		if (pi->conn_state & L2CAP_CONN_SREJ_SENT)
-			l2cap_send_ack(pi);
+		chan->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
+		if (chan->conn_state & L2CAP_CONN_SREJ_SENT)
+			l2cap_send_ack(chan);
 		else
-			l2cap_ertm_send(sk);
+			l2cap_ertm_send(chan);
 	}
 }
 
-static inline void l2cap_data_channel_rejframe(struct sock *sk, u16 rx_control)
+static inline void l2cap_data_channel_rejframe(struct l2cap_chan *chan, u16 rx_control)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
 	u8 tx_seq = __get_reqseq(rx_control);
 
-	BT_DBG("sk %p, req_seq %d ctrl 0x%4.4x", sk, tx_seq, rx_control);
+	BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan, tx_seq, rx_control);
 
-	pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
+	chan->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
 
 	pi->expected_ack_seq = tx_seq;
-	l2cap_drop_acked_frames(sk);
+	l2cap_drop_acked_frames(chan->sk);
 
 	if (rx_control & L2CAP_CTRL_FINAL) {
-		if (pi->conn_state & L2CAP_CONN_REJ_ACT)
-			pi->conn_state &= ~L2CAP_CONN_REJ_ACT;
+		if (chan->conn_state & L2CAP_CONN_REJ_ACT)
+			chan->conn_state &= ~L2CAP_CONN_REJ_ACT;
 		else
-			l2cap_retransmit_frames(sk);
+			l2cap_retransmit_frames(chan);
 	} else {
-		l2cap_retransmit_frames(sk);
+		l2cap_retransmit_frames(chan);
 
-		if (pi->conn_state & L2CAP_CONN_WAIT_F)
-			pi->conn_state |= L2CAP_CONN_REJ_ACT;
+		if (chan->conn_state & L2CAP_CONN_WAIT_F)
+			chan->conn_state |= L2CAP_CONN_REJ_ACT;
 	}
 }
-static inline void l2cap_data_channel_srejframe(struct sock *sk, u16 rx_control)
+static inline void l2cap_data_channel_srejframe(struct l2cap_chan *chan, u16 rx_control)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
 	u8 tx_seq = __get_reqseq(rx_control);
 
-	BT_DBG("sk %p, req_seq %d ctrl 0x%4.4x", sk, tx_seq, rx_control);
+	BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan, tx_seq, rx_control);
 
-	pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
+	chan->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
 
 	if (rx_control & L2CAP_CTRL_POLL) {
 		pi->expected_ack_seq = tx_seq;
-		l2cap_drop_acked_frames(sk);
+		l2cap_drop_acked_frames(chan->sk);
 
-		pi->conn_state |= L2CAP_CONN_SEND_FBIT;
-		l2cap_retransmit_one_frame(sk, tx_seq);
+		chan->conn_state |= L2CAP_CONN_SEND_FBIT;
+		l2cap_retransmit_one_frame(chan, tx_seq);
 
-		l2cap_ertm_send(sk);
+		l2cap_ertm_send(chan);
 
-		if (pi->conn_state & L2CAP_CONN_WAIT_F) {
+		if (chan->conn_state & L2CAP_CONN_WAIT_F) {
 			pi->srej_save_reqseq = tx_seq;
-			pi->conn_state |= L2CAP_CONN_SREJ_ACT;
+			chan->conn_state |= L2CAP_CONN_SREJ_ACT;
 		}
 	} else if (rx_control & L2CAP_CTRL_FINAL) {
-		if ((pi->conn_state & L2CAP_CONN_SREJ_ACT) &&
+		if ((chan->conn_state & L2CAP_CONN_SREJ_ACT) &&
 				pi->srej_save_reqseq == tx_seq)
-			pi->conn_state &= ~L2CAP_CONN_SREJ_ACT;
+			chan->conn_state &= ~L2CAP_CONN_SREJ_ACT;
 		else
-			l2cap_retransmit_one_frame(sk, tx_seq);
+			l2cap_retransmit_one_frame(chan, tx_seq);
 	} else {
-		l2cap_retransmit_one_frame(sk, tx_seq);
-		if (pi->conn_state & L2CAP_CONN_WAIT_F) {
+		l2cap_retransmit_one_frame(chan, tx_seq);
+		if (chan->conn_state & L2CAP_CONN_WAIT_F) {
 			pi->srej_save_reqseq = tx_seq;
-			pi->conn_state |= L2CAP_CONN_SREJ_ACT;
+			chan->conn_state |= L2CAP_CONN_SREJ_ACT;
 		}
 	}
 }
 
-static inline void l2cap_data_channel_rnrframe(struct sock *sk, u16 rx_control)
+static inline void l2cap_data_channel_rnrframe(struct l2cap_chan *chan, u16 rx_control)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
 	u8 tx_seq = __get_reqseq(rx_control);
 
-	BT_DBG("sk %p, req_seq %d ctrl 0x%4.4x", sk, tx_seq, rx_control);
+	BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan, tx_seq, rx_control);
 
-	pi->conn_state |= L2CAP_CONN_REMOTE_BUSY;
+	chan->conn_state |= L2CAP_CONN_REMOTE_BUSY;
 	pi->expected_ack_seq = tx_seq;
-	l2cap_drop_acked_frames(sk);
+	l2cap_drop_acked_frames(chan->sk);
 
 	if (rx_control & L2CAP_CTRL_POLL)
-		pi->conn_state |= L2CAP_CONN_SEND_FBIT;
+		chan->conn_state |= L2CAP_CONN_SEND_FBIT;
 
-	if (!(pi->conn_state & L2CAP_CONN_SREJ_SENT)) {
+	if (!(chan->conn_state & L2CAP_CONN_SREJ_SENT)) {
 		del_timer(&pi->retrans_timer);
 		if (rx_control & L2CAP_CTRL_POLL)
-			l2cap_send_rr_or_rnr(pi, L2CAP_CTRL_FINAL);
+			l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_FINAL);
 		return;
 	}
 
 	if (rx_control & L2CAP_CTRL_POLL)
-		l2cap_send_srejtail(sk);
+		l2cap_send_srejtail(chan);
 	else
-		l2cap_send_sframe(pi, L2CAP_SUPER_RCV_READY);
+		l2cap_send_sframe(chan, L2CAP_SUPER_RCV_READY);
 }
 
-static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, struct sk_buff *skb)
+static inline int l2cap_data_channel_sframe(struct l2cap_chan *chan, u16 rx_control, struct sk_buff *skb)
 {
-	BT_DBG("sk %p rx_control 0x%4.4x len %d", sk, rx_control, skb->len);
+	struct sock *sk = chan->sk;
+
+	BT_DBG("chan %p rx_control 0x%4.4x len %d", chan, rx_control, skb->len);
 
 	if (L2CAP_CTRL_FINAL & rx_control &&
-			l2cap_pi(sk)->conn_state & L2CAP_CONN_WAIT_F) {
+			chan->conn_state & L2CAP_CONN_WAIT_F) {
 		del_timer(&l2cap_pi(sk)->monitor_timer);
 		if (l2cap_pi(sk)->unacked_frames > 0)
 			__mod_retrans_timer();
-		l2cap_pi(sk)->conn_state &= ~L2CAP_CONN_WAIT_F;
+		chan->conn_state &= ~L2CAP_CONN_WAIT_F;
 	}
 
 	switch (rx_control & L2CAP_CTRL_SUPERVISE) {
 	case L2CAP_SUPER_RCV_READY:
-		l2cap_data_channel_rrframe(sk, rx_control);
+		l2cap_data_channel_rrframe(chan, rx_control);
 		break;
 
 	case L2CAP_SUPER_REJECT:
-		l2cap_data_channel_rejframe(sk, rx_control);
+		l2cap_data_channel_rejframe(chan, rx_control);
 		break;
 
 	case L2CAP_SUPER_SELECT_REJECT:
-		l2cap_data_channel_srejframe(sk, rx_control);
+		l2cap_data_channel_srejframe(chan, rx_control);
 		break;
 
 	case L2CAP_SUPER_RCV_NOT_READY:
-		l2cap_data_channel_rnrframe(sk, rx_control);
+		l2cap_data_channel_rnrframe(chan, rx_control);
 		break;
 	}
 
@@ -3537,6 +3555,7 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 
 static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 {
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	u16 control;
 	u8 req_seq;
@@ -3587,7 +3606,7 @@ static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		l2cap_data_channel_iframe(sk, control, skb);
+		l2cap_data_channel_iframe(chan, control, skb);
 	} else {
 		if (len != 0) {
 			BT_ERR("%d", len);
@@ -3595,7 +3614,7 @@ static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		l2cap_data_channel_sframe(sk, control, skb);
+		l2cap_data_channel_sframe(chan, control, skb);
 	}
 
 	return 0;
@@ -3676,7 +3695,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		else
 			pi->expected_tx_seq = (tx_seq + 1) % 64;
 
-		l2cap_streaming_reassembly_sdu(sk, skb, control);
+		l2cap_streaming_reassembly_sdu(chan, skb, control);
 
 		goto done;
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 450f57b..66ec966 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -778,14 +778,16 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 
 		if (pi->mode == L2CAP_MODE_STREAMING) {
 			l2cap_streaming_send(sk);
-		} else {
-			if ((pi->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
-					(pi->conn_state & L2CAP_CONN_WAIT_F)) {
-				err = len;
-				break;
-			}
-			err = l2cap_ertm_send(sk);
+			err = len;
+			break;
+		}
+
+		if ((pi->chan->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
+				(pi->chan->conn_state & L2CAP_CONN_WAIT_F)) {
+			err = len;
+			break;
 		}
+		err = l2cap_ertm_send(pi->chan);
 
 		if (err >= 0)
 			err = len;
-- 
1.7.4.1

