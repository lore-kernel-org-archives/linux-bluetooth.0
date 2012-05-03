Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Blueooth: Remove hlen variable
Date: Thu,  3 May 2012 04:54:21 -0300
Message-Id: <1336031661-29266-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hlen has a fixed size of L2CAP_HDR_SIZE, use this instead.

Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
---
 net/bluetooth/l2cap_core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 870116a..edc9a37 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1892,14 +1892,14 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff *skb;
-	int err, count, hlen = L2CAP_HDR_SIZE;
+	int err, count;
 	struct l2cap_hdr *lh;
 
 	BT_DBG("chan %p len %d", chan, (int)len);
 
-	count = min_t(unsigned int, (conn->mtu - hlen), len);
+	count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE), len);
 
-	skb = chan->ops->alloc_skb(chan, count + hlen,
+	skb = chan->ops->alloc_skb(chan, count + L2CAP_HDR_SIZE,
 				   msg->msg_flags & MSG_DONTWAIT);
 	if (IS_ERR(skb))
 		return skb;
-- 
1.7.10

