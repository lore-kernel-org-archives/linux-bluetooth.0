Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sat, 14 Dec 2013 12:43:57 +0800
Message-ID: <CAPgLHd_1w0SJy3oc7NYgRRzsCZEEZc7SR+RBSz8zjaZsYAPFWg@mail.gmail.com>
Subject: [PATCH -next] Bluetooth: fix return value check
From: Wei Yongjun <weiyj.lk@gmail.com>
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com
Cc: yongjun_wei@trendmicro.com.cn, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function bt_skb_alloc() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check should
be replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 net/bluetooth/6lowpan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 37239db..fb38c78 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -337,8 +337,8 @@ static inline int skbuff_copy(void *msg, int len, int count, int mtu,
 		count = min_t(unsigned int, mtu, len);
 
 		tmp = bt_skb_alloc(count, GFP_ATOMIC);
-		if (IS_ERR(tmp))
-			return PTR_ERR(tmp);
+		if (!tmp)
+			return PTR_ERR(-ENOMEM);
 
 		*frag = tmp;
 
@@ -384,8 +384,8 @@ static struct sk_buff *create_pdu(struct l2cap_conn *conn, void *msg,
 	BT_DBG("conn %p len %zu mtu %d count %d", conn, len, conn->mtu, count);
 
 	skb = bt_skb_alloc(count + L2CAP_HDR_SIZE, GFP_ATOMIC);
-	if (IS_ERR(skb))
-		return skb;
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
 
 	skb->priority = priority;
 
