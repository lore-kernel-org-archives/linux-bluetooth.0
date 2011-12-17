Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [RFC 06/22] Bluetooth: Move L2CAP timers to workqueue
Date: Sat, 17 Dec 2011 19:29:26 -0200
Message-Id: <1324157382-1815-7-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324157382-1815-6-git-send-email-padovan@profusion.mobi>
References: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-2-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-3-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-4-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-5-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-6-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

L2CAP timers also need to run in process context. As the works in l2cap
are small we are using the system worqueue.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |   17 +++++-----
 net/bluetooth/l2cap_core.c    |   70 ++++++++++++++++++-----------------------
 2 files changed, 40 insertions(+), 47 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 30719eb..03be911 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -482,10 +482,11 @@ struct l2cap_chan {
 	__u32		remote_acc_lat;
 	__u32		remote_flush_to;
 
-	struct timer_list	chan_timer;
-	struct timer_list	retrans_timer;
-	struct timer_list	monitor_timer;
-	struct timer_list	ack_timer;
+	struct delayed_work	chan_timer;
+	struct delayed_work	retrans_timer;
+	struct delayed_work	monitor_timer;
+	struct delayed_work	ack_timer;
+
 	struct sk_buff		*tx_send_head;
 	struct sk_buff_head	tx_q;
 	struct sk_buff_head	srej_q;
@@ -595,16 +596,16 @@ enum {
 };
 
 #define __set_chan_timer(c, t) l2cap_set_timer(c, &c->chan_timer, (t))
-#define __clear_chan_timer(c) l2cap_clear_timer(c, &c->chan_timer)
+#define __clear_chan_timer(c) l2cap_clear_timer(&c->chan_timer)
 #define __set_retrans_timer(c) l2cap_set_timer(c, &c->retrans_timer, \
 		L2CAP_DEFAULT_RETRANS_TO);
-#define __clear_retrans_timer(c) l2cap_clear_timer(c, &c->retrans_timer)
+#define __clear_retrans_timer(c) l2cap_clear_timer(&c->retrans_timer)
 #define __set_monitor_timer(c) l2cap_set_timer(c, &c->monitor_timer, \
 		L2CAP_DEFAULT_MONITOR_TO);
-#define __clear_monitor_timer(c) l2cap_clear_timer(c, &c->monitor_timer)
+#define __clear_monitor_timer(c) l2cap_clear_timer(&c->monitor_timer)
 #define __set_ack_timer(c) l2cap_set_timer(c, &chan->ack_timer, \
 		L2CAP_DEFAULT_ACK_TO);
-#define __clear_ack_timer(c) l2cap_clear_timer(c, &c->ack_timer)
+#define __clear_ack_timer(c) l2cap_clear_timer(&c->ack_timer)
 
 static inline int __seq_offset(struct l2cap_chan *chan, __u16 seq1, __u16 seq2)
 {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0369a9b..89cda6d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -213,20 +213,18 @@ static u16 l2cap_alloc_cid(struct l2cap_conn *conn)
 	return 0;
 }
 
-static void l2cap_set_timer(struct l2cap_chan *chan, struct timer_list *timer, long timeout)
+static void l2cap_set_timer(struct l2cap_chan *chan, struct delayed_work *work, long timeout)
 {
 	BT_DBG("chan %p state %d timeout %ld", chan, chan->state, timeout);
 
-	if (!mod_timer(timer, jiffies + msecs_to_jiffies(timeout)))
-		chan_hold(chan);
+	cancel_delayed_work_sync(work);
+
+	schedule_delayed_work(work, timeout);
 }
 
-static void l2cap_clear_timer(struct l2cap_chan *chan, struct timer_list *timer)
+static void l2cap_clear_timer(struct delayed_work *work)
 {
-	BT_DBG("chan %p state %d", chan, chan->state);
-
-	if (timer_pending(timer) && del_timer(timer))
-		chan_put(chan);
+	cancel_delayed_work_sync(work);
 }
 
 static char *state_to_string(int state)
@@ -264,23 +262,16 @@ static void l2cap_state_change(struct l2cap_chan *chan, int state)
 	chan->ops->state_change(chan->data, state);
 }
 
-static void l2cap_chan_timeout(unsigned long arg)
+static void l2cap_chan_timeout(struct work_struct *work)
 {
-	struct l2cap_chan *chan = (struct l2cap_chan *) arg;
+	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
+							chan_timer.work);
 	struct sock *sk = chan->sk;
 	int reason;
 
 	BT_DBG("chan %p state %d", chan, chan->state);
 
-	bh_lock_sock(sk);
-
-	if (sock_owned_by_user(sk)) {
-		/* sk is owned by user. Try again later */
-		__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
-		bh_unlock_sock(sk);
-		chan_put(chan);
-		return;
-	}
+	lock_sock(sk);
 
 	if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
 		reason = ECONNREFUSED;
@@ -292,7 +283,7 @@ static void l2cap_chan_timeout(unsigned long arg)
 
 	l2cap_chan_close(chan, reason);
 
-	bh_unlock_sock(sk);
+	release_sock(sk);
 
 	chan->ops->close(chan->data);
 	chan_put(chan);
@@ -312,7 +303,7 @@ struct l2cap_chan *l2cap_chan_create(struct sock *sk)
 	list_add(&chan->global_l, &chan_list);
 	write_unlock_bh(&chan_list_lock);
 
-	setup_timer(&chan->chan_timer, l2cap_chan_timeout, (unsigned long) chan);
+	INIT_DELAYED_WORK(&chan->chan_timer, l2cap_chan_timeout);
 
 	chan->state = BT_OPEN;
 
@@ -1251,17 +1242,18 @@ int __l2cap_wait_ack(struct sock *sk)
 	return err;
 }
 
-static void l2cap_monitor_timeout(unsigned long arg)
+static void l2cap_monitor_timeout(struct work_struct *work)
 {
-	struct l2cap_chan *chan = (void *) arg;
+	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
+							monitor_timer.work);
 	struct sock *sk = chan->sk;
 
 	BT_DBG("chan %p", chan);
 
-	bh_lock_sock(sk);
+	lock_sock(sk);
 	if (chan->retry_count >= chan->remote_max_tx) {
 		l2cap_send_disconn_req(chan->conn, chan, ECONNABORTED);
-		bh_unlock_sock(sk);
+		release_sock(sk);
 		return;
 	}
 
@@ -1269,24 +1261,25 @@ static void l2cap_monitor_timeout(unsigned long arg)
 	__set_monitor_timer(chan);
 
 	l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_POLL);
-	bh_unlock_sock(sk);
+	release_sock(sk);
 }
 
-static void l2cap_retrans_timeout(unsigned long arg)
+static void l2cap_retrans_timeout(struct work_struct *work)
 {
-	struct l2cap_chan *chan = (void *) arg;
+	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
+							retrans_timer.work);
 	struct sock *sk = chan->sk;
 
 	BT_DBG("chan %p", chan);
 
-	bh_lock_sock(sk);
+	lock_sock(sk);
 	chan->retry_count = 1;
 	__set_monitor_timer(chan);
 
 	set_bit(CONN_WAIT_F, &chan->conn_state);
 
 	l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_POLL);
-	bh_unlock_sock(sk);
+	release_sock(sk);
 }
 
 static void l2cap_drop_acked_frames(struct l2cap_chan *chan)
@@ -1955,13 +1948,14 @@ static void l2cap_add_opt_efs(void **ptr, struct l2cap_chan *chan)
 							(unsigned long) &efs);
 }
 
-static void l2cap_ack_timeout(unsigned long arg)
+static void l2cap_ack_timeout(struct work_struct *work)
 {
-	struct l2cap_chan *chan = (void *) arg;
+	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
+							ack_timer.work);
 
-	bh_lock_sock(chan->sk);
+	lock_sock(chan->sk);
 	l2cap_send_ack(chan);
-	bh_unlock_sock(chan->sk);
+	release_sock(chan->sk);
 }
 
 static inline void l2cap_ertm_init(struct l2cap_chan *chan)
@@ -1974,11 +1968,9 @@ static inline void l2cap_ertm_init(struct l2cap_chan *chan)
 	chan->num_acked = 0;
 	chan->frames_sent = 0;
 
-	setup_timer(&chan->retrans_timer, l2cap_retrans_timeout,
-							(unsigned long) chan);
-	setup_timer(&chan->monitor_timer, l2cap_monitor_timeout,
-							(unsigned long) chan);
-	setup_timer(&chan->ack_timer, l2cap_ack_timeout, (unsigned long) chan);
+	INIT_DELAYED_WORK(&chan->retrans_timer, l2cap_retrans_timeout);
+	INIT_DELAYED_WORK(&chan->monitor_timer, l2cap_monitor_timeout);
+	INIT_DELAYED_WORK(&chan->ack_timer, l2cap_ack_timeout);
 
 	skb_queue_head_init(&chan->srej_q);
 
-- 
1.7.6.4

