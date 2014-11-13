Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Add debug logs to help track locking issues
Date: Thu, 13 Nov 2014 14:37:50 +0200
Message-Id: <1415882270-5621-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1415882270-5621-1-git-send-email-johan.hedberg@gmail.com>
References: <1415882270-5621-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds some extra debug logs to L2CAP related code. These are
mainly to help track locking issues but will probably be useful for
debugging other types of issues as well.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c |  3 ++-
 net/bluetooth/l2cap_sock.c | 10 +++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 15784d32108d..8e1273173020 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -570,7 +570,8 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 
 	__clear_chan_timer(chan);
 
-	BT_DBG("chan %p, conn %p, err %d", chan, conn, err);
+	BT_DBG("chan %p, conn %p, err %d, state %s", chan, conn, err,
+	       state_to_string(chan->state));
 
 	chan->ops->teardown(chan, err);
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index a5aa9f92b5e2..b0efb7202957 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1102,6 +1102,8 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 	chan = l2cap_pi(sk)->chan;
 	conn = chan->conn;
 
+	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
+
 	if (conn)
 		mutex_lock(&conn->chan_lock);
 
@@ -1159,12 +1161,16 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 {
 	struct sock *sk;
 
-	BT_DBG("parent %p", parent);
+	BT_DBG("parent %p state %s", parent,
+	       state_to_string(parent->sk_state));
 
 	/* Close not yet accepted channels */
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
 		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 
+		BT_DBG("child chan %p state %s", chan,
+		       state_to_string(chan->state));
+
 		l2cap_chan_lock(chan);
 		__clear_chan_timer(chan);
 		l2cap_chan_close(chan, ECONNRESET);
@@ -1252,6 +1258,8 @@ static void l2cap_sock_teardown_cb(struct l2cap_chan *chan, int err)
 	struct sock *sk = chan->data;
 	struct sock *parent;
 
+	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
+
 	/* This callback can be called both for server (BT_LISTEN)
 	 * sockets as well as "normal" ones. To avoid lockdep warnings
 	 * with child socket locking (through l2cap_sock_cleanup_listen)
-- 
2.1.0

