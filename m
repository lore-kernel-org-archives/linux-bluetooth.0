Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 3/4] Bluetooth: Limit depth of the HCI TX queue with ERTM mode
Date: Fri,  3 Jun 2011 16:21:09 -0700
Message-Id: <1307143270-2655-3-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1307143270-2655-1-git-send-email-mathewm@codeaurora.org>
References: <1307143270-2655-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to provide timely responses to REJ, SREJ, and poll input from
the remote device, it helps to reduce the number of ERTM data frames
in the HCI TX queue at one time. If a full TX window of data is in the
HCI TX queue, any responses to REJ, SREJ, or polls must wait in line
behind all previously queued data. This latency leads to disconnects,
and will be more severe with extended window sizes.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/bluetooth.h |    1 +
 include/net/bluetooth/l2cap.h     |    5 +++++
 net/bluetooth/l2cap_core.c        |   31 +++++++++++++++++++++++++++++--
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index af930a3..ad8ab1c 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -158,6 +158,7 @@ struct bt_skb_cb {
 	__u8 sar;
 	unsigned short channel;
 	__u8 force_active;
+	struct l2cap_chan *chan;
 };
 #define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
 
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 0529d27..ac87965 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -39,6 +39,8 @@
 #define L2CAP_DEFAULT_ACK_TO		200
 #define L2CAP_LOCAL_BUSY_TRIES		12
 #define L2CAP_LE_DEFAULT_MTU		23
+#define L2CAP_MAX_ERTM_QUEUED		5
+#define L2CAP_MIN_ERTM_QUEUED		2
 
 #define L2CAP_CONN_TIMEOUT	(40000) /* 40 seconds */
 #define L2CAP_INFO_TIMEOUT	(4000)  /*  4 seconds */
@@ -341,6 +343,8 @@ struct l2cap_chan {
 	__u8		remote_max_tx;
 	__u16		remote_mps;
 
+	atomic_t	ertm_queued;
+
 	struct timer_list	chan_timer;
 	struct timer_list	retrans_timer;
 	struct timer_list	monitor_timer;
@@ -350,6 +354,7 @@ struct l2cap_chan {
 	struct sk_buff_head	srej_q;
 	struct sk_buff_head	busy_q;
 	struct work_struct	busy_work;
+	struct work_struct	tx_work;
 	struct list_head	srej_l;
 
 	struct list_head list;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6f9daf8..d167edd 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1127,7 +1127,8 @@ int __l2cap_wait_ack(struct sock *sk)
 	int timeo = HZ/5;
 
 	add_wait_queue(sk_sleep(sk), &wait);
-	while ((chan->unacked_frames > 0 && chan->conn)) {
+	while (chan->unacked_frames > 0 && chan->conn &&
+			atomic_read(&chan->ertm_queued)) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
 		if (!timeo)
@@ -1292,6 +1293,16 @@ static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u8 tx_seq)
 	l2cap_do_send(chan, tx_skb);
 }
 
+static void l2cap_skb_destructor(struct sk_buff *skb)
+{
+	struct l2cap_chan *chan = bt_cb(skb)->chan;
+	int queued;
+
+	queued = atomic_sub_return(1, &chan->ertm_queued);
+	if (queued < L2CAP_MIN_ERTM_QUEUED)
+		queue_work(_l2cap_wq, &chan->tx_work);
+}
+
 int l2cap_ertm_send(struct l2cap_chan *chan)
 {
 	struct sk_buff *skb, *tx_skb;
@@ -1302,7 +1313,8 @@ int l2cap_ertm_send(struct l2cap_chan *chan)
 	if (sk->sk_state != BT_CONNECTED)
 		return -ENOTCONN;
 
-	while ((skb = chan->tx_send_head) && (!l2cap_tx_window_full(chan))) {
+	while ((skb = chan->tx_send_head) && !l2cap_tx_window_full(chan) &&
+		atomic_read(&chan->ertm_queued) < L2CAP_MAX_ERTM_QUEUED) {
 
 		if (chan->remote_max_tx &&
 				bt_cb(skb)->retries == chan->remote_max_tx) {
@@ -1331,6 +1343,10 @@ int l2cap_ertm_send(struct l2cap_chan *chan)
 			put_unaligned_le16(fcs, skb->data + tx_skb->len - 2);
 		}
 
+		bt_cb(tx_skb)->chan = chan;
+		tx_skb->destructor = l2cap_skb_destructor;
+		atomic_inc(&chan->ertm_queued);
+
 		l2cap_do_send(chan, tx_skb);
 
 		__mod_retrans_timer();
@@ -1354,6 +1370,16 @@ int l2cap_ertm_send(struct l2cap_chan *chan)
 	return nsent;
 }
 
+static void l2cap_ertm_tx_worker(struct work_struct *work)
+{
+	struct l2cap_chan *chan =
+		container_of(work, struct l2cap_chan, tx_work);
+
+	lock_sock(chan->sk);
+	l2cap_ertm_send(chan);
+	release_sock(chan->sk);
+}
+
 static int l2cap_retransmit_frames(struct l2cap_chan *chan)
 {
 	int ret;
@@ -1870,6 +1896,7 @@ static inline void l2cap_ertm_init(struct l2cap_chan *chan)
 	INIT_LIST_HEAD(&chan->srej_l);
 
 	INIT_WORK(&chan->busy_work, l2cap_busy_work);
+	INIT_WORK(&chan->tx_work, l2cap_ertm_tx_worker);
 
 	sk->sk_backlog_rcv = l2cap_ertm_data_rcv;
 }
-- 
1.7.5.2


--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

