Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: bzhao@marvell.com
Subject: [PATCH] Bluetooth: btmrv: Use %*ph specifier instead of print_hex_dump_bytes
Date: Wed, 10 Oct 2012 17:41:33 +0300
Message-Id: <1349880093-23728-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use standard print specifier and remove print_hex_dump_bytes call.
Makes output more sensible:

...
[18809.401218] 00000000: 0b 00 00 fe 5b fc 01 f2 00 00 00    ....[......
...

would be changed to

...
[18809.401218] Bluetooth: hex: 0b 00 00 fe 5b fc 01 f2 00 00 00
...

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 drivers/bluetooth/btmrvl_sdio.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 90b3a75..49494ae 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -597,8 +597,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 
 	default:
 		BT_ERR("Unknown packet type:%d", type);
-		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET, payload,
-				     blksz * num_blocks);
+		BT_ERR("hex: %*ph", blksz * num_blocks, payload);
 
 		kfree_skb(skb);
 		skb = NULL;
@@ -857,8 +856,7 @@ static int btmrvl_sdio_host_to_card(struct btmrvl_private *priv,
 		if (ret < 0) {
 			i++;
 			BT_ERR("i=%d writesb failed: %d", i, ret);
-			print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
-						payload, nb);
+			BT_ERR("hex: %*ph", nb, payload);
 			ret = -EIO;
 			if (i > MAX_WRITE_IOMEM_RETRY)
 				goto exit;
-- 
1.7.9.5

