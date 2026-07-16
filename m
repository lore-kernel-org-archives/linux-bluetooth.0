Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBB0342C80;
	Thu, 16 Jul 2026 01:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784167178; cv=none; b=nWggh6AxdwkON1V6bmbZD/vYPOOOnfbUwBILaiZ6Ft4YYKxXLcx2BWqW0QB0kcb6wIttOrmkp9b+gMNXJ9OOCdnIijAGa1UtKNeJV+rAB4yvxAYxjdKFi8jCtd8c2AstwhwhXwsOxYf7SwXahR0Ca4MFG/T8r2mGG0d0L74gvDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784167178; c=relaxed/simple;
	bh=8mEEu0fofAd3LjQpobHKIIP/WCU/gXmoGNsGVUQipTA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpAJIyEl35BYmCAdl/lJcImnJWRZliivFdc/6bBmuT51qHSf9Hj9ImzGu2a46msghaZeilKwNIfu1O3Xlh/jeJvSD3lkxbfuW99NMCeNL1UaIDXX5WSg3JcWIn5qo3nz4Mf9QX2EFMKX2lZPphmloW5GG9BxcIhAs1XdAGvQ0K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Xf/9GvgJ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Xf/9GvgJ"
X-UUID: f6806d2a80b911f1b1788b6acf885367-20260716
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=AorHqhtqwV15STsrkbRcHwPgCy7RSx0CoHKVd3m/ihM=;
	b=Xf/9GvgJbgajWOwws1Qg9NZzNHVBzlB/GkQmAn14AWewzS4yK2fTO7408d0aO9dMNaJfIlm0Suyc5q7mMtR2B0Fezo8v4dnPD4xrVzSl5SH7Jm0aJv4DR0TbjaMsgefG+08RyFAv4y8+G3h+AHwXpDjsY5EbhB3hqXknEPfdUWc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:88e70b68-e863-4cf0-bc3e-0fa672a3953a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:2e302d19-ab14-4403-9336-76696324c5a8,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99|200|213,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f6806d2a80b911f1b1788b6acf885367-20260716
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1510600586; Thu, 16 Jul 2026 09:59:21 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 16 Jul 2026 09:59:21 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 16 Jul 2026 09:59:21 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v12 1/7] Bluetooth: btmtksdio: Fix DMA out-of-bounds access in TX path
Date: Thu, 16 Jul 2026 09:59:13 +0800
Message-ID: <20260716015920.1886719-2-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260716015920.1886719-1-chris.lu@mediatek.com>
References: <20260716015920.1886719-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

btmtksdio_tx_packet() aligns transfer size to 256 bytes using
round_up(), but does not ensure the skb buffer has sufficient space,
causing DMA to read beyond the buffer.

Fix by expanding skb tailroom if needed and zero-filling the padding.

Fixes: 9aebfd4a2200 ("Bluetooth: mediatek: add support for MediaTek MT7663S and MT7668S SDIO devices")
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 5b0fab7b89b5..feda1ea8f256 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -272,6 +272,7 @@ static int btmtksdio_tx_packet(struct btmtksdio_dev *bdev,
 			       struct sk_buff *skb)
 {
 	struct mtkbtsdio_hdr *sdio_hdr;
+	unsigned int padded_len, pad_len;
 	int err;
 
 	/* Make sure that there are enough rooms for SDIO header */
@@ -290,18 +291,42 @@ static int btmtksdio_tx_packet(struct btmtksdio_dev *bdev,
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
 
-- 
2.45.2

