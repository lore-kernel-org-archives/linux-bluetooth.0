Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: Restrict to one SCO listening socket
Date: Thu, 19 Apr 2012 14:37:58 +0200
Message-Id: <1334839078-14958-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The SCO sockets are only identified by its address. So only allow one
SCO socket in listening state per address or BDADDR_ANY.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/sco.c |   29 ++++++++++++++++++++++-------
 1 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 8b2548c..b1265fb 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -274,17 +274,20 @@ drop:
 }
 
 /* -------- Socket interface ---------- */
-static struct sock *__sco_get_sock_by_addr(bdaddr_t *ba)
+static struct sock *__sco_get_sock_listen_by_addr(bdaddr_t *ba)
 {
-	struct sock *sk;
 	struct hlist_node *node;
+	struct sock *sk;
+
+	sk_for_each(sk, node, &sco_sk_list.head) {
+		if (sk->sk_state != BT_LISTEN)
+			continue;
 
-	sk_for_each(sk, node, &sco_sk_list.head)
 		if (!bacmp(&bt_sk(sk)->src, ba))
-			goto found;
-	sk = NULL;
-found:
-	return sk;
+			return sk;
+	}
+
+	return NULL;
 }
 
 /* Find socket listening on source bdaddr.
@@ -530,6 +533,7 @@ done:
 static int sco_sock_listen(struct socket *sock, int backlog)
 {
 	struct sock *sk = sock->sk;
+	bdaddr_t *src = &bt_sk(sk)->src;
 	int err = 0;
 
 	BT_DBG("sk %p backlog %d", sk, backlog);
@@ -546,10 +550,21 @@ static int sco_sock_listen(struct socket *sock, int backlog)
 		goto done;
 	}
 
+	write_lock(&sco_sk_list.lock);
+
+	if (__sco_get_sock_listen_by_addr(src)) {
+		err = -EADDRINUSE;
+		goto unlock;
+	}
+
 	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;
+
 	sk->sk_state = BT_LISTEN;
 
+unlock:
+	write_unlock(&sco_sk_list.lock);
+
 done:
 	release_sock(sk);
 	return err;
-- 
1.7.7.6

