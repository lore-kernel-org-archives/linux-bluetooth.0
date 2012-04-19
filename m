Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Restrict to one SCO listening socket
Date: Thu, 19 Apr 2012 14:19:33 +0200
Message-Id: <1334837973-9277-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The SCO sockets are only identified by its address. So only allow one
SCO socket in listening state per address or BDADDR_ANY.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/sco.c |   35 +++++++++++++++++------------------
 1 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 8b2548c..de5d055 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -274,29 +274,15 @@ drop:
 }
 
 /* -------- Socket interface ---------- */
-static struct sock *__sco_get_sock_by_addr(bdaddr_t *ba)
-{
-	struct sock *sk;
-	struct hlist_node *node;
-
-	sk_for_each(sk, node, &sco_sk_list.head)
-		if (!bacmp(&bt_sk(sk)->src, ba))
-			goto found;
-	sk = NULL;
-found:
-	return sk;
-}
 
 /* Find socket listening on source bdaddr.
  * Returns closest match.
  */
-static struct sock *sco_get_sock_listen(bdaddr_t *src)
+static struct sock *__sco_get_sock_by_addr(bdaddr_t *src)
 {
 	struct sock *sk = NULL, *sk1 = NULL;
 	struct hlist_node *node;
 
-	read_lock(&sco_sk_list.lock);
-
 	sk_for_each(sk, node, &sco_sk_list.head) {
 		if (sk->sk_state != BT_LISTEN)
 			continue;
@@ -310,8 +296,6 @@ static struct sock *sco_get_sock_listen(bdaddr_t *src)
 			sk1 = sk;
 	}
 
-	read_unlock(&sco_sk_list.lock);
-
 	return node ? sk : sk1;
 }
 
@@ -530,6 +514,7 @@ done:
 static int sco_sock_listen(struct socket *sock, int backlog)
 {
 	struct sock *sk = sock->sk;
+	bdaddr_t *src = &bt_sk(sk)->src;
 	int err = 0;
 
 	BT_DBG("sk %p backlog %d", sk, backlog);
@@ -546,8 +531,19 @@ static int sco_sock_listen(struct socket *sock, int backlog)
 		goto done;
 	}
 
+	write_lock(&sco_sk_list.lock);
+
+	if (__sco_get_sock_by_addr(src))
+		err = -EADDRINUSE;
+
+	write_unlock(&sco_sk_list.lock);
+
+	if (err < 0)
+		goto done;
+
 	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;
+
 	sk->sk_state = BT_LISTEN;
 
 done:
@@ -856,7 +852,10 @@ static void sco_conn_ready(struct sco_conn *conn)
 		sk->sk_state_change(sk);
 		bh_unlock_sock(sk);
 	} else {
-		parent = sco_get_sock_listen(conn->src);
+		read_lock(&sco_sk_list.lock);
+		parent = __sco_get_sock_by_addr(conn->src);
+		read_unlock(&sco_sk_list.lock);
+
 		if (!parent)
 			goto done;
 
-- 
1.7.7.6

