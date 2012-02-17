Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv5 10/16] Bluetooth: Use chan lock in L2CAP sig commands
Date: Fri, 17 Feb 2012 15:44:06 +0200
Message-Id: <1329486252-25252-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1329486252-25252-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329486252-25252-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Convert sk lock to chan lock for L2CAP signalling commands.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   61 +++++++++++++++++++++++++------------------
 net/bluetooth/l2cap_sock.c |    7 +++-
 2 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 727a1dd..a36b2c3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -377,6 +377,8 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		hci_conn_put(conn->hcon);
 	}
 
+	lock_sock(sk);
+
 	__l2cap_state_change(chan, BT_CLOSED);
 	sock_set_flag(sk, SOCK_ZAPPED);
 
@@ -389,6 +391,8 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	} else
 		sk->sk_state_change(sk);
 
+	release_sock(sk);
+
 	if (!(test_bit(CONF_OUTPUT_DONE, &chan->conf_state) &&
 			test_bit(CONF_INPUT_DONE, &chan->conf_state)))
 		return;
@@ -421,10 +425,10 @@ static void l2cap_chan_cleanup_listen(struct sock *parent)
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
 		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 
+		l2cap_chan_lock(chan);
 		__clear_chan_timer(chan);
-		lock_sock(sk);
 		l2cap_chan_close(chan, ECONNRESET);
-		release_sock(sk);
+		l2cap_chan_unlock(chan);
 
 		chan->ops->close(chan->data);
 	}
@@ -440,10 +444,12 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 
 	switch (chan->state) {
 	case BT_LISTEN:
+		lock_sock(sk);
 		l2cap_chan_cleanup_listen(sk);
 
 		__l2cap_state_change(chan, BT_CLOSED);
 		sock_set_flag(sk, SOCK_ZAPPED);
+		release_sock(sk);
 		break;
 
 	case BT_CONNECTED:
@@ -486,7 +492,9 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 		break;
 
 	default:
+		lock_sock(sk);
 		sock_set_flag(sk, SOCK_ZAPPED);
+		release_sock(sk);
 		break;
 	}
 }
@@ -714,6 +722,7 @@ static inline int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
 
 static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *chan, int err)
 {
+	struct sock *sk = chan->sk;
 	struct l2cap_disconn_req req;
 
 	if (!conn)
@@ -730,8 +739,10 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
 	l2cap_send_cmd(conn, l2cap_get_ident(conn),
 			L2CAP_DISCONN_REQ, sizeof(req), &req);
 
+	lock_sock(sk);
 	__l2cap_state_change(chan, BT_DISCONN);
 	__l2cap_chan_set_err(chan, err);
+	release_sock(sk);
 }
 
 /* ---- L2CAP connections ---- */
@@ -992,7 +1003,6 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
 	struct l2cap_chan *chan, *l;
-	struct sock *sk;
 
 	if (!conn)
 		return;
@@ -1005,10 +1015,12 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	/* Kill channels */
 	list_for_each_entry_safe(chan, l, &conn->chan_l, list) {
-		sk = chan->sk;
-		lock_sock(sk);
+		l2cap_chan_lock(chan);
+
 		l2cap_chan_del(chan, err);
-		release_sock(sk);
+
+		l2cap_chan_unlock(chan);
+
 		chan->ops->close(chan->data);
 	}
 
@@ -2666,7 +2678,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	bt_accept_enqueue(parent, sk);
 
-	l2cap_chan_add(conn, chan);
+	__l2cap_chan_add(conn, chan);
 
 	dcid = chan->scid;
 
@@ -2739,7 +2751,6 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	struct l2cap_conn_rsp *rsp = (struct l2cap_conn_rsp *) data;
 	u16 scid, dcid, result, status;
 	struct l2cap_chan *chan;
-	struct sock *sk;
 	u8 req[128];
 	int err;
 
@@ -2769,8 +2780,7 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	err = 0;
 
-	sk = chan->sk;
-	lock_sock(sk);
+	l2cap_chan_lock(chan);
 
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
@@ -2796,7 +2806,7 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		break;
 	}
 
-	release_sock(sk);
+	l2cap_chan_unlock(chan);
 unlock:
 	mutex_unlock(&conn->chan_lock);
 
@@ -2820,7 +2830,6 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	u16 dcid, flags;
 	u8 rsp[64];
 	struct l2cap_chan *chan;
-	struct sock *sk;
 	int len;
 
 	dcid  = __le16_to_cpu(req->dcid);
@@ -2832,8 +2841,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	if (!chan)
 		return -ENOENT;
 
-	sk = chan->sk;
-	lock_sock(sk);
+	l2cap_chan_lock(chan);
 
 	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2) {
 		struct l2cap_cmd_rej_cid rej;
@@ -2922,7 +2930,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	}
 
 unlock:
-	release_sock(sk);
+	l2cap_chan_unlock(chan);
 	return 0;
 }
 
@@ -2931,7 +2939,6 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	struct l2cap_conf_rsp *rsp = (struct l2cap_conf_rsp *)data;
 	u16 scid, flags, result;
 	struct l2cap_chan *chan;
-	struct sock *sk;
 	int len = cmd->len - sizeof(*rsp);
 
 	scid   = __le16_to_cpu(rsp->scid);
@@ -2945,8 +2952,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	if (!chan)
 		return 0;
 
-	sk = chan->sk;
-	lock_sock(sk);
+	l2cap_chan_lock(chan);
 
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
@@ -3005,7 +3011,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		}
 
 	default:
-		__l2cap_chan_set_err(chan, ECONNRESET);
+		l2cap_chan_set_err(chan, ECONNRESET);
 
 		__set_chan_timer(chan,
 				msecs_to_jiffies(L2CAP_DISC_REJ_TIMEOUT));
@@ -3032,7 +3038,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	}
 
 done:
-	release_sock(sk);
+	l2cap_chan_unlock(chan);
 	return 0;
 }
 
@@ -3057,17 +3063,21 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 		return 0;
 	}
 
+	l2cap_chan_lock(chan);
+
 	sk = chan->sk;
-	lock_sock(sk);
 
 	rsp.dcid = cpu_to_le16(chan->scid);
 	rsp.scid = cpu_to_le16(chan->dcid);
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_DISCONN_RSP, sizeof(rsp), &rsp);
 
+	lock_sock(sk);
 	sk->sk_shutdown = SHUTDOWN_MASK;
+	release_sock(sk);
 
 	l2cap_chan_del(chan, ECONNRESET);
-	release_sock(sk);
+
+	l2cap_chan_unlock(chan);
 
 	chan->ops->close(chan->data);
 
@@ -3081,7 +3091,6 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 	struct l2cap_disconn_rsp *rsp = (struct l2cap_disconn_rsp *) data;
 	u16 dcid, scid;
 	struct l2cap_chan *chan;
-	struct sock *sk;
 
 	scid = __le16_to_cpu(rsp->scid);
 	dcid = __le16_to_cpu(rsp->dcid);
@@ -3096,11 +3105,11 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 		return 0;
 	}
 
-	sk = chan->sk;
-	lock_sock(sk);
+	l2cap_chan_lock(chan);
 
 	l2cap_chan_del(chan, 0);
-	release_sock(sk);
+
+	l2cap_chan_unlock(chan);
 
 	chan->ops->close(chan->data);
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1273fcb..db38fae 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -809,15 +809,18 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 
 	if (conn)
 		mutex_lock(&conn->chan_lock);
-
+	l2cap_chan_lock(chan);
 	lock_sock(sk);
+
 	if (!sk->sk_shutdown) {
 		if (chan->mode == L2CAP_MODE_ERTM)
 			err = __l2cap_wait_ack(sk);
 
 		sk->sk_shutdown = SHUTDOWN_MASK;
 
+		release_sock(sk);
 		l2cap_chan_close(chan, 0);
+		lock_sock(sk);
 
 		if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime)
 			err = bt_sock_wait_state(sk, BT_CLOSED,
@@ -828,7 +831,7 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 		err = -sk->sk_err;
 
 	release_sock(sk);
-
+	l2cap_chan_unlock(chan);
 	if (conn)
 		mutex_unlock(&conn->chan_lock);
 
-- 
1.7.9

