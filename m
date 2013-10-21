Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 2/3] Bluetooth: Use bt_cb(skb)->chan to send raw data back
Date: Mon, 21 Oct 2013 18:22:25 -0200
Message-Id: <1382386946-19797-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1382386946-19797-1-git-send-email-gustavo@padovan.org>
References: <1382386946-19797-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Instead of accessing skb->sk in L2CAP core we now compare the channel
a skb belongs to and not send it back if the channel is same. This change
removes another struct socket usage from L2CAP core.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index bb6d35e..0cef677 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2813,17 +2813,16 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
 	mutex_lock(&conn->chan_lock);
 
 	list_for_each_entry(chan, &conn->chan_l, list) {
-		struct sock *sk = chan->sk;
 		if (chan->chan_type != L2CAP_CHAN_RAW)
 			continue;
 
-		/* Don't send frame to the socket it came from */
-		if (skb->sk == sk)
+		/* Don't send frame to the channel it came from */
+		if (bt_cb(skb)->chan == chan)
 			continue;
+
 		nskb = skb_clone(skb, GFP_KERNEL);
 		if (!nskb)
 			continue;
-
 		if (chan->ops->recv(chan, nskb))
 			kfree_skb(nskb);
 	}
-- 
1.8.3.1

