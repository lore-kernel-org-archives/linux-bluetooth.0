Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH -v2 2/8] Bluetooth: Add l2cap_chan_ops abstraction
Date: Wed,  8 Jun 2011 12:18:53 -0300
Message-Id: <1307546339-12035-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1307546339-12035-2-git-send-email-padovan@profusion.mobi>
References: <1307546339-12035-1-git-send-email-padovan@profusion.mobi>
 <1307546339-12035-2-git-send-email-padovan@profusion.mobi>
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
index 0529d27..d3a1509 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -354,6 +354,15 @@ struct l2cap_chan {
 
 	struct list_head list;
 	struct list_head global_l;
+
+	void		*data;
+	struct l2cap_ops *ops;
+};
+
+struct l2cap_ops {
+	char		*name;
+
+	struct l2cap_chan	*(*new_connection) (void *data);
 };
 
 struct l2cap_conn {
@@ -460,9 +469,6 @@ int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm);
 int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
 
 void l2cap_sock_kill(struct sock *sk);
-void l2cap_sock_init(struct sock *sk, struct sock *parent);
-struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
-							int proto, gfp_t prio);
 
 struct l2cap_chan *l2cap_chan_create(struct sock *sk);
 void l2cap_chan_close(struct l2cap_chan *chan, int reason);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index aa3b057..add412e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -842,18 +842,16 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 		goto clean;
 	}
 
-	sk = l2cap_sock_alloc(sock_net(parent), NULL, BTPROTO_L2CAP, GFP_ATOMIC);
-	if (!sk)
+	chan = pchan->ops->new_connection(pchan->data);
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
 
@@ -2329,10 +2327,12 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		goto response;
 	}
 
-	sk = l2cap_sock_alloc(sock_net(parent), NULL, BTPROTO_L2CAP, GFP_ATOMIC);
-	if (!sk)
+	chan = pchan->ops->new_connection(pchan->data);
+	if (!chan)
 		goto response;
 
+	sk = chan->sk;
+
 	write_lock_bh(&conn->chan_lock);
 
 	/* Check if we already have channel with that dcid */
@@ -2345,9 +2345,6 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	hci_conn_hold(conn->hcon);
 
-	chan = l2cap_pi(sk)->chan;
-
-	l2cap_sock_init(sk, parent);
 	bacpy(&bt_sk(sk)->src, conn->src);
 	bacpy(&bt_sk(sk)->dst, conn->dst);
 	chan->psm  = psm;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 2f4fd57..4050ede 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -31,6 +31,8 @@
 #include <net/bluetooth/l2cap.h>
 
 static const struct proto_ops l2cap_sock_ops;
+static void l2cap_sock_init(struct sock *sk, struct sock *parent);
+static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock, int proto, gfp_t prio);
 
 static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 {
@@ -773,6 +775,25 @@ static int l2cap_sock_release(struct socket *sock)
 	return err;
 }
 
+static struct l2cap_chan *l2cap_sock_new_connection_cb(void *data)
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
+	.new_connection	= l2cap_sock_new_connection_cb,
+};
+
 static void l2cap_sock_destruct(struct sock *sk)
 {
 	BT_DBG("sk %p", sk);
@@ -781,7 +802,7 @@ static void l2cap_sock_destruct(struct sock *sk)
 	skb_queue_purge(&sk->sk_write_queue);
 }
 
-void l2cap_sock_init(struct sock *sk, struct sock *parent)
+static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct l2cap_chan *chan = pi->chan;
@@ -838,10 +859,14 @@ void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		chan->force_reliable = 0;
 		chan->flushable = BT_FLUSHABLE_OFF;
 		chan->force_active = BT_POWER_FORCE_ACTIVE_ON;
+
 	}
 
 	/* Default config options */
 	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
+
+	chan->data = sk;
+	chan->ops = &l2cap_chan_ops;
 }
 
 static struct proto l2cap_proto = {
@@ -850,7 +875,7 @@ static struct proto l2cap_proto = {
 	.obj_size	= sizeof(struct l2cap_pinfo)
 };
 
-struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock, int proto, gfp_t prio)
+static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock, int proto, gfp_t prio)
 {
 	struct sock *sk;
 	struct l2cap_chan *chan;
-- 
1.7.5.1

