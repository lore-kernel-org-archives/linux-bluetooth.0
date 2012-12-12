Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [RFC 12/16] Bluetooth: Use abstract chan->data in comparison
Date: Wed, 12 Dec 2012 02:13:40 -0200
Message-Id: <1355285624-25811-13-git-send-email-gustavo@padovan.org>
In-Reply-To: <1355285624-25811-1-git-send-email-gustavo@padovan.org>
References: <1355285624-25811-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

If the L2CAP user is l2cap_sock.c chan->data is a pointer to the l2cap
socket so chan->sk and chan->data are the same thing. Then we can just
compare with chan->data instead.

Non-socket users will have skb->sk = NULL, thus this change does not
interfere in other users.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 934ac1b..92936db 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2682,12 +2682,11 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
 	mutex_lock(&conn->chan_lock);
 
 	list_for_each_entry(chan, &conn->chan_l, list) {
-		struct sock *sk = chan->sk;
 		if (chan->chan_type != L2CAP_CHAN_RAW)
 			continue;
 
 		/* Don't send frame to the socket it came from */
-		if (skb->sk == sk)
+		if (skb->sk && skb->sk == chan->data)
 			continue;
 		nskb = skb_clone(skb, GFP_KERNEL);
 		if (!nskb)
-- 
1.7.11.7

