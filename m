Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 1/5] Bluetooth: Move bt_accept_enqueue() call to l2cap_sock.c
Date: Mon, 28 May 2012 18:16:19 -0300
Message-Id: <1338239783-26599-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

bt_accept_enqueue() can be easily placed at the end of
l2cap_sock_new_connection_cb().
There is no problem in moving to bt_accept_enqueue() to an earlier point
in the code, bt_accept_enqueue() only adds the sk to the it parents queue
basically.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c |    4 ----
 net/bluetooth/l2cap_sock.c |    2 ++
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6f30d1d..09f4bee 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1167,8 +1167,6 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	bacpy(&bt_sk(sk)->src, conn->src);
 	bacpy(&bt_sk(sk)->dst, conn->dst);
 
-	bt_accept_enqueue(parent, sk);
-
 	l2cap_chan_add(conn, chan);
 
 	l2cap_chan_ready(chan);
@@ -3360,8 +3358,6 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	chan->psm  = psm;
 	chan->dcid = scid;
 
-	bt_accept_enqueue(parent, sk);
-
 	__l2cap_chan_add(conn, chan);
 
 	dcid = chan->scid;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index d856cc8..942986e 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -910,6 +910,8 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
 	l2cap_sock_init(sk, parent);
 
+	bt_accept_enqueue(parent, sk);
+
 	return l2cap_pi(sk)->chan;
 }
 
-- 
1.7.10.2

