Return-Path: <cyrus@holtmann.org>
From: Yuri Ershov <ext-yuri.ershov@nokia.com>
To: marcel@holtmann.org, davem@davemloft.net, padovan@profusion.mobi,
        jprvita@profusion.mobi
Cc: linux-bluetooth@vger.kernel.org, ville.tervo@nokia.com,
        andrei.emeltchenko@nokia.com, Yuri Ershov <ext-yuri.ershov@nokia.com>
Subject: [PATCH] bluetooth: Fix NULL pointer dereference issue
Date: Thu, 28 Oct 2010 14:52:54 +0400
Message-Id: <456b20879a6fc3e434463389ef25c4d5cf8803d4.1288262806.git.ext-yuri.ershov@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes NULL pointer dereference at running test with
connect-transfer-disconnect in loop. The problem conditions are the
following: there are 2 BT devices. The first one listens and
receives (l2test -r), the second one makes "connect-disconnect-
connect..." sequence (l2test -c -b 1000 -i hci0 -P 10 <addr>).
After some time this will cause the race between functions
bt_accept_dequeue and l2cap_chan_del. The function l2cap_chan_del
sets the socket state to BT_CLOSED, unlinks and kills the socket
in the middle of bt_accept_dequeue, then at running the removed code
kernel oops appears.

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
