Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next 10/16] Bluetooth: move l2cap_sock_connect() to l2cap_sock.c
Date: Fri,  4 Feb 2011 04:01:52 -0200
Message-Id: <1296799318-5517-11-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1296799318-5517-10-git-send-email-padovan@profusion.mobi>
References: <1296799318-5517-1-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-2-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-3-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-4-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-5-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-6-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-7-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-8-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-9-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-10-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    2 +-
 net/bluetooth/l2cap_core.c    |   87 +----------------------------------------
 net/bluetooth/l2cap_sock.c    |   85 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 87 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 1905aad..b5ebf87 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -437,8 +437,8 @@ void l2cap_sock_kill(struct sock *sk);
 void l2cap_sock_init(struct sock *sk, struct sock *parent);
 struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 							int proto, gfp_t prio);
+int l2cap_do_connect(struct sock *sk);
 
-int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int alen, int flags);
 int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len);
 int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len, int flags);
 int l2cap_sock_shutdown(struct socket *sock, int how);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 34fc6b4..2d141fc 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -847,7 +847,7 @@ static void l2cap_sock_close(struct sock *sk)
 	l2cap_sock_kill(sk);
 }
 
-static int l2cap_do_connect(struct sock *sk)
+int l2cap_do_connect(struct sock *sk)
 {
 	bdaddr_t *src = &bt_sk(sk)->src;
 	bdaddr_t *dst = &bt_sk(sk)->dst;
@@ -907,91 +907,6 @@ done:
 	return err;
 }
 
-int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int alen, int flags)
-{
-	struct sock *sk = sock->sk;
-	struct sockaddr_l2 la;
-	int len, err = 0;
-
-	BT_DBG("sk %p", sk);
-
-	if (!addr || alen < sizeof(addr->sa_family) ||
-	    addr->sa_family != AF_BLUETOOTH)
-		return -EINVAL;
-
-	memset(&la, 0, sizeof(la));
-	len = min_t(unsigned int, sizeof(la), alen);
-	memcpy(&la, addr, len);
-
-	if (la.l2_cid)
-		return -EINVAL;
-
-	lock_sock(sk);
-
-	if ((sk->sk_type == SOCK_SEQPACKET || sk->sk_type == SOCK_STREAM)
-			&& !la.l2_psm) {
-		err = -EINVAL;
-		goto done;
-	}
-
-	switch (l2cap_pi(sk)->mode) {
-	case L2CAP_MODE_BASIC:
-		break;
-	case L2CAP_MODE_ERTM:
-	case L2CAP_MODE_STREAMING:
-		if (!disable_ertm)
-			break;
-		/* fall through */
-	default:
-		err = -ENOTSUPP;
-		goto done;
-	}
-
-	switch (sk->sk_state) {
-	case BT_CONNECT:
-	case BT_CONNECT2:
-	case BT_CONFIG:
-		/* Already connecting */
-		goto wait;
-
-	case BT_CONNECTED:
-		/* Already connected */
-		err = -EISCONN;
-		goto done;
-
-	case BT_OPEN:
-	case BT_BOUND:
-		/* Can connect */
-		break;
-
-	default:
-		err = -EBADFD;
-		goto done;
-	}
-
-	/* PSM must be odd and lsb of upper byte must be 0 */
-	if ((__le16_to_cpu(la.l2_psm) & 0x0101) != 0x0001 &&
-		sk->sk_type != SOCK_RAW) {
-		err = -EINVAL;
-		goto done;
-	}
-
-	/* Set destination address and psm */
-	bacpy(&bt_sk(sk)->dst, &la.l2_bdaddr);
-	l2cap_pi(sk)->psm = la.l2_psm;
-
-	err = l2cap_do_connect(sk);
-	if (err)
-		goto done;
-
-wait:
-	err = bt_sock_wait_state(sk, BT_CONNECTED,
-			sock_sndtimeo(sk, flags & O_NONBLOCK));
-done:
-	release_sock(sk);
-	return err;
-}
-
 static int __l2cap_wait_ack(struct sock *sk)
 {
 	DECLARE_WAITQUEUE(wait, current);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index b7d5ae9..e2f14f1 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -139,6 +139,91 @@ done:
 	return err;
 }
 
+static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int alen, int flags)
+{
+	struct sock *sk = sock->sk;
+	struct sockaddr_l2 la;
+	int len, err = 0;
+
+	BT_DBG("sk %p", sk);
+
+	if (!addr || alen < sizeof(addr->sa_family) ||
+	    addr->sa_family != AF_BLUETOOTH)
+		return -EINVAL;
+
+	memset(&la, 0, sizeof(la));
+	len = min_t(unsigned int, sizeof(la), alen);
+	memcpy(&la, addr, len);
+
+	if (la.l2_cid)
+		return -EINVAL;
+
+	lock_sock(sk);
+
+	if ((sk->sk_type == SOCK_SEQPACKET || sk->sk_type == SOCK_STREAM)
+			&& !la.l2_psm) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	switch (l2cap_pi(sk)->mode) {
+	case L2CAP_MODE_BASIC:
+		break;
+	case L2CAP_MODE_ERTM:
+	case L2CAP_MODE_STREAMING:
+		if (!disable_ertm)
+			break;
+		/* fall through */
+	default:
+		err = -ENOTSUPP;
+		goto done;
+	}
+
+	switch (sk->sk_state) {
+	case BT_CONNECT:
+	case BT_CONNECT2:
+	case BT_CONFIG:
+		/* Already connecting */
+		goto wait;
+
+	case BT_CONNECTED:
+		/* Already connected */
+		err = -EISCONN;
+		goto done;
+
+	case BT_OPEN:
+	case BT_BOUND:
+		/* Can connect */
+		break;
+
+	default:
+		err = -EBADFD;
+		goto done;
+	}
+
+	/* PSM must be odd and lsb of upper byte must be 0 */
+	if ((__le16_to_cpu(la.l2_psm) & 0x0101) != 0x0001 &&
+		sk->sk_type != SOCK_RAW) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	/* Set destination address and psm */
+	bacpy(&bt_sk(sk)->dst, &la.l2_bdaddr);
+	l2cap_pi(sk)->psm = la.l2_psm;
+
+	err = l2cap_do_connect(sk);
+	if (err)
+		goto done;
+
+wait:
+	err = bt_sock_wait_state(sk, BT_CONNECTED,
+			sock_sndtimeo(sk, flags & O_NONBLOCK));
+done:
+	release_sock(sk);
+	return err;
+}
+
 static int l2cap_sock_listen(struct socket *sock, int backlog)
 {
 	struct sock *sk = sock->sk;
-- 
1.7.4.rc3

