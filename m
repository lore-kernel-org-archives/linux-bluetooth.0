Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA40A3EE1C0;
	Mon, 17 Aug 2026 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960427; cv=none; b=Fv73FaYTjArWkZKOZ4R/bTkR4xLd2zO7YkC8qCVgkuoU+qODEohRWDBJrDozQC13geaHoWFxIfnrkTs3/o710Ne27E6Kz6Y5T3as33A3SUWlfJcoNjezT9Yx7vKMjqkb+MwEtu0lFS1zlakvESZXWA3+Y63FZEIwHBdDda3oKZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960427; c=relaxed/simple;
	bh=rllzSdXo3ZdsgkWddUyfh4v6szBPvORzgxynfzeIWJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtm8elLd1UmF+chER1WntEG0Nd3+vewnMkzpBU196v9N++KuVCd0i3Inn62j04ffDZxAxYbG2LQaxYtVr1kAEC9gavx33RHmPeglRQBvnlAahjmUeZGETf8V6H+VlYTEQtB+csOojabrp+FmQlCKZES7oH5G+VGuOnsX1iW96xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kWYxdeNk; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kWYxdeNk"
X-UUID: 83a7923e9a2111f1b1788b6acf885367-20260817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gYjs8Gt4Zh3PcSkiBzHmaM7G0pSUXr3KcGvF22lZlJw=;
	b=kWYxdeNkjy5AKg24m51VEbocXopfKqXAoF/IhvpfczKH7jvWcjaEuJQT5dkSYLIkJ8/XLdZBvjJCEfiGRAdevoHyaxZT9OtY/O/JUm/lj9DegpKospYZeMOiKuvAKTYyJqRdltPYsJ9fEGcPCVN8gpf+HP181QWCXyvDk302HBw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:f3e0bda7-a84f-446c-8828-144a81633d77,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:f8f48ee2-71f1-405e-92eb-6802d6af74fd,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 83a7923e9a2111f1b1788b6acf885367-20260817
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1354481893; Mon, 17 Aug 2026 17:53:35 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 17 Aug 2026 17:53:34 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 17 Aug 2026 17:53:34 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH 1/2] Bluetooth: btmtksdio: Take exclusive ownership of the SKB before TX
Date: Mon, 17 Aug 2026 17:53:31 +0800
Message-ID: <20260817095332.182994-2-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260817095332.182994-1-chris.lu@mediatek.com>
References: <20260817095332.182994-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

btmtksdio_tx_packet() prepends the MediaTek SDIO header with skb_push()
and writes into that space after only checking the headroom size. On a
cloned SKB that headroom belongs to a buffer shared with the other owner,
which the driver has no right to write to.

Cloned SKBs do reach this path: hci_send_cmd_sync() keeps a clone of every
HCI command in hdev->sent_cmd before handing the SKB to the driver, and
l2cap_ertm_send() clones SKBs for retransmission.

Replace the open-coded headroom check with skb_cow_head(), which both
guarantees the headroom and reallocates a private buffer when the SKB is
cloned. The cost is one reallocation and copy per cloned packet, the usual
price of this pattern in network drivers.

This has no observable effect on its own, as the driver only writes in
front of skb->data where no other owner looks. It is a prerequisite for
"Bluetooth: btmtksdio: Fix out-of-bounds DMA read in the TX path", which
writes padding behind skb->tail, and carries the same Fixes: tag so that
both are backported together.

Fixes: 9aebfd4a2200 ("Bluetooth: mediatek: add support for MediaTek MT7663S and MT7668S SDIO devices")
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Assisted-by: Claude:claude-opus-5
---
 drivers/bluetooth/btmtksdio.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 67d055d5f197..bcbbcf8ecc24 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -274,13 +274,12 @@ static int btmtksdio_tx_packet(struct btmtksdio_dev *bdev,
 	struct mtkbtsdio_hdr *sdio_hdr;
 	int err;
 
-	/* Make sure that there are enough rooms for SDIO header */
-	if (unlikely(skb_headroom(skb) < sizeof(*sdio_hdr))) {
-		err = pskb_expand_head(skb, sizeof(*sdio_hdr), 0,
-				       GFP_ATOMIC);
-		if (err < 0)
-			return err;
-	}
+	/* Make sure that the data buffer is not shared with anyone else and
+	 * that there is enough room for the SDIO header
+	 */
+	err = skb_cow_head(skb, sizeof(*sdio_hdr));
+	if (err < 0)
+		return err;
 
 	/* Prepend MediaTek SDIO Specific Header */
 	skb_push(skb, sizeof(*sdio_hdr));
-- 
2.45.2

