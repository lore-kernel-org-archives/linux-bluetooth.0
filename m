Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH -v2 5/7] Bluetooth: create channel timer to replace sk_timer
Date: Fri, 13 May 2011 16:20:48 -0300
Message-Id: <1305314450-25493-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1305314450-25493-5-git-send-email-padovan@profusion.mobi>
References: <1305314450-25493-1-git-send-email-padovan@profusion.mobi>
 <1305314450-25493-2-git-send-email-padovan@profusion.mobi>
 <1305314450-25493-3-git-send-email-padovan@profusion.mobi>
 <1305314450-25493-4-git-send-email-padovan@profusion.mobi>
 <1305314450-25493-5-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The new timer does not belong to struct sock, tought it still touch some
sock things, but this will be sorted out soon.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    5 +-
 net/bluetooth/l2cap_core.c    |  100 ++++++++++++++++++++++++++++++----------
 net/bluetooth/l2cap_sock.c    |   50 +--------------------
 3 files changed, 79 insertions(+), 76 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 094a7ac..efb1fc4 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -340,6 +340,7 @@ struct l2cap_chan {
 	__u8		remote_max_tx;
 	__u16		remote_mps;
 
+	struct timer_list	chan_timer;
 	struct timer_list	retrans_timer;
 	struct timer_list	monitor_timer;
 	struct timer_list	ack_timer;
@@ -457,12 +458,12 @@ int __l2cap_wait_ack(struct sock *sk);
 int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm);
 int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
 
-void l2cap_sock_set_timer(struct sock *sk, long timeout);
-void l2cap_sock_clear_timer(struct sock *sk);
 void l2cap_sock_kill(struct sock *sk);
 void l2cap_sock_init(struct sock *sk, struct sock *parent);
 struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 							int proto, gfp_t prio);
+
+void l2cap_chan_clear_timer(struct l2cap_chan *chan);
 struct l2cap_chan *l2cap_chan_create(struct sock *sk);
 void __l2cap_chan_close(struct l2cap_chan *chan, int reason);
 void l2cap_chan_destroy(struct l2cap_chan *chan);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0964854..afd648e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -208,6 +208,56 @@ static u16 l2cap_alloc_cid(struct l2cap_conn *conn)
 	return 0;
 }
 
+static void l2cap_chan_set_timer(struct l2cap_chan *chan, long timeout)
+{
+       BT_DBG("chan %p state %d timeout %ld", chan->sk, chan->sk->sk_state,
+								 timeout);
+       if (!mod_timer(&chan->chan_timer, jiffies + timeout))
+	       sock_hold(chan->sk);
+}
+
+void l2cap_chan_clear_timer(struct l2cap_chan *chan)
+{
+       BT_DBG("chan %p state %d", chan, chan->sk->sk_state);
+
+       if (timer_pending(&chan->chan_timer) && del_timer(&chan->chan_timer))
+	       __sock_put(chan->sk);
+}
+
+static void l2cap_chan_timeout(unsigned long arg)
+{
+	struct l2cap_chan *chan = (struct l2cap_chan *) arg;
+	struct sock *sk = chan->sk;
+	int reason;
+
+	BT_DBG("chan %p state %d", chan, sk->sk_state);
+
+	bh_lock_sock(sk);
+
+	if (sock_owned_by_user(sk)) {
+		/* sk is owned by user. Try again later */
+		l2cap_chan_set_timer(chan, HZ / 5);
+		bh_unlock_sock(sk);
+		sock_put(sk);
+		return;
+	}
+
+	if (sk->sk_state == BT_CONNECTED || sk->sk_state == BT_CONFIG)
+		reason = ECONNREFUSED;
+	else if (sk->sk_state == BT_CONNECT &&
+					chan->sec_level != BT_SECURITY_SDP)
+		reason = ECONNREFUSED;
+	else
+		reason = ETIMEDOUT;
+
+	__l2cap_chan_close(chan, reason);
+
+	bh_unlock_sock(sk);
+
+	l2cap_sock_kill(sk);
+	sock_put(sk);
+}
+
 struct l2cap_chan *l2cap_chan_create(struct sock *sk)
 {
 	struct l2cap_chan *chan;
@@ -222,6 +272,8 @@ struct l2cap_chan *l2cap_chan_create(struct sock *sk)
 	list_add(&chan->global_l, &chan_list);
 	write_unlock_bh(&chan_list_lock);
 
+	setup_timer(&chan->chan_timer, l2cap_chan_timeout, (unsigned long) chan);
+
 	return chan;
 }
 
@@ -281,7 +333,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	struct l2cap_conn *conn = chan->conn;
 	struct sock *parent = bt_sk(sk)->parent;
 
-	l2cap_sock_clear_timer(sk);
+	l2cap_chan_clear_timer(chan);
 
 	BT_DBG("chan %p, conn %p, err %d", chan, conn, err);
 
@@ -334,7 +386,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 /* Must be called on unlocked socket. */
 static void l2cap_chan_close(struct sock *sk)
 {
-	l2cap_sock_clear_timer(sk);
+	l2cap_chan_clear_timer(l2cap_pi(sk)->chan);
 	lock_sock(sk);
 	__l2cap_chan_close(l2cap_pi(sk)->chan, ECONNRESET);
 	release_sock(sk);
@@ -371,7 +423,7 @@ void __l2cap_chan_close(struct l2cap_chan *chan, int reason)
 	case BT_CONFIG:
 		if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED &&
 					conn->hcon->type == ACL_LINK) {
-			l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
+			l2cap_chan_set_timer(chan, sk->sk_sndtimeo);
 			l2cap_send_disconn_req(conn, chan, reason);
 		} else
 			l2cap_chan_del(chan, reason);
@@ -814,7 +866,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 
 	__l2cap_chan_add(conn, chan);
 
-	l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
+	l2cap_chan_set_timer(chan, sk->sk_sndtimeo);
 
 	sk->sk_state = BT_CONNECTED;
 	parent->sk_data_ready(parent, 0);
@@ -842,13 +894,13 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 		bh_lock_sock(sk);
 
 		if (conn->hcon->type == LE_LINK) {
-			l2cap_sock_clear_timer(sk);
+			l2cap_chan_clear_timer(chan);
 			sk->sk_state = BT_CONNECTED;
 			sk->sk_state_change(sk);
 		}
 
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
-			l2cap_sock_clear_timer(sk);
+			l2cap_chan_clear_timer(chan);
 			sk->sk_state = BT_CONNECTED;
 			sk->sk_state_change(sk);
 		} else if (sk->sk_state == BT_CONNECT)
@@ -1047,11 +1099,11 @@ int l2cap_chan_connect(struct l2cap_chan *chan)
 	l2cap_chan_add(conn, chan);
 
 	sk->sk_state = BT_CONNECT;
-	l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
+	l2cap_chan_set_timer(chan, sk->sk_sndtimeo);
 
 	if (hcon->state == BT_CONNECTED) {
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
-			l2cap_sock_clear_timer(sk);
+			l2cap_chan_clear_timer(chan);
 			if (l2cap_check_security(chan))
 				sk->sk_state = BT_CONNECTED;
 		} else
@@ -1615,7 +1667,7 @@ static void l2cap_chan_ready(struct sock *sk)
 	BT_DBG("sk %p, parent %p", sk, parent);
 
 	chan->conf_state = 0;
-	l2cap_sock_clear_timer(sk);
+	l2cap_chan_clear_timer(chan);
 
 	if (!parent) {
 		/* Outgoing channel.
@@ -2317,7 +2369,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	dcid = chan->scid;
 
-	l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
+	l2cap_chan_set_timer(chan, sk->sk_sndtimeo);
 
 	chan->ident = cmd->ident;
 
@@ -2434,8 +2486,8 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		/* don't delete l2cap channel if sk is owned by user */
 		if (sock_owned_by_user(sk)) {
 			sk->sk_state = BT_DISCONN;
-			l2cap_sock_clear_timer(sk);
-			l2cap_sock_set_timer(sk, HZ / 5);
+			l2cap_chan_clear_timer(chan);
+			l2cap_chan_set_timer(chan, HZ / 5);
 			break;
 		}
 
@@ -2608,7 +2660,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 	default:
 		sk->sk_err = ECONNRESET;
-		l2cap_sock_set_timer(sk, HZ * 5);
+		l2cap_chan_set_timer(chan, HZ * 5);
 		l2cap_send_disconn_req(conn, chan, ECONNRESET);
 		goto done;
 	}
@@ -2664,8 +2716,8 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 	/* don't delete l2cap channel if sk is owned by user */
 	if (sock_owned_by_user(sk)) {
 		sk->sk_state = BT_DISCONN;
-		l2cap_sock_clear_timer(sk);
-		l2cap_sock_set_timer(sk, HZ / 5);
+		l2cap_chan_clear_timer(chan);
+		l2cap_chan_set_timer(chan, HZ / 5);
 		bh_unlock_sock(sk);
 		return 0;
 	}
@@ -2698,8 +2750,8 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 	/* don't delete l2cap channel if sk is owned by user */
 	if (sock_owned_by_user(sk)) {
 		sk->sk_state = BT_DISCONN;
-		l2cap_sock_clear_timer(sk);
-		l2cap_sock_set_timer(sk, HZ / 5);
+		l2cap_chan_clear_timer(chan);
+		l2cap_chan_set_timer(chan, HZ / 5);
 		bh_unlock_sock(sk);
 		return 0;
 	}
@@ -4096,20 +4148,18 @@ static int l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
 
 static inline void l2cap_check_encryption(struct l2cap_chan *chan, u8 encrypt)
 {
-	struct sock *sk = chan->sk;
-
 	if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED)
 		return;
 
 	if (encrypt == 0x00) {
 		if (chan->sec_level == BT_SECURITY_MEDIUM) {
-			l2cap_sock_clear_timer(sk);
-			l2cap_sock_set_timer(sk, HZ * 5);
+			l2cap_chan_clear_timer(chan);
+			l2cap_chan_set_timer(chan, HZ * 5);
 		} else if (chan->sec_level == BT_SECURITY_HIGH)
 			__l2cap_chan_close(chan, ECONNREFUSED);
 	} else {
 		if (chan->sec_level == BT_SECURITY_MEDIUM)
-			l2cap_sock_clear_timer(sk);
+			l2cap_chan_clear_timer(chan);
 	}
 }
 
@@ -4154,8 +4204,8 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 				l2cap_send_cmd(conn, chan->ident,
 					L2CAP_CONN_REQ, sizeof(req), &req);
 			} else {
-				l2cap_sock_clear_timer(sk);
-				l2cap_sock_set_timer(sk, HZ / 10);
+				l2cap_chan_clear_timer(chan);
+				l2cap_chan_set_timer(chan, HZ / 10);
 			}
 		} else if (sk->sk_state == BT_CONNECT2) {
 			struct l2cap_conn_rsp rsp;
@@ -4166,7 +4216,7 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 				result = L2CAP_CR_SUCCESS;
 			} else {
 				sk->sk_state = BT_DISCONN;
-				l2cap_sock_set_timer(sk, HZ / 10);
+				l2cap_chan_set_timer(chan, HZ / 10);
 				result = L2CAP_CR_SEC_BLOCK;
 			}
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 6a80a96..14b686b 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -32,52 +32,6 @@
 
 static const struct proto_ops l2cap_sock_ops;
 
-/* ---- L2CAP timers ---- */
-static void l2cap_sock_timeout(unsigned long arg)
-{
-	struct sock *sk = (struct sock *) arg;
-	int reason;
-
-	BT_DBG("sock %p state %d", sk, sk->sk_state);
-
-	bh_lock_sock(sk);
-
-	if (sock_owned_by_user(sk)) {
-		/* sk is owned by user. Try again later */
-		l2cap_sock_set_timer(sk, HZ / 5);
-		bh_unlock_sock(sk);
-		sock_put(sk);
-		return;
-	}
-
-	if (sk->sk_state == BT_CONNECTED || sk->sk_state == BT_CONFIG)
-		reason = ECONNREFUSED;
-	else if (sk->sk_state == BT_CONNECT &&
-			l2cap_pi(sk)->chan->sec_level != BT_SECURITY_SDP)
-		reason = ECONNREFUSED;
-	else
-		reason = ETIMEDOUT;
-
-	__l2cap_chan_close(l2cap_pi(sk)->chan, reason);
-
-	bh_unlock_sock(sk);
-
-	l2cap_sock_kill(sk);
-	sock_put(sk);
-}
-
-void l2cap_sock_set_timer(struct sock *sk, long timeout)
-{
-	BT_DBG("sk %p state %d timeout %ld", sk, sk->sk_state, timeout);
-	sk_reset_timer(sk, &sk->sk_timer, jiffies + timeout);
-}
-
-void l2cap_sock_clear_timer(struct sock *sk)
-{
-	BT_DBG("sock %p state %d", sk, sk->sk_state);
-	sk_stop_timer(sk, &sk->sk_timer);
-}
-
 static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 {
 	struct sock *sk = sock->sk;
@@ -753,7 +707,7 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 			err = __l2cap_wait_ack(sk);
 
 		sk->sk_shutdown = SHUTDOWN_MASK;
-		l2cap_sock_clear_timer(sk);
+		l2cap_chan_clear_timer(chan);
 		__l2cap_chan_close(chan, 0);
 
 		if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime)
@@ -879,8 +833,6 @@ struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock, int proto, g
 	sk->sk_protocol = proto;
 	sk->sk_state = BT_OPEN;
 
-	setup_timer(&sk->sk_timer, l2cap_sock_timeout, (unsigned long) sk);
-
 	return sk;
 }
 
-- 
1.7.5.rc3

