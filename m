Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B832A2ECE93;
	Fri, 17 Jul 2026 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277587; cv=none; b=sAlNgZsYSP5sesf/VeL4FgTuhzn72VksPfvxONwit/+/iB9ukxtsN0bMRLW/2ocXkpyUMyaXKKY0Pt9rqj4eHVO3SubVHzRdnb3L5QL5ie7nHp5+mXayHKDExZEA1l9QaJiTk32yeDpgPOG6ayRt3Fkt599itAu2E2OTWFO7N5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277587; c=relaxed/simple;
	bh=aQ8MvLY2LLDx+v2xn0ZqdSvLvVmiVgmfrwC+tIFzIqA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ErqthzLdkHxpJv9baj3+1eJDn95kp44Syua9RHtVMbQIBlqCre67bqDTZSiKuqpGhoGkn4BRpOj5mgRrOgv8l2mZDrPStRpue/ZGIMIZwwd40cIRVY0P6gZB7RRkIAUt6UxcVdRaKCa5Gs5FyE4VjOs13zNG0t2Vh98iuM06x+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uWMaz7om; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uWMaz7om"
X-UUID: 0c3f205081bb11f1b1788b6acf885367-20260717
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=q4mKCxrkd3qReLHiYbaRIiZoCsE0Mlk7ZVDcZrPTBQU=;
	b=uWMaz7omqMtfPUMGLDPZw++n0VOQiRK5ccCUny7xz1vGZ5dlWnqUN63dyWaPJeTuvyMx9gL3ZbKkJux6W7aAQOzFvgqR033idTzAqXOZTextkj5XlRuZYzHB3Swn3SfWi1esQMCpHuO/AOX6VGOcT6Y7XXwEABY1cF1gqdKCkPU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18,REQID:3516b634-223e-45f7-8b73-014310ee716b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:8a735a6,CLOUDID:187213d7-d84b-4e52-b801-314e13fb1691,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99|200|213,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0c3f205081bb11f1b1788b6acf885367-20260717
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2037850899; Fri, 17 Jul 2026 16:39:38 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 17 Jul 2026 16:39:37 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 17 Jul 2026 16:39:37 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>,
	Sashiko <sashiko-review@kernel.org>
Subject: [PATCH v16 1/7] Bluetooth: btmtksdio: Fix SKB handling issues in TX path
Date: Fri, 17 Jul 2026 16:39:30 +0800
Message-ID: <20260717083936.2923891-2-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260717083936.2923891-1-chris.lu@mediatek.com>
References: <20260717083936.2923891-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Fix two SKB handling issues in btmtksdio_tx_packet():

1. DMA out-of-bounds read: The driver aligns transfer size to 256 bytes
   using round_up(), but does not ensure the skb buffer has sufficient
   tailroom, causing DMA to read beyond the buffer. Fix by expanding skb
   tailroom if needed and zero-filling the padding.

2. Cloned SKB corruption: The driver modifies SKB header (via skb_push)
   and tail (via skb_put_zero) without checking if the SKB is cloned.
   If the Bluetooth core passes a cloned SKB (e.g., from L2CAP
   retransmission queues), the driver corrupts the shared data buffer.

   Fix by calling skb_unshare() at function entry to ensure we have a
   private copy. Use double-pointer parameter (struct sk_buff **pskb)
   to properly update the caller's SKB pointer when skb_unshare()
   allocates a new SKB, preventing use-after-free when the caller
   requeues the SKB on error.

   On error paths, do not free the SKB - leave it valid for the caller
   to requeue, avoiding use-after-free in btmtksdio_txrx_work().

Fixes: 9aebfd4a2200 ("Bluetooth: mediatek: add support for MediaTek MT7663S and MT7668S SDIO devices")
Reported-by: Sashiko <sashiko-review@kernel.org>
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Assisted-by: Claude:Sonnet-4.5
---
 drivers/bluetooth/btmtksdio.c | 65 +++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index c6f80c419e90..aea7d07b49ad 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -269,17 +269,32 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 }
 
 static int btmtksdio_tx_packet(struct btmtksdio_dev *bdev,
-			       struct sk_buff *skb)
+			       struct sk_buff **pskb)
 {
+	struct sk_buff *skb = *pskb;
 	struct mtkbtsdio_hdr *sdio_hdr;
+	unsigned int padded_len, pad_len;
 	int err;
 
-	/* Make sure that there are enough rooms for SDIO header */
+	/* Ensure SKB is not cloned before any modification.
+	 * If cloned (e.g., L2CAP retransmission queues), create a
+	 * private copy to avoid corrupting shared data buffer.
+	 */
+	skb = skb_unshare(skb, GFP_ATOMIC);
+	if (!skb) {
+		*pskb = NULL;
+		return -ENOMEM;
+	}
+	*pskb = skb;
+
+	/* Make sure that there are enough rooms for SDIO header.
+	 * After skb_unshare(), we have exclusive ownership of the buffer.
+	 */
 	if (unlikely(skb_headroom(skb) < sizeof(*sdio_hdr))) {
 		err = pskb_expand_head(skb, sizeof(*sdio_hdr), 0,
 				       GFP_ATOMIC);
 		if (err < 0)
-			return err;
+			goto err_free_skb;
 	}
 
 	/* Prepend MediaTek SDIO Specific Header */
@@ -290,21 +305,50 @@ static int btmtksdio_tx_packet(struct btmtksdio_dev *bdev,
 	sdio_hdr->reserved = cpu_to_le16(0);
 	sdio_hdr->bt_type = hci_skb_pkt_type(skb);
 
+	/* Calculate padded length for block-aligned DMA transfer.
+	 * SDIO requires transfers to be block-aligned (MTK_SDIO_BLOCK_SIZE).
+	 * Pad with zeros to prevent DMA from reading beyond skb buffer.
+	 */
+	padded_len = round_up(skb->len, MTK_SDIO_BLOCK_SIZE);
+	pad_len = padded_len - skb->len;
+
+	if (pad_len > 0) {
+		/* Ensure sufficient tailroom for padding */
+		if (unlikely(skb_tailroom(skb) < pad_len)) {
+			err = pskb_expand_head(skb, 0, pad_len, GFP_ATOMIC);
+			if (err < 0)
+				goto err_skb_pull;
+			/* Reassign sdio_hdr after buffer reallocation */
+			sdio_hdr = (void *)skb->data;
+		}
+
+		/* Zero-fill padding to prevent information disclosure */
+		skb_put_zero(skb, pad_len);
+	}
+
 	clear_bit(BTMTKSDIO_HW_TX_READY, &bdev->tx_state);
-	err = sdio_writesb(bdev->func, MTK_REG_CTDR, skb->data,
-			   round_up(skb->len, MTK_SDIO_BLOCK_SIZE));
+	err = sdio_writesb(bdev->func, MTK_REG_CTDR, skb->data, padded_len);
 	if (err < 0)
-		goto err_skb_pull;
+		goto err_skb_trim;
 
-	bdev->hdev->stat.byte_tx += skb->len;
+	/* Record actual transmitted data (excluding padding) */
+	bdev->hdev->stat.byte_tx += le16_to_cpu(sdio_hdr->len);
 
 	kfree_skb(skb);
+	*pskb = NULL;
 
 	return 0;
 
+err_skb_trim:
+	if (pad_len > 0)
+		skb_trim(skb, skb->len - pad_len);
 err_skb_pull:
 	skb_pull(skb, sizeof(*sdio_hdr));
-
+err_free_skb:
+	/* On error, keep skb valid for caller to requeue.
+	 * Do NOT free skb here - let caller handle it.
+	 */
+	*pskb = skb;
 	return err;
 }
 
@@ -606,10 +650,11 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 		if (test_bit(BTMTKSDIO_HW_TX_READY, &bdev->tx_state)) {
 			skb = skb_dequeue(&bdev->txq);
 			if (skb) {
-				err = btmtksdio_tx_packet(bdev, skb);
+				err = btmtksdio_tx_packet(bdev, &skb);
 				if (err < 0) {
 					bdev->hdev->stat.err_tx++;
-					skb_queue_head(&bdev->txq, skb);
+					if (skb)
+						skb_queue_head(&bdev->txq, skb);
 				}
 			}
 		}
-- 
2.45.2

