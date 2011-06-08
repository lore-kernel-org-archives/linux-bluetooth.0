Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH -v2 8/8] Bluetooth: keep reference if any ERTM timer is enabled
Date: Wed,  8 Jun 2011 12:18:59 -0300
Message-Id: <1307546339-12035-9-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1307546339-12035-8-git-send-email-padovan@profusion.mobi>
References: <1307546339-12035-1-git-send-email-padovan@profusion.mobi>
 <1307546339-12035-2-git-send-email-padovan@profusion.mobi>
 <1307546339-12035-3-git-send-email-padovan@profusion.mobi>
 <1307546339-12035-4-git-send-email-padovan@profusion.mobi>
 <1307546339-12035-5-git-send-email-padovan@profusion.mobi>
 <1307546339-12035-6-git-send-email-padovan@profusion.mobi>
 <1307546339-12035-7-git-send-email-padovan@profusion.mobi>
 <1307546339-12035-8-git-send-email-padovan@profusion.mobi>
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
index 7aaf7f7..c284be0 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -441,12 +441,15 @@ struct l2cap_pinfo {
 
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
index c6d008d..3af8882 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -389,9 +389,9 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
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
@@ -697,9 +697,9 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
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
@@ -1177,7 +1177,7 @@ static void l2cap_monitor_timeout(unsigned long arg)
 	}
 
 	chan->retry_count++;
-	__mod_monitor_timer();
+	__set_monitor_timer(chan);
 
 	l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_POLL);
 	bh_unlock_sock(sk);
@@ -1192,7 +1192,7 @@ static void l2cap_retrans_timeout(unsigned long arg)
 
 	bh_lock_sock(sk);
 	chan->retry_count = 1;
-	__mod_monitor_timer();
+	__set_monitor_timer(chan);
 
 	chan->conn_state |= L2CAP_CONN_WAIT_F;
 
@@ -1216,7 +1216,7 @@ static void l2cap_drop_acked_frames(struct l2cap_chan *chan)
 	}
 
 	if (!chan->unacked_frames)
-		del_timer(&chan->retrans_timer);
+		__clear_retrans_timer(chan);
 }
 
 void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
@@ -1343,7 +1343,7 @@ int l2cap_ertm_send(struct l2cap_chan *chan)
 
 		l2cap_do_send(chan, tx_skb);
 
-		__mod_retrans_timer();
+		__set_retrans_timer(chan);
 
 		bt_cb(skb)->tx_seq = chan->next_tx_seq;
 		chan->next_tx_seq = (chan->next_tx_seq + 1) % 64;
@@ -3260,8 +3260,8 @@ static int l2cap_try_push_rx_skb(struct l2cap_chan *chan)
 	l2cap_send_sframe(chan, control);
 	chan->retry_count = 1;
 
-	del_timer(&chan->retrans_timer);
-	__mod_monitor_timer();
+	__clear_retrans_timer(chan);
+	__set_monitor_timer(chan);
 
 	chan->conn_state |= L2CAP_CONN_WAIT_F;
 
@@ -3352,7 +3352,7 @@ static int l2cap_push_rx_skb(struct l2cap_chan *chan, struct sk_buff *skb, u16 c
 
 	chan->conn_state |= L2CAP_CONN_RNR_SENT;
 
-	del_timer(&chan->ack_timer);
+	__clear_ack_timer(chan);
 
 	queue_work(_busy_wq, &chan->busy_work);
 
@@ -3521,9 +3521,9 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 
 	if (L2CAP_CTRL_FINAL & rx_control &&
 			chan->conn_state & L2CAP_CONN_WAIT_F) {
-		del_timer(&chan->monitor_timer);
+		__clear_monitor_timer(chan);
 		if (chan->unacked_frames > 0)
-			__mod_retrans_timer();
+			__set_retrans_timer(chan);
 		chan->conn_state &= ~L2CAP_CONN_WAIT_F;
 	}
 
@@ -3604,7 +3604,7 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 
 		l2cap_send_srejframe(chan, tx_seq);
 
-		del_timer(&chan->ack_timer);
+		__clear_ack_timer(chan);
 	}
 	return 0;
 
@@ -3629,7 +3629,7 @@ expected:
 			l2cap_retransmit_frames(chan);
 	}
 
-	__mod_ack_timer();
+	__set_ack_timer(chan);
 
 	chan->num_acked = (chan->num_acked + 1) % num_to_ack;
 	if (chan->num_acked == num_to_ack - 1)
@@ -3655,7 +3655,7 @@ static inline void l2cap_data_channel_rrframe(struct l2cap_chan *chan, u16 rx_co
 		if (chan->conn_state & L2CAP_CONN_SREJ_SENT) {
 			if ((chan->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
 					(chan->unacked_frames > 0))
-				__mod_retrans_timer();
+				__set_retrans_timer(chan);
 
 			chan->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
 			l2cap_send_srejtail(chan);
@@ -3674,7 +3674,7 @@ static inline void l2cap_data_channel_rrframe(struct l2cap_chan *chan, u16 rx_co
 	} else {
 		if ((chan->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
 				(chan->unacked_frames > 0))
-			__mod_retrans_timer();
+			__set_retrans_timer(chan);
 
 		chan->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
 		if (chan->conn_state & L2CAP_CONN_SREJ_SENT)
@@ -3757,7 +3757,7 @@ static inline void l2cap_data_channel_rnrframe(struct l2cap_chan *chan, u16 rx_c
 		chan->conn_state |= L2CAP_CONN_SEND_FBIT;
 
 	if (!(chan->conn_state & L2CAP_CONN_SREJ_SENT)) {
-		del_timer(&chan->retrans_timer);
+		__clear_retrans_timer(chan);
 		if (rx_control & L2CAP_CTRL_POLL)
 			l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_FINAL);
 		return;
@@ -3775,9 +3775,9 @@ static inline int l2cap_data_channel_sframe(struct l2cap_chan *chan, u16 rx_cont
 
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

