Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH -v2] Bluetooth: Fix wrong set of skb fragments
Date: Tue, 15 May 2012 13:22:55 -0300
Message-Id: <1337098975-4859-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If alloc() fails we let the frags linked list with garbage value(the err
ptr value) in its last element.

Reported-by: Mat Martineau <mathewm@codeaurora.org>
Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
---
 net/bluetooth/l2cap_core.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 869beb3..8a84a18 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1836,13 +1836,17 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 	/* Continuation fragments (no L2CAP header) */
 	frag = &skb_shinfo(skb)->frag_list;
 	while (len) {
+		struct sk_buff *tmp;
+
 		count = min_t(unsigned int, conn->mtu, len);
 
-		*frag = chan->ops->alloc_skb(chan, count,
-					     msg->msg_flags & MSG_DONTWAIT);
+		tmp = chan->ops->alloc_skb(chan, count,
+					   msg->msg_flags & MSG_DONTWAIT);
+		if (IS_ERR(tmp))
+			return PTR_ERR(tmp);
+
+		*frag = tmp;
 
-		if (IS_ERR(*frag))
-			return PTR_ERR(*frag);
 		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count))
 			return -EFAULT;
 
-- 
1.7.10.1

