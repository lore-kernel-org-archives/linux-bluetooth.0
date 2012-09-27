Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 1/3] Bluetooth: btmrvl: Correct num_block name
Date: Thu, 27 Sep 2012 10:51:46 +0300
Message-Id: <1348732308-29348-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Make code readable by correcting name from buf_block_len to num_blocks
since it represent number of blocks; NOT a length of a block buffer.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 drivers/bluetooth/btmrvl_sdio.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index da4df9c..25dc53b 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -492,7 +492,7 @@ done:
 static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 {
 	u16 buf_len = 0;
-	int ret, buf_block_len, blksz;
+	int ret, num_blocks, blksz;
 	struct sk_buff *skb = NULL;
 	u32 type;
 	u8 *payload = NULL;
@@ -516,18 +516,17 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 	BT_DBG("%s buf_len %zu", hdev->name, buf_len);
 
 	blksz = SDIO_BLOCK_SIZE;
-	buf_block_len = (buf_len + blksz - 1) / blksz;
+	num_blocks = (buf_len + blksz - 1) / blksz;
 
 	if (buf_len <= SDIO_HEADER_LEN
-			|| (buf_block_len * blksz) > ALLOC_BUF_SIZE) {
+	    || (num_blocks * blksz) > ALLOC_BUF_SIZE) {
 		BT_ERR("invalid packet length: %d", buf_len);
 		ret = -EINVAL;
 		goto exit;
 	}
 
 	/* Allocate buffer */
-	skb = bt_skb_alloc(buf_block_len * blksz + BTSDIO_DMA_ALIGN,
-								GFP_ATOMIC);
+	skb = bt_skb_alloc(num_blocks * blksz + BTSDIO_DMA_ALIGN, GFP_ATOMIC);
 	if (skb == NULL) {
 		BT_ERR("No free skb");
 		goto exit;
@@ -543,7 +542,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 	payload = skb->data;
 
 	ret = sdio_readsb(card->func, payload, card->ioport,
-			  buf_block_len * blksz);
+			  num_blocks * blksz);
 	if (ret < 0) {
 		BT_ERR("readsb failed: %d", ret);
 		ret = -EIO;
@@ -594,7 +593,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 	default:
 		BT_ERR("Unknown packet type:%d", type);
 		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET, payload,
-						blksz * buf_block_len);
+				     blksz * num_blocks);
 
 		kfree_skb(skb);
 		skb = NULL;
-- 
1.7.9.5

