Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Remove unneeded forward declaration of __sco_chan_add
Date: Sun, 13 Jul 2014 19:54:48 +0200
Message-Id: <1405274089-22043-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The forward declaration of __sco_chan_add is not needed and thus just
remove it. Move __sco_chan_add into the proper location.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/sco.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index e6c7b636b901..75cffc14ab6e 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -53,7 +53,6 @@ struct sco_conn {
 #define sco_conn_lock(c)	spin_lock(&c->lock);
 #define sco_conn_unlock(c)	spin_unlock(&c->lock);
 
-static void __sco_chan_add(struct sco_conn *conn, struct sock *sk, struct sock *parent);
 static void sco_chan_del(struct sock *sk, int err);
 
 static void sco_sock_close(struct sock *sk);
@@ -164,6 +163,17 @@ static int sco_conn_del(struct hci_conn *hcon, int err)
 	return 0;
 }
 
+static void __sco_chan_add(struct sco_conn *conn, struct sock *sk, struct sock *parent)
+{
+	BT_DBG("conn %p", conn);
+
+	sco_pi(sk)->conn = conn;
+	conn->sk = sk;
+
+	if (parent)
+		bt_accept_enqueue(parent, sk);
+}
+
 static int sco_chan_add(struct sco_conn *conn, struct sock *sk,
 			struct sock *parent)
 {
@@ -968,17 +978,6 @@ static int sco_sock_release(struct socket *sock)
 	return err;
 }
 
-static void __sco_chan_add(struct sco_conn *conn, struct sock *sk, struct sock *parent)
-{
-	BT_DBG("conn %p", conn);
-
-	sco_pi(sk)->conn = conn;
-	conn->sk = sk;
-
-	if (parent)
-		bt_accept_enqueue(parent, sk);
-}
-
 /* Delete channel.
  * Must be called on the locked socket. */
 static void sco_chan_del(struct sock *sk, int err)
-- 
1.9.3

