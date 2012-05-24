Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 11/12] Bluetooth: Remove parent socket usage from l2cap_core.c
Date: Thu, 24 May 2012 20:05:41 -0300
Message-Id: <1337900742-31036-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1337900742-31036-1-git-send-email-gustavo@padovan.org>
References: <1337900389-30915-9-git-send-email-gustavo@padovan.org>
 <1337900742-31036-1-git-send-email-gustavo@padovan.org>
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
index 7946d5c..c38447b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1139,7 +1139,7 @@ static struct l2cap_chan *l2cap_global_chan_by_scid(int state, u16 cid,
 
 static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 {
-	struct sock *parent, *sk;
+	struct sock *sk;
 	struct l2cap_chan *chan, *pchan;
 
 	BT_DBG("");
@@ -1150,9 +1150,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	if (!pchan)
 		return;
 
-	parent = pchan->sk;
-
-	lock_sock(parent);
+	l2cap_chan_lock(pchan);
 
 	chan = pchan->ops->new_connection(pchan->data);
 	if (!chan)
@@ -1170,7 +1168,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	l2cap_chan_ready(chan);
 
 clean:
-	release_sock(parent);
+	l2cap_chan_unlock(pchan);
 }
 
 static void l2cap_conn_ready(struct l2cap_conn *conn)
@@ -3308,7 +3306,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
 	struct l2cap_chan *chan = NULL, *pchan;
-	struct sock *parent, *sk = NULL;
+	struct sock *sk = NULL;
 	int result, status = L2CAP_CS_NO_INFO;
 
 	u16 dcid = 0, scid = __le16_to_cpu(req->scid);
@@ -3323,10 +3321,8 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		goto sendresp;
 	}
 
-	parent = pchan->sk;
-
 	mutex_lock(&conn->chan_lock);
-	lock_sock(parent);
+	l2cap_chan_lock(pchan);
 
 	/* Check if the ACL is secure enough (if not SDP) */
 	if (psm != cpu_to_le16(0x0001) &&
@@ -3388,7 +3384,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	}
 
 response:
-	release_sock(parent);
+	l2cap_chan_unlock(pchan);
 	mutex_unlock(&conn->chan_lock);
 
 sendresp:
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1b6a675..22f1874 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -899,16 +899,21 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(void *data)
 {
 	struct sock *sk, *parent = data;
 
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
 
@@ -916,6 +921,8 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(void *data)
 
 	bt_accept_enqueue(parent, sk);
 
+	release_sock(parent);
+
 	return l2cap_pi(sk)->chan;
 }
 
-- 
1.7.10.1

