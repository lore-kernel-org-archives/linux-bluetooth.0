Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/15] Bluetooth: Move more ERTM stuff to struct l2cap_chan
Date: Fri,  1 Apr 2011 19:33:14 -0300
Message-Id: <1301697200-2446-10-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1301697200-2446-9-git-send-email-padovan@profusion.mobi>
References: <1301697200-2446-1-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-2-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-3-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-4-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-5-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-6-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-7-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-8-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-9-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As part of the moving channel stuff to l2cap_chan.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |   10 ++++----
 net/bluetooth/l2cap_core.c    |   51 +++++++++++++++++++---------------------
 2 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 9b43874..041213b 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -293,6 +293,11 @@ struct l2cap_chan {
 	__u8		expected_tx_seq;
 	__u8		buffer_seq;
 	__u8		buffer_seq_srej;
+	__u8		srej_save_reqseq;
+	__u8		frames_sent;
+	__u8		unacked_frames;
+	__u8		retry_count;
+	__u8		num_acked;
 
 	struct list_head list;
 };
@@ -359,11 +364,6 @@ struct l2cap_pinfo {
 
 	__u8		conf_state;
 
-	__u8		srej_save_reqseq;
-	__u8		frames_sent;
-	__u8		unacked_frames;
-	__u8		retry_count;
-	__u8		num_acked;
 	__u16		sdu_len;
 	__u16		partial_sdu_len;
 	struct sk_buff	*sdu;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e00856d..97a6b34 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -925,7 +925,7 @@ int __l2cap_wait_ack(struct sock *sk)
 	int timeo = HZ/5;
 
 	add_wait_queue(sk_sleep(sk), &wait);
-	while ((l2cap_pi(sk)->unacked_frames > 0 && l2cap_pi(sk)->conn)) {
+	while ((l2cap_pi(sk)->chan->unacked_frames > 0 && l2cap_pi(sk)->conn)) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
 		if (!timeo)
@@ -957,13 +957,13 @@ static void l2cap_monitor_timeout(unsigned long arg)
 	BT_DBG("chan %p", chan);
 
 	bh_lock_sock(sk);
-	if (l2cap_pi(sk)->retry_count >= l2cap_pi(sk)->remote_max_tx) {
+	if (chan->retry_count >= l2cap_pi(sk)->remote_max_tx) {
 		l2cap_send_disconn_req(l2cap_pi(sk)->conn, sk, ECONNABORTED);
 		bh_unlock_sock(sk);
 		return;
 	}
 
-	l2cap_pi(sk)->retry_count++;
+	chan->retry_count++;
 	__mod_monitor_timer();
 
 	l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_POLL);
@@ -978,7 +978,7 @@ static void l2cap_retrans_timeout(unsigned long arg)
 	BT_DBG("sk %p", sk);
 
 	bh_lock_sock(sk);
-	l2cap_pi(sk)->retry_count = 1;
+	chan->retry_count = 1;
 	__mod_monitor_timer();
 
 	chan->conn_state |= L2CAP_CONN_WAIT_F;
@@ -993,17 +993,17 @@ static void l2cap_drop_acked_frames(struct l2cap_chan *chan)
 	struct sk_buff *skb;
 
 	while ((skb = skb_peek(TX_QUEUE(sk))) &&
-			l2cap_pi(sk)->unacked_frames) {
+			chan->unacked_frames) {
 		if (bt_cb(skb)->tx_seq == chan->expected_ack_seq)
 			break;
 
 		skb = skb_dequeue(TX_QUEUE(sk));
 		kfree_skb(skb);
 
-		l2cap_pi(sk)->unacked_frames--;
+		chan->unacked_frames--;
 	}
 
-	if (!l2cap_pi(sk)->unacked_frames)
+	if (!chan->unacked_frames)
 		del_timer(&l2cap_pi(sk)->retrans_timer);
 }
 
@@ -1142,9 +1142,9 @@ int l2cap_ertm_send(struct l2cap_chan *chan)
 		chan->next_tx_seq = (chan->next_tx_seq + 1) % 64;
 
 		if (bt_cb(skb)->retries == 1)
-			pi->unacked_frames++;
+			chan->unacked_frames++;
 
-		pi->frames_sent++;
+		chan->frames_sent++;
 
 		if (skb_queue_is_last(TX_QUEUE(sk), skb))
 			sk->sk_send_head = NULL;
@@ -1575,10 +1575,10 @@ static inline void l2cap_ertm_init(struct l2cap_chan *chan)
 	struct sock *sk = chan->sk;
 
 	chan->expected_ack_seq = 0;
-	l2cap_pi(sk)->unacked_frames = 0;
+	chan->unacked_frames = 0;
 	chan->buffer_seq = 0;
-	l2cap_pi(sk)->num_acked = 0;
-	l2cap_pi(sk)->frames_sent = 0;
+	chan->num_acked = 0;
+	chan->frames_sent = 0;
 
 	setup_timer(&l2cap_pi(sk)->retrans_timer,
 			l2cap_retrans_timeout, (unsigned long) chan);
@@ -2788,10 +2788,9 @@ static int l2cap_check_fcs(struct l2cap_pinfo *pi,  struct sk_buff *skb)
 
 static inline void l2cap_send_i_or_rr_or_rnr(struct l2cap_chan *chan)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
 	u16 control = 0;
 
-	pi->frames_sent = 0;
+	chan->frames_sent = 0;
 
 	control |= chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 
@@ -2807,7 +2806,7 @@ static inline void l2cap_send_i_or_rr_or_rnr(struct l2cap_chan *chan)
 	l2cap_ertm_send(chan);
 
 	if (!(chan->conn_state & L2CAP_CONN_LOCAL_BUSY) &&
-			pi->frames_sent == 0) {
+			chan->frames_sent == 0) {
 		control |= L2CAP_SUPER_RCV_READY;
 		l2cap_send_sframe(chan, control);
 	}
@@ -2989,7 +2988,7 @@ static int l2cap_try_push_rx_skb(struct l2cap_chan *chan)
 	control = chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 	control |= L2CAP_SUPER_RCV_READY | L2CAP_CTRL_POLL;
 	l2cap_send_sframe(chan, control);
-	l2cap_pi(sk)->retry_count = 1;
+	chan->retry_count = 1;
 
 	del_timer(&pi->retrans_timer);
 	__mod_monitor_timer();
@@ -3261,7 +3260,7 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 	if (L2CAP_CTRL_FINAL & rx_control &&
 			chan->conn_state & L2CAP_CONN_WAIT_F) {
 		del_timer(&pi->monitor_timer);
-		if (pi->unacked_frames > 0)
+		if (chan->unacked_frames > 0)
 			__mod_retrans_timer();
 		chan->conn_state &= ~L2CAP_CONN_WAIT_F;
 	}
@@ -3370,8 +3369,8 @@ expected:
 
 	__mod_ack_timer();
 
-	pi->num_acked = (pi->num_acked + 1) % num_to_ack;
-	if (pi->num_acked == num_to_ack - 1)
+	chan->num_acked = (chan->num_acked + 1) % num_to_ack;
+	if (chan->num_acked == num_to_ack - 1)
 		l2cap_send_ack(chan);
 
 	return 0;
@@ -3384,7 +3383,6 @@ drop:
 static inline void l2cap_data_channel_rrframe(struct l2cap_chan *chan, u16 rx_control)
 {
 	struct sock *sk = chan->sk;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
 
 	BT_DBG("sk %p, req_seq %d ctrl 0x%4.4x", sk, __get_reqseq(rx_control),
 						rx_control);
@@ -3396,7 +3394,7 @@ static inline void l2cap_data_channel_rrframe(struct l2cap_chan *chan, u16 rx_co
 		chan->conn_state |= L2CAP_CONN_SEND_FBIT;
 		if (chan->conn_state & L2CAP_CONN_SREJ_SENT) {
 			if ((chan->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
-					(pi->unacked_frames > 0))
+					(chan->unacked_frames > 0))
 				__mod_retrans_timer();
 
 			chan->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
@@ -3415,7 +3413,7 @@ static inline void l2cap_data_channel_rrframe(struct l2cap_chan *chan, u16 rx_co
 
 	} else {
 		if ((chan->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
-				(pi->unacked_frames > 0))
+				(chan->unacked_frames > 0))
 			__mod_retrans_timer();
 
 		chan->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
@@ -3451,7 +3449,6 @@ static inline void l2cap_data_channel_rejframe(struct l2cap_chan *chan, u16 rx_c
 }
 static inline void l2cap_data_channel_srejframe(struct l2cap_chan *chan, u16 rx_control)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
 	u8 tx_seq = __get_reqseq(rx_control);
 
 	BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan, tx_seq, rx_control);
@@ -3468,19 +3465,19 @@ static inline void l2cap_data_channel_srejframe(struct l2cap_chan *chan, u16 rx_
 		l2cap_ertm_send(chan);
 
 		if (chan->conn_state & L2CAP_CONN_WAIT_F) {
-			pi->srej_save_reqseq = tx_seq;
+			chan->srej_save_reqseq = tx_seq;
 			chan->conn_state |= L2CAP_CONN_SREJ_ACT;
 		}
 	} else if (rx_control & L2CAP_CTRL_FINAL) {
 		if ((chan->conn_state & L2CAP_CONN_SREJ_ACT) &&
-				pi->srej_save_reqseq == tx_seq)
+				chan->srej_save_reqseq == tx_seq)
 			chan->conn_state &= ~L2CAP_CONN_SREJ_ACT;
 		else
 			l2cap_retransmit_one_frame(chan, tx_seq);
 	} else {
 		l2cap_retransmit_one_frame(chan, tx_seq);
 		if (chan->conn_state & L2CAP_CONN_WAIT_F) {
-			pi->srej_save_reqseq = tx_seq;
+			chan->srej_save_reqseq = tx_seq;
 			chan->conn_state |= L2CAP_CONN_SREJ_ACT;
 		}
 	}
@@ -3522,7 +3519,7 @@ static inline int l2cap_data_channel_sframe(struct l2cap_chan *chan, u16 rx_cont
 	if (L2CAP_CTRL_FINAL & rx_control &&
 			chan->conn_state & L2CAP_CONN_WAIT_F) {
 		del_timer(&l2cap_pi(sk)->monitor_timer);
-		if (l2cap_pi(sk)->unacked_frames > 0)
+		if (chan->unacked_frames > 0)
 			__mod_retrans_timer();
 		chan->conn_state &= ~L2CAP_CONN_WAIT_F;
 	}
-- 
1.7.4.1

