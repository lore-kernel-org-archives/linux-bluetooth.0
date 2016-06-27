Return-Path: <jcliang@chromium.org>
From: Ricky Liang <jcliang@chromium.org>
To: 
Cc: Ricky Liang <jcliang@chromium.org>,
	Wei-Ning Huang <wnhuang@chromium.org>,
	Daniel Kurtz <djkurtz@chromium.org>,
	Amitkumar Karwar <akarwar@marvell.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org (open list:BLUETOOTH DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] Bluetooth: btmrvl: fix slab-out-of-bounds access in btmrvl_sdio
Date: Mon, 27 Jun 2016 12:22:44 +0800
Message-Id: <1467001364-2055-1-git-send-email-jcliang@chromium.org>
In-Reply-To: <1466411387-3525-1-git-send-email-jcliang@chromium.org>
References: <1466411387-3525-1-git-send-email-jcliang@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Kasan reported slab-out-of-bounds access in btmrvl_sdio:

[   33.055400] ==================================================================
[   33.062585] BUG: KASAN: slab-out-of-bounds in memcpy+0x24/0x50 at addr ffffffc0d89b4a00
[   33.070529] Read of size 256 by task btmrvl_main_ser/3576
[   33.075885] =============================================================================
[   33.084002] BUG kmalloc-256 (Tainted: G    B         ): kasan: bad access detected
[   33.091511] -----------------------------------------------------------------------------
<snip...>
[   33.413498] Call trace:
[   33.415928] [<ffffffc00020a440>] dump_backtrace+0x0/0x190
[   33.421288] [<ffffffc00020a5ec>] show_stack+0x1c/0x28
[   33.426305] [<ffffffc000b3288c>] dump_stack+0xa0/0xf8
[   33.431320] [<ffffffc000396130>] print_trailer+0x158/0x16c
[   33.436765] [<ffffffc0003962cc>] object_err+0x48/0x5c
[   33.441780] [<ffffffc00039be24>] kasan_report+0x344/0x510
[   33.447141] [<ffffffc00039afd8>] __asan_loadN+0x20/0x150
[   33.452413] [<ffffffc00039b60c>] memcpy+0x20/0x50
[   33.457084] [<ffffffc000595fcc>] swiotlb_tbl_map_single+0x2ec/0x310
[   33.463305] [<ffffffc000596b54>] map_single+0x24/0x30
[   33.468320] [<ffffffc0005970c8>] swiotlb_map_sg_attrs+0xec/0x21c
[   33.474286] [<ffffffc000219d4c>] __swiotlb_map_sg_attrs+0x48/0xec
[   33.480339] [<ffffffc0008ea610>] msdc_prepare_data.isra.11+0xf0/0x11c
[   33.486733] [<ffffffc0008ecbd0>] msdc_ops_request+0x74/0xf0
[   33.492266] [<ffffffc0008c6b38>] __mmc_start_request+0x78/0x8c
[   33.498057] [<ffffffc0008c6d6c>] mmc_start_request+0x220/0x240
[   33.503848] [<ffffffc0008c6e04>] mmc_wait_for_req+0x78/0x250
[   33.509468] [<ffffffc0008d70fc>] mmc_io_rw_extended+0x2ec/0x388
[   33.515347] [<ffffffc0008d8fc0>] sdio_io_rw_ext_helper+0x160/0x268
[   33.521483] [<ffffffc0008d93fc>] sdio_writesb+0x40/0x50
[   33.526677] [<ffffffbffc338b38>] btmrvl_sdio_host_to_card+0x124/0x1bc [btmrvl_sdio]
[   33.534283] [<ffffffbffc3290a0>] btmrvl_service_main_thread+0x384/0x428 [btmrvl]
[   33.541626] [<ffffffc0002518e8>] kthread+0x140/0x158
[   33.546550] Memory state around the buggy address:
[   33.551305]  ffffffc0d89b4980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   33.558474]  ffffffc0d89b4a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   33.565643] >ffffffc0d89b4a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
[   33.572809]                                                                 ^
[   33.579889]  ffffffc0d89b4b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   33.587055]  ffffffc0d89b4b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   33.594221] ==================================================================

The cause of this is that btmrvl_sdio_host_to_card can access memory region
out of its allocated space due to:

  1. the requested block size is smaller than SDIO_BLOCK_SIZE, and/or
  2. the allocated memory is not BTSDIO_DMA_ALIGN-aligned.

Since sdio_writesb() is able to handle any size of data it's not necessary
to re-allocate memroy region which size is multiple of SDIO_BLOCK_SIZE. We
just need to make sure the relocation of memory for making the address
BTSDIO_DMA_ALIGN-aligned does not cause out-of-bound access.

CC: Wei-Ning Huang <wnhuang@chromium.org>
CC: Daniel Kurtz <djkurtz@chromium.org>
CC: Amitkumar Karwar <akarwar@marvell.com>

Signed-off-by: Ricky Liang <jcliang@chromium.org>
---
 drivers/bluetooth/btmrvl_sdio.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index f425ddf..ecc0191 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1071,8 +1071,6 @@ static int btmrvl_sdio_host_to_card(struct btmrvl_private *priv,
 {
 	struct btmrvl_sdio_card *card = priv->btmrvl_dev.card;
 	int ret = 0;
-	int buf_block_len;
-	int blksz;
 	int i = 0;
 	u8 *buf = NULL;
 	void *tmpbuf = NULL;
@@ -1085,7 +1083,7 @@ static int btmrvl_sdio_host_to_card(struct btmrvl_private *priv,
 
 	buf = payload;
 	if ((unsigned long) payload & (BTSDIO_DMA_ALIGN - 1)) {
-		tmpbufsz = ALIGN_SZ(nb, BTSDIO_DMA_ALIGN);
+		tmpbufsz = ALIGN_SZ(nb, BTSDIO_DMA_ALIGN) + BTSDIO_DMA_ALIGN;
 		tmpbuf = kzalloc(tmpbufsz, GFP_KERNEL);
 		if (!tmpbuf)
 			return -ENOMEM;
@@ -1093,15 +1091,12 @@ static int btmrvl_sdio_host_to_card(struct btmrvl_private *priv,
 		memcpy(buf, payload, nb);
 	}
 
-	blksz = SDIO_BLOCK_SIZE;
-	buf_block_len = DIV_ROUND_UP(nb, blksz);
-
 	sdio_claim_host(card->func);
 
 	do {
 		/* Transfer data to card */
 		ret = sdio_writesb(card->func, card->ioport, buf,
-				   buf_block_len * blksz);
+				   nb);
 		if (ret < 0) {
 			i++;
 			BT_ERR("i=%d writesb failed: %d", i, ret);
-- 
2.1.2
