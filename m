Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next 05/16] Bluetooth: move l2cap_sock_bind()/listen() to l2cap_sock.c
Date: Fri,  4 Feb 2011 04:01:47 -0200
Message-Id: <1296799318-5517-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1296799318-5517-5-git-send-email-padovan@profusion.mobi>
References: <1296799318-5517-1-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-2-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-3-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-4-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-5-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    2 -
 net/bluetooth/l2cap_core.c    |  134 ----------------------------------------
 net/bluetooth/l2cap_sock.c    |  135 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 135 insertions(+), 136 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index d0baf41..3ca4fe3 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -438,9 +438,7 @@ void l2cap_sock_init(struct sock *sk, struct sock *parent);
 struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 							int proto, gfp_t prio);
 
-int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen);
 int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int alen, int flags);
-int l2cap_sock_listen(struct socket *sock, int backlog);
 int l2cap_sock_accept(struct socket *sock, struct socket *newsock, int flags);
 int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr, int *len, int peer);
 int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fd2b940..c4a90c5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -722,17 +722,6 @@ static inline void l2cap_chan_add(struct l2cap_conn *conn, struct sock *sk, stru
 }
 
 /* ---- Socket interface ---- */
-static struct sock *__l2cap_get_sock_by_addr(__le16 psm, bdaddr_t *src)
-{
-	struct sock *sk;
-	struct hlist_node *node;
-	sk_for_each(sk, node, &l2cap_sk_list.head)
-		if (l2cap_pi(sk)->sport == psm && !bacmp(&bt_sk(sk)->src, src))
-			goto found;
-	sk = NULL;
-found:
-	return sk;
-}
 
 /* Find socket with psm and source bdaddr.
  * Returns closest match.
@@ -858,70 +847,6 @@ static void l2cap_sock_close(struct sock *sk)
 	l2cap_sock_kill(sk);
 }
 
-int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
-{
-	struct sock *sk = sock->sk;
-	struct sockaddr_l2 la;
-	int len, err = 0;
-
-	BT_DBG("sk %p", sk);
-
-	if (!addr || addr->sa_family != AF_BLUETOOTH)
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
-	if (sk->sk_state != BT_OPEN) {
-		err = -EBADFD;
-		goto done;
-	}
-
-	if (la.l2_psm) {
-		__u16 psm = __le16_to_cpu(la.l2_psm);
-
-		/* PSM must be odd and lsb of upper byte must be 0 */
-		if ((psm & 0x0101) != 0x0001) {
-			err = -EINVAL;
-			goto done;
-		}
-
-		/* Restrict usage of well-known PSMs */
-		if (psm < 0x1001 && !capable(CAP_NET_BIND_SERVICE)) {
-			err = -EACCES;
-			goto done;
-		}
-	}
-
-	write_lock_bh(&l2cap_sk_list.lock);
-
-	if (la.l2_psm && __l2cap_get_sock_by_addr(la.l2_psm, &la.l2_bdaddr)) {
-		err = -EADDRINUSE;
-	} else {
-		/* Save source address */
-		bacpy(&bt_sk(sk)->src, &la.l2_bdaddr);
-		l2cap_pi(sk)->psm   = la.l2_psm;
-		l2cap_pi(sk)->sport = la.l2_psm;
-		sk->sk_state = BT_BOUND;
-
-		if (__le16_to_cpu(la.l2_psm) == 0x0001 ||
-					__le16_to_cpu(la.l2_psm) == 0x0003)
-			l2cap_pi(sk)->sec_level = BT_SECURITY_SDP;
-	}
-
-	write_unlock_bh(&l2cap_sk_list.lock);
-
-done:
-	release_sock(sk);
-	return err;
-}
-
 static int l2cap_do_connect(struct sock *sk)
 {
 	bdaddr_t *src = &bt_sk(sk)->src;
@@ -1067,65 +992,6 @@ done:
 	return err;
 }
 
-int l2cap_sock_listen(struct socket *sock, int backlog)
-{
-	struct sock *sk = sock->sk;
-	int err = 0;
-
-	BT_DBG("sk %p backlog %d", sk, backlog);
-
-	lock_sock(sk);
-
-	if ((sock->type != SOCK_SEQPACKET && sock->type != SOCK_STREAM)
-			|| sk->sk_state != BT_BOUND) {
-		err = -EBADFD;
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
-	if (!l2cap_pi(sk)->psm) {
-		bdaddr_t *src = &bt_sk(sk)->src;
-		u16 psm;
-
-		err = -EINVAL;
-
-		write_lock_bh(&l2cap_sk_list.lock);
-
-		for (psm = 0x1001; psm < 0x1100; psm += 2)
-			if (!__l2cap_get_sock_by_addr(cpu_to_le16(psm), src)) {
-				l2cap_pi(sk)->psm   = cpu_to_le16(psm);
-				l2cap_pi(sk)->sport = cpu_to_le16(psm);
-				err = 0;
-				break;
-			}
-
-		write_unlock_bh(&l2cap_sk_list.lock);
-
-		if (err < 0)
-			goto done;
-	}
-
-	sk->sk_max_ack_backlog = backlog;
-	sk->sk_ack_backlog = 0;
-	sk->sk_state = BT_LISTEN;
-
-done:
-	release_sock(sk);
-	return err;
-}
-
 int l2cap_sock_accept(struct socket *sock, struct socket *newsock, int flags)
 {
 	DECLARE_WAITQUEUE(wait, current);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 20efd24..ef9a60f 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -62,6 +62,141 @@ static void l2cap_sock_timeout(unsigned long arg)
 	sock_put(sk);
 }
 
+static struct sock *__l2cap_get_sock_by_addr(__le16 psm, bdaddr_t *src)
+{
+	struct sock *sk;
+	struct hlist_node *node;
+	sk_for_each(sk, node, &l2cap_sk_list.head)
+		if (l2cap_pi(sk)->sport == psm && !bacmp(&bt_sk(sk)->src, src))
+			goto found;
+	sk = NULL;
+found:
+	return sk;
+}
+
+static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
+{
+	struct sock *sk = sock->sk;
+	struct sockaddr_l2 la;
+	int len, err = 0;
+
+	BT_DBG("sk %p", sk);
+
+	if (!addr || addr->sa_family != AF_BLUETOOTH)
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
+	if (sk->sk_state != BT_OPEN) {
+		err = -EBADFD;
+		goto done;
+	}
+
+	if (la.l2_psm) {
+		__u16 psm = __le16_to_cpu(la.l2_psm);
+
+		/* PSM must be odd and lsb of upper byte must be 0 */
+		if ((psm & 0x0101) != 0x0001) {
+			err = -EINVAL;
+			goto done;
+		}
+
+		/* Restrict usage of well-known PSMs */
+		if (psm < 0x1001 && !capable(CAP_NET_BIND_SERVICE)) {
+			err = -EACCES;
+			goto done;
+		}
+	}
+
+	write_lock_bh(&l2cap_sk_list.lock);
+
+	if (la.l2_psm && __l2cap_get_sock_by_addr(la.l2_psm, &la.l2_bdaddr)) {
+		err = -EADDRINUSE;
+	} else {
+		/* Save source address */
+		bacpy(&bt_sk(sk)->src, &la.l2_bdaddr);
+		l2cap_pi(sk)->psm   = la.l2_psm;
+		l2cap_pi(sk)->sport = la.l2_psm;
+		sk->sk_state = BT_BOUND;
+
+		if (__le16_to_cpu(la.l2_psm) == 0x0001 ||
+					__le16_to_cpu(la.l2_psm) == 0x0003)
+			l2cap_pi(sk)->sec_level = BT_SECURITY_SDP;
+	}
+
+	write_unlock_bh(&l2cap_sk_list.lock);
+
+done:
+	release_sock(sk);
+	return err;
+}
+
+static int l2cap_sock_listen(struct socket *sock, int backlog)
+{
+	struct sock *sk = sock->sk;
+	int err = 0;
+
+	BT_DBG("sk %p backlog %d", sk, backlog);
+
+	lock_sock(sk);
+
+	if ((sock->type != SOCK_SEQPACKET && sock->type != SOCK_STREAM)
+			|| sk->sk_state != BT_BOUND) {
+		err = -EBADFD;
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
+	if (!l2cap_pi(sk)->psm) {
+		bdaddr_t *src = &bt_sk(sk)->src;
+		u16 psm;
+
+		err = -EINVAL;
+
+		write_lock_bh(&l2cap_sk_list.lock);
+
+		for (psm = 0x1001; psm < 0x1100; psm += 2)
+			if (!__l2cap_get_sock_by_addr(cpu_to_le16(psm), src)) {
+				l2cap_pi(sk)->psm   = cpu_to_le16(psm);
+				l2cap_pi(sk)->sport = cpu_to_le16(psm);
+				err = 0;
+				break;
+			}
+
+		write_unlock_bh(&l2cap_sk_list.lock);
+
+		if (err < 0)
+			goto done;
+	}
+
+	sk->sk_max_ack_backlog = backlog;
+	sk->sk_ack_backlog = 0;
+	sk->sk_state = BT_LISTEN;
+
+done:
+	release_sock(sk);
+	return err;
+}
+
 static int l2cap_sock_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
-- 
1.7.4.rc3

