Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 12/15] Bluetooth: Move ERTM timers to struct l2cap_chan
Date: Fri,  1 Apr 2011 19:33:17 -0300
Message-Id: <1301697200-2446-13-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1301697200-2446-12-git-send-email-padovan@profusion.mobi>
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
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This also triggered a change in l2cap_send_disconn_req() parameters.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |   15 ++++----
 net/bluetooth/l2cap_core.c    |   74 ++++++++++++++++++++---------------------
 net/bluetooth/l2cap_sock.c    |   13 ++++---
 3 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 11c53cb..5f4abea 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -306,6 +306,10 @@ struct l2cap_chan {
 	__u8		remote_max_tx;
 	__u16		remote_mps;
 
+	struct timer_list	retrans_timer;
+	struct timer_list	monitor_timer;
+	struct timer_list	ack_timer;
+
 	struct list_head list;
 };
 
@@ -379,9 +383,6 @@ struct l2cap_pinfo {
 
 	__le16		sport;
 
-	struct timer_list	retrans_timer;
-	struct timer_list	monitor_timer;
-	struct timer_list	ack_timer;
 	struct sk_buff_head	tx_queue;
 	struct sk_buff_head	srej_queue;
 	struct sk_buff_head	busy_queue;
@@ -415,11 +416,11 @@ struct l2cap_pinfo {
 #define L2CAP_CONN_RNR_SENT        0x0200
 #define L2CAP_CONN_SAR_RETRY       0x0400
 
-#define __mod_retrans_timer() mod_timer(&l2cap_pi(sk)->retrans_timer, \
+#define __mod_retrans_timer() mod_timer(&chan->retrans_timer, \
 		jiffies +  msecs_to_jiffies(L2CAP_DEFAULT_RETRANS_TO));
-#define __mod_monitor_timer() mod_timer(&l2cap_pi(sk)->monitor_timer, \
+#define __mod_monitor_timer() mod_timer(&chan->monitor_timer, \
 		jiffies + msecs_to_jiffies(L2CAP_DEFAULT_MONITOR_TO));
-#define __mod_ack_timer() mod_timer(&l2cap_pi(sk)->ack_timer, \
+#define __mod_ack_timer() mod_timer(&chan->ack_timer, \
 		jiffies + msecs_to_jiffies(L2CAP_DEFAULT_ACK_TO));
 
 static inline int l2cap_tx_window_full(struct l2cap_chan *ch)
@@ -466,7 +467,7 @@ void l2cap_sock_kill(struct sock *sk);
 void l2cap_sock_init(struct sock *sk, struct sock *parent);
 struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 							int proto, gfp_t prio);
-void l2cap_send_disconn_req(struct l2cap_conn *conn, struct sock *sk, int err);
+void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *chan, int err);
 void l2cap_chan_del(struct l2cap_chan *chan, int err);
 int l2cap_do_connect(struct sock *sk);
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 512cf26..b44347b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -241,9 +241,9 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	if (l2cap_pi(sk)->mode == L2CAP_MODE_ERTM) {
 		struct srej_list *l, *tmp;
 
-		del_timer(&l2cap_pi(sk)->retrans_timer);
-		del_timer(&l2cap_pi(sk)->monitor_timer);
-		del_timer(&l2cap_pi(sk)->ack_timer);
+		del_timer(&chan->retrans_timer);
+		del_timer(&chan->monitor_timer);
+		del_timer(&chan->ack_timer);
 
 		skb_queue_purge(SREJ_QUEUE(sk));
 		skb_queue_purge(BUSY_QUEUE(sk));
@@ -462,19 +462,22 @@ static inline int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
 	}
 }
 
-void l2cap_send_disconn_req(struct l2cap_conn *conn, struct sock *sk, int err)
+void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *chan, int err)
 {
+	struct sock *sk;
 	struct l2cap_disconn_req req;
 
 	if (!conn)
 		return;
 
+	sk = chan->sk;
+
 	skb_queue_purge(TX_QUEUE(sk));
 
 	if (l2cap_pi(sk)->mode == L2CAP_MODE_ERTM) {
-		del_timer(&l2cap_pi(sk)->retrans_timer);
-		del_timer(&l2cap_pi(sk)->monitor_timer);
-		del_timer(&l2cap_pi(sk)->ack_timer);
+		del_timer(&chan->retrans_timer);
+		del_timer(&chan->monitor_timer);
+		del_timer(&chan->ack_timer);
 	}
 
 	req.dcid = cpu_to_le16(l2cap_pi(sk)->dcid);
@@ -958,7 +961,7 @@ static void l2cap_monitor_timeout(unsigned long arg)
 
 	bh_lock_sock(sk);
 	if (chan->retry_count >= chan->remote_max_tx) {
-		l2cap_send_disconn_req(l2cap_pi(sk)->conn, sk, ECONNABORTED);
+		l2cap_send_disconn_req(l2cap_pi(chan)->conn, chan, ECONNABORTED);
 		bh_unlock_sock(sk);
 		return;
 	}
@@ -1004,7 +1007,7 @@ static void l2cap_drop_acked_frames(struct l2cap_chan *chan)
 	}
 
 	if (!chan->unacked_frames)
-		del_timer(&l2cap_pi(sk)->retrans_timer);
+		del_timer(&chan->retrans_timer);
 }
 
 void l2cap_do_send(struct sock *sk, struct sk_buff *skb)
@@ -1068,7 +1071,7 @@ static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u8 tx_seq)
 
 	if (chan->remote_max_tx &&
 			bt_cb(skb)->retries == chan->remote_max_tx) {
-		l2cap_send_disconn_req(pi->conn, sk, ECONNABORTED);
+		l2cap_send_disconn_req(pi->conn, chan, ECONNABORTED);
 		return;
 	}
 
@@ -1109,7 +1112,7 @@ int l2cap_ertm_send(struct l2cap_chan *chan)
 
 		if (chan->remote_max_tx &&
 				bt_cb(skb)->retries == chan->remote_max_tx) {
-			l2cap_send_disconn_req(pi->conn, sk, ECONNABORTED);
+			l2cap_send_disconn_req(pi->conn, chan, ECONNABORTED);
 			break;
 		}
 
@@ -1580,12 +1583,11 @@ static inline void l2cap_ertm_init(struct l2cap_chan *chan)
 	chan->num_acked = 0;
 	chan->frames_sent = 0;
 
-	setup_timer(&l2cap_pi(sk)->retrans_timer,
-			l2cap_retrans_timeout, (unsigned long) chan);
-	setup_timer(&l2cap_pi(sk)->monitor_timer,
-			l2cap_monitor_timeout, (unsigned long) chan);
-	setup_timer(&l2cap_pi(sk)->ack_timer,
-			l2cap_ack_timeout, (unsigned long) chan);
+	setup_timer(&chan->retrans_timer, l2cap_retrans_timeout,
+							(unsigned long) chan);
+	setup_timer(&chan->monitor_timer, l2cap_monitor_timeout,
+							(unsigned long) chan);
+	setup_timer(&chan->ack_timer, l2cap_ack_timeout, (unsigned long) chan);
 
 	__skb_queue_head_init(SREJ_QUEUE(sk));
 	__skb_queue_head_init(BUSY_QUEUE(sk));
@@ -2292,7 +2294,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	/* Complete config. */
 	len = l2cap_parse_conf_req(chan, rsp);
 	if (len < 0) {
-		l2cap_send_disconn_req(conn, sk, ECONNRESET);
+		l2cap_send_disconn_req(conn, chan, ECONNRESET);
 		goto unlock;
 	}
 
@@ -2364,7 +2366,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 			char req[64];
 
 			if (len > sizeof(req) - sizeof(struct l2cap_conf_req)) {
-				l2cap_send_disconn_req(conn, sk, ECONNRESET);
+				l2cap_send_disconn_req(conn, chan, ECONNRESET);
 				goto done;
 			}
 
@@ -2373,7 +2375,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 			len = l2cap_parse_conf_rsp(sk, rsp->data,
 							len, req, &result);
 			if (len < 0) {
-				l2cap_send_disconn_req(conn, sk, ECONNRESET);
+				l2cap_send_disconn_req(conn, chan, ECONNRESET);
 				goto done;
 			}
 
@@ -2388,7 +2390,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	default:
 		sk->sk_err = ECONNRESET;
 		l2cap_sock_set_timer(sk, HZ * 5);
-		l2cap_send_disconn_req(conn, sk, ECONNRESET);
+		l2cap_send_disconn_req(conn, chan, ECONNRESET);
 		goto done;
 	}
 
@@ -2958,7 +2960,7 @@ drop:
 	chan->sdu = NULL;
 
 disconnect:
-	l2cap_send_disconn_req(pi->conn, chan->sk, ECONNRESET);
+	l2cap_send_disconn_req(pi->conn, chan, ECONNRESET);
 	kfree_skb(skb);
 	return 0;
 }
@@ -2966,7 +2968,6 @@ disconnect:
 static int l2cap_try_push_rx_skb(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->sk;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct sk_buff *skb;
 	u16 control;
 	int err;
@@ -2990,7 +2991,7 @@ static int l2cap_try_push_rx_skb(struct l2cap_chan *chan)
 	l2cap_send_sframe(chan, control);
 	chan->retry_count = 1;
 
-	del_timer(&pi->retrans_timer);
+	del_timer(&chan->retrans_timer);
 	__mod_monitor_timer();
 
 	chan->conn_state |= L2CAP_CONN_WAIT_F;
@@ -3021,7 +3022,7 @@ static void l2cap_busy_work(struct work_struct *work)
 
 		if (n_tries++ > L2CAP_LOCAL_BUSY_TRIES) {
 			err = -EBUSY;
-			l2cap_send_disconn_req(pi->conn, sk, EBUSY);
+			l2cap_send_disconn_req(pi->conn, pi->chan, EBUSY);
 			break;
 		}
 
@@ -3084,7 +3085,7 @@ static int l2cap_push_rx_skb(struct l2cap_chan *chan, struct sk_buff *skb, u16 c
 
 	chan->conn_state |= L2CAP_CONN_RNR_SENT;
 
-	del_timer(&pi->ack_timer);
+	del_timer(&chan->ack_timer);
 
 	queue_work(_busy_wq, &pi->busy_work);
 
@@ -3259,7 +3260,7 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 
 	if (L2CAP_CTRL_FINAL & rx_control &&
 			chan->conn_state & L2CAP_CONN_WAIT_F) {
-		del_timer(&pi->monitor_timer);
+		del_timer(&chan->monitor_timer);
 		if (chan->unacked_frames > 0)
 			__mod_retrans_timer();
 		chan->conn_state &= ~L2CAP_CONN_WAIT_F;
@@ -3277,7 +3278,7 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 
 	/* invalid tx_seq */
 	if (tx_seq_offset >= pi->tx_win) {
-		l2cap_send_disconn_req(pi->conn, sk, ECONNRESET);
+		l2cap_send_disconn_req(pi->conn, chan, ECONNRESET);
 		goto drop;
 	}
 
@@ -3342,7 +3343,7 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 
 		l2cap_send_srejframe(chan, tx_seq);
 
-		del_timer(&pi->ack_timer);
+		del_timer(&chan->ack_timer);
 	}
 	return 0;
 
@@ -3485,7 +3486,6 @@ static inline void l2cap_data_channel_srejframe(struct l2cap_chan *chan, u16 rx_
 
 static inline void l2cap_data_channel_rnrframe(struct l2cap_chan *chan, u16 rx_control)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
 	u8 tx_seq = __get_reqseq(rx_control);
 
 	BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan, tx_seq, rx_control);
@@ -3498,7 +3498,7 @@ static inline void l2cap_data_channel_rnrframe(struct l2cap_chan *chan, u16 rx_c
 		chan->conn_state |= L2CAP_CONN_SEND_FBIT;
 
 	if (!(chan->conn_state & L2CAP_CONN_SREJ_SENT)) {
-		del_timer(&pi->retrans_timer);
+		del_timer(&chan->retrans_timer);
 		if (rx_control & L2CAP_CTRL_POLL)
 			l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_FINAL);
 		return;
@@ -3512,13 +3512,11 @@ static inline void l2cap_data_channel_rnrframe(struct l2cap_chan *chan, u16 rx_c
 
 static inline int l2cap_data_channel_sframe(struct l2cap_chan *chan, u16 rx_control, struct sk_buff *skb)
 {
-	struct sock *sk = chan->sk;
-
 	BT_DBG("chan %p rx_control 0x%4.4x len %d", chan, rx_control, skb->len);
 
 	if (L2CAP_CTRL_FINAL & rx_control &&
 			chan->conn_state & L2CAP_CONN_WAIT_F) {
-		del_timer(&l2cap_pi(sk)->monitor_timer);
+		del_timer(&chan->monitor_timer);
 		if (chan->unacked_frames > 0)
 			__mod_retrans_timer();
 		chan->conn_state &= ~L2CAP_CONN_WAIT_F;
@@ -3573,7 +3571,7 @@ static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 		len -= 2;
 
 	if (len > pi->mps) {
-		l2cap_send_disconn_req(pi->conn, sk, ECONNRESET);
+		l2cap_send_disconn_req(pi->conn, chan, ECONNRESET);
 		goto drop;
 	}
 
@@ -3589,13 +3587,13 @@ static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 
 	/* check for invalid req-seq */
 	if (req_seq_offset > next_tx_seq_offset) {
-		l2cap_send_disconn_req(pi->conn, sk, ECONNRESET);
+		l2cap_send_disconn_req(pi->conn, chan, ECONNRESET);
 		goto drop;
 	}
 
 	if (__is_iframe(control)) {
 		if (len < 0) {
-			l2cap_send_disconn_req(pi->conn, sk, ECONNRESET);
+			l2cap_send_disconn_req(pi->conn, chan, ECONNRESET);
 			goto drop;
 		}
 
@@ -3603,7 +3601,7 @@ static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 	} else {
 		if (len != 0) {
 			BT_ERR("%d", len);
-			l2cap_send_disconn_req(pi->conn, sk, ECONNRESET);
+			l2cap_send_disconn_req(pi->conn, chan, ECONNRESET);
 			goto drop;
 		}
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index f90ca25..d66886f 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -866,6 +866,7 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 void __l2cap_sock_close(struct sock *sk, int reason)
 {
 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 
 	BT_DBG("sk %p state %d socket %p", sk, sk->sk_state, sk->sk_socket);
 
@@ -880,9 +881,9 @@ void __l2cap_sock_close(struct sock *sk, int reason)
 					sk->sk_type == SOCK_STREAM) &&
 					conn->hcon->type == ACL_LINK) {
 			l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
-			l2cap_send_disconn_req(conn, sk, reason);
+			l2cap_send_disconn_req(conn, chan, reason);
 		} else
-			l2cap_chan_del(l2cap_pi(sk)->chan, reason);
+			l2cap_chan_del(chan, reason);
 		break;
 
 	case BT_CONNECT2:
@@ -901,16 +902,16 @@ void __l2cap_sock_close(struct sock *sk, int reason)
 			rsp.dcid   = cpu_to_le16(l2cap_pi(sk)->scid);
 			rsp.result = cpu_to_le16(result);
 			rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
-			l2cap_send_cmd(conn, l2cap_pi(sk)->chan->ident,
-					L2CAP_CONN_RSP, sizeof(rsp), &rsp);
+			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP,
+							sizeof(rsp), &rsp);
 		}
 
-		l2cap_chan_del(l2cap_pi(sk)->chan, reason);
+		l2cap_chan_del(chan, reason);
 		break;
 
 	case BT_CONNECT:
 	case BT_DISCONN:
-		l2cap_chan_del(l2cap_pi(sk)->chan, reason);
+		l2cap_chan_del(chan, reason);
 		break;
 
 	default:
-- 
1.7.4.1

