Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Restrict to one SCO listening socket
Date: Thu, 19 Apr 2012 14:02:43 +0200
Message-Id: <1334836963-5392-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The SCO sockets are only identified by its address. So only allow one
SCO socket in listening state per address or BDADDR_ANY.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/sco.c |   19 +++++++------------
 1 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 8b2548c..7355d6f 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -274,18 +274,6 @@ drop:
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
@@ -530,6 +518,7 @@ done:
 static int sco_sock_listen(struct socket *sock, int backlog)
 {
 	struct sock *sk = sock->sk;
+	bdaddr_t *src = &bt_sk(sk)->src;
 	int err = 0;
 
 	BT_DBG("sk %p backlog %d", sk, backlog);
@@ -546,8 +535,14 @@ static int sco_sock_listen(struct socket *sock, int backlog)
 		goto done;
 	}
 
+	if (sco_get_sock_listen(src)) {
+		err = -EADDRINUSE;
+		goto done;
+	}
+
 	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;
+
 	sk->sk_state = BT_LISTEN;
 
 done:
-- 
1.7.7.6

