Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH v3 3/3] Bluetooth: Remove L2CAP busy queue
Date: Thu,  7 Jul 2011 09:39:03 -0700
Message-Id: <1310056743-2643-4-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1310056743-2643-1-git-send-email-mathewm@codeaurora.org>
References: <1310056743-2643-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The ERTM receive buffer is now handled in a way that does not require
the busy queue and the associated polling code.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/l2cap.h |    4 -
 net/bluetooth/l2cap_core.c    |  125 +++--------------------------------------
 2 files changed, 8 insertions(+), 121 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 66b8d96..578545a 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -37,7 +37,6 @@
 #define L2CAP_DEFAULT_MONITOR_TO	12000   /* 12 seconds */
 #define L2CAP_DEFAULT_MAX_PDU_SIZE	1009    /* Sized for 3-DH5 packet */
 #define L2CAP_DEFAULT_ACK_TO		200
-#define L2CAP_LOCAL_BUSY_TRIES		12
 #define L2CAP_LE_DEFAULT_MTU		23
 
 #define L2CAP_CONN_TIMEOUT	(40000) /* 40 seconds */
@@ -352,8 +351,6 @@ struct l2cap_chan {
 	struct sk_buff		*tx_send_head;
 	struct sk_buff_head	tx_q;
 	struct sk_buff_head	srej_q;
-	struct sk_buff_head	busy_q;
-	struct work_struct	busy_work;
 	struct list_head	srej_l;
 
 	struct list_head list;
@@ -450,7 +447,6 @@ enum {
 	CONN_REJ_ACT,
 	CONN_SEND_FBIT,
 	CONN_RNR_SENT,
-	CONN_SAR_RETRY,
 };
 
 #define __set_chan_timer(c, t) l2cap_set_timer(c, &c->chan_timer, (t))
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ea9c7d0..2c5d335 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -61,13 +61,9 @@ int disable_ertm;
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
 static u8 l2cap_fixed_chan[8] = { 0x02, };
 
-static struct workqueue_struct *_busy_wq;
-
 static LIST_HEAD(chan_list);
 static DEFINE_RWLOCK(chan_list_lock);
 
-static void l2cap_busy_work(struct work_struct *work);
-
 static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
 				u8 code, u8 ident, u16 dlen, void *data);
 static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len,
@@ -395,7 +391,6 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		__clear_ack_timer(chan);
 
 		skb_queue_purge(&chan->srej_q);
-		skb_queue_purge(&chan->busy_q);
 
 		list_for_each_entry_safe(l, tmp, &chan->srej_l, list) {
 			list_del(&l->list);
@@ -1873,11 +1868,9 @@ static inline void l2cap_ertm_init(struct l2cap_chan *chan)
 	setup_timer(&chan->ack_timer, l2cap_ack_timeout, (unsigned long) chan);
 
 	skb_queue_head_init(&chan->srej_q);
-	skb_queue_head_init(&chan->busy_q);
 
 	INIT_LIST_HEAD(&chan->srej_l);
 
-	INIT_WORK(&chan->busy_work, l2cap_busy_work);
 
 	sk->sk_backlog_rcv = l2cap_ertm_data_rcv;
 }
@@ -3182,32 +3175,27 @@ static int l2cap_ertm_reassembly_sdu(struct l2cap_chan *chan, struct sk_buff *sk
 		if (!chan->sdu)
 			goto disconnect;
 
-		if (!test_bit(CONN_SAR_RETRY, &chan->conn_state)) {
-			chan->partial_sdu_len += skb->len;
+		chan->partial_sdu_len += skb->len;
 
-			if (chan->partial_sdu_len > chan->imtu)
-				goto drop;
+		if (chan->partial_sdu_len > chan->imtu)
+			goto drop;
 
-			if (chan->partial_sdu_len != chan->sdu_len)
-				goto drop;
+		if (chan->partial_sdu_len != chan->sdu_len)
+			goto drop;
 
-			memcpy(skb_put(chan->sdu, skb->len), skb->data, skb->len);
-		}
+		memcpy(skb_put(chan->sdu, skb->len), skb->data, skb->len);
 
 		_skb = skb_clone(chan->sdu, GFP_ATOMIC);
 		if (!_skb) {
-			set_bit(CONN_SAR_RETRY, &chan->conn_state);
 			return -ENOMEM;
 		}
 
 		err = chan->ops->recv(chan->data, _skb);
 		if (err < 0) {
 			kfree_skb(_skb);
-			set_bit(CONN_SAR_RETRY, &chan->conn_state);
 			return err;
 		}
 
-		clear_bit(CONN_SAR_RETRY, &chan->conn_state);
 		clear_bit(CONN_SAR_SDU, &chan->conn_state);
 
 		kfree_skb(chan->sdu);
@@ -3268,93 +3256,6 @@ done:
 	BT_DBG("chan %p, Exit local busy", chan);
 }
 
-static int l2cap_try_push_rx_skb(struct l2cap_chan *chan)
-{
-	struct sk_buff *skb;
-	u16 control;
-	int err;
-
-	while ((skb = skb_dequeue(&chan->busy_q))) {
-		control = bt_cb(skb)->sar << L2CAP_CTRL_SAR_SHIFT;
-		err = l2cap_ertm_reassembly_sdu(chan, skb, control);
-		if (err < 0) {
-			skb_queue_head(&chan->busy_q, skb);
-			return -EBUSY;
-		}
-
-		chan->buffer_seq = (chan->buffer_seq + 1) % 64;
-	}
-
-	l2cap_ertm_exit_local_busy(chan);
-
-	return 0;
-}
-
-static void l2cap_busy_work(struct work_struct *work)
-{
-	DECLARE_WAITQUEUE(wait, current);
-	struct l2cap_chan *chan =
-		container_of(work, struct l2cap_chan, busy_work);
-	struct sock *sk = chan->sk;
-	int n_tries = 0, timeo = HZ/5, err;
-	struct sk_buff *skb;
-
-	lock_sock(sk);
-
-	add_wait_queue(sk_sleep(sk), &wait);
-	while ((skb = skb_peek(&chan->busy_q))) {
-		set_current_state(TASK_INTERRUPTIBLE);
-
-		if (n_tries++ > L2CAP_LOCAL_BUSY_TRIES) {
-			err = -EBUSY;
-			l2cap_send_disconn_req(chan->conn, chan, EBUSY);
-			break;
-		}
-
-		if (!timeo)
-			timeo = HZ/5;
-
-		if (signal_pending(current)) {
-			err = sock_intr_errno(timeo);
-			break;
-		}
-
-		release_sock(sk);
-		timeo = schedule_timeout(timeo);
-		lock_sock(sk);
-
-		err = sock_error(sk);
-		if (err)
-			break;
-
-		if (l2cap_try_push_rx_skb(chan) == 0)
-			break;
-	}
-
-	set_current_state(TASK_RUNNING);
-	remove_wait_queue(sk_sleep(sk), &wait);
-
-	release_sock(sk);
-}
-
-static int l2cap_push_rx_skb(struct l2cap_chan *chan, struct sk_buff *skb, u16 control)
-{
-	int err;
-
-	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
-		bt_cb(skb)->sar = control >> L2CAP_CTRL_SAR_SHIFT;
-		__skb_queue_tail(&chan->busy_q, skb);
-		return l2cap_try_push_rx_skb(chan);
-
-
-	}
-
-	err = l2cap_ertm_reassembly_sdu(chan, skb, control);
-	chan->buffer_seq = (chan->buffer_seq + 1) % 64;
-
-	return err;
-}
-
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy)
 {
 	if (chan->mode == L2CAP_MODE_ERTM) {
@@ -3612,7 +3513,6 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 		chan->buffer_seq_srej = chan->buffer_seq;
 
 		__skb_queue_head_init(&chan->srej_q);
-		__skb_queue_head_init(&chan->busy_q);
 		l2cap_add_to_srej_queue(chan, skb, tx_seq, sar);
 
 		set_bit(CONN_SEND_PBIT, &chan->conn_state);
@@ -3633,7 +3533,8 @@ expected:
 		return 0;
 	}
 
-	err = l2cap_push_rx_skb(chan, skb, rx_control);
+	err = l2cap_ertm_reassembly_sdu(chan, skb, rx_control);
+	chan->buffer_seq = (chan->buffer_seq + 1) % 64;
 	if (err < 0) {
 		l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
 		return err;
@@ -4439,12 +4340,6 @@ int __init l2cap_init(void)
 	if (err < 0)
 		return err;
 
-	_busy_wq = create_singlethread_workqueue("l2cap");
-	if (!_busy_wq) {
-		err = -ENOMEM;
-		goto error;
-	}
-
 	err = hci_register_proto(&l2cap_hci_proto);
 	if (err < 0) {
 		BT_ERR("L2CAP protocol registration failed");
@@ -4462,7 +4357,6 @@ int __init l2cap_init(void)
 	return 0;
 
 error:
-	destroy_workqueue(_busy_wq);
 	l2cap_cleanup_sockets();
 	return err;
 }
@@ -4471,9 +4365,6 @@ void l2cap_exit(void)
 {
 	debugfs_remove(l2cap_debugfs);
 
-	flush_workqueue(_busy_wq);
-	destroy_workqueue(_busy_wq);
-
 	if (hci_unregister_proto(&l2cap_hci_proto) < 0)
 		BT_ERR("L2CAP protocol unregistration failed");
 
-- 
1.7.6

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

