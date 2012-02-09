Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 09/16] Bluetooth: Use chan lock in L2CAP sig commands
Date: Thu,  9 Feb 2012 16:17:30 +0200
Message-Id: <1328797057-26331-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Convert sk lock to chan lock for L2CAP signalling commands.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   76 +++++++++++++++++++++++++++++++-------------
 1 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index bcc1c1c..eb04405 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -737,6 +737,7 @@ static inline int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
 
 static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *chan, int err)
 {
+	struct sock *sk = chan->sk;
 	struct l2cap_disconn_req req;
 
 	if (!conn)
@@ -753,8 +754,10 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
 	l2cap_send_cmd(conn, l2cap_get_ident(conn),
 			L2CAP_DISCONN_REQ, sizeof(req), &req);
 
+	lock_sock(sk);
 	__l2cap_state_change(chan, BT_DISCONN);
 	__l2cap_set_sock_err(chan, err);
+	release_sock(sk);
 }
 
 /* ---- L2CAP connections ---- */
@@ -2644,6 +2647,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	parent = pchan->sk;
 
+	mutex_lock(&conn->chan_lock);
 	lock_sock(parent);
 
 	/* Check if the ACL is secure enough (if not SDP) */
@@ -2684,7 +2688,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	bt_accept_enqueue(parent, sk);
 
-	l2cap_chan_add(conn, chan);
+	__l2cap_chan_add(conn, chan);
 
 	dcid = chan->scid;
 
@@ -2717,6 +2721,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 response:
 	release_sock(parent);
+	mutex_unlock(&conn->chan_lock);
 
 sendresp:
 	rsp.scid   = cpu_to_le16(scid);
@@ -2758,6 +2763,7 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	struct l2cap_chan *chan;
 	struct sock *sk;
 	u8 req[128];
+	int err;
 
 	scid   = __le16_to_cpu(rsp->scid);
 	dcid   = __le16_to_cpu(rsp->dcid);
@@ -2767,17 +2773,26 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
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
 
-	mutex_lock(&conn->chan_lock);
+	err = 0;
+
+	l2cap_chan_lock(chan);
+
 	sk = chan->sk;
 
 	switch (result) {
@@ -2804,10 +2819,11 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		break;
 	}
 
-	release_sock(sk);
+	l2cap_chan_unlock(chan);
+unlock:
 	mutex_unlock(&conn->chan_lock);
 
-	return 0;
+	return err;
 }
 
 static inline void set_default_fcs(struct l2cap_chan *chan)
@@ -2839,6 +2855,8 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	if (!chan)
 		return -ENOENT;
 
+	l2cap_chan_lock(chan);
+
 	sk = chan->sk;
 
 	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2) {
@@ -2928,7 +2946,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	}
 
 unlock:
-	release_sock(sk);
+	l2cap_chan_unlock(chan);
 	return 0;
 }
 
@@ -2951,6 +2969,8 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	if (!chan)
 		return 0;
 
+	l2cap_chan_lock(chan);
+
 	sk = chan->sk;
 
 	switch (result) {
@@ -3037,7 +3057,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	}
 
 done:
-	release_sock(sk);
+	l2cap_chan_unlock(chan);
 	return 0;
 }
 
@@ -3054,21 +3074,29 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 
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
+
+	l2cap_chan_lock(chan);
 
-	mutex_lock(&conn->chan_lock);
 	sk = chan->sk;
 
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
 	mutex_unlock(&conn->chan_lock);
 
 	chan->ops->close(chan->data);
@@ -3080,22 +3108,26 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 	struct l2cap_disconn_rsp *rsp = (struct l2cap_disconn_rsp *) data;
 	u16 dcid, scid;
 	struct l2cap_chan *chan;
-	struct sock *sk;
 
 	scid = __le16_to_cpu(rsp->scid);
 	dcid = __le16_to_cpu(rsp->dcid);
 
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
 
-	mutex_lock(&conn->chan_lock);
-	sk = chan->sk;
+	l2cap_chan_lock(chan);
 
 	l2cap_chan_del(chan, 0);
-	release_sock(sk);
+
+	l2cap_chan_unlock(chan);
+	mutex_unlock(&conn->chan_lock);
 
 	chan->ops->close(chan->data);
 	return 0;
-- 
1.7.8.3

