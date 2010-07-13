Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 5/5] Bluetooth: first move for L2CAP split
Date: Tue, 13 Jul 2010 11:57:15 -0300
Message-Id: <1279033035-24708-5-git-send-email-gustavo@padovan.org>
In-Reply-To: <1279033035-24708-4-git-send-email-gustavo@padovan.org>
References: <1279033035-24708-1-git-send-email-gustavo@padovan.org>
 <1279033035-24708-2-git-send-email-gustavo@padovan.org>
 <1279033035-24708-3-git-send-email-gustavo@padovan.org>
 <1279033035-24708-4-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

By now l2cap_sock_create and its dependencies were moved to sock.c

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |   12 +++
 net/bluetooth/l2cap/core.c    |  173 ++--------------------------------------
 net/bluetooth/l2cap/sock.c    |  174 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+), 164 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index d030302..0fca782 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -422,6 +422,18 @@ static inline int l2cap_tx_window_full(struct sock *sk)
 #define __is_sframe(ctrl) (ctrl) & L2CAP_CTRL_FRAME_TYPE
 #define __is_sar_start(ctrl) ((ctrl) & L2CAP_CTRL_SAR) == L2CAP_SDU_START
 
+extern int enable_ertm;
+extern const struct proto_ops l2cap_sock_ops;
+extern struct bt_sock_list l2cap_sk_list;
+
+int l2cap_init_sockets(void);
+void l2cap_cleanup_sockets(void);
+
+void __l2cap_sock_close(struct sock *sk, int reason);
+void l2cap_sock_kill(struct sock *sk);
+void l2cap_sock_init(struct sock *sk, struct sock *parent);
+struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock, int proto, gfp_t prio);
+
 void l2cap_load(void);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap/core.c b/net/bluetooth/l2cap/core.c
index cdd608d..d0c4068 100644
--- a/net/bluetooth/l2cap/core.c
+++ b/net/bluetooth/l2cap/core.c
@@ -56,24 +56,21 @@
 
 #define VERSION "2.15"
 
-static int enable_ertm = 0;
+int enable_ertm = 0;
 
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
 static u8 l2cap_fixed_chan[8] = { 0x02, };
 
-static const struct proto_ops l2cap_sock_ops;
-
 static struct workqueue_struct *_busy_wq;
 
-static struct bt_sock_list l2cap_sk_list = {
+struct bt_sock_list l2cap_sk_list = {
 	.lock = __RW_LOCK_UNLOCKED(l2cap_sk_list.lock)
 };
 
 static void l2cap_busy_work(struct work_struct *work);
 
-static void __l2cap_sock_close(struct sock *sk, int reason);
 static void l2cap_sock_close(struct sock *sk);
-static void l2cap_sock_kill(struct sock *sk);
+void l2cap_sock_kill(struct sock *sk);
 
 static int l2cap_build_conf_req(struct sock *sk, void *data);
 static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
@@ -82,31 +79,6 @@ static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
 static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb);
 
 /* ---- L2CAP timers ---- */
-static void l2cap_sock_timeout(unsigned long arg)
-{
-	struct sock *sk = (struct sock *) arg;
-	int reason;
-
-	BT_DBG("sock %p state %d", sk, sk->sk_state);
-
-	bh_lock_sock(sk);
-
-	if (sk->sk_state == BT_CONNECTED || sk->sk_state == BT_CONFIG)
-		reason = ECONNREFUSED;
-	else if (sk->sk_state == BT_CONNECT &&
-				l2cap_pi(sk)->sec_level != BT_SECURITY_SDP)
-		reason = ECONNREFUSED;
-	else
-		reason = ETIMEDOUT;
-
-	__l2cap_sock_close(sk, reason);
-
-	bh_unlock_sock(sk);
-
-	l2cap_sock_kill(sk);
-	sock_put(sk);
-}
-
 static void l2cap_sock_set_timer(struct sock *sk, long timeout)
 {
 	BT_DBG("sk %p state %d timeout %ld", sk, sk->sk_state, timeout);
@@ -777,14 +749,6 @@ static inline struct sock *l2cap_get_sock_by_psm(int state, __le16 psm, bdaddr_t
 	return s;
 }
 
-static void l2cap_sock_destruct(struct sock *sk)
-{
-	BT_DBG("sk %p", sk);
-
-	skb_queue_purge(&sk->sk_receive_queue);
-	skb_queue_purge(&sk->sk_write_queue);
-}
-
 static void l2cap_sock_cleanup_listen(struct sock *parent)
 {
 	struct sock *sk;
@@ -802,7 +766,7 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 /* Kill socket (only if zapped and orphan)
  * Must be called on unlocked socket.
  */
-static void l2cap_sock_kill(struct sock *sk)
+void l2cap_sock_kill(struct sock *sk)
 {
 	if (!sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket)
 		return;
@@ -815,7 +779,7 @@ static void l2cap_sock_kill(struct sock *sk)
 	sock_put(sk);
 }
 
-static void __l2cap_sock_close(struct sock *sk, int reason)
+void __l2cap_sock_close(struct sock *sk, int reason)
 {
 	BT_DBG("sk %p state %d socket %p", sk, sk->sk_state, sk->sk_socket);
 
@@ -879,109 +843,6 @@ static void l2cap_sock_close(struct sock *sk)
 	l2cap_sock_kill(sk);
 }
 
-static void l2cap_sock_init(struct sock *sk, struct sock *parent)
-{
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
-
-	BT_DBG("sk %p", sk);
-
-	if (parent) {
-		sk->sk_type = parent->sk_type;
-		bt_sk(sk)->defer_setup = bt_sk(parent)->defer_setup;
-
-		pi->imtu = l2cap_pi(parent)->imtu;
-		pi->omtu = l2cap_pi(parent)->omtu;
-		pi->conf_state = l2cap_pi(parent)->conf_state;
-		pi->mode = l2cap_pi(parent)->mode;
-		pi->fcs  = l2cap_pi(parent)->fcs;
-		pi->max_tx = l2cap_pi(parent)->max_tx;
-		pi->tx_win = l2cap_pi(parent)->tx_win;
-		pi->sec_level = l2cap_pi(parent)->sec_level;
-		pi->role_switch = l2cap_pi(parent)->role_switch;
-		pi->force_reliable = l2cap_pi(parent)->force_reliable;
-	} else {
-		pi->imtu = L2CAP_DEFAULT_MTU;
-		pi->omtu = 0;
-		if (enable_ertm && sk->sk_type == SOCK_STREAM) {
-			pi->mode = L2CAP_MODE_ERTM;
-			pi->conf_state |= L2CAP_CONF_STATE2_DEVICE;
-		} else {
-			pi->mode = L2CAP_MODE_BASIC;
-		}
-		pi->max_tx = L2CAP_DEFAULT_MAX_TX;
-		pi->fcs  = L2CAP_FCS_CRC16;
-		pi->tx_win = L2CAP_DEFAULT_TX_WINDOW;
-		pi->sec_level = BT_SECURITY_LOW;
-		pi->role_switch = 0;
-		pi->force_reliable = 0;
-	}
-
-	/* Default config options */
-	pi->conf_len = 0;
-	pi->flush_to = L2CAP_DEFAULT_FLUSH_TO;
-	skb_queue_head_init(TX_QUEUE(sk));
-	skb_queue_head_init(SREJ_QUEUE(sk));
-	skb_queue_head_init(BUSY_QUEUE(sk));
-	INIT_LIST_HEAD(SREJ_LIST(sk));
-}
-
-static struct proto l2cap_proto = {
-	.name		= "L2CAP",
-	.owner		= THIS_MODULE,
-	.obj_size	= sizeof(struct l2cap_pinfo)
-};
-
-static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock, int proto, gfp_t prio)
-{
-	struct sock *sk;
-
-	sk = sk_alloc(net, PF_BLUETOOTH, prio, &l2cap_proto);
-	if (!sk)
-		return NULL;
-
-	sock_init_data(sock, sk);
-	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
-
-	sk->sk_destruct = l2cap_sock_destruct;
-	sk->sk_sndtimeo = msecs_to_jiffies(L2CAP_CONN_TIMEOUT);
-
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = proto;
-	sk->sk_state = BT_OPEN;
-
-	setup_timer(&sk->sk_timer, l2cap_sock_timeout, (unsigned long) sk);
-
-	bt_sock_link(&l2cap_sk_list, sk);
-	return sk;
-}
-
-static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
-			     int kern)
-{
-	struct sock *sk;
-
-	BT_DBG("sock %p", sock);
-
-	sock->state = SS_UNCONNECTED;
-
-	if (sock->type != SOCK_SEQPACKET && sock->type != SOCK_STREAM &&
-			sock->type != SOCK_DGRAM && sock->type != SOCK_RAW)
-		return -ESOCKTNOSUPPORT;
-
-	if (sock->type == SOCK_RAW && !kern && !capable(CAP_NET_RAW))
-		return -EPERM;
-
-	sock->ops = &l2cap_sock_ops;
-
-	sk = l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC);
-	if (!sk)
-		return -ENOMEM;
-
-	l2cap_sock_init(sk, NULL);
-	return 0;
-}
-
 static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 {
 	struct sock *sk = sock->sk;
@@ -4743,7 +4604,7 @@ static const struct file_operations l2cap_debugfs_fops = {
 
 static struct dentry *l2cap_debugfs;
 
-static const struct proto_ops l2cap_sock_ops = {
+const struct proto_ops l2cap_sock_ops = {
 	.family		= PF_BLUETOOTH,
 	.owner		= THIS_MODULE,
 	.release	= l2cap_sock_release,
@@ -4763,12 +4624,6 @@ static const struct proto_ops l2cap_sock_ops = {
 	.getsockopt	= l2cap_sock_getsockopt
 };
 
-static const struct net_proto_family l2cap_sock_family_ops = {
-	.family	= PF_BLUETOOTH,
-	.owner	= THIS_MODULE,
-	.create	= l2cap_sock_create,
-};
-
 static struct hci_proto l2cap_hci_proto = {
 	.name		= "L2CAP",
 	.id		= HCI_PROTO_L2CAP,
@@ -4784,7 +4639,7 @@ static int __init l2cap_init(void)
 {
 	int err;
 
-	err = proto_register(&l2cap_proto, 0);
+	err = l2cap_init_sockets();
 	if (err < 0)
 		return err;
 
@@ -4792,16 +4647,9 @@ static int __init l2cap_init(void)
 	if (!_busy_wq)
 		goto error;
 
-	err = bt_sock_register(BTPROTO_L2CAP, &l2cap_sock_family_ops);
-	if (err < 0) {
-		BT_ERR("L2CAP socket registration failed");
-		goto error;
-	}
-
 	err = hci_register_proto(&l2cap_hci_proto);
 	if (err < 0) {
 		BT_ERR("L2CAP protocol registration failed");
-		bt_sock_unregister(BTPROTO_L2CAP);
 		goto error;
 	}
 
@@ -4818,7 +4666,7 @@ static int __init l2cap_init(void)
 	return 0;
 
 error:
-	proto_unregister(&l2cap_proto);
+	l2cap_cleanup_sockets();
 	return err;
 }
 
@@ -4829,13 +4677,10 @@ static void __exit l2cap_exit(void)
 	flush_workqueue(_busy_wq);
 	destroy_workqueue(_busy_wq);
 
-	if (bt_sock_unregister(BTPROTO_L2CAP) < 0)
-		BT_ERR("L2CAP socket unregistration failed");
-
 	if (hci_unregister_proto(&l2cap_hci_proto) < 0)
 		BT_ERR("L2CAP protocol unregistration failed");
 
-	proto_unregister(&l2cap_proto);
+	l2cap_cleanup_sockets();
 }
 
 void l2cap_load(void)
diff --git a/net/bluetooth/l2cap/sock.c b/net/bluetooth/l2cap/sock.c
index 76975f3..d28d11e 100644
--- a/net/bluetooth/l2cap/sock.c
+++ b/net/bluetooth/l2cap/sock.c
@@ -25,3 +25,177 @@
 
 /* Bluetooth L2CAP sockets. */
 
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/l2cap.h>
+
+static void l2cap_sock_timeout(unsigned long arg)
+{
+	struct sock *sk = (struct sock *) arg;
+	int reason;
+
+	BT_DBG("sock %p state %d", sk, sk->sk_state);
+
+	bh_lock_sock(sk);
+
+	if (sk->sk_state == BT_CONNECTED || sk->sk_state == BT_CONFIG)
+		reason = ECONNREFUSED;
+	else if (sk->sk_state == BT_CONNECT &&
+				l2cap_pi(sk)->sec_level != BT_SECURITY_SDP)
+		reason = ECONNREFUSED;
+	else
+		reason = ETIMEDOUT;
+
+	__l2cap_sock_close(sk, reason);
+
+	bh_unlock_sock(sk);
+
+	l2cap_sock_kill(sk);
+	sock_put(sk);
+}
+
+static void l2cap_sock_destruct(struct sock *sk)
+{
+	BT_DBG("sk %p", sk);
+
+	skb_queue_purge(&sk->sk_receive_queue);
+	skb_queue_purge(&sk->sk_write_queue);
+}
+
+void l2cap_sock_init(struct sock *sk, struct sock *parent)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+
+	BT_DBG("sk %p", sk);
+
+	if (parent) {
+		sk->sk_type = parent->sk_type;
+		bt_sk(sk)->defer_setup = bt_sk(parent)->defer_setup;
+
+		pi->imtu = l2cap_pi(parent)->imtu;
+		pi->omtu = l2cap_pi(parent)->omtu;
+		pi->conf_state = l2cap_pi(parent)->conf_state;
+		pi->mode = l2cap_pi(parent)->mode;
+		pi->fcs  = l2cap_pi(parent)->fcs;
+		pi->max_tx = l2cap_pi(parent)->max_tx;
+		pi->tx_win = l2cap_pi(parent)->tx_win;
+		pi->sec_level = l2cap_pi(parent)->sec_level;
+		pi->role_switch = l2cap_pi(parent)->role_switch;
+		pi->force_reliable = l2cap_pi(parent)->force_reliable;
+	} else {
+		pi->imtu = L2CAP_DEFAULT_MTU;
+		pi->omtu = 0;
+		if (enable_ertm && sk->sk_type == SOCK_STREAM) {
+			pi->mode = L2CAP_MODE_ERTM;
+			pi->conf_state |= L2CAP_CONF_STATE2_DEVICE;
+		} else {
+			pi->mode = L2CAP_MODE_BASIC;
+		}
+		pi->max_tx = L2CAP_DEFAULT_MAX_TX;
+		pi->fcs  = L2CAP_FCS_CRC16;
+		pi->tx_win = L2CAP_DEFAULT_TX_WINDOW;
+		pi->sec_level = BT_SECURITY_LOW;
+		pi->role_switch = 0;
+		pi->force_reliable = 0;
+	}
+
+	/* Default config options */
+	pi->conf_len = 0;
+	pi->flush_to = L2CAP_DEFAULT_FLUSH_TO;
+	skb_queue_head_init(TX_QUEUE(sk));
+	skb_queue_head_init(SREJ_QUEUE(sk));
+	skb_queue_head_init(BUSY_QUEUE(sk));
+	INIT_LIST_HEAD(SREJ_LIST(sk));
+}
+
+static struct proto l2cap_proto = {
+	.name		= "L2CAP",
+	.owner		= THIS_MODULE,
+	.obj_size	= sizeof(struct l2cap_pinfo)
+};
+
+struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock, int proto, gfp_t prio)
+{
+	struct sock *sk;
+
+	sk = sk_alloc(net, PF_BLUETOOTH, prio, &l2cap_proto);
+	if (!sk)
+		return NULL;
+
+	sock_init_data(sock, sk);
+	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
+
+	sk->sk_destruct = l2cap_sock_destruct;
+	sk->sk_sndtimeo = msecs_to_jiffies(L2CAP_CONN_TIMEOUT);
+
+	sock_reset_flag(sk, SOCK_ZAPPED);
+
+	sk->sk_protocol = proto;
+	sk->sk_state = BT_OPEN;
+
+	setup_timer(&sk->sk_timer, l2cap_sock_timeout, (unsigned long) sk);
+
+	bt_sock_link(&l2cap_sk_list, sk);
+	return sk;
+}
+
+static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
+			     int kern)
+{
+	struct sock *sk;
+
+	BT_DBG("sock %p", sock);
+
+	sock->state = SS_UNCONNECTED;
+
+	if (sock->type != SOCK_SEQPACKET && sock->type != SOCK_STREAM &&
+			sock->type != SOCK_DGRAM && sock->type != SOCK_RAW)
+		return -ESOCKTNOSUPPORT;
+
+	if (sock->type == SOCK_RAW && !kern && !capable(CAP_NET_RAW))
+		return -EPERM;
+
+	sock->ops = &l2cap_sock_ops;
+
+	sk = l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC);
+	if (!sk)
+		return -ENOMEM;
+
+	l2cap_sock_init(sk, NULL);
+	return 0;
+}
+
+static const struct net_proto_family l2cap_sock_family_ops = {
+	.family	= PF_BLUETOOTH,
+	.owner	= THIS_MODULE,
+	.create	= l2cap_sock_create,
+};
+
+int __init l2cap_init_sockets(void)
+{
+	int err;
+
+	err = proto_register(&l2cap_proto, 0);
+	if (err < 0)
+		return err;
+
+	err = bt_sock_register(BTPROTO_L2CAP, &l2cap_sock_family_ops);
+	if (err < 0)
+		goto error;
+
+	BT_INFO("L2CAP socket layer initialized");
+
+	return 0;
+
+error:
+	BT_ERR("L2CAP socket registration failed");
+	proto_unregister(&l2cap_proto);
+	return err;
+}
+
+void l2cap_cleanup_sockets(void)
+{
+	if (bt_sock_unregister(BTPROTO_L2CAP) < 0)
+		BT_ERR("L2CAP socket unregistration failed");
+
+	proto_unregister(&l2cap_proto);
+}
-- 
1.7.1
