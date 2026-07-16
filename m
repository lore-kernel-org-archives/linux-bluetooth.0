Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979803C0A05;
	Thu, 16 Jul 2026 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201111; cv=none; b=pOwActFxSHH1Qgrg9H/3IGqkLAM2u6ZkaBgZ+vFBkoyNfFp1aJLW/GNx4o2EbuJmeZH/kUzPdAJWhEZ9qAQkLkVJYiNG0VWZpTMclT7BfyYoXNfzL6IkPZCuqa8YW+3fmN4yJQX/yE9x6SxjGvHzjJzjkbn2TbaCTIfff3PtizI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201111; c=relaxed/simple;
	bh=EqYUk63NVelyOLK0vCOukGKRH+yoJFON7cycYQjv03s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dxN1eradHlDNRtd3KYYg3JLCs49xh7pK/p07OZLOuU5g7IWnT5BOya8VnD3KRuJYOVdKnG4QPYLXcr5GR/TLZFTiSw2YebJVMDwQfXr+T1xk63GX0kluYXFR9WgwPCBjpsq1I2PXT493c6Pokc9DUK13ivh0xpqtwaFhOvZuO+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WkRrdWGs; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WkRrdWGs"
X-UUID: d590c160810811f18dc8c9802ae25ab1-20260716
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=t9Z0tBhOMFqq/izG02xcKi5uI5s0bUCn3BE16KHOvDg=;
	b=WkRrdWGsUs7ssSSmk5vPWPlALK24TcOhpxbHIVwRjhtpW3pO418srUsnyRvf83m3HOMMeVYjMqOdeIHtBvZgfLQh6LYHQxhrzJJLzdSLZP3cPZuo051A23rtdkEBTi9lOZzhgHB+ELfj2dvZ8aP8o9j0wIHCUUZwkxpvCV1JOIw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18,REQID:b331a203-89e0-48e7-9b63-8cc2e6ac9a0f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:8a735a6,CLOUDID:2a5f563f-46cf-453a-bd84-ad9fc7cb0e8c,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99|200|213,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d590c160810811f18dc8c9802ae25ab1-20260716
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1840437761; Thu, 16 Jul 2026 19:23:56 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 16 Jul 2026 19:23:55 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 16 Jul 2026 19:23:55 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v13 1/7] Bluetooth: btmtksdio: Fix SKB handling issues in TX path
Date: Thu, 16 Jul 2026 19:23:46 +0800
Message-ID: <20260716112353.2192865-2-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260716112353.2192865-1-chris.lu@mediatek.com>
References: <20260716112353.2192865-1-chris.lu@mediatek.com>
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
   retransmission queues), the driver corrupts the shared data buffer
   for other subsystems. Fix by calling skb_unshare() at function entry
   to ensure we have a private copy before any modifications.

Fixes: 9aebfd4a2200 ("Bluetooth: mediatek: add support for MediaTek MT7663S and MT7668S SDIO devices")
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Assisted-by: Claude:Sonnet-4.5
---
 drivers/bluetooth/btmtksdio.c | 42 ++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 5b0fab7b89b5..8a7f2e1c4d56 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -272,9 +272,20 @@ static int btmtksdio_tx_packet(struct btmtksdio_dev *bdev,
 			       struct sk_buff *skb)
 {
 	struct mtkbtsdio_hdr *sdio_hdr;
+	unsigned int padded_len, pad_len;
 	int err;

-	/* Make sure that there are enough rooms for SDIO header */
+	/* Ensure SKB is not cloned before any modification.
+	 * If cloned (e.g., L2CAP retransmission queues), create a
+	 * private copy to avoid corrupting shared data buffer.
+	 */
+	skb = skb_unshare(skb, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	/* Make sure that there are enough rooms for SDIO header.
+	 * After skb_unshare(), we have exclusive ownership of the buffer.
+	 */
 	if (unlikely(skb_headroom(skb) < sizeof(*sdio_hdr))) {
 		err = pskb_expand_head(skb, sizeof(*sdio_hdr), 0,
 				       GFP_ATOMIC);
@@ -290,18 +301,39 @@ static int btmtksdio_tx_packet(struct btmtksdio_dev *bdev,
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

 	return 0;

+err_skb_trim:
+	if (pad_len > 0)
+		skb_trim(skb, skb->len - pad_len);
 err_skb_pull:
 	skb_pull(skb, sizeof(*sdio_hdr));
+	kfree_skb(skb);

 	return err;
 }
--
2.45.2

