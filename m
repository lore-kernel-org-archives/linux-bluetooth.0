Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv5 03/16] Bluetooth: Lock chan list when deleting chan
Date: Fri, 17 Feb 2012 15:43:59 +0200
Message-Id: <1329486252-25252-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1329486252-25252-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329486252-25252-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Locks conn->chan_lock when dealing with chan_del
and chan_close. Use unlocked version of get_chan
inside locked region.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   54 +++++++++++++++++++++++++++++++++++---------
 net/bluetooth/l2cap_sock.c |   10 ++++++++
 2 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 109b62d..18a9742 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -214,11 +214,13 @@ static void l2cap_chan_timeout(struct work_struct *work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
 							chan_timer.work);
+	struct l2cap_conn *conn = chan->conn;
 	struct sock *sk = chan->sk;
 	int reason;
 
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
+	mutex_lock(&conn->chan_lock);
 	lock_sock(sk);
 
 	if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
@@ -234,6 +236,8 @@ static void l2cap_chan_timeout(struct work_struct *work)
 	release_sock(sk);
 
 	chan->ops->close(chan->data);
+	mutex_unlock(&conn->chan_lock);
+
 	l2cap_chan_put(chan);
 }
 
@@ -2594,6 +2598,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	parent = pchan->sk;
 
+	mutex_lock(&conn->chan_lock);
 	lock_sock(parent);
 
 	/* Check if the ACL is secure enough (if not SDP) */
@@ -2667,6 +2672,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 response:
 	release_sock(parent);
+	mutex_unlock(&conn->chan_lock);
 
 sendresp:
 	rsp.scid   = cpu_to_le16(scid);
@@ -2708,6 +2714,7 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	struct l2cap_chan *chan;
 	struct sock *sk;
 	u8 req[128];
+	int err;
 
 	scid   = __le16_to_cpu(rsp->scid);
 	dcid   = __le16_to_cpu(rsp->dcid);
@@ -2717,16 +2724,24 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	BT_DBG("dcid 0x%4.4x scid 0x%4.4x result 0x%2.2x status 0x%2.2x",
 						dcid, scid, result, status);
 
+	mutex_lock(&conn->chan_lock);
+
 	if (scid) {
-		chan = l2cap_get_chan_by_scid(conn, scid);
-		if (!chan)
-			return -EFAULT;
+		chan = __l2cap_get_chan_by_scid(conn, scid);
+		if (!chan) {
+			err = -EFAULT;
+			goto unlock;
+		}
 	} else {
-		chan = l2cap_get_chan_by_ident(conn, cmd->ident);
-		if (!chan)
-			return -EFAULT;
+		chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
+		if (!chan) {
+			err = -EFAULT;
+			goto unlock;
+		}
 	}
 
+	err = 0;
+
 	sk = chan->sk;
 
 	switch (result) {
@@ -2754,7 +2769,10 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	}
 
 	release_sock(sk);
-	return 0;
+unlock:
+	mutex_unlock(&conn->chan_lock);
+
+	return err;
 }
 
 static inline void set_default_fcs(struct l2cap_chan *chan)
@@ -3000,9 +3018,13 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 
 	BT_DBG("scid 0x%4.4x dcid 0x%4.4x", scid, dcid);
 
-	chan = l2cap_get_chan_by_scid(conn, dcid);
-	if (!chan)
+	mutex_lock(&conn->chan_lock);
+
+	chan = __l2cap_get_chan_by_scid(conn, dcid);
+	if (!chan) {
+		mutex_unlock(&conn->chan_lock);
 		return 0;
+	}
 
 	sk = chan->sk;
 
@@ -3016,6 +3038,9 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 	release_sock(sk);
 
 	chan->ops->close(chan->data);
+
+	mutex_unlock(&conn->chan_lock);
+
 	return 0;
 }
 
@@ -3031,9 +3056,13 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 
 	BT_DBG("dcid 0x%4.4x scid 0x%4.4x", dcid, scid);
 
-	chan = l2cap_get_chan_by_scid(conn, scid);
-	if (!chan)
+	mutex_lock(&conn->chan_lock);
+
+	chan = __l2cap_get_chan_by_scid(conn, scid);
+	if (!chan) {
+		mutex_unlock(&conn->chan_lock);
 		return 0;
+	}
 
 	sk = chan->sk;
 
@@ -3041,6 +3070,9 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 	release_sock(sk);
 
 	chan->ops->close(chan->data);
+
+	mutex_unlock(&conn->chan_lock);
+
 	return 0;
 }
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index b48d6c1..1273fcb 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -796,6 +796,7 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 {
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan;
+	struct l2cap_conn *conn;
 	int err = 0;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
@@ -804,6 +805,10 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 		return 0;
 
 	chan = l2cap_pi(sk)->chan;
+	conn = chan->conn;
+
+	if (conn)
+		mutex_lock(&conn->chan_lock);
 
 	lock_sock(sk);
 	if (!sk->sk_shutdown) {
@@ -811,6 +816,7 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 			err = __l2cap_wait_ack(sk);
 
 		sk->sk_shutdown = SHUTDOWN_MASK;
+
 		l2cap_chan_close(chan, 0);
 
 		if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime)
@@ -822,6 +828,10 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 		err = -sk->sk_err;
 
 	release_sock(sk);
+
+	if (conn)
+		mutex_unlock(&conn->chan_lock);
+
 	return err;
 }
 
-- 
1.7.9

