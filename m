Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove sco_chan_get helper function
Date: Mon, 14 Jul 2014 01:30:15 +0200
Message-Id: <1405294215-43683-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The sco_chan_get helper function is only used in two places and really
only protects conn->sk with a lock. So instead of hiding that fact,
just put the actual code in place where it is used.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/sco.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index e35be32ab0b5..62046519f4aa 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -127,15 +127,6 @@ static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 	return conn;
 }
 
-static struct sock *sco_chan_get(struct sco_conn *conn)
-{
-	struct sock *sk = NULL;
-	sco_conn_lock(conn);
-	sk = conn->sk;
-	sco_conn_unlock(conn);
-	return sk;
-}
-
 /* Delete channel.
  * Must be called on the locked socket. */
 static void sco_chan_del(struct sock *sk, int err)
@@ -174,7 +165,10 @@ static int sco_conn_del(struct hci_conn *hcon, int err)
 	BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
 
 	/* Kill socket */
-	sk = sco_chan_get(conn);
+	sco_conn_lock(conn);
+	sk = conn->sk;
+	sco_conn_unlock(conn);
+
 	if (sk) {
 		bh_lock_sock(sk);
 		sco_sock_clear_timer(sk);
@@ -303,7 +297,11 @@ static int sco_send_frame(struct sock *sk, struct msghdr *msg, int len)
 
 static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
 {
-	struct sock *sk = sco_chan_get(conn);
+	struct sock *sk;
+
+	sco_conn_lock(conn);
+	sk = conn->sk;
+	sco_conn_unlock(conn);
 
 	if (!sk)
 		goto drop;
-- 
1.9.3

