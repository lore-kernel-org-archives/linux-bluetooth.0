Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 2/8] Bluetooth: Move bt_accept_enqueue() to l2cap_sock.c
Date: Mon,  8 Oct 2012 07:19:35 +0800
Message-Id: <1349651981-6251-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1349651981-6251-1-git-send-email-gustavo@padovan.org>
References: <1349651981-6251-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

This is move the parent socket usage to l2cap_sock.c

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c | 4 ----
 net/bluetooth/l2cap_sock.c | 2 ++
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 787e30a..fc10d23 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1233,8 +1233,6 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	bacpy(&bt_sk(sk)->src, conn->src);
 	bacpy(&bt_sk(sk)->dst, conn->dst);
 
-	bt_accept_enqueue(parent, sk);
-
 	l2cap_chan_add(conn, chan);
 
 	l2cap_chan_ready(chan);
@@ -3451,8 +3449,6 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn,
 	chan->psm  = psm;
 	chan->dcid = scid;
 
-	bt_accept_enqueue(parent, sk);
-
 	__l2cap_chan_add(conn, chan);
 
 	dcid = chan->scid;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index dd593c9..50c38e0 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -948,6 +948,8 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
 	l2cap_sock_init(sk, parent);
 
+	bt_accept_enqueue(parent, sk);
+
 	return l2cap_pi(sk)->chan;
 }
 
-- 
1.7.11.4

