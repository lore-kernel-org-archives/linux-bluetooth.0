Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] Bluetooth: Hold the lock inside sco_get_sock_by_addr()
Date: Tue,  2 Nov 2010 15:03:13 +0000
Message-Id: <1288710198-6108-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1288710198-6108-1-git-send-email-padovan@profusion.mobi>
References: <1288710198-6108-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It also have to change the name of the function to
sco_get_sock_by_addr() because we do hold the lock inside it now.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/sco.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index d0927d1..85b5498 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -276,16 +276,18 @@ drop:
 }
 
 /* -------- Socket interface ---------- */
-static struct sock *__sco_get_sock_by_addr(bdaddr_t *ba)
+static struct sock *sco_get_sock_by_addr(bdaddr_t *ba)
 {
 	struct sock *sk;
 	struct hlist_node *node;
 
+	write_lock_bh(&sco_sk_list.lock);
 	sk_for_each(sk, node, &sco_sk_list.head)
 		if (!bacmp(&bt_sk(sk)->src, ba))
 			goto found;
 	sk = NULL;
 found:
+	write_unlock_bh(&sco_sk_list.lock);
 	return sk;
 }
 
@@ -469,9 +471,7 @@ static int sco_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_le
 		goto done;
 	}
 
-	write_lock_bh(&sco_sk_list.lock);
-
-	if (bacmp(src, BDADDR_ANY) && __sco_get_sock_by_addr(src)) {
+	if (bacmp(src, BDADDR_ANY) && sco_get_sock_by_addr(src)) {
 		err = -EADDRINUSE;
 	} else {
 		/* Save source address */
@@ -479,8 +479,6 @@ static int sco_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_le
 		sk->sk_state = BT_BOUND;
 	}
 
-	write_unlock_bh(&sco_sk_list.lock);
-
 done:
 	release_sock(sk);
 	return err;
-- 
1.7.3.1

