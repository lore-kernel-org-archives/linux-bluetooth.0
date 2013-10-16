Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 4/7] Bluetooth: Remove parent socket usage from l2cap_core.c
Date: Wed, 16 Oct 2013 16:08:32 -0300
Message-Id: <1381950515-25256-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1381950515-25256-1-git-send-email-gustavo@padovan.org>
References: <1381950515-25256-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

The parent socket is not used inside the L2CAP core anymore. We only lock
it to indirect access through the new_connection() callback. The hold of
the socket lock was moved to the new_connection() callback.

Inside L2CAP core the channel lock is now used in l2cap_le_conn_ready()
and l2cap_conn_ready() to protect the execution of these two functions
during the handling of new incoming connections.

This change remove the socket lock usage from L2CAP core while keeping
the code safe against race conditions.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c | 14 ++++----------
 net/bluetooth/l2cap_sock.c |  4 ++++
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8c757c0..e30a53a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1361,7 +1361,6 @@ static struct l2cap_chan *l2cap_global_chan_by_scid(int state, u16 cid,
 
 static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 {
-	struct sock *parent;
 	struct l2cap_chan *chan, *pchan;
 
 	BT_DBG("");
@@ -1376,9 +1375,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	if (__l2cap_get_chan_by_dcid(conn, L2CAP_CID_ATT))
 		return;
 
-	parent = pchan->sk;
-
-	lock_sock(parent);
+	l2cap_chan_lock(pchan);
 
 	chan = pchan->ops->new_connection(pchan);
 	if (!chan)
@@ -1394,7 +1391,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	__l2cap_chan_add(conn, chan);
 
 clean:
-	release_sock(parent);
+	l2cap_chan_unlock(pchan);
 }
 
 static void l2cap_conn_ready(struct l2cap_conn *conn)
@@ -3697,7 +3694,6 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
 	struct l2cap_chan *chan = NULL, *pchan;
-	struct sock *parent;
 	int result, status = L2CAP_CS_NO_INFO;
 
 	u16 dcid = 0, scid = __le16_to_cpu(req->scid);
@@ -3713,10 +3709,8 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 		goto sendresp;
 	}
 
-	parent = pchan->sk;
-
 	mutex_lock(&conn->chan_lock);
-	lock_sock(parent);
+	l2cap_chan_lock(pchan);
 
 	/* Check if the ACL is secure enough (if not SDP) */
 	if (psm != __constant_cpu_to_le16(L2CAP_PSM_SDP) &&
@@ -3792,7 +3786,7 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 	}
 
 response:
-	release_sock(parent);
+	l2cap_chan_unlock(pchan);
 	mutex_unlock(&conn->chan_lock);
 
 sendresp:
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 347cc63..f5a7c66 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1019,6 +1019,8 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk, *parent = chan->data;
 
+	lock_sock(parent);
+
 	/* Check for backlog size */
 	if (sk_acceptq_is_full(parent)) {
 		BT_DBG("backlog full %d", parent->sk_ack_backlog);
@@ -1036,6 +1038,8 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
 	bt_accept_enqueue(parent, sk);
 
+	release_sock(parent);
+
 	return l2cap_pi(sk)->chan;
 }
 
-- 
1.8.3.1

