Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.61.82.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572231;
	b=uZyFA+5EOI5mxDylAiSbdr7K3zo0aRyLmzypa1sjnRwW0Gun41khRGiaM3VdaC/HkLrf
	 KO47ctgq1VdyUB+6sBv5uMbZ/w2sko0YN08ZaTkjDHIFGFEoSZCQ68+7q47lAnE5WXek5
	 54atzf/TBawCtTfuxGWc0f45cz8iOYAgl0MGAWSMMphC4nCu0QBtYMxKHFhGezRd7OTBg
	 oFdO6hwpXCNpOW4IhRPq6U5I84kSdHa5bFnS49QxQhsgXdCBknDzci9U4MMDzvAEAAN4V
	 UBsx6MxTWlDx1lfkI2vXeoIgyVUJOoL4QJHOw+VMJM7d14ev2Zf3U3ZtnhpZN75sHEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572231;
	h=DMARC-Filter:X-UUID:DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=tQdSCEU0x8lkQ6fgPe4pYGr4c4CcRG3XO5hkaeUqero=;
	b=Sfle47Ogged+IHuM5WfZTRykbCuz6S57Lmw9gNf6Ryz48fKTRhaoA1b0vTTATASxmWCO
	 kNctVx98lnvULenJv6AJEoQf5pmDRaBXhSgPkAzDJio63VavYXtraP8Wma7/3cjlcAg2J
	 vPoILMgPrUVizZl9ZDL3BPPSIKW2o2y8CnhlyqkaqJL/PlEuPDfQ0nZwpH+vmdJK+Vxum
	 CWcUXJ0DJi5y66z1WUTh9oIhkfaH0Mex5jOHvFJ4hgVbZUJY6pZuiPfyuRvQokS+JdwiP
	 +5dbLYe5naJaIe7X8Y+ReyR3Aw+9v/jKoo4Dl45XtkAJfsD8SRXgw1Ell7s1OU05hdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mediatek.com;
	spf=pass smtp.mailfrom=mediatek.com;
	dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b="CYfwH/x+";
	arc=none smtp.remote-ip=210.61.82.184
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9322E606A31F;
	Wed, 21 Oct 2026 08:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9322E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=CYfwH/x+
X-UUID: 83cf16aacd2b11f18dc8c9802ae25ab1-20261021
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=tQdSCEU0x8lkQ6fgPe4pYGr4c4CcRG3XO5hkaeUqero=;
	b=CYfwH/x+T0Tg8pdBcHo82nmRMbtijUm4bFiCXioqUBot8A66sK0y631nhToSgEfcSdm3u2wJHJIHqniJMhmy5d0UgpkxPEsUsJUvZMBc+LkWiwbKN6um8oxrmeNJjSD3i7M9R/JXooK1Y2pPEfMO+8zzF3QwuL8m5VGbdnYzxRY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:f2f5ee74-f021-4953-bc86-1bbc8d29d118,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:291e20b,CLOUDID:212cdfba-4006-44bb-949c-6e25a7b8dad4,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 83cf16aacd2b11f18dc8c9802ae25ab1-20261021
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 301622949; Wed, 21 Oct 2026 16:43:40 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 21 Oct 2026 16:43:39 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 21 Oct 2026 16:43:39 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Hao Qin <hao.qin@mediatek.com>, Wenlong Tian
	<ot_wenlong.tian@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Will Lee
	<will-cy.Lee@mediatek.com>, SS Wu <ss.wu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v3 RESEND 3/3] Bluetooth: btmtk: derive the firmware ISO setting from MTK_ISO_THRESHOLD
Date: Wed, 21 Oct 2026 16:43:37 +0800
Message-ID: <20261021084337.1515468-4-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261021084337.1515468-1-chris.lu@mediatek.com>
References: <20261021084337.1515468-1-chris.lu@mediatek.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The ISO data transfer size is spelled out twice: as a raw byte pair in the
vendor command sent by btmtk_usb_isointf_init(), and as MTK_ISO_THRESHOLD
for the padding in btmtk_isopkt_pad(). Build the command payload from the
macro so the size is stated once, and update the setting for current
MediaTek controllers.

Fixes: ceac1cb0259d ("Bluetooth: btusb: mediatek: add ISO data transmission functions")
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 479f3d937554..0f632240d991 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -31,7 +31,7 @@
 #define BTMTK_CBMCU_FLAG_ENABLE_PATCH	0xF1
 
 /* It is for mt79xx iso data transmission setting */
-#define MTK_ISO_THRESHOLD	264
+#define MTK_ISO_THRESHOLD	342
 
 struct btmtk_patch_header {
 	u8 datetime[16];
@@ -1741,7 +1741,7 @@ static int btmtk_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
 static int btmtk_usb_isointf_init(struct hci_dev *hdev)
 {
 	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
-	u8 iso_param[2] = { 0x08, 0x01 };
+	__le16 iso_param = cpu_to_le16(MTK_ISO_THRESHOLD);
 	struct sk_buff *skb;
 	int err;
 
@@ -1756,7 +1756,7 @@ static int btmtk_usb_isointf_init(struct hci_dev *hdev)
 		return err;
 	}
 
-	skb = __hci_cmd_sync(hdev, 0xfd98, sizeof(iso_param), iso_param,
+	skb = __hci_cmd_sync(hdev, 0xfd98, sizeof(iso_param), &iso_param,
 			     HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Failed to apply iso setting (%ld)", PTR_ERR(skb));
-- 
2.45.2

