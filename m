Return-Path: <cyrus@holtmann.org>
From: Yuri Ershov <ext-yuri.ershov@nokia.com>
To: marcel@holtmann.org, davem@davemloft.net, padovan@profusion.mobi,
        jprvita@profusion.mobi
Cc: linux-bluetooth@vger.kernel.org, ville.tervo@nokia.com,
        andrei.emeltchenko@nokia.com, Yuri Ershov <ext-yuri.ershov@nokia.com>
Subject: [PATCH] bluetooth: Fix NULL pointer dereference issue
Date: Thu, 21 Oct 2010 20:08:58 +0400
Message-Id: <1987fd374e92ea2e4ebb06b24c6321e65ab933c6.1287676475.git.ext-yuri.ershov@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes NULL pointer dereference at running test with
connect-transfer-disconnect in loop. Sometimes sk_state is 
BT_CLOSED and sk_refcnt equal to 0, so there is oops in 
bt_accept_unlink. In normal case removed block is not used.

Signed-off-by: Yuri Ershov <ext-yuri.ershov@nokia.com>
---
 net/bluetooth/af_bluetooth.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 421c45b..47c107e 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -204,13 +204,6 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 
 		lock_sock(sk);
 
-		/* FIXME: Is this check still needed */
-		if (sk->sk_state == BT_CLOSED) {
-			release_sock(sk);
-			bt_accept_unlink(sk);
-			continue;
-		}
-
 		if (sk->sk_state == BT_CONNECTED || !newsock ||
 						bt_sk(parent)->defer_setup) {
 			bt_accept_unlink(sk);
-- 
1.6.3.3
