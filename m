Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv4 09/16] Bluetooth: Use chan lock in L2CAP sig commands
Date: Fri, 10 Feb 2012 15:55:06 +0200
Message-Id: <1328882113-19810-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1328882113-19810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328882113-19810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Convert sk lock to chan lock for L2CAP signalling commands.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   85 +++++++++++++++++++++++++++++---------------
 1 files changed, 56 insertions(+), 29 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c8cac0e..94938f0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -739,6 +739,7 @@ static inline int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
 
 static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *chan, int err)
 {
+	struct sock *sk = chan->sk;
 	struct l2cap_disconn_req req;
 
 	if (!conn)
@@ -755,8 +756,10 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
 	l2cap_send_cmd(conn, l2cap_get_ident(conn),
 			L2CAP_DISCONN_REQ, sizeof(req), &req);
 
+	lock_sock(sk);
 	__l2cap_state_change(chan, BT_DISCONN);
 	__l2cap_chan_set_err(chan, err);
+	release_sock(sk);
 }
 
 /* ---- L2CAP connections ---- */
@@ -2646,6 +2649,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	parent = pchan->sk;
 
+	mutex_lock(&conn->chan_lock);
 	lock_sock(parent);
 
 	/* Check if the ACL is secure enough (if not SDP) */
@@ -2686,7 +2690,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	bt_accept_enqueue(parent, sk);
 
-	l2cap_chan_add(conn, chan);
+	__l2cap_chan_add(conn, chan);
 
 	dcid = chan->scid;
 
@@ -2719,6 +2723,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 response:
 	release_sock(parent);
+	mutex_unlock(&conn->chan_lock);
 
 sendresp:
 	rsp.scid   = cpu_to_le16(scid);
@@ -2760,6 +2765,7 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	struct l2cap_chan *chan;
 	struct sock *sk;
 	u8 req[128];
+	int err;
 
 	scid   = __le16_to_cpu(rsp->scid);
 	dcid   = __le16_to_cpu(rsp->dcid);
@@ -2769,18 +2775,27 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
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
+	l2cap_chan_lock(chan);
+
 	sk = chan->sk;
-	lock_sock(sk);
 
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
@@ -2806,8 +2821,11 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		break;
 	}
 
-	release_sock(sk);
-	return 0;
+	l2cap_chan_unlock(chan);
+unlock:
+	mutex_unlock(&conn->chan_lock);
+
+	return err;
 }
 
 static inline void set_default_fcs(struct l2cap_chan *chan)
@@ -2827,7 +2845,6 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	u16 dcid, flags;
 	u8 rsp[64];
 	struct l2cap_chan *chan;
-	struct sock *sk;
 	int len;
 
 	dcid  = __le16_to_cpu(req->dcid);
@@ -2839,8 +2856,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	if (!chan)
 		return -ENOENT;
 
-	sk = chan->sk;
-	lock_sock(sk);
+	l2cap_chan_lock(chan);
 
 	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2) {
 		struct l2cap_cmd_rej_cid rej;
@@ -2929,7 +2945,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	}
 
 unlock:
-	release_sock(sk);
+	l2cap_chan_unlock(chan);
 	return 0;
 }
 
@@ -2938,7 +2954,6 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	struct l2cap_conf_rsp *rsp = (struct l2cap_conf_rsp *)data;
 	u16 scid, flags, result;
 	struct l2cap_chan *chan;
-	struct sock *sk;
 	int len = cmd->len - sizeof(*rsp);
 
 	scid   = __le16_to_cpu(rsp->scid);
@@ -2952,8 +2967,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	if (!chan)
 		return 0;
 
-	sk = chan->sk;
-	lock_sock(sk);
+	l2cap_chan_lock(chan);
 
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
@@ -3012,7 +3026,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		}
 
 	default:
-		__l2cap_chan_set_err(chan, ECONNRESET);
+		l2cap_chan_set_err(chan, ECONNRESET);
 
 		__set_chan_timer(chan,
 				msecs_to_jiffies(L2CAP_DISC_REJ_TIMEOUT));
@@ -3039,7 +3053,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	}
 
 done:
-	release_sock(sk);
+	l2cap_chan_unlock(chan);
 	return 0;
 }
 
@@ -3056,21 +3070,30 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 
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
+	mutex_unlock(&conn->chan_lock);
 
 	chan->ops->close(chan->data);
 	return 0;
@@ -3081,22 +3104,26 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
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
 
-	sk = chan->sk;
-	lock_sock(sk);
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

