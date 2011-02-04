Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next 03/16] Bluetooth: move l2cap_sock_ops to l2cap_sock.c
Date: Fri,  4 Feb 2011 04:01:45 -0200
Message-Id: <1296799318-5517-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1296799318-5517-3-git-send-email-padovan@profusion.mobi>
References: <1296799318-5517-1-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-2-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-3-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

First step to move all l2cap_sock_ops function to l2cap_sock.c

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |   12 +++++++++++
 net/bluetooth/l2cap_core.c    |   42 ++++++++++------------------------------
 net/bluetooth/l2cap_sock.c    |   21 +++++++++++++++++++-
 3 files changed, 43 insertions(+), 32 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index fce5274..533bef5 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -438,6 +438,18 @@ void l2cap_sock_init(struct sock *sk, struct sock *parent);
 struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 							int proto, gfp_t prio);
 
+int l2cap_sock_release(struct socket *sock);
+int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen);
+int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int alen, int flags);
+int l2cap_sock_listen(struct socket *sock, int backlog);
+int l2cap_sock_accept(struct socket *sock, struct socket *newsock, int flags);
+int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr, int *len, int peer);
+int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len);
+int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len, int flags);
+int l2cap_sock_shutdown(struct socket *sock, int how);
+int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen);
+int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen);
+
 
 void l2cap_load(void);
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 53f9ebd..d11bcf2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -858,7 +858,7 @@ static void l2cap_sock_close(struct sock *sk)
 	l2cap_sock_kill(sk);
 }
 
-static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
+int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 {
 	struct sock *sk = sock->sk;
 	struct sockaddr_l2 la;
@@ -982,7 +982,7 @@ done:
 	return err;
 }
 
-static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int alen, int flags)
+int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int alen, int flags)
 {
 	struct sock *sk = sock->sk;
 	struct sockaddr_l2 la;
@@ -1067,7 +1067,7 @@ done:
 	return err;
 }
 
-static int l2cap_sock_listen(struct socket *sock, int backlog)
+int l2cap_sock_listen(struct socket *sock, int backlog)
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
@@ -1126,7 +1126,7 @@ done:
 	return err;
 }
 
-static int l2cap_sock_accept(struct socket *sock, struct socket *newsock, int flags)
+int l2cap_sock_accept(struct socket *sock, struct socket *newsock, int flags)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	struct sock *sk = sock->sk, *nsk;
@@ -1182,7 +1182,7 @@ done:
 	return err;
 }
 
-static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr, int *len, int peer)
+int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr, int *len, int peer)
 {
 	struct sockaddr_l2 *la = (struct sockaddr_l2 *) addr;
 	struct sock *sk = sock->sk;
@@ -1664,7 +1664,7 @@ static inline int l2cap_sar_segment_sdu(struct sock *sk, struct msghdr *msg, siz
 	return size;
 }
 
-static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len)
+int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
@@ -1766,7 +1766,7 @@ done:
 	return err;
 }
 
-static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len, int flags)
+int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len, int flags)
 {
 	struct sock *sk = sock->sk;
 
@@ -1893,7 +1893,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 	return err;
 }
 
-static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen)
+int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	struct bt_security sec;
@@ -2066,7 +2066,7 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __us
 	return err;
 }
 
-static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen)
+int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen)
 {
 	struct sock *sk = sock->sk;
 	struct bt_security sec;
@@ -2127,7 +2127,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 	return err;
 }
 
-static int l2cap_sock_shutdown(struct socket *sock, int how)
+int l2cap_sock_shutdown(struct socket *sock, int how)
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
@@ -2158,7 +2158,7 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 	return err;
 }
 
-static int l2cap_sock_release(struct socket *sock)
+int l2cap_sock_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
 	int err;
@@ -4714,26 +4714,6 @@ static const struct file_operations l2cap_debugfs_fops = {
 
 static struct dentry *l2cap_debugfs;
 
-const struct proto_ops l2cap_sock_ops = {
-	.family		= PF_BLUETOOTH,
-	.owner		= THIS_MODULE,
-	.release	= l2cap_sock_release,
-	.bind		= l2cap_sock_bind,
-	.connect	= l2cap_sock_connect,
-	.listen		= l2cap_sock_listen,
-	.accept		= l2cap_sock_accept,
-	.getname	= l2cap_sock_getname,
-	.sendmsg	= l2cap_sock_sendmsg,
-	.recvmsg	= l2cap_sock_recvmsg,
-	.poll		= bt_sock_poll,
-	.ioctl		= bt_sock_ioctl,
-	.mmap		= sock_no_mmap,
-	.socketpair	= sock_no_socketpair,
-	.shutdown	= l2cap_sock_shutdown,
-	.setsockopt	= l2cap_sock_setsockopt,
-	.getsockopt	= l2cap_sock_getsockopt
-};
-
 static struct hci_proto l2cap_hci_proto = {
 	.name		= "L2CAP",
 	.id		= HCI_PROTO_L2CAP,
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 6ea1894..c1455f7 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -62,7 +62,6 @@ static void l2cap_sock_timeout(unsigned long arg)
 	sock_put(sk);
 }
 
-
 static void l2cap_sock_destruct(struct sock *sk)
 {
 	BT_DBG("sk %p", sk);
@@ -176,6 +175,26 @@ static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
 	return 0;
 }
 
+const struct proto_ops l2cap_sock_ops = {
+	.family		= PF_BLUETOOTH,
+	.owner		= THIS_MODULE,
+	.release	= l2cap_sock_release,
+	.bind		= l2cap_sock_bind,
+	.connect	= l2cap_sock_connect,
+	.listen		= l2cap_sock_listen,
+	.accept		= l2cap_sock_accept,
+	.getname	= l2cap_sock_getname,
+	.sendmsg	= l2cap_sock_sendmsg,
+	.recvmsg	= l2cap_sock_recvmsg,
+	.poll		= bt_sock_poll,
+	.ioctl		= bt_sock_ioctl,
+	.mmap		= sock_no_mmap,
+	.socketpair	= sock_no_socketpair,
+	.shutdown	= l2cap_sock_shutdown,
+	.setsockopt	= l2cap_sock_setsockopt,
+	.getsockopt	= l2cap_sock_getsockopt
+};
+
 static const struct net_proto_family l2cap_sock_family_ops = {
 	.family	= PF_BLUETOOTH,
 	.owner	= THIS_MODULE,
-- 
1.7.4.rc3

