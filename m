Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Don't check source address in SCO bind function
Date: Thu, 19 Apr 2012 13:43:53 +0200
Message-Id: <1334835833-21828-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Checking the source address in SCO bind function will prevent from
having an incoming and outgoing SCO socket. However that might be
needed in case of multiple SCO connections on a single device.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/sco.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 2fb9636..8b2548c 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -463,7 +463,6 @@ static int sco_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_le
 {
 	struct sockaddr_sco *sa = (struct sockaddr_sco *) addr;
 	struct sock *sk = sock->sk;
-	bdaddr_t *src = &sa->sco_bdaddr;
 	int err = 0;
 
 	BT_DBG("sk %p %s", sk, batostr(&sa->sco_bdaddr));
@@ -478,17 +477,14 @@ static int sco_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_le
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
+	if (sk->sk_type != SOCK_SEQPACKET) {
+		err = -EINVAL;
+		goto done;
 	}
 
-	write_unlock(&sco_sk_list.lock);
+	bacpy(&bt_sk(sk)->src, &sa->sco_bdaddr);
+
+	sk->sk_state = BT_BOUND;
 
 done:
 	release_sock(sk);
-- 
1.7.7.6

