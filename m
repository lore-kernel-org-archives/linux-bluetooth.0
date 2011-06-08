Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH -v2 7/8] Bluetooth: Make timer functions generic
Date: Wed,  8 Jun 2011 12:18:58 -0300
Message-Id: <1307546339-12035-8-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1307546339-12035-7-git-send-email-padovan@profusion.mobi>
References: <1307546339-12035-1-git-send-email-padovan@profusion.mobi>
 <1307546339-12035-2-git-send-email-padovan@profusion.mobi>
 <1307546339-12035-3-git-send-email-padovan@profusion.mobi>
 <1307546339-12035-4-git-send-email-padovan@profusion.mobi>
 <1307546339-12035-5-git-send-email-padovan@profusion.mobi>
 <1307546339-12035-6-git-send-email-padovan@profusion.mobi>
 <1307546339-12035-7-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We now plan to use l2cap_set_timer and l2cap_clear_timer in ERTM timers.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    2 +
 net/bluetooth/l2cap_core.c    |   58 ++++++++++++++++++++--------------------
 2 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index b3d953b..7aaf7f7 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -439,6 +439,8 @@ struct l2cap_pinfo {
 #define L2CAP_CONN_RNR_SENT        0x0200
 #define L2CAP_CONN_SAR_RETRY       0x0400
 
+#define __set_chan_timer(c, t) l2cap_set_timer(c, &c->chan_timer, (t))
+#define __clear_chan_timer(c) l2cap_clear_timer(c, &c->chan_timer)
 #define __mod_retrans_timer() mod_timer(&chan->retrans_timer, \
 		jiffies +  msecs_to_jiffies(L2CAP_DEFAULT_RETRANS_TO));
 #define __mod_monitor_timer() mod_timer(&chan->monitor_timer, \
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6ae5fe6..c6d008d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -220,19 +220,19 @@ static u16 l2cap_alloc_cid(struct l2cap_conn *conn)
 	return 0;
 }
 
-static void l2cap_chan_set_timer(struct l2cap_chan *chan, long timeout)
+static void l2cap_set_timer(struct l2cap_chan *chan, struct timer_list *timer, long timeout)
 {
        BT_DBG("chan %p state %d timeout %ld", chan->sk, chan->state, timeout);
 
-       if (!mod_timer(&chan->chan_timer, jiffies + timeout))
+       if (!mod_timer(timer, jiffies + timeout))
 	       chan_hold(chan);
 }
 
-static void l2cap_chan_clear_timer(struct l2cap_chan *chan)
+static void l2cap_clear_timer(struct l2cap_chan *chan, struct timer_list *timer)
 {
        BT_DBG("chan %p state %d", chan, chan->state);
 
-       if (timer_pending(&chan->chan_timer) && del_timer(&chan->chan_timer))
+       if (timer_pending(timer) && del_timer(timer))
 	       chan_put(chan);
 }
 
@@ -254,7 +254,7 @@ static void l2cap_chan_timeout(unsigned long arg)
 
 	if (sock_owned_by_user(sk)) {
 		/* sk is owned by user. Try again later */
-		l2cap_chan_set_timer(chan, HZ / 5);
+		__set_chan_timer(chan, HZ / 5);
 		bh_unlock_sock(sk);
 		chan_put(chan);
 		return;
@@ -353,7 +353,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	struct l2cap_conn *conn = chan->conn;
 	struct sock *parent = bt_sk(sk)->parent;
 
-	l2cap_chan_clear_timer(chan);
+	__clear_chan_timer(chan);
 
 	BT_DBG("chan %p, conn %p, err %d", chan, conn, err);
 
@@ -412,7 +412,7 @@ static void l2cap_chan_cleanup_listen(struct sock *parent)
 	/* Close not yet accepted channels */
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
 		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-		l2cap_chan_clear_timer(chan);
+		__clear_chan_timer(chan);
 		lock_sock(sk);
 		l2cap_chan_close(chan, ECONNRESET);
 		release_sock(sk);
@@ -439,8 +439,8 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 	case BT_CONFIG:
 		if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED &&
 					conn->hcon->type == ACL_LINK) {
-			l2cap_chan_clear_timer(chan);
-			l2cap_chan_set_timer(chan, sk->sk_sndtimeo);
+			__clear_chan_timer(chan);
+			__set_chan_timer(chan, sk->sk_sndtimeo);
 			l2cap_send_disconn_req(conn, chan, reason);
 		} else
 			l2cap_chan_del(chan, reason);
@@ -878,7 +878,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 
 	__l2cap_chan_add(conn, chan);
 
-	l2cap_chan_set_timer(chan, sk->sk_sndtimeo);
+	__set_chan_timer(chan, sk->sk_sndtimeo);
 
 	l2cap_state_change(chan, BT_CONNECTED);
 	parent->sk_data_ready(parent, 0);
@@ -906,13 +906,13 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 		bh_lock_sock(sk);
 
 		if (conn->hcon->type == LE_LINK) {
-			l2cap_chan_clear_timer(chan);
+			__clear_chan_timer(chan);
 			l2cap_state_change(chan, BT_CONNECTED);
 			sk->sk_state_change(sk);
 		}
 
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
-			l2cap_chan_clear_timer(chan);
+			__clear_chan_timer(chan);
 			l2cap_state_change(chan, BT_CONNECTED);
 			sk->sk_state_change(sk);
 		} else if (chan->state == BT_CONNECT)
@@ -1111,11 +1111,11 @@ int l2cap_chan_connect(struct l2cap_chan *chan)
 	l2cap_chan_add(conn, chan);
 
 	l2cap_state_change(chan, BT_CONNECT);
-	l2cap_chan_set_timer(chan, sk->sk_sndtimeo);
+	__set_chan_timer(chan, sk->sk_sndtimeo);
 
 	if (hcon->state == BT_CONNECTED) {
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
-			l2cap_chan_clear_timer(chan);
+			__clear_chan_timer(chan);
 			if (l2cap_check_security(chan))
 				l2cap_state_change(chan, BT_CONNECTED);
 		} else
@@ -1679,7 +1679,7 @@ static void l2cap_chan_ready(struct sock *sk)
 	BT_DBG("sk %p, parent %p", sk, parent);
 
 	chan->conf_state = 0;
-	l2cap_chan_clear_timer(chan);
+	__clear_chan_timer(chan);
 
 	if (!parent) {
 		/* Outgoing channel.
@@ -2374,7 +2374,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	dcid = chan->scid;
 
-	l2cap_chan_set_timer(chan, sk->sk_sndtimeo);
+	__set_chan_timer(chan, sk->sk_sndtimeo);
 
 	chan->ident = cmd->ident;
 
@@ -2491,8 +2491,8 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		/* don't delete l2cap channel if sk is owned by user */
 		if (sock_owned_by_user(sk)) {
 			l2cap_state_change(chan, BT_DISCONN);
-			l2cap_chan_clear_timer(chan);
-			l2cap_chan_set_timer(chan, HZ / 5);
+			__clear_chan_timer(chan);
+			__set_chan_timer(chan, HZ / 5);
 			break;
 		}
 
@@ -2665,7 +2665,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 	default:
 		sk->sk_err = ECONNRESET;
-		l2cap_chan_set_timer(chan, HZ * 5);
+		__set_chan_timer(chan, HZ * 5);
 		l2cap_send_disconn_req(conn, chan, ECONNRESET);
 		goto done;
 	}
@@ -2721,8 +2721,8 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 	/* don't delete l2cap channel if sk is owned by user */
 	if (sock_owned_by_user(sk)) {
 		l2cap_state_change(chan, BT_DISCONN);
-		l2cap_chan_clear_timer(chan);
-		l2cap_chan_set_timer(chan, HZ / 5);
+		__clear_chan_timer(chan);
+		__set_chan_timer(chan, HZ / 5);
 		bh_unlock_sock(sk);
 		return 0;
 	}
@@ -2755,8 +2755,8 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 	/* don't delete l2cap channel if sk is owned by user */
 	if (sock_owned_by_user(sk)) {
 		l2cap_state_change(chan,BT_DISCONN);
-		l2cap_chan_clear_timer(chan);
-		l2cap_chan_set_timer(chan, HZ / 5);
+		__clear_chan_timer(chan);
+		__set_chan_timer(chan, HZ / 5);
 		bh_unlock_sock(sk);
 		return 0;
 	}
@@ -4152,13 +4152,13 @@ static inline void l2cap_check_encryption(struct l2cap_chan *chan, u8 encrypt)
 
 	if (encrypt == 0x00) {
 		if (chan->sec_level == BT_SECURITY_MEDIUM) {
-			l2cap_chan_clear_timer(chan);
-			l2cap_chan_set_timer(chan, HZ * 5);
+			__clear_chan_timer(chan);
+			__set_chan_timer(chan, HZ * 5);
 		} else if (chan->sec_level == BT_SECURITY_HIGH)
 			l2cap_chan_close(chan, ECONNREFUSED);
 	} else {
 		if (chan->sec_level == BT_SECURITY_MEDIUM)
-			l2cap_chan_clear_timer(chan);
+			__clear_chan_timer(chan);
 	}
 }
 
@@ -4203,8 +4203,8 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 				l2cap_send_cmd(conn, chan->ident,
 					L2CAP_CONN_REQ, sizeof(req), &req);
 			} else {
-				l2cap_chan_clear_timer(chan);
-				l2cap_chan_set_timer(chan, HZ / 10);
+				__clear_chan_timer(chan);
+				__set_chan_timer(chan, HZ / 10);
 			}
 		} else if (chan->state == BT_CONNECT2) {
 			struct l2cap_conn_rsp rsp;
@@ -4215,7 +4215,7 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 				result = L2CAP_CR_SUCCESS;
 			} else {
 				l2cap_state_change(chan, BT_DISCONN);
-				l2cap_chan_set_timer(chan, HZ / 10);
+				__set_chan_timer(chan, HZ / 10);
 				result = L2CAP_CR_SEC_BLOCK;
 			}
 
-- 
1.7.5.1

