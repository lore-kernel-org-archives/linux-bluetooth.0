Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] Bluetooth: keep reference if any ERTM timer is enabled
Date: Thu,  2 Jun 2011 13:15:29 -0300
Message-Id: <1307031329-8001-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1307031329-8001-5-git-send-email-padovan@profusion.mobi>
References: <1307031329-8001-1-git-send-email-padovan@profusion.mobi>
 <1307031329-8001-2-git-send-email-padovan@profusion.mobi>
 <1307031329-8001-3-git-send-email-padovan@profusion.mobi>
 <1307031329-8001-4-git-send-email-padovan@profusion.mobi>
 <1307031329-8001-5-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ERTM use the generic L2CAP timer functions to keep a reference to the
channel. This is useful for avoiding crashes.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |   15 ++++++++-----
 net/bluetooth/l2cap_core.c    |   44 ++++++++++++++++++++--------------------
 2 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index e3e58f9..c4799da2 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -437,12 +437,15 @@ struct l2cap_pinfo {
 
 #define __set_chan_timer(c, t) l2cap_set_timer(c, &c->chan_timer, (t))
 #define __clear_chan_timer(c) l2cap_clear_timer(c, &c->chan_timer)
-#define __mod_retrans_timer() mod_timer(&chan->retrans_timer, \
-		jiffies +  msecs_to_jiffies(L2CAP_DEFAULT_RETRANS_TO));
-#define __mod_monitor_timer() mod_timer(&chan->monitor_timer, \
-		jiffies + msecs_to_jiffies(L2CAP_DEFAULT_MONITOR_TO));
-#define __mod_ack_timer() mod_timer(&chan->ack_timer, \
-		jiffies + msecs_to_jiffies(L2CAP_DEFAULT_ACK_TO));
+#define __set_retrans_timer(c) l2cap_set_timer(c, &c->retrans_timer, \
+		L2CAP_DEFAULT_RETRANS_TO);
+#define __clear_retrans_timer(c) l2cap_clear_timer(c, &c->retrans_timer)
+#define __set_monitor_timer(c) l2cap_set_timer(c, &c->monitor_timer, \
+		L2CAP_DEFAULT_MONITOR_TO);
+#define __clear_monitor_timer(c) l2cap_clear_timer(c, &c->monitor_timer)
+#define __set_ack_timer(c) l2cap_set_timer(c, &chan->ack_timer, \
+		L2CAP_DEFAULT_ACK_TO);
+#define __clear_ack_timer(c) l2cap_clear_timer(c, &c->ack_timer)
 
 static inline int l2cap_tx_window_full(struct l2cap_chan *ch)
 {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8586077..7042f6e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -380,9 +380,9 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	if (chan->mode == L2CAP_MODE_ERTM) {
 		struct srej_list *l, *tmp;
 
-		del_timer(&chan->retrans_timer);
-		del_timer(&chan->monitor_timer);
-		del_timer(&chan->ack_timer);
+		__clear_retrans_timer(chan);
+		__clear_monitor_timer(chan);
+		__clear_ack_timer(chan);
 
 		skb_queue_purge(&chan->srej_q);
 		skb_queue_purge(&chan->busy_q);
@@ -686,9 +686,9 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
 	sk = chan->sk;
 
 	if (chan->mode == L2CAP_MODE_ERTM) {
-		del_timer(&chan->retrans_timer);
-		del_timer(&chan->monitor_timer);
-		del_timer(&chan->ack_timer);
+		__clear_retrans_timer(chan);
+		__clear_monitor_timer(chan);
+		__clear_ack_timer(chan);
 	}
 
 	req.dcid = cpu_to_le16(chan->dcid);
@@ -1166,7 +1166,7 @@ static void l2cap_monitor_timeout(unsigned long arg)
 	}
 
 	chan->retry_count++;
-	__mod_monitor_timer();
+	__set_monitor_timer(chan);
 
 	l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_POLL);
 	bh_unlock_sock(sk);
@@ -1181,7 +1181,7 @@ static void l2cap_retrans_timeout(unsigned long arg)
 
 	bh_lock_sock(sk);
 	chan->retry_count = 1;
-	__mod_monitor_timer();
+	__set_monitor_timer(chan);
 
 	chan->conn_state |= L2CAP_CONN_WAIT_F;
 
@@ -1205,7 +1205,7 @@ static void l2cap_drop_acked_frames(struct l2cap_chan *chan)
 	}
 
 	if (!chan->unacked_frames)
-		del_timer(&chan->retrans_timer);
+		__clear_retrans_timer(chan);
 }
 
 void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
@@ -1332,7 +1332,7 @@ int l2cap_ertm_send(struct l2cap_chan *chan)
 
 		l2cap_do_send(chan, tx_skb);
 
-		__mod_retrans_timer();
+		__set_retrans_timer(chan);
 
 		bt_cb(skb)->tx_seq = chan->next_tx_seq;
 		chan->next_tx_seq = (chan->next_tx_seq + 1) % 64;
@@ -3249,8 +3249,8 @@ static int l2cap_try_push_rx_skb(struct l2cap_chan *chan)
 	l2cap_send_sframe(chan, control);
 	chan->retry_count = 1;
 
-	del_timer(&chan->retrans_timer);
-	__mod_monitor_timer();
+	__clear_retrans_timer(chan);
+	__set_monitor_timer(chan);
 
 	chan->conn_state |= L2CAP_CONN_WAIT_F;
 
@@ -3341,7 +3341,7 @@ static int l2cap_push_rx_skb(struct l2cap_chan *chan, struct sk_buff *skb, u16 c
 
 	chan->conn_state |= L2CAP_CONN_RNR_SENT;
 
-	del_timer(&chan->ack_timer);
+	__clear_ack_timer(chan);
 
 	queue_work(_busy_wq, &chan->busy_work);
 
@@ -3510,9 +3510,9 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 
 	if (L2CAP_CTRL_FINAL & rx_control &&
 			chan->conn_state & L2CAP_CONN_WAIT_F) {
-		del_timer(&chan->monitor_timer);
+		__clear_monitor_timer(chan);
 		if (chan->unacked_frames > 0)
-			__mod_retrans_timer();
+			__set_retrans_timer(chan);
 		chan->conn_state &= ~L2CAP_CONN_WAIT_F;
 	}
 
@@ -3593,7 +3593,7 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 
 		l2cap_send_srejframe(chan, tx_seq);
 
-		del_timer(&chan->ack_timer);
+		__clear_ack_timer(chan);
 	}
 	return 0;
 
@@ -3618,7 +3618,7 @@ expected:
 			l2cap_retransmit_frames(chan);
 	}
 
-	__mod_ack_timer();
+	__set_ack_timer(chan);
 
 	chan->num_acked = (chan->num_acked + 1) % num_to_ack;
 	if (chan->num_acked == num_to_ack - 1)
@@ -3644,7 +3644,7 @@ static inline void l2cap_data_channel_rrframe(struct l2cap_chan *chan, u16 rx_co
 		if (chan->conn_state & L2CAP_CONN_SREJ_SENT) {
 			if ((chan->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
 					(chan->unacked_frames > 0))
-				__mod_retrans_timer();
+				__set_retrans_timer(chan);
 
 			chan->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
 			l2cap_send_srejtail(chan);
@@ -3663,7 +3663,7 @@ static inline void l2cap_data_channel_rrframe(struct l2cap_chan *chan, u16 rx_co
 	} else {
 		if ((chan->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
 				(chan->unacked_frames > 0))
-			__mod_retrans_timer();
+			__set_retrans_timer(chan);
 
 		chan->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
 		if (chan->conn_state & L2CAP_CONN_SREJ_SENT)
@@ -3746,7 +3746,7 @@ static inline void l2cap_data_channel_rnrframe(struct l2cap_chan *chan, u16 rx_c
 		chan->conn_state |= L2CAP_CONN_SEND_FBIT;
 
 	if (!(chan->conn_state & L2CAP_CONN_SREJ_SENT)) {
-		del_timer(&chan->retrans_timer);
+		__clear_retrans_timer(chan);
 		if (rx_control & L2CAP_CTRL_POLL)
 			l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_FINAL);
 		return;
@@ -3764,9 +3764,9 @@ static inline int l2cap_data_channel_sframe(struct l2cap_chan *chan, u16 rx_cont
 
 	if (L2CAP_CTRL_FINAL & rx_control &&
 			chan->conn_state & L2CAP_CONN_WAIT_F) {
-		del_timer(&chan->monitor_timer);
+		__clear_monitor_timer(chan);
 		if (chan->unacked_frames > 0)
-			__mod_retrans_timer();
+			__set_retrans_timer(chan);
 		chan->conn_state &= ~L2CAP_CONN_WAIT_F;
 	}
 
-- 
1.7.5.1

