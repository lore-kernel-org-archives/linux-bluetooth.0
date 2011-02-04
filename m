Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next 08/16] Bluetooth: move l2cap_sock_setsockopt() to l2cap_sock.c
Date: Fri,  4 Feb 2011 04:01:50 -0200
Message-Id: <1296799318-5517-9-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1296799318-5517-8-git-send-email-padovan@profusion.mobi>
References: <1296799318-5517-1-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-2-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-3-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-4-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-5-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-6-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-7-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-8-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    1 -
 net/bluetooth/l2cap_core.c    |  174 ----------------------------------------
 net/bluetooth/l2cap_sock.c    |  175 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+), 175 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 0d0c180..901ecbe 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -442,7 +442,6 @@ int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int alen, int
 int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len);
 int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len, int flags);
 int l2cap_sock_shutdown(struct socket *sock, int how);
-int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen);
 int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen);
 
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6d0d81d..26ec2b8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1595,180 +1595,6 @@ int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *m
 	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
 }
 
-static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __user *optval, unsigned int optlen)
-{
-	struct sock *sk = sock->sk;
-	struct l2cap_options opts;
-	int len, err = 0;
-	u32 opt;
-
-	BT_DBG("sk %p", sk);
-
-	lock_sock(sk);
-
-	switch (optname) {
-	case L2CAP_OPTIONS:
-		if (sk->sk_state == BT_CONNECTED) {
-			err = -EINVAL;
-			break;
-		}
-
-		opts.imtu     = l2cap_pi(sk)->imtu;
-		opts.omtu     = l2cap_pi(sk)->omtu;
-		opts.flush_to = l2cap_pi(sk)->flush_to;
-		opts.mode     = l2cap_pi(sk)->mode;
-		opts.fcs      = l2cap_pi(sk)->fcs;
-		opts.max_tx   = l2cap_pi(sk)->max_tx;
-		opts.txwin_size = (__u16)l2cap_pi(sk)->tx_win;
-
-		len = min_t(unsigned int, sizeof(opts), optlen);
-		if (copy_from_user((char *) &opts, optval, len)) {
-			err = -EFAULT;
-			break;
-		}
-
-		if (opts.txwin_size > L2CAP_DEFAULT_TX_WINDOW) {
-			err = -EINVAL;
-			break;
-		}
-
-		l2cap_pi(sk)->mode = opts.mode;
-		switch (l2cap_pi(sk)->mode) {
-		case L2CAP_MODE_BASIC:
-			l2cap_pi(sk)->conf_state &= ~L2CAP_CONF_STATE2_DEVICE;
-			break;
-		case L2CAP_MODE_ERTM:
-		case L2CAP_MODE_STREAMING:
-			if (!disable_ertm)
-				break;
-			/* fall through */
-		default:
-			err = -EINVAL;
-			break;
-		}
-
-		l2cap_pi(sk)->imtu = opts.imtu;
-		l2cap_pi(sk)->omtu = opts.omtu;
-		l2cap_pi(sk)->fcs  = opts.fcs;
-		l2cap_pi(sk)->max_tx = opts.max_tx;
-		l2cap_pi(sk)->tx_win = (__u8)opts.txwin_size;
-		break;
-
-	case L2CAP_LM:
-		if (get_user(opt, (u32 __user *) optval)) {
-			err = -EFAULT;
-			break;
-		}
-
-		if (opt & L2CAP_LM_AUTH)
-			l2cap_pi(sk)->sec_level = BT_SECURITY_LOW;
-		if (opt & L2CAP_LM_ENCRYPT)
-			l2cap_pi(sk)->sec_level = BT_SECURITY_MEDIUM;
-		if (opt & L2CAP_LM_SECURE)
-			l2cap_pi(sk)->sec_level = BT_SECURITY_HIGH;
-
-		l2cap_pi(sk)->role_switch    = (opt & L2CAP_LM_MASTER);
-		l2cap_pi(sk)->force_reliable = (opt & L2CAP_LM_RELIABLE);
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
-int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen)
-{
-	struct sock *sk = sock->sk;
-	struct bt_security sec;
-	int len, err = 0;
-	u32 opt;
-
-	BT_DBG("sk %p", sk);
-
-	if (level == SOL_L2CAP)
-		return l2cap_sock_setsockopt_old(sock, optname, optval, optlen);
-
-	if (level != SOL_BLUETOOTH)
-		return -ENOPROTOOPT;
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
-		sec.level = BT_SECURITY_LOW;
-
-		len = min_t(unsigned int, sizeof(sec), optlen);
-		if (copy_from_user((char *) &sec, optval, len)) {
-			err = -EFAULT;
-			break;
-		}
-
-		if (sec.level < BT_SECURITY_LOW ||
-					sec.level > BT_SECURITY_HIGH) {
-			err = -EINVAL;
-			break;
-		}
-
-		l2cap_pi(sk)->sec_level = sec.level;
-		break;
-
-	case BT_DEFER_SETUP:
-		if (sk->sk_state != BT_BOUND && sk->sk_state != BT_LISTEN) {
-			err = -EINVAL;
-			break;
-		}
-
-		if (get_user(opt, (u32 __user *) optval)) {
-			err = -EFAULT;
-			break;
-		}
-
-		bt_sk(sk)->defer_setup = opt;
-		break;
-
-	case BT_FLUSHABLE:
-		if (get_user(opt, (u32 __user *) optval)) {
-			err = -EFAULT;
-			break;
-		}
-
-		if (opt > BT_FLUSHABLE_ON) {
-			err = -EINVAL;
-			break;
-		}
-
-		if (opt == BT_FLUSHABLE_OFF) {
-			struct l2cap_conn *conn = l2cap_pi(sk)->conn;
-			/* proceed futher only when we have l2cap_conn and
-			   No Flush support in the LM */
-			if (!conn || !lmp_no_flush_capable(conn->hcon->hdev)) {
-				err = -EINVAL;
-				break;
-			}
-		}
-
-		l2cap_pi(sk)->flushable = opt;
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
 static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __user *optval, int __user *optlen)
 {
 	struct sock *sk = sock->sk;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 4c13f8b..1bbe8a0 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -27,6 +27,7 @@
 /* Bluetooth L2CAP sockets. */
 
 #include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 
 static void l2cap_sock_timeout(unsigned long arg)
@@ -276,6 +277,180 @@ static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr, int *l
 	return 0;
 }
 
+static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __user *optval, unsigned int optlen)
+{
+	struct sock *sk = sock->sk;
+	struct l2cap_options opts;
+	int len, err = 0;
+	u32 opt;
+
+	BT_DBG("sk %p", sk);
+
+	lock_sock(sk);
+
+	switch (optname) {
+	case L2CAP_OPTIONS:
+		if (sk->sk_state == BT_CONNECTED) {
+			err = -EINVAL;
+			break;
+		}
+
+		opts.imtu     = l2cap_pi(sk)->imtu;
+		opts.omtu     = l2cap_pi(sk)->omtu;
+		opts.flush_to = l2cap_pi(sk)->flush_to;
+		opts.mode     = l2cap_pi(sk)->mode;
+		opts.fcs      = l2cap_pi(sk)->fcs;
+		opts.max_tx   = l2cap_pi(sk)->max_tx;
+		opts.txwin_size = (__u16)l2cap_pi(sk)->tx_win;
+
+		len = min_t(unsigned int, sizeof(opts), optlen);
+		if (copy_from_user((char *) &opts, optval, len)) {
+			err = -EFAULT;
+			break;
+		}
+
+		if (opts.txwin_size > L2CAP_DEFAULT_TX_WINDOW) {
+			err = -EINVAL;
+			break;
+		}
+
+		l2cap_pi(sk)->mode = opts.mode;
+		switch (l2cap_pi(sk)->mode) {
+		case L2CAP_MODE_BASIC:
+			l2cap_pi(sk)->conf_state &= ~L2CAP_CONF_STATE2_DEVICE;
+			break;
+		case L2CAP_MODE_ERTM:
+		case L2CAP_MODE_STREAMING:
+			if (!disable_ertm)
+				break;
+			/* fall through */
+		default:
+			err = -EINVAL;
+			break;
+		}
+
+		l2cap_pi(sk)->imtu = opts.imtu;
+		l2cap_pi(sk)->omtu = opts.omtu;
+		l2cap_pi(sk)->fcs  = opts.fcs;
+		l2cap_pi(sk)->max_tx = opts.max_tx;
+		l2cap_pi(sk)->tx_win = (__u8)opts.txwin_size;
+		break;
+
+	case L2CAP_LM:
+		if (get_user(opt, (u32 __user *) optval)) {
+			err = -EFAULT;
+			break;
+		}
+
+		if (opt & L2CAP_LM_AUTH)
+			l2cap_pi(sk)->sec_level = BT_SECURITY_LOW;
+		if (opt & L2CAP_LM_ENCRYPT)
+			l2cap_pi(sk)->sec_level = BT_SECURITY_MEDIUM;
+		if (opt & L2CAP_LM_SECURE)
+			l2cap_pi(sk)->sec_level = BT_SECURITY_HIGH;
+
+		l2cap_pi(sk)->role_switch    = (opt & L2CAP_LM_MASTER);
+		l2cap_pi(sk)->force_reliable = (opt & L2CAP_LM_RELIABLE);
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
+static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen)
+{
+	struct sock *sk = sock->sk;
+	struct bt_security sec;
+	int len, err = 0;
+	u32 opt;
+
+	BT_DBG("sk %p", sk);
+
+	if (level == SOL_L2CAP)
+		return l2cap_sock_setsockopt_old(sock, optname, optval, optlen);
+
+	if (level != SOL_BLUETOOTH)
+		return -ENOPROTOOPT;
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
+		sec.level = BT_SECURITY_LOW;
+
+		len = min_t(unsigned int, sizeof(sec), optlen);
+		if (copy_from_user((char *) &sec, optval, len)) {
+			err = -EFAULT;
+			break;
+		}
+
+		if (sec.level < BT_SECURITY_LOW ||
+					sec.level > BT_SECURITY_HIGH) {
+			err = -EINVAL;
+			break;
+		}
+
+		l2cap_pi(sk)->sec_level = sec.level;
+		break;
+
+	case BT_DEFER_SETUP:
+		if (sk->sk_state != BT_BOUND && sk->sk_state != BT_LISTEN) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (get_user(opt, (u32 __user *) optval)) {
+			err = -EFAULT;
+			break;
+		}
+
+		bt_sk(sk)->defer_setup = opt;
+		break;
+
+	case BT_FLUSHABLE:
+		if (get_user(opt, (u32 __user *) optval)) {
+			err = -EFAULT;
+			break;
+		}
+
+		if (opt > BT_FLUSHABLE_ON) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (opt == BT_FLUSHABLE_OFF) {
+			struct l2cap_conn *conn = l2cap_pi(sk)->conn;
+			/* proceed futher only when we have l2cap_conn and
+			   No Flush support in the LM */
+			if (!conn || !lmp_no_flush_capable(conn->hcon->hdev)) {
+				err = -EINVAL;
+				break;
+			}
+		}
+
+		l2cap_pi(sk)->flushable = opt;
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
 static int l2cap_sock_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
-- 
1.7.4.rc3

