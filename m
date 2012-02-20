Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv6 10/14] Bluetooth: Use chan lock in receiving data
Date: Mon, 20 Feb 2012 16:21:21 +0200
Message-Id: <1329747685-4163-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1329747685-4163-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329747685-4163-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Change locking logic when receiving ACL and L2CAP data.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   11 +++++------
 net/bluetooth/l2cap_sock.c |   11 +++++++++--
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 71c7a08..31810d3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4261,7 +4261,6 @@ drop:
 static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk_buff *skb)
 {
 	struct l2cap_chan *chan;
-	struct sock *sk = NULL;
 	u32 control;
 	u16 tx_seq;
 	int len;
@@ -4269,11 +4268,12 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 	chan = l2cap_get_chan_by_scid(conn, cid);
 	if (!chan) {
 		BT_DBG("unknown cid 0x%4.4x", cid);
-		goto drop;
+		/* Drop packet and return */
+		kfree(skb);
+		return 0;
 	}
 
-	sk = chan->sk;
-	lock_sock(sk);
+	l2cap_chan_lock(chan);
 
 	BT_DBG("chan %p, len %d", chan, skb->len);
 
@@ -4344,8 +4344,7 @@ drop:
 	kfree_skb(skb);
 
 done:
-	if (sk)
-		release_sock(sk);
+	l2cap_chan_unlock(chan);
 
 	return 0;
 }
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index db38fae..a278858 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -877,8 +877,12 @@ static int l2cap_sock_recv_cb(void *data, struct sk_buff *skb)
 	struct sock *sk = data;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 
-	if (pi->rx_busy_skb)
-		return -ENOMEM;
+	lock_sock(sk);
+
+	if (pi->rx_busy_skb) {
+		err = -ENOMEM;
+		goto done;
+	}
 
 	err = sock_queue_rcv_skb(sk, skb);
 
@@ -897,6 +901,9 @@ static int l2cap_sock_recv_cb(void *data, struct sk_buff *skb)
 		err = 0;
 	}
 
+done:
+	release_sock(sk);
+
 	return err;
 }
 
-- 
1.7.9

