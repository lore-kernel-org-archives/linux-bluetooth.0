Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDF23B813C;
	Tue, 13 Oct 2026 08:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879517; cv=none; b=rMeq0iYLw5CVXZaOTqz/2DxI9m1OSeTtVxjmLJnoWMie8AchzYammIsDcsgWoDaErjJhQ1fTDO/dNmj5mus9CkDrrYGH00ve/8Y/jYyb6WCjpSfx3xUxWwvWp0vRvnqRFGNhjpE5VaF5GwRy/9ilM0pnQzKH4j1x5sqxURjch9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879517; c=relaxed/simple;
	bh=C0ItskmYWZJOCm6EUy1F3wxbLyr4CaulpTb18mOLMw0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+e25/N3EMDrNLbNd3kz0r+hBxTIEXkv+E56i0Ets/rvU8pb/5S3v1SEH2FMAXFKToSZ9SFCX/DMThXsOjd9HgcAjd7ZcGTCUiEXPnBX2KV/WnJ580hvpQxwHyos/7Qju3hdqFhSBj5HUVnXqSfa71z6wfi1HIVwD5m9OYnvNZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dGVDa3zE; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dGVDa3zE"
X-UUID: aa4a7be2c6de11f18dc8c9802ae25ab1-20261013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=2koErh8H97/dPt4DifQK5DJYoWrNT2mAtpnRDTTX3Wo=;
	b=dGVDa3zEBVWKAKLgQEUOcub269ePf1Io2CHq2Qvpv9HF0Eom9fpHMLXwKgBrHITQPuRJVq87kXzqvBvNTk1n7jtcmhat14AHvIeZllhZI+LlkUMhIFqzb0aokYQ1gJ2uWmg9Ov5yh7liDu9UaSwZZyrCGrAWVwGKS5ut7PEXXP0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:a95c5f06-9bee-4350-a31e-f6bd1b28c1a3,IP:0,U
	RL:0,TC:0,Content:54,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:54
X-CID-META: VersionHash:291e20b,CLOUDID:16534995-3103-4fdb-b79c-08de0e281a5d,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:3|15|5
	0|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: aa4a7be2c6de11f18dc8c9802ae25ab1-20261013
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1841572890; Tue, 13 Oct 2026 16:18:26 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Oct 2026 16:18:25 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 13 Oct 2026 16:18:25 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Hao Qin <hao.qin@mediatek.com>, Wenlong Tian
	<ot_wenlong.tian@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Will Lee
	<will-cy.Lee@mediatek.com>, SS Wu <ss.wu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH 2/2] Bluetooth: btmtk: size the ISO receive skb to hold header plus payload
Date: Tue, 13 Oct 2026 16:18:23 +0800
Message-ID: <20261013081823.817996-3-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261013081823.817996-1-chris.lu@mediatek.com>
References: <20261013081823.817996-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

btmtk_recv_isopkt() allocates HCI_MAX_ISO_SIZE (251) bytes and stores the
4-byte HCI ISO header into the same skb, leaving only 247 bytes for the
payload. A Data_Total_Length of 248..251 would fail the skb_tailroom()
check and be dropped with -EILSEQ, taking the rest of the URB transfer
with it.

HCI_MAX_ISO_SIZE is the maximum payload length, not the maximum frame
length, so allocate HCI_MAX_ISO_SIZE + HCI_ISO_HDR_SIZE, matching how the
ACL path uses HCI_MAX_FRAME_SIZE (HCI_MAX_ACL_SIZE + 4).

Fixes: ceac1cb0259d ("Bluetooth: btusb: mediatek: add ISO data transmission functions")
Co-developed-by: Hao Qin <hao.qin@mediatek.com>
Signed-off-by: Hao Qin <hao.qin@mediatek.com>
Co-developed-by: Wenlong Tian <ot_wenlong.tian@mediatek.com>
Signed-off-by: Wenlong Tian <ot_wenlong.tian@mediatek.com>
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 869eb2176379..1b501b64d71f 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1178,7 +1178,8 @@ static int btmtk_recv_isopkt(struct hci_dev *hdev, void *buffer, int count)
 		int len;
 
 		if (!skb) {
-			skb = bt_skb_alloc(HCI_MAX_ISO_SIZE, GFP_ATOMIC);
+			skb = bt_skb_alloc(HCI_MAX_ISO_SIZE + HCI_ISO_HDR_SIZE,
+					   GFP_ATOMIC);
 			if (!skb) {
 				err = -ENOMEM;
 				break;
-- 
2.45.2

