Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 14/15] Bluetooth: Move busy workqueue to struct l2cap_chan
Date: Fri,  1 Apr 2011 19:33:19 -0300
Message-Id: <1301697200-2446-15-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1301697200-2446-14-git-send-email-padovan@profusion.mobi>
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
 <1301697200-2446-14-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As part of the moving channel stuff to l2cap_chan.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    2 +-
 net/bluetooth/l2cap_core.c    |   20 +++++++++-----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 09f4a2f..d05d91f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -311,6 +311,7 @@ struct l2cap_chan {
 	struct timer_list	ack_timer;
 	struct sk_buff_head	srej_q;
 	struct sk_buff_head	busy_q;
+	struct work_struct	busy_work;
 
 	struct list_head list;
 };
@@ -384,7 +385,6 @@ struct l2cap_pinfo {
 	__le16		sport;
 
 	struct sk_buff_head	tx_queue;
-	struct work_struct	busy_work;
 	struct srej_list	srej_l;
 	struct l2cap_conn	*conn;
 	struct l2cap_chan	*chan;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a5aecc5..0cf3a55 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1592,7 +1592,7 @@ static inline void l2cap_ertm_init(struct l2cap_chan *chan)
 	skb_queue_head_init(&chan->srej_q);
 	skb_queue_head_init(&chan->busy_q);
 
-	INIT_WORK(&l2cap_pi(sk)->busy_work, l2cap_busy_work);
+	INIT_WORK(&chan->busy_work, l2cap_busy_work);
 
 	sk->sk_backlog_rcv = l2cap_ertm_data_rcv;
 }
@@ -3007,21 +3007,21 @@ done:
 static void l2cap_busy_work(struct work_struct *work)
 {
 	DECLARE_WAITQUEUE(wait, current);
-	struct l2cap_pinfo *pi =
-		container_of(work, struct l2cap_pinfo, busy_work);
-	struct sock *sk = (struct sock *)pi;
+	struct l2cap_chan *chan =
+		container_of(work, struct l2cap_chan, busy_work);
+	struct sock *sk = chan->sk;
 	int n_tries = 0, timeo = HZ/5, err;
 	struct sk_buff *skb;
 
 	lock_sock(sk);
 
 	add_wait_queue(sk_sleep(sk), &wait);
-	while ((skb = skb_peek(&pi->chan->busy_q))) {
+	while ((skb = skb_peek(&chan->busy_q))) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
 		if (n_tries++ > L2CAP_LOCAL_BUSY_TRIES) {
 			err = -EBUSY;
-			l2cap_send_disconn_req(pi->conn, pi->chan, EBUSY);
+			l2cap_send_disconn_req(l2cap_pi(sk)->conn, chan, EBUSY);
 			break;
 		}
 
@@ -3041,7 +3041,7 @@ static void l2cap_busy_work(struct work_struct *work)
 		if (err)
 			break;
 
-		if (l2cap_try_push_rx_skb(l2cap_pi(sk)->chan) == 0)
+		if (l2cap_try_push_rx_skb(chan) == 0)
 			break;
 	}
 
@@ -3053,8 +3053,6 @@ static void l2cap_busy_work(struct work_struct *work)
 
 static int l2cap_push_rx_skb(struct l2cap_chan *chan, struct sk_buff *skb, u16 control)
 {
-	struct sock *sk = chan->sk;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	int sctrl, err;
 
 	if (chan->conn_state & L2CAP_CONN_LOCAL_BUSY) {
@@ -3072,7 +3070,7 @@ static int l2cap_push_rx_skb(struct l2cap_chan *chan, struct sk_buff *skb, u16 c
 	}
 
 	/* Busy Condition */
-	BT_DBG("sk %p, Enter local busy", sk);
+	BT_DBG("chan %p, Enter local busy", chan);
 
 	chan->conn_state |= L2CAP_CONN_LOCAL_BUSY;
 	bt_cb(skb)->sar = control >> L2CAP_CTRL_SAR_SHIFT;
@@ -3086,7 +3084,7 @@ static int l2cap_push_rx_skb(struct l2cap_chan *chan, struct sk_buff *skb, u16 c
 
 	del_timer(&chan->ack_timer);
 
-	queue_work(_busy_wq, &pi->busy_work);
+	queue_work(_busy_wq, &chan->busy_work);
 
 	return err;
 }
-- 
1.7.4.1

