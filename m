Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH trivial 1/3] Bluetooth: Make l2cap_data_channel return void
Date: Thu, 31 May 2012 11:18:55 +0300
Message-Id: <1338452337-22618-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

l2cap_data_channel always return 0 which is not used anywhere,
make it void function.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index bef5266..56f5c0e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5128,7 +5128,8 @@ drop:
 	return 0;
 }
 
-static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk_buff *skb)
+static void l2cap_data_channel(struct l2cap_conn *conn, u16 cid,
+			       struct sk_buff *skb)
 {
 	struct l2cap_chan *chan;
 
@@ -5138,7 +5139,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 			chan = a2mp_channel_create(conn, skb);
 			if (!chan) {
 				kfree_skb(skb);
-				return 0;
+				return;
 			}
 
 			l2cap_chan_lock(chan);
@@ -5146,7 +5147,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 			BT_DBG("unknown cid 0x%4.4x", cid);
 			/* Drop packet and return */
 			kfree_skb(skb);
-			return 0;
+			return;
 		}
 	}
 
@@ -5184,8 +5185,6 @@ drop:
 
 done:
 	l2cap_chan_unlock(chan);
-
-	return 0;
 }
 
 static inline int l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm, struct sk_buff *skb)
-- 
1.7.9.5

