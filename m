Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo@padovan.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v2 02/18] Bluetooth: hidp: verify l2cap sockets
Date: Tue,  2 Apr 2013 18:08:22 +0200
Message-Id: <1364918918-2336-3-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1364918918-2336-1-git-send-email-dh.herrmann@gmail.com>
References: <1364918918-2336-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

We need to verify that the given sockets actually are l2cap sockets. If
they aren't, we are not supposed to access bt_sk(sock) and we shouldn't
start the session if the offsets turn out to be valid local BT addresses.

That is, if someone passes a TCP socket to HIDCONNADD, then we access some
random offset in the TCP socket (which isn't even guaranteed to be valid).

Fix this by checking that the socket is an l2cap socket.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 include/net/bluetooth/l2cap.h | 1 +
 net/bluetooth/hidp/core.c     | 2 ++
 net/bluetooth/l2cap_sock.c    | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 7588ef4..db6694f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -787,6 +787,7 @@ extern bool disable_ertm;
 
 int l2cap_init_sockets(void);
 void l2cap_cleanup_sockets(void);
+bool l2cap_is_socket(struct socket *sock);
 
 void __l2cap_connect_rsp_defer(struct l2cap_chan *chan);
 int __l2cap_wait_ack(struct sock *sk);
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index a7352ff..c547b55 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -969,6 +969,8 @@ int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock,
 
 	BT_DBG("");
 
+	if (!l2cap_is_socket(ctrl_sock) || !l2cap_is_socket(intr_sock))
+		return -EINVAL;
 	if (bacmp(&bt_sk(ctrl_sock->sk)->src, &bt_sk(intr_sock->sk)->src) ||
 			bacmp(&bt_sk(ctrl_sock->sk)->dst, &bt_sk(intr_sock->sk)->dst))
 		return -ENOTUNIQ;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1bcfb84..461e8bc 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -43,6 +43,12 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent);
 static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 				     int proto, gfp_t prio);
 
+bool l2cap_is_socket(struct socket *sock)
+{
+	return sock && sock->ops == &l2cap_sock_ops;
+}
+EXPORT_SYMBOL(l2cap_is_socket);
+
 static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 {
 	struct sock *sk = sock->sk;
-- 
1.8.2
