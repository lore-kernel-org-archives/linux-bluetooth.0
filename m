Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 3/8] Bluetooth: Remove parent socket usage from l2cap_core.c
Date: Mon,  8 Oct 2012 07:19:36 +0800
Message-Id: <1349651981-6251-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1349651981-6251-1-git-send-email-gustavo@padovan.org>
References: <1349651981-6251-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

We can lock the parent lock only inside the new_connection() call,
then we just use the l2cap_chan_lock() in core code.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c | 16 ++++++----------
 net/bluetooth/l2cap_sock.c |  9 ++++++++-
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fc10d23..9e166ce 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1206,7 +1206,7 @@ static struct l2cap_chan *l2cap_global_chan_by_scid(int state, u16 cid,
 
 static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 {
-	struct sock *parent, *sk;
+	struct sock *sk;
 	struct l2cap_chan *chan, *pchan;
 
 	BT_DBG("");
@@ -1217,9 +1217,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	if (!pchan)
 		return;
 
-	parent = pchan->sk;
-
-	lock_sock(parent);
+	l2cap_chan_lock(pchan);
 
 	chan = pchan->ops->new_connection(pchan);
 	if (!chan)
@@ -1238,7 +1236,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	l2cap_chan_ready(chan);
 
 clean:
-	release_sock(parent);
+	l2cap_chan_unlock(pchan);
 }
 
 static void l2cap_conn_ready(struct l2cap_conn *conn)
@@ -3402,7 +3400,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn,
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
 	struct l2cap_chan *chan = NULL, *pchan;
-	struct sock *parent, *sk = NULL;
+	struct sock *sk = NULL;
 	int result, status = L2CAP_CS_NO_INFO;
 
 	u16 dcid = 0, scid = __le16_to_cpu(req->scid);
@@ -3417,10 +3415,8 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn,
 		goto sendresp;
 	}
 
-	parent = pchan->sk;
-
 	mutex_lock(&conn->chan_lock);
-	lock_sock(parent);
+	l2cap_chan_lock(pchan);
 
 	/* Check if the ACL is secure enough (if not SDP) */
 	if (psm != __constant_cpu_to_le16(L2CAP_PSM_SDP) &&
@@ -3481,7 +3477,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn,
 	}
 
 response:
-	release_sock(parent);
+	l2cap_chan_unlock(pchan);
 	mutex_unlock(&conn->chan_lock);
 
 sendresp:
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 50c38e0..0feb8f8 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -933,16 +933,21 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk, *parent = chan->data;
 
+	lock_sock(parent);
+
 	/* Check for backlog size */
 	if (sk_acceptq_is_full(parent)) {
 		BT_DBG("backlog full %d", parent->sk_ack_backlog);
+		release_sock(parent);
 		return NULL;
 	}
 
 	sk = l2cap_sock_alloc(sock_net(parent), NULL, BTPROTO_L2CAP,
 			      GFP_ATOMIC);
-	if (!sk)
+	if (!sk) {
+		release_sock(parent);
 		return NULL;
+	}
 
 	bt_sock_reclassify_lock(sk, BTPROTO_L2CAP);
 
@@ -950,6 +955,8 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
 	bt_accept_enqueue(parent, sk);
 
+	release_sock(parent);
+
 	return l2cap_pi(sk)->chan;
 }
 
-- 
1.7.11.4

