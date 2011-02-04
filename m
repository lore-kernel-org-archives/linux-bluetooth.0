Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next 15/16] Bluetooth: move l2cap_sock_kill() to l2cap_sock.c
Date: Fri,  4 Feb 2011 04:01:57 -0200
Message-Id: <1296799318-5517-16-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1296799318-5517-15-git-send-email-padovan@profusion.mobi>
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
 <1296799318-5517-11-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-12-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-13-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-14-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-15-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap_core.c |   16 ----------------
 net/bluetooth/l2cap_sock.c |   16 ++++++++++++++++
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1baa16c..0ba097d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -753,22 +753,6 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 	sock_set_flag(parent, SOCK_ZAPPED);
 }
 
-/* Kill socket (only if zapped and orphan)
- * Must be called on unlocked socket.
- */
-void l2cap_sock_kill(struct sock *sk)
-{
-	if (!sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket)
-		return;
-
-	BT_DBG("sk %p state %d", sk, sk->sk_state);
-
-	/* Kill poor orphan */
-	bt_sock_unlink(&l2cap_sk_list, sk);
-	sock_set_flag(sk, SOCK_DEAD);
-	sock_put(sk);
-}
-
 void __l2cap_sock_close(struct sock *sk, int reason)
 {
 	BT_DBG("sk %p state %d socket %p", sk, sk->sk_state, sk->sk_socket);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 23bb968..4b4e020 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -838,6 +838,22 @@ static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct ms
 	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
 }
 
+/* Kill socket (only if zapped and orphan)
+ * Must be called on unlocked socket.
+ */
+void l2cap_sock_kill(struct sock *sk)
+{
+	if (!sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket)
+		return;
+
+	BT_DBG("sk %p state %d", sk, sk->sk_state);
+
+	/* Kill poor orphan */
+	bt_sock_unlink(&l2cap_sk_list, sk);
+	sock_set_flag(sk, SOCK_DEAD);
+	sock_put(sk);
+}
+
 static int l2cap_sock_shutdown(struct socket *sock, int how)
 {
 	struct sock *sk = sock->sk;
-- 
1.7.4.rc3

