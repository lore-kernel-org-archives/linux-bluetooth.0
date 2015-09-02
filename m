Return-Path: <cyrus@holtmann.org>
From: Kieran Bingham <kieranbingham@gmail.com>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	akarwar@marvell.com,
	Kieran Bingham <kieranbingham@gmail.com>
Subject: [PATCH v2] bluetooth: btmrvl: skb resource leak, and double free.
Date: Wed,  2 Sep 2015 13:51:10 +0100
Message-Id: <1441198270-24054-1-git-send-email-kieranbingham@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

if btmrvl_tx_pkt() is called, and the branch
  if (skb_headroom(skb) < BTM_HEADER_LEN)
evaluates positive, a new skb is allocated via skb_realloc_headroom.

The original skb is stored in a tmp variable, before being free'd.
However on success, the new skb, is not free'd, nor is it
returned to the caller which will then double-free the original skb.

This issue exists from the original driver submission in
 commit: #132ff4e5fa8dfb71a7d99902f88043113947e972

If this code path had been alive, it would have been noted from the
double-free causing a panic.

All skb's here should be allocated through bt_skb_alloc which
adds 8 bytes as headroom, which is plenty against the 4 bytes
pushed on by this driver.

This code path is dead, and buggy at the same time, so the cleanest
approach is to remove the affected branch.

Reported by coverity (CID 113422)

Signed-off-by: Kieran Bingham <kieranbingham@gmail.com>
---
 drivers/bluetooth/btmrvl_main.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index de05deb..bc110f6 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -377,20 +377,6 @@ static int btmrvl_tx_pkt(struct btmrvl_private *priv, struct sk_buff *skb)
 		return -EINVAL;
 	}
 
-	if (skb_headroom(skb) < BTM_HEADER_LEN) {
-		struct sk_buff *tmp = skb;
-
-		skb = skb_realloc_headroom(skb, BTM_HEADER_LEN);
-		if (!skb) {
-			BT_ERR("Tx Error: realloc_headroom failed %d",
-				BTM_HEADER_LEN);
-			skb = tmp;
-			return -EINVAL;
-		}
-
-		kfree_skb(tmp);
-	}
-
 	skb_push(skb, BTM_HEADER_LEN);
 
 	/* header type: byte[3]
-- 
2.1.4
