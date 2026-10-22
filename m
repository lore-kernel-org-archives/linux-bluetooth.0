Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.61.82.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792639324;
	b=sNGZmGr4pHoOG7iEdfEEtWclW1Kn59d7xnqJdehzJPZofDnYZm+RyKjjUGf+zh7EJTM4
	 8NmKSIuKY/e3erpn3ZW26bAvAcwE5jcRsy3Q4AT7cjbHL1+eswJj854V29NyO3BKwQ3KT
	 skXAi9nAP3xn1v6Zwd8DYkBzrnjiuL9UgvENDC50aLe5iJOeV4OrkWaeSWR2Yb/CTnG2p
	 mGhy60LSsdtYDbf4Twx9afYBsFyxWjxiQzA4bSkXj620UfoWswVvlerSX+8+oLM6NtoBg
	 xYxlg9A8QwXx9k6CysQnKl2dTaP1ud6Nm/359ndMq/WNijcSrqFRfUYZgD2JQl0585A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792639324;
	h=DMARC-Filter:X-UUID:DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=BRcTTOuABMbev2Vvx6K/Ogw8u913Ev/oz94OXx24R5o=;
	b=OMLp19uqoVYv9b5mWf3qLwQ+oXrlN35awYmNhCp1wYasu/8aCPD8DYzq3iigIMY6ClLX
	 ROWV9iy5emB+3W3Km0qpyJ6DqMXM3GHFvlrj5lnXMclXmeC61EoljW27DhPif50ey585v
	 w1gE31HSuRNHowAQinyzQmY0vjEGrLd+w6eUdOZEFZQm5MFo2fblt5W8TvRL+LQuDQpaA
	 ZXE+6Qd7OL+PCh5I/gzLfaJu7BJBiosvVEXksBo4tQURokR7hWiJeXLUmN4vIOCwoupum
	 uau/+BSVHzQCVNQ7Gj2EVuNFjVKwS+Um0j1W4RByfd/yix5tPvzNm6y7/YfEgdh+Qbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mediatek.com;
	spf=pass smtp.mailfrom=mediatek.com;
	dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=EMZcvojs;
	arc=none smtp.remote-ip=210.61.82.184
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768BF606A31F;
	Thu, 22 Oct 2026 03:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 768BF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=EMZcvojs
X-UUID: bacff934cdc711f18dc8c9802ae25ab1-20261022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BRcTTOuABMbev2Vvx6K/Ogw8u913Ev/oz94OXx24R5o=;
	b=EMZcvojsfg55ceJFMLHRKu32lyKDZLSgaxu32n+7Mb12ubHJS05r+Egd96D8QDIcVwg2UKh87Ka2g2bKqWj1ZYPHSsq30gvrNWBJhKZk96rgXiDOZNyXwRQhxB+GWhxoUznpygChyCI1NwLFJK6OHo+/rKZYRfYb30SHKb/ayog=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:c65742bc-3f25-4122-98f0-6bb05a055236,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:291e20b,CLOUDID:288fe6ba-4006-44bb-949c-6e25a7b8dad4,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bacff934cdc711f18dc8c9802ae25ab1-20261022
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1796106040; Thu, 22 Oct 2026 11:21:54 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 22 Oct 2026 11:21:52 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 22 Oct 2026 11:21:52 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Hao Qin <hao.qin@mediatek.com>, Wenlong Tian
	<ot_wenlong.tian@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Will Lee
	<will-cy.Lee@mediatek.com>, SS Wu <ss.wu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v4 3/3] Bluetooth: btmtk: derive the firmware ISO setting from MTK_ISO_THRESHOLD
Date: Thu, 22 Oct 2026 11:21:50 +0800
Message-ID: <20261022032150.2213479-4-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261022032150.2213479-1-chris.lu@mediatek.com>
References: <20261022032150.2213479-1-chris.lu@mediatek.com>
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
index f2224eb0bf6b..bf9bfed3da23 100644
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

