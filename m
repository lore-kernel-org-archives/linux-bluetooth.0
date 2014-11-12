Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix L2CAP socket lock nesting level
Date: Wed, 12 Nov 2014 22:08:30 +0200
Message-Id: <1415822910-25657-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1415822910-25657-1-git-send-email-johan.hedberg@gmail.com>
References: <1415822910-25657-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The teardown callback for L2CAP channels is problematic in that it is
explicitly called for all types of channels from l2cap_chan_del(),
meaning it's not possible to hard-code a nesting level when taking the
socket lock. The simplest way to have a correct nesting level for the
socket locking is to use the same value as for the chan. This also means
that the other places trying to lock parent sockets need to be update to
use the chan value (since L2CAP_NESTING_PARENT is defined as 2 whereas
L2CAP_NESTING_PARENT has the value 1).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_sock.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index f1a51564b8fd..7913c28c643d 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -307,7 +307,7 @@ static int l2cap_sock_accept(struct socket *sock, struct socket *newsock,
 	long timeo;
 	int err = 0;
 
-	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
+	lock_sock_nested(sk, L2CAP_NESTING_PARENT);
 
 	timeo = sock_rcvtimeo(sk, flags & O_NONBLOCK);
 
@@ -339,7 +339,7 @@ static int l2cap_sock_accept(struct socket *sock, struct socket *newsock,
 
 		release_sock(sk);
 		timeo = schedule_timeout(timeo);
-		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
+		lock_sock_nested(sk, L2CAP_NESTING_PARENT);
 	}
 	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(sk_sleep(sk), &wait);
@@ -1252,7 +1252,14 @@ static void l2cap_sock_teardown_cb(struct l2cap_chan *chan, int err)
 	struct sock *sk = chan->data;
 	struct sock *parent;
 
-	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
+	/* This callback can be called both for server (BT_LISTEN)
+	 * sockets as well as "normal" ones. To avoid lockdep warnings
+	 * with child socket locking (through l2cap_sock_cleanup_listen)
+	 * we need separation into separate nesting levels. The simplest
+	 * way to accomplish this is to inherit the nesting level used
+	 * for the channel.
+	 */
+	lock_sock_nested(sk, atomic_read(&chan->nesting));
 
 	parent = bt_sk(sk)->parent;
 
-- 
2.1.0

