Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix double locking in LE and conless chan
Date: Fri, 24 Feb 2012 16:35:32 +0200
Message-Id: <1330094132-11762-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove socket lock since chan->ops->recv locks socket itself.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   24 ++++--------------------
 1 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b2f1565..ed50e4a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4382,18 +4382,13 @@ done:
 
 static inline int l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm, struct sk_buff *skb)
 {
-	struct sock *sk = NULL;
 	struct l2cap_chan *chan;
 
 	chan = l2cap_global_chan_by_psm(0, psm, conn->src);
 	if (!chan)
 		goto drop;
 
-	sk = chan->sk;
-
-	lock_sock(sk);
-
-	BT_DBG("sk %p, len %d", sk, skb->len);
+	BT_DBG("chan %p, len %d", chan, skb->len);
 
 	if (chan->state != BT_BOUND && chan->state != BT_CONNECTED)
 		goto drop;
@@ -4402,31 +4397,23 @@ static inline int l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm, str
 		goto drop;
 
 	if (!chan->ops->recv(chan->data, skb))
-		goto done;
+		return 0;
 
 drop:
 	kfree_skb(skb);
 
-done:
-	if (sk)
-		release_sock(sk);
 	return 0;
 }
 
 static inline int l2cap_att_channel(struct l2cap_conn *conn, __le16 cid, struct sk_buff *skb)
 {
-	struct sock *sk = NULL;
 	struct l2cap_chan *chan;
 
 	chan = l2cap_global_chan_by_scid(0, cid, conn->src);
 	if (!chan)
 		goto drop;
 
-	sk = chan->sk;
-
-	lock_sock(sk);
-
-	BT_DBG("sk %p, len %d", sk, skb->len);
+	BT_DBG("chan %p, len %d", chan, skb->len);
 
 	if (chan->state != BT_BOUND && chan->state != BT_CONNECTED)
 		goto drop;
@@ -4435,14 +4422,11 @@ static inline int l2cap_att_channel(struct l2cap_conn *conn, __le16 cid, struct
 		goto drop;
 
 	if (!chan->ops->recv(chan->data, skb))
-		goto done;
+		return 0;
 
 drop:
 	kfree_skb(skb);
 
-done:
-	if (sk)
-		release_sock(sk);
 	return 0;
 }
 
-- 
1.7.9

