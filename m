Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [PATCH v2 1/1] Bluetooth: Fix EADDRINUSE check in SCO sockets
Date: Mon, 16 Apr 2012 09:58:28 +0200
Message-Id: <1334563108-8526-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1334563108-8526-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334563108-8526-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The EADDRINUSE error should be returned only when the SCO socket is
being used as a server. This means it should be checked in
sco_sock_listen() instead of in sco_sock_bind(), because in the later we
can't know if it is a server or not.

This patch is required in order to use multiple SCO connections in the
same Bluetooth adapter.

Signed-off-by: Mikel Astiz <mikel.astiz.oss@gmail.com>
---
 net/bluetooth/sco.c |   49 ++++++++++++++++++++++++++++++-------------------
 1 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 8bf26d1..45bedd3 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -278,17 +278,30 @@ drop:
 }
 
 /* -------- Socket interface ---------- */
-static struct sock *__sco_get_sock_by_addr(bdaddr_t *ba)
+static bool __sco_addr_in_use(bdaddr_t *src)
 {
 	struct sock *sk;
 	struct hlist_node *node;
 
-	sk_for_each(sk, node, &sco_sk_list.head)
-		if (!bacmp(&bt_sk(sk)->src, ba))
-			goto found;
-	sk = NULL;
-found:
-	return sk;
+	sk_for_each(sk, node, &sco_sk_list.head) {
+		if (sk->sk_state != BT_LISTEN)
+			continue;
+
+		/* Exact match */
+		if (!bacmp(&bt_sk(sk)->src, src))
+			return true;
+
+		/* Closest match */
+		if (!bacmp(&bt_sk(sk)->src, BDADDR_ANY))
+			return true;
+
+		/* Match any if given src is BDADDR_ANY */
+		if (!bacmp(src, BDADDR_ANY))
+			return true;
+	}
+
+	/* No match found so address is free */
+	return false;
 }
 
 /* Find socket listening on source bdaddr.
@@ -467,7 +480,6 @@ static int sco_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_le
 {
 	struct sockaddr_sco *sa = (struct sockaddr_sco *) addr;
 	struct sock *sk = sock->sk;
-	bdaddr_t *src = &sa->sco_bdaddr;
 	int err = 0;
 
 	BT_DBG("sk %p %s", sk, batostr(&sa->sco_bdaddr));
@@ -482,17 +494,9 @@ static int sco_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_le
 		goto done;
 	}
 
-	write_lock(&sco_sk_list.lock);
-
-	if (bacmp(src, BDADDR_ANY) && __sco_get_sock_by_addr(src)) {
-		err = -EADDRINUSE;
-	} else {
-		/* Save source address */
-		bacpy(&bt_sk(sk)->src, &sa->sco_bdaddr);
-		sk->sk_state = BT_BOUND;
-	}
-
-	write_unlock(&sco_sk_list.lock);
+	/* Save source address */
+	bacpy(&bt_sk(sk)->src, &sa->sco_bdaddr);
+	sk->sk_state = BT_BOUND;
 
 done:
 	release_sock(sk);
@@ -543,17 +547,24 @@ static int sco_sock_listen(struct socket *sock, int backlog)
 	BT_DBG("sk %p backlog %d", sk, backlog);
 
 	lock_sock(sk);
+	write_lock(&sco_sk_list.lock);
 
 	if (sk->sk_state != BT_BOUND || sock->type != SOCK_SEQPACKET) {
 		err = -EBADFD;
 		goto done;
 	}
 
+	if (__sco_addr_in_use(&bt_sk(sk)->src)) {
+		err = -EADDRINUSE;
+		goto done;
+	}
+
 	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;
 	sk->sk_state = BT_LISTEN;
 
 done:
+	write_unlock(&sco_sk_list.lock);
 	release_sock(sk);
 	return err;
 }
-- 
1.7.7.6

