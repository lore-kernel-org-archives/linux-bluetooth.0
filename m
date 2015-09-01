Return-Path: <cyrus@holtmann.org>
From: Kieran Bingham <kieranbingham@gmail.com>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	akarwar@marvell.com,
	Kieran Bingham <kieranbingham@gmail.com>
Subject: [PATCH] bluetooth: btmrvl: skb resource leak, and double free.
Date: Tue,  1 Sep 2015 20:24:02 +0100
Message-Id: <1441135442-14505-1-git-send-email-kieranbingham@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

if btmrvl_tx_pkt() is called, and the branch
  if (skb_headroom(skb) < BTM_HEADER_LEN)
evaluates positive, a new skb is allocated via skb_realloc_headroom.

The original skb is stored in a tmp variable, before being free'd.
However on success, the new skb, is not free'd, nor is it
returned to the caller which will then double-free the original skb.

This issue exists from the original driver submission in
 commit: #132ff4e5fa8dfb71a7d99902f88043113947e972

Move the error handling, and kfree_skb inside the helper function,
where the statistics can be updated, and the skb free'd at the
appropriate occasion.

Reported by coverity (CID 113422)

Signed-off-by: Kieran Bingham <kieranbingham@gmail.com>
---
 drivers/bluetooth/btmrvl_main.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index de05deb..ceaef95 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -366,15 +366,15 @@ void btmrvl_firmware_dump(struct btmrvl_private *priv)
 
 static int btmrvl_tx_pkt(struct btmrvl_private *priv, struct sk_buff *skb)
 {
-	int ret = 0;
+	int ret = -EINVAL;
 
 	if (!skb || !skb->data)
-		return -EINVAL;
+		goto tx_pkt_out;
 
 	if (!skb->len || ((skb->len + BTM_HEADER_LEN) > BTM_UPLD_SIZE)) {
 		BT_ERR("Tx Error: Bad skb length %d : %d",
 						skb->len, BTM_UPLD_SIZE);
-		return -EINVAL;
+		goto tx_pkt_out;
 	}
 
 	if (skb_headroom(skb) < BTM_HEADER_LEN) {
@@ -385,7 +385,7 @@ static int btmrvl_tx_pkt(struct btmrvl_private *priv, struct sk_buff *skb)
 			BT_ERR("Tx Error: realloc_headroom failed %d",
 				BTM_HEADER_LEN);
 			skb = tmp;
-			return -EINVAL;
+			goto tx_pkt_out;
 		}
 
 		kfree_skb(tmp);
@@ -406,6 +406,14 @@ static int btmrvl_tx_pkt(struct btmrvl_private *priv, struct sk_buff *skb)
 	if (priv->hw_host_to_card)
 		ret = priv->hw_host_to_card(priv, skb->data, skb->len);
 
+tx_pkt_out:
+	if (ret)
+		priv->btmrvl_dev.hcidev->stat.err_tx++;
+	else
+		priv->btmrvl_dev.hcidev->stat.byte_tx += skb->len;
+
+	kfree_skb(skb);
+
 	return ret;
 }
 
@@ -670,14 +678,8 @@ static int btmrvl_service_main_thread(void *data)
 			continue;
 
 		skb = skb_dequeue(&adapter->tx_queue);
-		if (skb) {
-			if (btmrvl_tx_pkt(priv, skb))
-				priv->btmrvl_dev.hcidev->stat.err_tx++;
-			else
-				priv->btmrvl_dev.hcidev->stat.byte_tx += skb->len;
-
-			kfree_skb(skb);
-		}
+		if (skb)
+			btmrvl_tx_pkt(priv, skb);
 	}
 
 	return 0;
-- 
2.1.4
