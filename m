Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next 04/16] Bluetooth: move l2cap_sock_release() to l2cap_sock.c
Date: Fri,  4 Feb 2011 04:01:46 -0200
Message-Id: <1296799318-5517-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1296799318-5517-4-git-send-email-padovan@profusion.mobi>
References: <1296799318-5517-1-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-2-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-3-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-4-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    1 -
 net/bluetooth/l2cap_core.c    |   17 -----------------
 net/bluetooth/l2cap_sock.c    |   17 +++++++++++++++++
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 533bef5..d0baf41 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -438,7 +438,6 @@ void l2cap_sock_init(struct sock *sk, struct sock *parent);
 struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 							int proto, gfp_t prio);
 
-int l2cap_sock_release(struct socket *sock);
 int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen);
 int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int alen, int flags);
 int l2cap_sock_listen(struct socket *sock, int backlog);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d11bcf2..fd2b940 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2158,23 +2158,6 @@ int l2cap_sock_shutdown(struct socket *sock, int how)
 	return err;
 }
 
-int l2cap_sock_release(struct socket *sock)
-{
-	struct sock *sk = sock->sk;
-	int err;
-
-	BT_DBG("sock %p, sk %p", sock, sk);
-
-	if (!sk)
-		return 0;
-
-	err = l2cap_sock_shutdown(sock, 2);
-
-	sock_orphan(sk);
-	l2cap_sock_kill(sk);
-	return err;
-}
-
 static void l2cap_chan_ready(struct sock *sk)
 {
 	struct sock *parent = bt_sk(sk)->parent;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index c1455f7..20efd24 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -62,6 +62,23 @@ static void l2cap_sock_timeout(unsigned long arg)
 	sock_put(sk);
 }
 
+static int l2cap_sock_release(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+	int err;
+
+	BT_DBG("sock %p, sk %p", sock, sk);
+
+	if (!sk)
+		return 0;
+
+	err = l2cap_sock_shutdown(sock, 2);
+
+	sock_orphan(sk);
+	l2cap_sock_kill(sk);
+	return err;
+}
+
 static void l2cap_sock_destruct(struct sock *sk)
 {
 	BT_DBG("sk %p", sk);
-- 
1.7.4.rc3

