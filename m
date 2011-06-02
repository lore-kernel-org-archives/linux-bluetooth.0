Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] Bluetooth: Add l2cap_chan_ops abstraction
Date: Thu,  2 Jun 2011 13:15:24 -0300
Message-Id: <1307031329-8001-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add an abstraction layer between L2CAP core and its users (only
l2cap_sock.c now). The first function implemented is new_connection() that
replaces calls to l2cap_sock_alloc() in l2cap_core.c

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |   12 +++++++++---
 net/bluetooth/l2cap_core.c    |   17 +++++++----------
 net/bluetooth/l2cap_sock.c    |   29 +++++++++++++++++++++++++++--
 3 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index a2dcbff..95e44df 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -353,6 +353,15 @@ struct l2cap_chan {
 
 	struct list_head list;
 	struct list_head global_l;
+
+	struct l2cap_ops *ops;
+};
+
+struct l2cap_ops {
+	char		*name;
+	void		*data;
+
+	struct l2cap_chan	*(*new_connection) (void *data);
 };
 
 struct l2cap_conn {
@@ -459,9 +468,6 @@ int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm);
 int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
 
 void l2cap_sock_kill(struct sock *sk);
-void l2cap_sock_init(struct sock *sk, struct sock *parent);
-struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
-							int proto, gfp_t prio);
 
 struct l2cap_chan *l2cap_chan_create(struct sock *sk);
 void l2cap_chan_close(struct l2cap_chan *chan, int reason);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 233ecdc..6849e74 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -837,18 +837,16 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 		goto clean;
 	}
 
-	sk = l2cap_sock_alloc(sock_net(parent), NULL, BTPROTO_L2CAP, GFP_ATOMIC);
-	if (!sk)
+	chan = pchan->ops->new_connection(pchan->ops->data);
+	if (!chan)
 		goto clean;
 
-	chan = l2cap_pi(sk)->chan;
+	sk = chan->sk;
 
 	write_lock_bh(&conn->chan_lock);
 
 	hci_conn_hold(conn->hcon);
 
-	l2cap_sock_init(sk, parent);
-
 	bacpy(&bt_sk(sk)->src, conn->src);
 	bacpy(&bt_sk(sk)->dst, conn->dst);
 
@@ -2323,10 +2321,12 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		goto response;
 	}
 
-	sk = l2cap_sock_alloc(sock_net(parent), NULL, BTPROTO_L2CAP, GFP_ATOMIC);
-	if (!sk)
+	chan = pchan->ops->new_connection(pchan->ops->data);
+	if (!chan)
 		goto response;
 
+	sk = chan->sk;
+
 	write_lock_bh(&conn->chan_lock);
 
 	/* Check if we already have channel with that dcid */
@@ -2339,9 +2339,6 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	hci_conn_hold(conn->hcon);
 
-	chan = l2cap_pi(sk)->chan;
-
-	l2cap_sock_init(sk, parent);
 	bacpy(&bt_sk(sk)->src, conn->src);
 	bacpy(&bt_sk(sk)->dst, conn->dst);
 	chan->psm  = psm;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1337811..79926a4 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -31,6 +31,8 @@
 #include <net/bluetooth/l2cap.h>
 
 static const struct proto_ops l2cap_sock_ops;
+static void l2cap_sock_init(struct sock *sk, struct sock *parent);
+static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock, int proto, gfp_t prio);
 
 static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 {
@@ -739,6 +741,25 @@ static int l2cap_sock_release(struct socket *sock)
 	return err;
 }
 
+static struct l2cap_chan *l2cap_chan_new_connection_cb(void *data)
+{
+	struct sock *sk, *parent = data;
+
+	sk = l2cap_sock_alloc(sock_net(parent), NULL, BTPROTO_L2CAP,
+								GFP_ATOMIC);
+	if (!sk)
+		return NULL;
+
+	l2cap_sock_init(sk, parent);
+
+	return l2cap_pi(sk)->chan;
+}
+
+static struct l2cap_ops l2cap_chan_ops = {
+	.name		= "L2CAP Socket Interface",
+	.new_connection	= l2cap_chan_new_connection_cb,
+};
+
 static void l2cap_sock_destruct(struct sock *sk)
 {
 	BT_DBG("sk %p", sk);
@@ -747,7 +768,7 @@ static void l2cap_sock_destruct(struct sock *sk)
 	skb_queue_purge(&sk->sk_write_queue);
 }
 
-void l2cap_sock_init(struct sock *sk, struct sock *parent)
+static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct l2cap_chan *chan = pi->chan;
@@ -772,6 +793,7 @@ void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		chan->role_switch = pchan->role_switch;
 		chan->force_reliable = pchan->force_reliable;
 		chan->flushable = pchan->flushable;
+		chan->ops = pchan->ops;
 	} else {
 
 		switch (sk->sk_type) {
@@ -802,6 +824,9 @@ void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		chan->role_switch = 0;
 		chan->force_reliable = 0;
 		chan->flushable = BT_FLUSHABLE_OFF;
+
+		l2cap_chan_ops.data = sk;
+		chan->ops = &l2cap_chan_ops;
 	}
 
 	/* Default config options */
@@ -814,7 +839,7 @@ static struct proto l2cap_proto = {
 	.obj_size	= sizeof(struct l2cap_pinfo)
 };
 
-struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock, int proto, gfp_t prio)
+static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock, int proto, gfp_t prio)
 {
 	struct sock *sk;
 	struct l2cap_chan *chan;
-- 
1.7.5.1

