Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next 02/16] Bluetooth: Initial work for L2CAP split.
Date: Fri,  4 Feb 2011 04:01:44 -0200
Message-Id: <1296799318-5517-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1296799318-5517-2-git-send-email-padovan@profusion.mobi>
References: <1296799318-5517-1-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-2-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch tries to do the minimal to move l2cap_sock_create() and its
dependencies to l2cap_sock.c. It create a API to initialize and cleanup
the L2CAP sockets from l2cap_core.c through l2cap_init_sockets() and
l2cap_cleanup_sockets().

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |   15 +++
 net/bluetooth/Makefile        |    2 +-
 net/bluetooth/l2cap_core.c    |  187 ++----------------------------------
 net/bluetooth/l2cap_sock.c    |  213 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 240 insertions(+), 177 deletions(-)
 create mode 100644 net/bluetooth/l2cap_sock.c

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 7f88a87..fce5274 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -424,6 +424,21 @@ static inline int l2cap_tx_window_full(struct sock *sk)
 #define __is_sframe(ctrl)	((ctrl) & L2CAP_CTRL_FRAME_TYPE)
 #define __is_sar_start(ctrl)	(((ctrl) & L2CAP_CTRL_SAR) == L2CAP_SDU_START)
 
+extern int disable_ertm;
+extern const struct proto_ops l2cap_sock_ops;
+extern struct bt_sock_list l2cap_sk_list;
+
+int l2cap_init_sockets(void);
+void l2cap_cleanup_sockets(void);
+
+void l2cap_sock_set_timer(struct sock *sk, long timeout);
+void __l2cap_sock_close(struct sock *sk, int reason);
+void l2cap_sock_kill(struct sock *sk);
+void l2cap_sock_init(struct sock *sk, struct sock *parent);
+struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
+							int proto, gfp_t prio);
+
+
 void l2cap_load(void);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index bf2945e..339b429 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -11,4 +11,4 @@ obj-$(CONFIG_BT_CMTP)	+= cmtp/
 obj-$(CONFIG_BT_HIDP)	+= hidp/
 
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o hci_sock.o hci_sysfs.o lib.o
-l2cap-y := l2cap_core.o
+l2cap-y := l2cap_core.o l2cap_sock.o
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1761558..53f9ebd 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -24,7 +24,7 @@
    SOFTWARE IS DISCLAIMED.
 */
 
-/* Bluetooth L2CAP core and sockets. */
+/* Bluetooth L2CAP core. */
 
 #include <linux/module.h>
 
@@ -57,24 +57,20 @@
 
 #define VERSION "2.15"
 
-static int disable_ertm;
+int disable_ertm;
 
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
 
 static int l2cap_build_conf_req(struct sock *sk, void *data);
 static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
@@ -83,7 +79,7 @@ static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
 static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb);
 
 /* ---- L2CAP timers ---- */
-static void l2cap_sock_set_timer(struct sock *sk, long timeout)
+void l2cap_sock_set_timer(struct sock *sk, long timeout)
 {
 	BT_DBG("sk %p state %d timeout %ld", sk, sk->sk_state, timeout);
 	sk_reset_timer(sk, &sk->sk_timer, jiffies + timeout);
@@ -95,39 +91,6 @@ static void l2cap_sock_clear_timer(struct sock *sk)
 	sk_stop_timer(sk, &sk->sk_timer);
 }
 
-static void l2cap_sock_timeout(unsigned long arg)
-{
-	struct sock *sk = (struct sock *) arg;
-	int reason;
-
-	BT_DBG("sock %p state %d", sk, sk->sk_state);
-
-	bh_lock_sock(sk);
-
-	if (sock_owned_by_user(sk)) {
-		/* sk is owned by user. Try again later */
-		l2cap_sock_set_timer(sk, HZ / 5);
-		bh_unlock_sock(sk);
-		sock_put(sk);
-		return;
-	}
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
 /* ---- L2CAP channels ---- */
 static struct sock *__l2cap_get_chan_by_dcid(struct l2cap_chan_list *l, u16 cid)
 {
@@ -801,14 +764,6 @@ static struct sock *l2cap_get_sock_by_psm(int state, __le16 psm, bdaddr_t *src)
 	return node ? sk : sk1;
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
@@ -826,7 +781,7 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 /* Kill socket (only if zapped and orphan)
  * Must be called on unlocked socket.
  */
-static void l2cap_sock_kill(struct sock *sk)
+void l2cap_sock_kill(struct sock *sk)
 {
 	if (!sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket)
 		return;
@@ -839,7 +794,7 @@ static void l2cap_sock_kill(struct sock *sk)
 	sock_put(sk);
 }
 
-static void __l2cap_sock_close(struct sock *sk, int reason)
+void __l2cap_sock_close(struct sock *sk, int reason)
 {
 	BT_DBG("sk %p state %d socket %p", sk, sk->sk_state, sk->sk_socket);
 
@@ -903,111 +858,6 @@ static void l2cap_sock_close(struct sock *sk)
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
-		pi->flushable = l2cap_pi(parent)->flushable;
-	} else {
-		pi->imtu = L2CAP_DEFAULT_MTU;
-		pi->omtu = 0;
-		if (!disable_ertm && sk->sk_type == SOCK_STREAM) {
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
-		pi->flushable = BT_FLUSHABLE_OFF;
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
@@ -4864,7 +4714,7 @@ static const struct file_operations l2cap_debugfs_fops = {
 
 static struct dentry *l2cap_debugfs;
 
-static const struct proto_ops l2cap_sock_ops = {
+const struct proto_ops l2cap_sock_ops = {
 	.family		= PF_BLUETOOTH,
 	.owner		= THIS_MODULE,
 	.release	= l2cap_sock_release,
@@ -4884,12 +4734,6 @@ static const struct proto_ops l2cap_sock_ops = {
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
@@ -4905,19 +4749,13 @@ static int __init l2cap_init(void)
 {
 	int err;
 
-	err = proto_register(&l2cap_proto, 0);
+	err = l2cap_init_sockets();
 	if (err < 0)
 		return err;
 
 	_busy_wq = create_singlethread_workqueue("l2cap");
 	if (!_busy_wq) {
-		proto_unregister(&l2cap_proto);
-		return -ENOMEM;
-	}
-
-	err = bt_sock_register(BTPROTO_L2CAP, &l2cap_sock_family_ops);
-	if (err < 0) {
-		BT_ERR("L2CAP socket registration failed");
+		err = -ENOMEM;
 		goto error;
 	}
 
@@ -4942,7 +4780,7 @@ static int __init l2cap_init(void)
 
 error:
 	destroy_workqueue(_busy_wq);
-	proto_unregister(&l2cap_proto);
+	l2cap_cleanup_sockets();
 	return err;
 }
 
@@ -4953,13 +4791,10 @@ static void __exit l2cap_exit(void)
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
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
new file mode 100644
index 0000000..6ea1894
--- /dev/null
+++ b/net/bluetooth/l2cap_sock.c
@@ -0,0 +1,213 @@
+/*
+   BlueZ - Bluetooth protocol stack for Linux
+   Copyright (C) 2000-2001 Qualcomm Incorporated
+   Copyright (C) 2009-2010 Gustavo F. Padovan <gustavo@padovan.org>
+   Copyright (C) 2010 Google Inc.
+
+   Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License version 2 as
+   published by the Free Software Foundation;
+
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
+   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
+   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
+   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+
+   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
+   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
+   SOFTWARE IS DISCLAIMED.
+*/
+
+/* Bluetooth L2CAP sockets. */
+
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
+	if (sock_owned_by_user(sk)) {
+		/* sk is owned by user. Try again later */
+		l2cap_sock_set_timer(sk, HZ / 5);
+		bh_unlock_sock(sk);
+		sock_put(sk);
+		return;
+	}
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
+		pi->flushable = l2cap_pi(parent)->flushable;
+	} else {
+		pi->imtu = L2CAP_DEFAULT_MTU;
+		pi->omtu = 0;
+		if (!disable_ertm && sk->sk_type == SOCK_STREAM) {
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
+		pi->flushable = BT_FLUSHABLE_OFF;
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
+       int err;
+
+       err = proto_register(&l2cap_proto, 0);
+       if (err < 0)
+               return err;
+
+       err = bt_sock_register(BTPROTO_L2CAP, &l2cap_sock_family_ops);
+       if (err < 0)
+               goto error;
+
+       BT_INFO("L2CAP socket layer initialized");
+
+       return 0;
+
+error:
+       BT_ERR("L2CAP socket registration failed");
+       proto_unregister(&l2cap_proto);
+       return err;
+}
+
+void l2cap_cleanup_sockets(void)
+{
+       if (bt_sock_unregister(BTPROTO_L2CAP) < 0)
+               BT_ERR("L2CAP socket unregistration failed");
+
+       proto_unregister(&l2cap_proto);
+}
-- 
1.7.4.rc3

