Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi, ulisses@profusion.mobi
Subject: [PATCH 7/7] Bluetooth: Implement Local Busy Condition handling
Date: Wed, 14 Apr 2010 16:41:52 -0300
Message-Id: <1271274112-7806-8-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1271274112-7806-7-git-send-email-padovan@profusion.mobi>
References: <1271274112-7806-1-git-send-email-padovan@profusion.mobi>
 <1271274112-7806-2-git-send-email-padovan@profusion.mobi>
 <1271274112-7806-3-git-send-email-padovan@profusion.mobi>
 <1271274112-7806-4-git-send-email-padovan@profusion.mobi>
 <1271274112-7806-5-git-send-email-padovan@profusion.mobi>
 <1271274112-7806-6-git-send-email-padovan@profusion.mobi>
 <1271274112-7806-7-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Supports Local Busy condition handling through a waitqueue that wake ups
each 200ms and try to push the packets to the upper layer. If it can
push all the queue then it leaves the Local Busy state.

The patch modifies the behaviour of l2cap_ertm_reassembly_sdu() to
support retry of the push operation.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    6 ++
 net/bluetooth/l2cap.c         |  183 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 169 insertions(+), 20 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 15f6e55..fd0e4e4 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -35,6 +35,7 @@
 #define L2CAP_DEFAULT_MONITOR_TO	12000   /* 12 seconds */
 #define L2CAP_DEFAULT_MAX_PDU_SIZE	672
 #define L2CAP_DEFAULT_ACK_TO		200
+#define L2CAP_LOCAL_BUSY_TRIES		12
 
 #define L2CAP_CONN_TIMEOUT	(40000) /* 40 seconds */
 #define L2CAP_INFO_TIMEOUT	(4000)  /*  4 seconds */
@@ -294,6 +295,7 @@ struct l2cap_conn {
 #define l2cap_pi(sk) ((struct l2cap_pinfo *) sk)
 #define TX_QUEUE(sk) (&l2cap_pi(sk)->tx_queue)
 #define SREJ_QUEUE(sk) (&l2cap_pi(sk)->srej_queue)
+#define BUSY_QUEUE(sk) (&l2cap_pi(sk)->busy_queue)
 #define SREJ_LIST(sk) (&l2cap_pi(sk)->srej_l.list)
 
 struct srej_list {
@@ -356,6 +358,8 @@ struct l2cap_pinfo {
 	struct timer_list	ack_timer;
 	struct sk_buff_head	tx_queue;
 	struct sk_buff_head	srej_queue;
+	struct sk_buff_head	busy_queue;
+	struct work_struct	busy_work;
 	struct srej_list	srej_l;
 	struct l2cap_conn	*conn;
 	struct sock		*next_c;
@@ -383,6 +387,8 @@ struct l2cap_pinfo {
 #define L2CAP_CONN_LOCAL_BUSY      0x0040
 #define L2CAP_CONN_REJ_ACT         0x0080
 #define L2CAP_CONN_SEND_FBIT       0x0100
+#define L2CAP_CONN_RNR_SENT        0x0200
+#define L2CAP_CONN_SAR_RETRY       0x0400
 
 #define __mod_retrans_timer() mod_timer(&l2cap_pi(sk)->retrans_timer, \
 		jiffies +  msecs_to_jiffies(L2CAP_DEFAULT_RETRANS_TO));
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 1f66541..709dc03 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -68,10 +68,14 @@ static u8 l2cap_fixed_chan[8] = { 0x02, };
 
 static const struct proto_ops l2cap_sock_ops;
 
+static struct workqueue_struct *_busy_wq;
+
 static struct bt_sock_list l2cap_sk_list = {
 	.lock = __RW_LOCK_UNLOCKED(l2cap_sk_list.lock)
 };
 
+static void l2cap_busy_work(struct work_struct *work);
+
 static void __l2cap_sock_close(struct sock *sk, int reason);
 static void l2cap_sock_close(struct sock *sk);
 static void l2cap_sock_kill(struct sock *sk);
@@ -386,8 +390,10 @@ static inline void l2cap_send_sframe(struct l2cap_pinfo *pi, u16 control)
 
 static inline void l2cap_send_rr_or_rnr(struct l2cap_pinfo *pi, u16 control)
 {
-	if (pi->conn_state & L2CAP_CONN_LOCAL_BUSY)
+	if (pi->conn_state & L2CAP_CONN_LOCAL_BUSY) {
 		control |= L2CAP_SUPER_RCV_NOT_READY;
+		pi->conn_state |= L2CAP_CONN_RNR_SENT;
+	}
 	else
 		control |= L2CAP_SUPER_RCV_READY;
 
@@ -816,6 +822,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 	pi->flush_to = L2CAP_DEFAULT_FLUSH_TO;
 	skb_queue_head_init(TX_QUEUE(sk));
 	skb_queue_head_init(SREJ_QUEUE(sk));
+	skb_queue_head_init(BUSY_QUEUE(sk));
 	INIT_LIST_HEAD(SREJ_LIST(sk));
 }
 
@@ -1440,6 +1447,7 @@ static void l2cap_send_ack(struct l2cap_pinfo *pi)
 
 	if (pi->conn_state & L2CAP_CONN_LOCAL_BUSY) {
 		control |= L2CAP_SUPER_RCV_NOT_READY;
+		pi->conn_state |= L2CAP_CONN_RNR_SENT;
 		l2cap_send_sframe(pi, control);
 		return;
 	} else if (l2cap_ertm_send(sk) == 0) {
@@ -2266,6 +2274,9 @@ static inline void l2cap_ertm_init(struct sock *sk)
 			l2cap_ack_timeout, (unsigned long) sk);
 
 	__skb_queue_head_init(SREJ_QUEUE(sk));
+	__skb_queue_head_init(BUSY_QUEUE(sk));
+
+	INIT_WORK(&l2cap_pi(sk)->busy_work, l2cap_busy_work);
 }
 
 static int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
@@ -3033,6 +3044,7 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 
 	if (l2cap_pi(sk)->mode == L2CAP_MODE_ERTM) {
 		skb_queue_purge(SREJ_QUEUE(sk));
+		skb_queue_purge(BUSY_QUEUE(sk));
 		del_timer(&l2cap_pi(sk)->retrans_timer);
 		del_timer(&l2cap_pi(sk)->monitor_timer);
 		del_timer(&l2cap_pi(sk)->ack_timer);
@@ -3064,6 +3076,7 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 
 	if (l2cap_pi(sk)->mode == L2CAP_MODE_ERTM) {
 		skb_queue_purge(SREJ_QUEUE(sk));
+		skb_queue_purge(BUSY_QUEUE(sk));
 		del_timer(&l2cap_pi(sk)->retrans_timer);
 		del_timer(&l2cap_pi(sk)->monitor_timer);
 		del_timer(&l2cap_pi(sk)->ack_timer);
@@ -3274,6 +3287,7 @@ static inline void l2cap_send_i_or_rr_or_rnr(struct sock *sk)
 	if (pi->conn_state & L2CAP_CONN_LOCAL_BUSY) {
 		control |= L2CAP_SUPER_RCV_NOT_READY | L2CAP_CTRL_FINAL;
 		l2cap_send_sframe(pi, control);
+		pi->conn_state |= L2CAP_CONN_RNR_SENT;
 		pi->conn_state &= ~L2CAP_CONN_SEND_FBIT;
 
 	}
@@ -3321,7 +3335,7 @@ static int l2cap_ertm_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 c
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct sk_buff *_skb;
-	int err = 0;
+	int err;
 
 	switch (control & L2CAP_CTRL_SAR) {
 	case L2CAP_SDU_UNSEGMENTED:
@@ -3339,16 +3353,18 @@ static int l2cap_ertm_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 c
 			goto drop;
 
 		pi->sdu_len = get_unaligned_le16(skb->data);
-		skb_pull(skb, 2);
 
 		if (pi->sdu_len > pi->imtu)
 			goto disconnect;
 
 		pi->sdu = bt_skb_alloc(pi->sdu_len, GFP_ATOMIC);
-		if (!pi->sdu) {
-			err = -ENOMEM;
-			break;
-		}
+		if (!pi->sdu)
+			return -ENOMEM;
+
+		/* pull sdu_len bytes only after alloc, because of Local Busy
+		 * condition we have to be sure that this will be executed
+		 * only once, i.e., when alloc does not fail */
+		skb_pull(skb, 2);
 
 		memcpy(skb_put(pi->sdu, skb->len), skb->data, skb->len);
 
@@ -3378,28 +3394,40 @@ static int l2cap_ertm_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 c
 		if (!pi->sdu)
 			goto disconnect;
 
-		memcpy(skb_put(pi->sdu, skb->len), skb->data, skb->len);
+		if (!(pi->conn_state & L2CAP_CONN_SAR_RETRY)) {
+			memcpy(skb_put(pi->sdu, skb->len), skb->data, skb->len);
 
-		pi->conn_state &= ~L2CAP_CONN_SAR_SDU;
-		pi->partial_sdu_len += skb->len;
+			pi->partial_sdu_len += skb->len;
 
-		if (pi->partial_sdu_len > pi->imtu)
-			goto drop;
+			if (pi->partial_sdu_len > pi->imtu)
+				goto drop;
 
-		if (pi->partial_sdu_len != pi->sdu_len)
-			goto drop;
+			if (pi->partial_sdu_len != pi->sdu_len)
+				goto drop;
+		}
 
 		_skb = skb_clone(pi->sdu, GFP_ATOMIC);
+		if (!_skb) {
+			pi->conn_state |= L2CAP_CONN_SAR_RETRY;
+			return -ENOMEM;
+		}
+
 		err = sock_queue_rcv_skb(sk, _skb);
-		if (err < 0)
+		if (err < 0) {
 			kfree_skb(_skb);
+			pi->conn_state |= L2CAP_CONN_SAR_RETRY;
+			return err;
+		}
+
+		pi->conn_state &= ~L2CAP_CONN_SAR_RETRY;
+		pi->conn_state &= ~L2CAP_CONN_SAR_SDU;
 
 		kfree_skb(pi->sdu);
 		break;
 	}
 
 	kfree_skb(skb);
-	return err;
+	return 0;
 
 drop:
 	kfree_skb(pi->sdu);
@@ -3411,6 +3439,112 @@ disconnect:
 	return 0;
 }
 
+static void l2cap_busy_work(struct work_struct *work)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	struct l2cap_pinfo *pi =
+		container_of(work, struct l2cap_pinfo, busy_work);
+	struct sock *sk = (struct sock *)pi;
+	int n_tries = 0, timeo = HZ/5, err;
+	struct sk_buff *skb;
+	u16 control;
+
+	lock_sock(sk);
+
+	add_wait_queue(sk->sk_sleep, &wait);
+	while ((skb = skb_peek(BUSY_QUEUE(sk)))) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		if (n_tries++ > L2CAP_LOCAL_BUSY_TRIES) {
+			err = -EBUSY;
+			l2cap_send_disconn_req(pi->conn, sk);
+			goto done;
+		}
+
+		if (!timeo)
+			timeo = HZ/5;
+
+		if (signal_pending(current)) {
+			err = sock_intr_errno(timeo);
+			goto done;
+		}
+
+		release_sock(sk);
+		timeo = schedule_timeout(timeo);
+		lock_sock(sk);
+
+		err = sock_error(sk);
+		if (err)
+			goto done;
+
+		while((skb = skb_peek(BUSY_QUEUE(sk)))) {
+			control = bt_cb(skb)->sar << L2CAP_CTRL_SAR_SHIFT;
+			err = l2cap_ertm_reassembly_sdu(sk, skb, control);
+			if (err < 0)
+				break;
+
+			skb_dequeue(BUSY_QUEUE(sk));
+
+			pi->buffer_seq = (pi->buffer_seq + 1) % 64;
+		}
+
+		if (!skb)
+			break;
+	}
+
+	if (!(pi->conn_state & L2CAP_CONN_RNR_SENT))
+		goto done;
+
+	control = pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+	control |= L2CAP_SUPER_RCV_READY | L2CAP_CTRL_POLL;
+	l2cap_send_sframe(pi, control);
+
+	del_timer(&pi->retrans_timer);
+	__mod_monitor_timer();
+
+	pi->conn_state &= ~L2CAP_CONN_LOCAL_BUSY;
+	pi->conn_state &= ~L2CAP_CONN_RNR_SENT;
+
+done:
+	set_current_state(TASK_RUNNING);
+	remove_wait_queue(sk->sk_sleep, &wait);
+
+	release_sock(sk);
+}
+
+static int l2cap_push_rx_skb(struct sock *sk, struct sk_buff *skb, u16 control)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	int sctrl, err;
+
+	if (pi->conn_state & L2CAP_CONN_LOCAL_BUSY) {
+		bt_cb(skb)->sar = control >> L2CAP_CTRL_SAR_SHIFT;
+		__skb_queue_tail(BUSY_QUEUE(sk), skb);
+		return -EBUSY;
+	}
+
+	err = l2cap_ertm_reassembly_sdu(sk, skb, control);
+	if (err >= 0) {
+		pi->buffer_seq = (pi->buffer_seq + 1) % 64;
+		return err;
+	}
+
+	/* Busy Condition */
+	pi->conn_state |= L2CAP_CONN_LOCAL_BUSY;
+	bt_cb(skb)->sar = control >> L2CAP_CTRL_SAR_SHIFT;
+	__skb_queue_tail(BUSY_QUEUE(sk), skb);
+
+	sctrl = pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+	sctrl |= L2CAP_SUPER_RCV_NOT_READY;
+	l2cap_send_sframe(pi, sctrl);
+
+	pi->conn_state |= L2CAP_CONN_RNR_SENT;
+
+	queue_work(_busy_wq, &pi->busy_work);
+
+	return err;
+}
+
 static int l2cap_streaming_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 control)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
@@ -3585,6 +3719,9 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 	if (tx_seq == pi->expected_tx_seq)
 		goto expected;
 
+	if (pi->conn_state == L2CAP_CONN_LOCAL_BUSY)
+		return 0;
+
 	/* Check for duplicated tx_seq. This actually
 	 * subtracts 1 from expected_tx_seq */
 	if (tx_seq == (pi->expected_tx_seq + 63) % 64) {
@@ -3628,6 +3765,7 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 		pi->buffer_seq_srej = pi->buffer_seq;
 
 		__skb_queue_head_init(SREJ_QUEUE(sk));
+		__skb_queue_head_init(BUSY_QUEUE(sk));
 		l2cap_add_to_srej_queue(sk, skb, tx_seq, sar);
 
 		pi->conn_state |= L2CAP_CONN_SEND_PBIT;
@@ -3655,11 +3793,9 @@ expected:
 		}
 	}
 
-	pi->buffer_seq = (pi->buffer_seq + 1) % 64;
-
-	err = l2cap_ertm_reassembly_sdu(sk, skb, rx_control);
+	err = l2cap_push_rx_skb(sk, skb, rx_control);
 	if (err < 0)
-		return err;
+		return 0;
 
 	__mod_ack_timer();
 
@@ -4354,6 +4490,10 @@ static int __init l2cap_init(void)
 	if (err < 0)
 		return err;
 
+	_busy_wq = create_singlethread_workqueue("l2cap");
+	if (!_busy_wq)
+		goto error;
+
 	err = bt_sock_register(BTPROTO_L2CAP, &l2cap_sock_family_ops);
 	if (err < 0) {
 		BT_ERR("L2CAP socket registration failed");
@@ -4388,6 +4528,9 @@ static void __exit l2cap_exit(void)
 {
 	debugfs_remove(l2cap_debugfs);
 
+	flush_workqueue(_busy_wq);
+	destroy_workqueue(_busy_wq);
+
 	if (bt_sock_unregister(BTPROTO_L2CAP) < 0)
 		BT_ERR("L2CAP socket unregistration failed");
 
-- 
1.6.4.4
