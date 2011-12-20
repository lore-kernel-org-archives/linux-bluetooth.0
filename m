Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 1/2] Bluetooth: fix bt_accept_dequeue() to work in process context
Date: Tue, 20 Dec 2011 17:15:56 -0200
Message-Id: <1324408558-24653-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

No local_bh_disable is needed there once we run everything in process
context. The same goes for the replacement of bh_lock_sock() by
lock_sock().

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/af_bluetooth.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 062124c..cdcfcab 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -199,15 +199,14 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 
 	BT_DBG("parent %p", parent);
 
-	local_bh_disable();
 	list_for_each_safe(p, n, &bt_sk(parent)->accept_q) {
 		sk = (struct sock *) list_entry(p, struct bt_sock, accept_q);
 
-		bh_lock_sock(sk);
+		lock_sock(sk);
 
 		/* FIXME: Is this check still needed */
 		if (sk->sk_state == BT_CLOSED) {
-			bh_unlock_sock(sk);
+			release_sock(sk);
 			bt_accept_unlink(sk);
 			continue;
 		}
@@ -218,14 +217,12 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 			if (newsock)
 				sock_graft(sk, newsock);
 
-			bh_unlock_sock(sk);
-			local_bh_enable();
+			release_sock(sk);
 			return sk;
 		}
 
-		bh_unlock_sock(sk);
+		release_sock(sk);
 	}
-	local_bh_enable();
 
 	return NULL;
 }
-- 
1.7.6.4

