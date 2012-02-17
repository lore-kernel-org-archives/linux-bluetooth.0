Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/3] Bluetooth: Use symbolic names for state in debug
Date: Fri, 17 Feb 2012 11:40:56 +0200
Message-Id: <1329471657-18278-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1329471657-18278-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329471657-18278-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use state_to_string function in debug statements.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    3 ++-
 net/bluetooth/hci_conn.c      |    2 +-
 net/bluetooth/l2cap_core.c    |    5 +++--
 net/bluetooth/l2cap_sock.c    |    2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 42fdbb8..bbb0e21 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -612,7 +612,8 @@ static inline void l2cap_chan_put(struct l2cap_chan *c)
 static inline void l2cap_set_timer(struct l2cap_chan *chan,
 					struct delayed_work *work, long timeout)
 {
-	BT_DBG("chan %p state %d timeout %ld", chan, chan->state, timeout);
+	BT_DBG("chan %p state %s timeout %ld", chan,
+					state_to_string(chan->state), timeout);
 
 	if (!cancel_delayed_work(work))
 		l2cap_chan_hold(chan);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 6d15cba..f7a090c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -282,7 +282,7 @@ static void hci_conn_timeout(struct work_struct *work)
 							disc_work.work);
 	__u8 reason;
 
-	BT_DBG("conn %p state %d", conn, conn->state);
+	BT_DBG("conn %p state %s", conn, state_to_string(conn->state));
 
 	if (atomic_read(&conn->refcnt))
 		return;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 252a96e..88968e7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -231,7 +231,7 @@ static void l2cap_chan_timeout(struct work_struct *work)
 	struct sock *sk = chan->sk;
 	int reason;
 
-	BT_DBG("chan %p state %d", chan, chan->state);
+	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
 	lock_sock(sk);
 
@@ -413,7 +413,8 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 	struct l2cap_conn *conn = chan->conn;
 	struct sock *sk = chan->sk;
 
-	BT_DBG("chan %p state %d socket %p", chan, chan->state, sk->sk_socket);
+	BT_DBG("chan %p state %s sk %p", chan,
+					state_to_string(chan->state), sk);
 
 	switch (chan->state) {
 	case BT_LISTEN:
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 138fe34..b48d6c1 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -783,7 +783,7 @@ static void l2cap_sock_kill(struct sock *sk)
 	if (!sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket)
 		return;
 
-	BT_DBG("sk %p state %d", sk, sk->sk_state);
+	BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
 
 	/* Kill poor orphan */
 
-- 
1.7.9

