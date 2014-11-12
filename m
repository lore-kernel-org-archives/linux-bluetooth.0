Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix l2cap_sock_teardown_cb lockdep warning
Date: Wed, 12 Nov 2014 09:15:50 +0200
Message-Id: <1415776550-32392-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Any code calling bt_accept_dequeue() to get a new child socket from a
server socket should use lock_sock_nested to avoid lockdep warnings due
to the parent and child sockets being locked at the same time. The
l2cap_sock_accept() function is already doing this correctly but a
second place calling bt_accept_dequeue() is the code path from
l2cap_sock_teardown_cb() that calls l2cap_sock_cleanup_listen().

This patch fixes the proper nested locking annotation and thereby avoids
the following style of lockdep warning.

[  +0.000224] [ INFO: possible recursive locking detected ]
[  +0.000222] 3.17.0+ #1153 Not tainted
[  +0.000130] ---------------------------------------------
[  +0.000227] l2cap-tester/562 is trying to acquire lock:
[  +0.000210]  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+...}, at: [<c1393f47>] bt_accept_dequeue+0x68/0x11b
[  +0.000467]
but task is already holding lock:
[  +0.000186]  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+...}, at: [<c13b949a>] lock_sock+0xa/0xc
[  +0.000421]
other info that might help us debug this:
[  +0.000199]  Possible unsafe locking scenario:

[  +0.000117]        CPU0
[  +0.000000]        ----
[  +0.000000]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
[  +0.000000]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
[  +0.000000]
 *** DEADLOCK ***

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 31f106e61ca2..ad1cf82fee02 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1246,7 +1246,7 @@ static void l2cap_sock_teardown_cb(struct l2cap_chan *chan, int err)
 	struct sock *sk = chan->data;
 	struct sock *parent;
 
-	lock_sock(sk);
+	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 
 	parent = bt_sk(sk)->parent;
 
-- 
2.1.0

