Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH -v2 1/8] Bluetooth: Merge l2cap_chan_create() in the l2cap_sock_alloc()
Date: Wed,  8 Jun 2011 12:18:52 -0300
Message-Id: <1307546339-12035-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1307546339-12035-1-git-send-email-padovan@profusion.mobi>
References: <1307546339-12035-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As a first step to remove l2cap_sock_alloc() and l2cap_sock_init() from
l2cap_core.c

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap_core.c |   18 +++---------------
 net/bluetooth/l2cap_sock.c |   18 +++++++++---------
 2 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index bb451f3..aa3b057 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -846,13 +846,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	if (!sk)
 		goto clean;
 
-	chan = l2cap_chan_create(sk);
-	if (!chan) {
-		l2cap_sock_kill(sk);
-		goto clean;
-	}
-
-	l2cap_pi(sk)->chan = chan;
+	chan = l2cap_pi(sk)->chan;
 
 	write_lock_bh(&conn->chan_lock);
 
@@ -2339,14 +2333,6 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	if (!sk)
 		goto response;
 
-	chan = l2cap_chan_create(sk);
-	if (!chan) {
-		l2cap_sock_kill(sk);
-		goto response;
-	}
-
-	l2cap_pi(sk)->chan = chan;
-
 	write_lock_bh(&conn->chan_lock);
 
 	/* Check if we already have channel with that dcid */
@@ -2359,6 +2345,8 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	hci_conn_hold(conn->hcon);
 
+	chan = l2cap_pi(sk)->chan;
+
 	l2cap_sock_init(sk, parent);
 	bacpy(&bt_sk(sk)->src, conn->src);
 	bacpy(&bt_sk(sk)->dst, conn->dst);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index ab81894..2f4fd57 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -853,6 +853,7 @@ static struct proto l2cap_proto = {
 struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock, int proto, gfp_t prio)
 {
 	struct sock *sk;
+	struct l2cap_chan *chan;
 
 	sk = sk_alloc(net, PF_BLUETOOTH, prio, &l2cap_proto);
 	if (!sk)
@@ -869,6 +870,14 @@ struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock, int proto, g
 	sk->sk_protocol = proto;
 	sk->sk_state = BT_OPEN;
 
+	chan = l2cap_chan_create(sk);
+	if (!chan) {
+		l2cap_sock_kill(sk);
+		return NULL;
+	}
+
+	l2cap_pi(sk)->chan = chan;
+
 	return sk;
 }
 
@@ -876,7 +885,6 @@ static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
 			     int kern)
 {
 	struct sock *sk;
-	struct l2cap_chan *chan;
 
 	BT_DBG("sock %p", sock);
 
@@ -895,14 +903,6 @@ static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
 	if (!sk)
 		return -ENOMEM;
 
-	chan = l2cap_chan_create(sk);
-	if (!chan) {
-		l2cap_sock_kill(sk);
-		return -ENOMEM;
-	}
-
-	l2cap_pi(sk)->chan = chan;
-
 	l2cap_sock_init(sk, NULL);
 	return 0;
 }
-- 
1.7.5.1

