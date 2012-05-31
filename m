Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH trivial 2/3] Bluetooth: Make l2cap_conless_channel return void
Date: Thu, 31 May 2012 11:18:56 +0300
Message-Id: <1338452337-22618-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1338452337-22618-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1338452337-22618-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

l2cap_conless_channel always return 0 which is not used.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 56f5c0e..a8d69ab 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5187,7 +5187,8 @@ done:
 	l2cap_chan_unlock(chan);
 }
 
-static inline int l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm, struct sk_buff *skb)
+static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
+				  struct sk_buff *skb)
 {
 	struct l2cap_chan *chan;
 
@@ -5204,12 +5205,10 @@ static inline int l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm, str
 		goto drop;
 
 	if (!chan->ops->recv(chan, skb))
-		return 0;
+		return;
 
 drop:
 	kfree_skb(skb);
-
-	return 0;
 }
 
 static inline int l2cap_att_channel(struct l2cap_conn *conn, u16 cid,
-- 
1.7.9.5

