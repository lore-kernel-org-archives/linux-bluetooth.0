Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Remove unneeded forward declaration of sco_chan_del
Date: Sun, 13 Jul 2014 19:54:49 +0200
Message-Id: <1405274089-22043-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The forward declaration of sco_chan_del is not needed and thus just
remove it. Move sco_chan_del into the proper location.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/sco.c | 56 ++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 75cffc14ab6e..4d67b0354d23 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -53,8 +53,6 @@ struct sco_conn {
 #define sco_conn_lock(c)	spin_lock(&c->lock);
 #define sco_conn_unlock(c)	spin_unlock(&c->lock);
 
-static void sco_chan_del(struct sock *sk, int err);
-
 static void sco_sock_close(struct sock *sk);
 static void sco_sock_kill(struct sock *sk);
 
@@ -138,6 +136,33 @@ static struct sock *sco_chan_get(struct sco_conn *conn)
 	return sk;
 }
 
+/* Delete channel.
+ * Must be called on the locked socket. */
+static void sco_chan_del(struct sock *sk, int err)
+{
+	struct sco_conn *conn;
+
+	conn = sco_pi(sk)->conn;
+
+	BT_DBG("sk %p, conn %p, err %d", sk, conn, err);
+
+	if (conn) {
+		sco_conn_lock(conn);
+		conn->sk = NULL;
+		sco_pi(sk)->conn = NULL;
+		sco_conn_unlock(conn);
+
+		if (conn->hcon)
+			hci_conn_drop(conn->hcon);
+	}
+
+	sk->sk_state = BT_CLOSED;
+	sk->sk_err   = err;
+	sk->sk_state_change(sk);
+
+	sock_set_flag(sk, SOCK_ZAPPED);
+}
+
 static int sco_conn_del(struct hci_conn *hcon, int err)
 {
 	struct sco_conn *conn = hcon->sco_data;
@@ -978,33 +1003,6 @@ static int sco_sock_release(struct socket *sock)
 	return err;
 }
 
-/* Delete channel.
- * Must be called on the locked socket. */
-static void sco_chan_del(struct sock *sk, int err)
-{
-	struct sco_conn *conn;
-
-	conn = sco_pi(sk)->conn;
-
-	BT_DBG("sk %p, conn %p, err %d", sk, conn, err);
-
-	if (conn) {
-		sco_conn_lock(conn);
-		conn->sk = NULL;
-		sco_pi(sk)->conn = NULL;
-		sco_conn_unlock(conn);
-
-		if (conn->hcon)
-			hci_conn_drop(conn->hcon);
-	}
-
-	sk->sk_state = BT_CLOSED;
-	sk->sk_err   = err;
-	sk->sk_state_change(sk);
-
-	sock_set_flag(sk, SOCK_ZAPPED);
-}
-
 static void sco_conn_ready(struct sco_conn *conn)
 {
 	struct sock *parent;
-- 
1.9.3

