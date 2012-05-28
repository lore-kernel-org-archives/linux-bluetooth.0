Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 2/5] Bluetooth: Remove parent socket usage from l2cap_core.c
Date: Mon, 28 May 2012 18:16:20 -0300
Message-Id: <1338239783-26599-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1338239783-26599-1-git-send-email-gustavo@padovan.org>
References: <1338239783-26599-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

We can lock the parent lock only inside the new_connection() call, then we
just use the l2cap_chan_lock() in core code.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c |   16 ++++++----------
 net/bluetooth/l2cap_sock.c |    9 ++++++++-
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 09f4bee..4a4367f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1141,7 +1141,7 @@ static struct l2cap_chan *l2cap_global_chan_by_scid(int state, u16 cid,
 
 static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 {
-	struct sock *parent, *sk;
+	struct sock *sk;
 	struct l2cap_chan *chan, *pchan;
 
 	BT_DBG("");
@@ -1152,9 +1152,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	if (!pchan)
 		return;
 
-	parent = pchan->sk;
-
-	lock_sock(parent);
+	l2cap_chan_lock(pchan);
 
 	chan = pchan->ops->new_connection(pchan);
 	if (!chan)
@@ -1172,7 +1170,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	l2cap_chan_ready(chan);
 
 clean:
-	release_sock(parent);
+	l2cap_chan_unlock(pchan);
 }
 
 static void l2cap_conn_ready(struct l2cap_conn *conn)
@@ -3311,7 +3309,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
 	struct l2cap_chan *chan = NULL, *pchan;
-	struct sock *parent, *sk = NULL;
+	struct sock *sk = NULL;
 	int result, status = L2CAP_CS_NO_INFO;
 
 	u16 dcid = 0, scid = __le16_to_cpu(req->scid);
@@ -3326,10 +3324,8 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		goto sendresp;
 	}
 
-	parent = pchan->sk;
-
 	mutex_lock(&conn->chan_lock);
-	lock_sock(parent);
+	l2cap_chan_lock(pchan);
 
 	/* Check if the ACL is secure enough (if not SDP) */
 	if (psm != __constant_cpu_to_le16(L2CAP_PSM_SDP) &&
@@ -3390,7 +3386,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	}
 
 response:
-	release_sock(parent);
+	l2cap_chan_unlock(pchan);
 	mutex_unlock(&conn->chan_lock);
 
 sendresp:
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 942986e..719fb57 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -895,16 +895,21 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
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
 
@@ -912,6 +917,8 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
 	bt_accept_enqueue(parent, sk);
 
+	release_sock(parent);
+
 	return l2cap_pi(sk)->chan;
 }
 
-- 
1.7.10.2

