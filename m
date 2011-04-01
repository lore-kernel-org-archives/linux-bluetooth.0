Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 13/15] Bluetooth: Move srej and busy queues to struct l2cap_chan
Date: Fri,  1 Apr 2011 19:33:18 -0300
Message-Id: <1301697200-2446-14-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1301697200-2446-13-git-send-email-padovan@profusion.mobi>
References: <1301697200-2446-1-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-2-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-3-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-4-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-5-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-6-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-7-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-8-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-9-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-10-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-11-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-12-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-13-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As part of the moving channel stuff to l2cap_chan.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    6 +---
 net/bluetooth/l2cap_core.c    |   42 +++++++++++++++++++---------------------
 net/bluetooth/l2cap_sock.c    |    2 -
 3 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 5f4abea..09f4a2f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -309,6 +309,8 @@ struct l2cap_chan {
 	struct timer_list	retrans_timer;
 	struct timer_list	monitor_timer;
 	struct timer_list	ack_timer;
+	struct sk_buff_head	srej_q;
+	struct sk_buff_head	busy_q;
 
 	struct list_head list;
 };
@@ -347,8 +349,6 @@ struct l2cap_conn {
 /* ----- L2CAP socket info ----- */
 #define l2cap_pi(sk) ((struct l2cap_pinfo *) sk)
 #define TX_QUEUE(sk) (&l2cap_pi(sk)->tx_queue)
-#define SREJ_QUEUE(sk) (&l2cap_pi(sk)->srej_queue)
-#define BUSY_QUEUE(sk) (&l2cap_pi(sk)->busy_queue)
 #define SREJ_LIST(sk) (&l2cap_pi(sk)->srej_l.list)
 
 struct srej_list {
@@ -384,8 +384,6 @@ struct l2cap_pinfo {
 	__le16		sport;
 
 	struct sk_buff_head	tx_queue;
-	struct sk_buff_head	srej_queue;
-	struct sk_buff_head	busy_queue;
 	struct work_struct	busy_work;
 	struct srej_list	srej_l;
 	struct l2cap_conn	*conn;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b44347b..a5aecc5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -245,8 +245,8 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		del_timer(&chan->monitor_timer);
 		del_timer(&chan->ack_timer);
 
-		skb_queue_purge(SREJ_QUEUE(sk));
-		skb_queue_purge(BUSY_QUEUE(sk));
+		skb_queue_purge(&chan->srej_q);
+		skb_queue_purge(&chan->busy_q);
 
 		list_for_each_entry_safe(l, tmp, SREJ_LIST(sk), list) {
 			list_del(&l->list);
@@ -1589,8 +1589,8 @@ static inline void l2cap_ertm_init(struct l2cap_chan *chan)
 							(unsigned long) chan);
 	setup_timer(&chan->ack_timer, l2cap_ack_timeout, (unsigned long) chan);
 
-	__skb_queue_head_init(SREJ_QUEUE(sk));
-	__skb_queue_head_init(BUSY_QUEUE(sk));
+	skb_queue_head_init(&chan->srej_q);
+	skb_queue_head_init(&chan->busy_q);
 
 	INIT_WORK(&l2cap_pi(sk)->busy_work, l2cap_busy_work);
 
@@ -2816,16 +2816,15 @@ static inline void l2cap_send_i_or_rr_or_rnr(struct l2cap_chan *chan)
 
 static int l2cap_add_to_srej_queue(struct l2cap_chan *chan, struct sk_buff *skb, u8 tx_seq, u8 sar)
 {
-	struct sock *sk = chan->sk;
 	struct sk_buff *next_skb;
 	int tx_seq_offset, next_tx_seq_offset;
 
 	bt_cb(skb)->tx_seq = tx_seq;
 	bt_cb(skb)->sar = sar;
 
-	next_skb = skb_peek(SREJ_QUEUE(sk));
+	next_skb = skb_peek(&chan->srej_q);
 	if (!next_skb) {
-		__skb_queue_tail(SREJ_QUEUE(sk), skb);
+		__skb_queue_tail(&chan->srej_q, skb);
 		return 0;
 	}
 
@@ -2843,16 +2842,16 @@ static int l2cap_add_to_srej_queue(struct l2cap_chan *chan, struct sk_buff *skb,
 			next_tx_seq_offset += 64;
 
 		if (next_tx_seq_offset > tx_seq_offset) {
-			__skb_queue_before(SREJ_QUEUE(sk), next_skb, skb);
+			__skb_queue_before(&chan->srej_q, next_skb, skb);
 			return 0;
 		}
 
-		if (skb_queue_is_last(SREJ_QUEUE(sk), next_skb))
+		if (skb_queue_is_last(&chan->srej_q, next_skb))
 			break;
 
-	} while ((next_skb = skb_queue_next(SREJ_QUEUE(sk), next_skb)));
+	} while ((next_skb = skb_queue_next(&chan->srej_q, next_skb)));
 
-	__skb_queue_tail(SREJ_QUEUE(sk), skb);
+	__skb_queue_tail(&chan->srej_q, skb);
 
 	return 0;
 }
@@ -2972,11 +2971,11 @@ static int l2cap_try_push_rx_skb(struct l2cap_chan *chan)
 	u16 control;
 	int err;
 
-	while ((skb = skb_dequeue(BUSY_QUEUE(sk)))) {
+	while ((skb = skb_dequeue(&chan->busy_q))) {
 		control = bt_cb(skb)->sar << L2CAP_CTRL_SAR_SHIFT;
 		err = l2cap_ertm_reassembly_sdu(chan, skb, control);
 		if (err < 0) {
-			skb_queue_head(BUSY_QUEUE(sk), skb);
+			skb_queue_head(&chan->busy_q, skb);
 			return -EBUSY;
 		}
 
@@ -3017,7 +3016,7 @@ static void l2cap_busy_work(struct work_struct *work)
 	lock_sock(sk);
 
 	add_wait_queue(sk_sleep(sk), &wait);
-	while ((skb = skb_peek(BUSY_QUEUE(sk)))) {
+	while ((skb = skb_peek(&pi->chan->busy_q))) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
 		if (n_tries++ > L2CAP_LOCAL_BUSY_TRIES) {
@@ -3060,7 +3059,7 @@ static int l2cap_push_rx_skb(struct l2cap_chan *chan, struct sk_buff *skb, u16 c
 
 	if (chan->conn_state & L2CAP_CONN_LOCAL_BUSY) {
 		bt_cb(skb)->sar = control >> L2CAP_CTRL_SAR_SHIFT;
-		__skb_queue_tail(BUSY_QUEUE(sk), skb);
+		__skb_queue_tail(&chan->busy_q, skb);
 		return l2cap_try_push_rx_skb(chan);
 
 
@@ -3077,7 +3076,7 @@ static int l2cap_push_rx_skb(struct l2cap_chan *chan, struct sk_buff *skb, u16 c
 
 	chan->conn_state |= L2CAP_CONN_LOCAL_BUSY;
 	bt_cb(skb)->sar = control >> L2CAP_CTRL_SAR_SHIFT;
-	__skb_queue_tail(BUSY_QUEUE(sk), skb);
+	__skb_queue_tail(&chan->busy_q, skb);
 
 	sctrl = chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 	sctrl |= L2CAP_SUPER_RCV_NOT_READY;
@@ -3188,15 +3187,14 @@ drop:
 
 static void l2cap_check_srej_gap(struct l2cap_chan *chan, u8 tx_seq)
 {
-	struct sock *sk = chan->sk;
 	struct sk_buff *skb;
 	u16 control;
 
-	while ((skb = skb_peek(SREJ_QUEUE(sk)))) {
+	while ((skb = skb_peek(&chan->srej_q))) {
 		if (bt_cb(skb)->tx_seq != tx_seq)
 			break;
 
-		skb = skb_dequeue(SREJ_QUEUE(sk));
+		skb = skb_dequeue(&chan->srej_q);
 		control = bt_cb(skb)->sar << L2CAP_CTRL_SAR_SHIFT;
 		l2cap_ertm_reassembly_sdu(chan, skb, control);
 		chan->buffer_seq_srej =
@@ -3335,8 +3333,8 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 		INIT_LIST_HEAD(SREJ_LIST(sk));
 		chan->buffer_seq_srej = chan->buffer_seq;
 
-		__skb_queue_head_init(SREJ_QUEUE(sk));
-		__skb_queue_head_init(BUSY_QUEUE(sk));
+		__skb_queue_head_init(&chan->srej_q);
+		__skb_queue_head_init(&chan->busy_q);
 		l2cap_add_to_srej_queue(chan, skb, tx_seq, sar);
 
 		chan->conn_state |= L2CAP_CONN_SEND_PBIT;
@@ -3353,7 +3351,7 @@ expected:
 	if (chan->conn_state & L2CAP_CONN_SREJ_SENT) {
 		bt_cb(skb)->tx_seq = tx_seq;
 		bt_cb(skb)->sar = sar;
-		__skb_queue_tail(SREJ_QUEUE(sk), skb);
+		__skb_queue_tail(&chan->srej_q, skb);
 		return 0;
 	}
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index d66886f..55dee99 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1018,8 +1018,6 @@ void l2cap_sock_init(struct sock *sk, struct sock *parent)
 	/* Default config options */
 	pi->flush_to = L2CAP_DEFAULT_FLUSH_TO;
 	skb_queue_head_init(TX_QUEUE(sk));
-	skb_queue_head_init(SREJ_QUEUE(sk));
-	skb_queue_head_init(BUSY_QUEUE(sk));
 	INIT_LIST_HEAD(SREJ_LIST(sk));
 }
 
-- 
1.7.4.1

