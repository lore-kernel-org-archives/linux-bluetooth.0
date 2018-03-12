Return-Path: <elfring@users.sourceforge.net>
Subject: [PATCH 3/5] Bluetooth: btmrvl: One check less in
 btmrvl_sdio_card_to_host() after error detection
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-bluetooth@vger.kernel.org, Johan Hedberg <johan.hedberg@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
Message-ID: <a988a80d-12c0-a414-ab81-ff4ab075855c@users.sourceforge.net>
Date: Mon, 12 Mar 2018 12:33:26 +0100
MIME-Version: 1.0
In-Reply-To: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Mar 2018 11:13:00 +0100

One check could be repeated by the btmrvl_sdio_card_to_host() function
during error handling even if the relevant properties can be determined
for the involved variables before by source code analysis.

* Adjust jump targets so that an extra check can be omitted at the end.

* Reuse a bit of exception handling better.

* Delete an initialisation for the local variable "skb"
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/bluetooth/btmrvl_sdio.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 84c222abf0f7..9854addc8e96 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -687,5 +687,5 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 {
 	u16 buf_len = 0;
 	int ret, num_blocks, blksz;
-	struct sk_buff *skb = NULL;
+	struct sk_buff *skb;
 	u32 type;
@@ -695,16 +695,14 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 
 	if (!card || !card->func) {
 		BT_ERR("card or function is NULL!");
-		ret = -EINVAL;
-		goto exit;
+		goto e_inval;
 	}
 
 	/* Read the length of data to be transferred */
 	ret = btmrvl_sdio_read_rx_len(card, &buf_len);
 	if (ret < 0) {
 		BT_ERR("read rx_len failed");
-		ret = -EIO;
-		goto exit;
+		goto e_io;
 	}
 
 	blksz = SDIO_BLOCK_SIZE;
@@ -713,8 +711,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 	if (buf_len <= SDIO_HEADER_LEN
 	    || (num_blocks * blksz) > ALLOC_BUF_SIZE) {
 		BT_ERR("invalid packet length: %d", buf_len);
-		ret = -EINVAL;
-		goto exit;
+		goto e_inval;
 	}
 
 	/* Allocate buffer */
@@ -722,7 +719,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 	if (!skb) {
 		BT_ERR("No free skb");
 		ret = -ENOMEM;
-		goto exit;
+		goto increment_counter;
 	}
 
 	if ((unsigned long) skb->data & (BTSDIO_DMA_ALIGN - 1)) {
@@ -738,8 +735,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 			  num_blocks * blksz);
 	if (ret < 0) {
 		BT_ERR("readsb failed: %d", ret);
-		ret = -EIO;
-		goto exit;
+		goto free_skb;
 	}
 
 	/* This is SDIO specific header length: byte[2][1][0], type: byte[3]
@@ -753,8 +749,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 	if (buf_len > blksz * num_blocks) {
 		BT_ERR("Skip incorrect packet: hdrlen %d buffer %d",
 		       buf_len, blksz * num_blocks);
-		ret = -EIO;
-		goto exit;
+		goto free_skb;
 	}
 
 	type = payload[3];
@@ -797,12 +792,18 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 		break;
 	}
 
-exit:
-	if (ret) {
-		hdev->stat.err_rx++;
-		kfree_skb(skb);
-	}
+	return 0;
+
+free_skb:
+	kfree_skb(skb);
+e_io:
+	ret = -EIO;
+	goto increment_counter;
 
+e_inval:
+	ret = -EINVAL;
+increment_counter:
+	hdev->stat.err_rx++;
 	return ret;
 }
 
-- 
2.16.2
