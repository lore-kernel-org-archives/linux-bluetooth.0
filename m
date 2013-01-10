Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 11/16] Bluetooth: remove parent socket usage from l2cap_core.c
Date: Thu, 10 Jan 2013 05:47:48 -0200
Message-Id: <1357804073-31582-12-git-send-email-gustavo@padovan.org>
In-Reply-To: <1357804073-31582-1-git-send-email-gustavo@padovan.org>
References: <1357804073-31582-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Since we do not touch the parent sock in l2cap_core.c anymore we don't
need to lock it there anymore. That lock was replaced by the
l2cap_chan_lock and inside the new_connection() call for l2cap_sock.c the
parent lock is locked, so the operations that uses it can be performed
safely.

The l2cap_chan_lock give us the needed protection to handle the incoming
connections.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c | 16 ++++------------
 net/bluetooth/l2cap_sock.c |  4 ++++
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2c4458a..6d62bfb 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1315,7 +1315,6 @@ static struct l2cap_chan *l2cap_global_chan_by_scid(int state, u16 cid,
 
 static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 {
-	struct sock *parent;
 	struct l2cap_chan *chan, *pchan;
 
 	BT_DBG("");
@@ -1326,9 +1325,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	if (!pchan)
 		return;
 
-	parent = pchan->sk;
-
-	lock_sock(parent);
+	l2cap_chan_lock(pchan);
 
 	chan = pchan->ops->new_connection(pchan);
 	if (!chan)
@@ -1345,7 +1342,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	l2cap_chan_ready(chan);
 
 clean:
-	release_sock(parent);
+	l2cap_chan_unlock(pchan);
 }
 
 static void l2cap_conn_ready(struct l2cap_conn *conn)
@@ -3562,7 +3559,6 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
 	struct l2cap_chan *chan = NULL, *pchan;
-	struct sock *parent, *sk = NULL;
 	int result, status = L2CAP_CS_NO_INFO;
 
 	u16 dcid = 0, scid = __le16_to_cpu(req->scid);
@@ -3577,10 +3573,8 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 		goto sendresp;
 	}
 
-	parent = pchan->sk;
-
 	mutex_lock(&conn->chan_lock);
-	lock_sock(parent);
+	l2cap_chan_lock(pchan);
 
 	/* Check if the ACL is secure enough (if not SDP) */
 	if (psm != __constant_cpu_to_le16(L2CAP_PSM_SDP) &&
@@ -3600,8 +3594,6 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 	if (!chan)
 		goto response;
 
-	sk = chan->sk;
-
 	hci_conn_hold(conn->hcon);
 
 	bacpy(&chan->src, conn->src);
@@ -3651,7 +3643,7 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 	}
 
 response:
-	release_sock(parent);
+	l2cap_chan_unlock(pchan);
 	mutex_unlock(&conn->chan_lock);
 
 sendresp:
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index cf8f187..3d76de8 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -943,6 +943,8 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk, *parent = chan->data;
 
+	lock_sock(parent);
+
 	/* Check for backlog size */
 	if (sk_acceptq_is_full(parent)) {
 		BT_DBG("backlog full %d", parent->sk_ack_backlog);
@@ -960,6 +962,8 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
 	bt_accept_enqueue(parent, sk);
 
+	release_sock(parent);
+
 	return l2cap_pi(sk)->chan;
 }
 
-- 
1.8.0.2

