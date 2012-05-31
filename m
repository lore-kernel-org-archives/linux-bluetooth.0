Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH trivial 3/3] Bluetooth: Make l2cap_att_channel return void
Date: Thu, 31 May 2012 11:18:57 +0300
Message-Id: <1338452337-22618-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1338452337-22618-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1338452337-22618-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

l2cap_att_channel always returns 0 which is not used.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a8d69ab..8229ae4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5211,8 +5211,8 @@ drop:
 	kfree_skb(skb);
 }
 
-static inline int l2cap_att_channel(struct l2cap_conn *conn, u16 cid,
-				    struct sk_buff *skb)
+static void l2cap_att_channel(struct l2cap_conn *conn, u16 cid,
+			      struct sk_buff *skb)
 {
 	struct l2cap_chan *chan;
 
@@ -5229,12 +5229,10 @@ static inline int l2cap_att_channel(struct l2cap_conn *conn, u16 cid,
 		goto drop;
 
 	if (!chan->ops->recv(chan, skb))
-		return 0;
+		return;
 
 drop:
 	kfree_skb(skb);
-
-	return 0;
 }
 
 static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
-- 
1.7.9.5

