Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next 07/16] Bluetooth: move l2cap_sock_getname() to l2cap_sock.c
Date: Fri,  4 Feb 2011 04:01:49 -0200
Message-Id: <1296799318-5517-8-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1296799318-5517-7-git-send-email-padovan@profusion.mobi>
References: <1296799318-5517-1-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-2-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-3-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-4-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-5-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-6-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-7-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    1 -
 net/bluetooth/l2cap_core.c    |   23 -----------------------
 net/bluetooth/l2cap_sock.c    |   23 +++++++++++++++++++++++
 3 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 7921b6b..0d0c180 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -439,7 +439,6 @@ struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 							int proto, gfp_t prio);
 
 int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int alen, int flags);
-int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr, int *len, int peer);
 int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len);
 int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len, int flags);
 int l2cap_sock_shutdown(struct socket *sock, int how);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 32a615a..6d0d81d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -992,29 +992,6 @@ done:
 	return err;
 }
 
-int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr, int *len, int peer)
-{
-	struct sockaddr_l2 *la = (struct sockaddr_l2 *) addr;
-	struct sock *sk = sock->sk;
-
-	BT_DBG("sock %p, sk %p", sock, sk);
-
-	addr->sa_family = AF_BLUETOOTH;
-	*len = sizeof(struct sockaddr_l2);
-
-	if (peer) {
-		la->l2_psm = l2cap_pi(sk)->psm;
-		bacpy(&la->l2_bdaddr, &bt_sk(sk)->dst);
-		la->l2_cid = cpu_to_le16(l2cap_pi(sk)->dcid);
-	} else {
-		la->l2_psm = l2cap_pi(sk)->sport;
-		bacpy(&la->l2_bdaddr, &bt_sk(sk)->src);
-		la->l2_cid = cpu_to_le16(l2cap_pi(sk)->scid);
-	}
-
-	return 0;
-}
-
 static int __l2cap_wait_ack(struct sock *sk)
 {
 	DECLARE_WAITQUEUE(wait, current);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index b19a386..4c13f8b 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -253,6 +253,29 @@ done:
 	return err;
 }
 
+static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr, int *len, int peer)
+{
+	struct sockaddr_l2 *la = (struct sockaddr_l2 *) addr;
+	struct sock *sk = sock->sk;
+
+	BT_DBG("sock %p, sk %p", sock, sk);
+
+	addr->sa_family = AF_BLUETOOTH;
+	*len = sizeof(struct sockaddr_l2);
+
+	if (peer) {
+		la->l2_psm = l2cap_pi(sk)->psm;
+		bacpy(&la->l2_bdaddr, &bt_sk(sk)->dst);
+		la->l2_cid = cpu_to_le16(l2cap_pi(sk)->dcid);
+	} else {
+		la->l2_psm = l2cap_pi(sk)->sport;
+		bacpy(&la->l2_bdaddr, &bt_sk(sk)->src);
+		la->l2_cid = cpu_to_le16(l2cap_pi(sk)->scid);
+	}
+
+	return 0;
+}
+
 static int l2cap_sock_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
-- 
1.7.4.rc3

