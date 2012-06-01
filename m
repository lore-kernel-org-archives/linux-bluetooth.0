Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] Bluetooth: Fix checking the wrong flag when accepting a socket
Date: Thu, 31 May 2012 22:53:39 -0300
Message-Id: <1338515619-7448-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Most probably a typo, the check should have been for BT_SK_DEFER_SETUP
instead of BT_DEFER_SETUP (which right now only represents a socket
option).

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/af_bluetooth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 2517472..f7db579 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -199,7 +199,7 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 		}
 
 		if (sk->sk_state == BT_CONNECTED || !newsock ||
-		    test_bit(BT_DEFER_SETUP, &bt_sk(parent)->flags)) {
+		    test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags)) {
 			bt_accept_unlink(sk);
 			if (newsock)
 				sock_graft(sk, newsock);
-- 
1.7.10.3

