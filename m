Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next 09/16] Bluetooth: move l2cap_sock_getsockopt() to l2cap_sock.c
Date: Fri,  4 Feb 2011 04:01:51 -0200
Message-Id: <1296799318-5517-10-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1296799318-5517-9-git-send-email-padovan@profusion.mobi>
References: <1296799318-5517-1-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-2-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-3-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-4-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-5-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-6-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-7-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-8-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-9-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    1 -
 net/bluetooth/l2cap_core.c    |  145 -----------------------------------------
 net/bluetooth/l2cap_sock.c    |  145 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+), 146 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 901ecbe..1905aad 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -442,7 +442,6 @@ int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int alen, int
 int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len);
 int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len, int flags);
 int l2cap_sock_shutdown(struct socket *sock, int how);
-int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen);
 
 
 void l2cap_load(void);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 26ec2b8..34fc6b4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1595,151 +1595,6 @@ int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *m
 	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
 }
 
-static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __user *optval, int __user *optlen)
-{
-	struct sock *sk = sock->sk;
-	struct l2cap_options opts;
-	struct l2cap_conninfo cinfo;
-	int len, err = 0;
-	u32 opt;
-
-	BT_DBG("sk %p", sk);
-
-	if (get_user(len, optlen))
-		return -EFAULT;
-
-	lock_sock(sk);
-
-	switch (optname) {
-	case L2CAP_OPTIONS:
-		opts.imtu     = l2cap_pi(sk)->imtu;
-		opts.omtu     = l2cap_pi(sk)->omtu;
-		opts.flush_to = l2cap_pi(sk)->flush_to;
-		opts.mode     = l2cap_pi(sk)->mode;
-		opts.fcs      = l2cap_pi(sk)->fcs;
-		opts.max_tx   = l2cap_pi(sk)->max_tx;
-		opts.txwin_size = (__u16)l2cap_pi(sk)->tx_win;
-
-		len = min_t(unsigned int, len, sizeof(opts));
-		if (copy_to_user(optval, (char *) &opts, len))
-			err = -EFAULT;
-
-		break;
-
-	case L2CAP_LM:
-		switch (l2cap_pi(sk)->sec_level) {
-		case BT_SECURITY_LOW:
-			opt = L2CAP_LM_AUTH;
-			break;
-		case BT_SECURITY_MEDIUM:
-			opt = L2CAP_LM_AUTH | L2CAP_LM_ENCRYPT;
-			break;
-		case BT_SECURITY_HIGH:
-			opt = L2CAP_LM_AUTH | L2CAP_LM_ENCRYPT |
-							L2CAP_LM_SECURE;
-			break;
-		default:
-			opt = 0;
-			break;
-		}
-
-		if (l2cap_pi(sk)->role_switch)
-			opt |= L2CAP_LM_MASTER;
-
-		if (l2cap_pi(sk)->force_reliable)
-			opt |= L2CAP_LM_RELIABLE;
-
-		if (put_user(opt, (u32 __user *) optval))
-			err = -EFAULT;
-		break;
-
-	case L2CAP_CONNINFO:
-		if (sk->sk_state != BT_CONNECTED &&
-					!(sk->sk_state == BT_CONNECT2 &&
-						bt_sk(sk)->defer_setup)) {
-			err = -ENOTCONN;
-			break;
-		}
-
-		cinfo.hci_handle = l2cap_pi(sk)->conn->hcon->handle;
-		memcpy(cinfo.dev_class, l2cap_pi(sk)->conn->hcon->dev_class, 3);
-
-		len = min_t(unsigned int, len, sizeof(cinfo));
-		if (copy_to_user(optval, (char *) &cinfo, len))
-			err = -EFAULT;
-
-		break;
-
-	default:
-		err = -ENOPROTOOPT;
-		break;
-	}
-
-	release_sock(sk);
-	return err;
-}
-
-int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen)
-{
-	struct sock *sk = sock->sk;
-	struct bt_security sec;
-	int len, err = 0;
-
-	BT_DBG("sk %p", sk);
-
-	if (level == SOL_L2CAP)
-		return l2cap_sock_getsockopt_old(sock, optname, optval, optlen);
-
-	if (level != SOL_BLUETOOTH)
-		return -ENOPROTOOPT;
-
-	if (get_user(len, optlen))
-		return -EFAULT;
-
-	lock_sock(sk);
-
-	switch (optname) {
-	case BT_SECURITY:
-		if (sk->sk_type != SOCK_SEQPACKET && sk->sk_type != SOCK_STREAM
-				&& sk->sk_type != SOCK_RAW) {
-			err = -EINVAL;
-			break;
-		}
-
-		sec.level = l2cap_pi(sk)->sec_level;
-
-		len = min_t(unsigned int, len, sizeof(sec));
-		if (copy_to_user(optval, (char *) &sec, len))
-			err = -EFAULT;
-
-		break;
-
-	case BT_DEFER_SETUP:
-		if (sk->sk_state != BT_BOUND && sk->sk_state != BT_LISTEN) {
-			err = -EINVAL;
-			break;
-		}
-
-		if (put_user(bt_sk(sk)->defer_setup, (u32 __user *) optval))
-			err = -EFAULT;
-
-		break;
-
-	case BT_FLUSHABLE:
-		if (put_user(l2cap_pi(sk)->flushable, (u32 __user *) optval))
-			err = -EFAULT;
-
-		break;
-
-	default:
-		err = -ENOPROTOOPT;
-		break;
-	}
-
-	release_sock(sk);
-	return err;
-}
-
 int l2cap_sock_shutdown(struct socket *sock, int how)
 {
 	struct sock *sk = sock->sk;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1bbe8a0..b7d5ae9 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -277,6 +277,151 @@ static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr, int *l
 	return 0;
 }
 
+static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __user *optval, int __user *optlen)
+{
+	struct sock *sk = sock->sk;
+	struct l2cap_options opts;
+	struct l2cap_conninfo cinfo;
+	int len, err = 0;
+	u32 opt;
+
+	BT_DBG("sk %p", sk);
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	lock_sock(sk);
+
+	switch (optname) {
+	case L2CAP_OPTIONS:
+		opts.imtu     = l2cap_pi(sk)->imtu;
+		opts.omtu     = l2cap_pi(sk)->omtu;
+		opts.flush_to = l2cap_pi(sk)->flush_to;
+		opts.mode     = l2cap_pi(sk)->mode;
+		opts.fcs      = l2cap_pi(sk)->fcs;
+		opts.max_tx   = l2cap_pi(sk)->max_tx;
+		opts.txwin_size = (__u16)l2cap_pi(sk)->tx_win;
+
+		len = min_t(unsigned int, len, sizeof(opts));
+		if (copy_to_user(optval, (char *) &opts, len))
+			err = -EFAULT;
+
+		break;
+
+	case L2CAP_LM:
+		switch (l2cap_pi(sk)->sec_level) {
+		case BT_SECURITY_LOW:
+			opt = L2CAP_LM_AUTH;
+			break;
+		case BT_SECURITY_MEDIUM:
+			opt = L2CAP_LM_AUTH | L2CAP_LM_ENCRYPT;
+			break;
+		case BT_SECURITY_HIGH:
+			opt = L2CAP_LM_AUTH | L2CAP_LM_ENCRYPT |
+							L2CAP_LM_SECURE;
+			break;
+		default:
+			opt = 0;
+			break;
+		}
+
+		if (l2cap_pi(sk)->role_switch)
+			opt |= L2CAP_LM_MASTER;
+
+		if (l2cap_pi(sk)->force_reliable)
+			opt |= L2CAP_LM_RELIABLE;
+
+		if (put_user(opt, (u32 __user *) optval))
+			err = -EFAULT;
+		break;
+
+	case L2CAP_CONNINFO:
+		if (sk->sk_state != BT_CONNECTED &&
+					!(sk->sk_state == BT_CONNECT2 &&
+						bt_sk(sk)->defer_setup)) {
+			err = -ENOTCONN;
+			break;
+		}
+
+		cinfo.hci_handle = l2cap_pi(sk)->conn->hcon->handle;
+		memcpy(cinfo.dev_class, l2cap_pi(sk)->conn->hcon->dev_class, 3);
+
+		len = min_t(unsigned int, len, sizeof(cinfo));
+		if (copy_to_user(optval, (char *) &cinfo, len))
+			err = -EFAULT;
+
+		break;
+
+	default:
+		err = -ENOPROTOOPT;
+		break;
+	}
+
+	release_sock(sk);
+	return err;
+}
+
+static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen)
+{
+	struct sock *sk = sock->sk;
+	struct bt_security sec;
+	int len, err = 0;
+
+	BT_DBG("sk %p", sk);
+
+	if (level == SOL_L2CAP)
+		return l2cap_sock_getsockopt_old(sock, optname, optval, optlen);
+
+	if (level != SOL_BLUETOOTH)
+		return -ENOPROTOOPT;
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	lock_sock(sk);
+
+	switch (optname) {
+	case BT_SECURITY:
+		if (sk->sk_type != SOCK_SEQPACKET && sk->sk_type != SOCK_STREAM
+				&& sk->sk_type != SOCK_RAW) {
+			err = -EINVAL;
+			break;
+		}
+
+		sec.level = l2cap_pi(sk)->sec_level;
+
+		len = min_t(unsigned int, len, sizeof(sec));
+		if (copy_to_user(optval, (char *) &sec, len))
+			err = -EFAULT;
+
+		break;
+
+	case BT_DEFER_SETUP:
+		if (sk->sk_state != BT_BOUND && sk->sk_state != BT_LISTEN) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (put_user(bt_sk(sk)->defer_setup, (u32 __user *) optval))
+			err = -EFAULT;
+
+		break;
+
+	case BT_FLUSHABLE:
+		if (put_user(l2cap_pi(sk)->flushable, (u32 __user *) optval))
+			err = -EFAULT;
+
+		break;
+
+	default:
+		err = -ENOPROTOOPT;
+		break;
+	}
+
+	release_sock(sk);
+	return err;
+}
+
 static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __user *optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
-- 
1.7.4.rc3

