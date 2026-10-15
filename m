Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B2D4AA1F3;
	Thu, 15 Oct 2026 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052103; cv=none; b=hoUng45ziuouqJddk8nZpHoQWRuD2/xNzTZLPEOmuMVAgJtVPZF6geFOAPlWPJEdm0AoXlBB6JGo16bGmIErkek63LcuB3fcSBxCXQVpkrKa0d/EkcKAkssV/TbzffTrTbGjprUmRUpdoumKQ1LFioGgrWMVVjp2pMSR+lYy7nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052103; c=relaxed/simple;
	bh=IfUwLtkSJu91J3o0Di2OgKdJzeqxzb7StX3U6vIIVBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+lh3rTk2xcB/KIea38ZBYx44UUIHaosEcWoKNlmmyxVFvrl4koGFf+G9uiciz2zWnyySRBkKCOPnMC8IAz5+IhaFnTCERnw3SHwqI9rHnql+xF7F16CRrgLuYskX84MfRhZan0zmz9LrEEpffXgj5GpMHoMOgOvYeQ/YQxIEfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YMYEH0Or; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YMYEH0Or"
X-UUID: 802e6074c87011f1b1788b6acf885367-20261015
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bpxjN2Rvl+YfUl0+XO3Q4bMQQ3s3XqRur7QXJlWCn4I=;
	b=YMYEH0OrzhifdsfQDWIjsrDHP7t+VtJxf9lJ9ucO4YtmZwsd/IOzv3l4TrbvB5lME2xlJHiLKsSKhHuU5Wt8cbjBEcQX/0wu9tp2YSDynYeZC+708ITl/Zr82aTwEvpEgvEbkp/e4omzDokbDwIaoyErQwYvwuRyJ8nTCxENG70=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:397a0e05-da2f-4324-961e-ec31cc5c7bc6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:291e20b,CLOUDID:6b0f6095-3103-4fdb-b79c-08de0e281a5d,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 802e6074c87011f1b1788b6acf885367-20261015
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1453683901; Thu, 15 Oct 2026 16:14:53 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Oct 2026 16:14:52 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 15 Oct 2026 16:14:52 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Hao Qin <hao.qin@mediatek.com>, Wenlong Tian
	<ot_wenlong.tian@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Will Lee
	<will-cy.Lee@mediatek.com>, SS Wu <ss.wu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v2 3/3] Bluetooth: btmtk: derive the firmware ISO setting from MTK_ISO_THRESHOLD
Date: Thu, 15 Oct 2026 16:14:50 +0800
Message-ID: <20261015081450.1241194-4-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261015081450.1241194-1-chris.lu@mediatek.com>
References: <20261015081450.1241194-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
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
index 7c3fffcefdf1..9424125ce539 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -24,7 +24,7 @@
 #define MTK_SEC_MAP_NEED_SEND_SIZE	52
 
 /* It is for mt79xx iso data transmission setting */
-#define MTK_ISO_THRESHOLD	264
+#define MTK_ISO_THRESHOLD	342
 
 struct btmtk_patch_header {
 	u8 datetime[16];
@@ -1347,7 +1347,7 @@ static int btmtk_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
 static int btmtk_usb_isointf_init(struct hci_dev *hdev)
 {
 	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
-	u8 iso_param[2] = { 0x08, 0x01 };
+	__le16 iso_param = cpu_to_le16(MTK_ISO_THRESHOLD);
 	struct sk_buff *skb;
 	int err;
 
@@ -1362,7 +1362,7 @@ static int btmtk_usb_isointf_init(struct hci_dev *hdev)
 		return err;
 	}
 
-	skb = __hci_cmd_sync(hdev, 0xfd98, sizeof(iso_param), iso_param,
+	skb = __hci_cmd_sync(hdev, 0xfd98, sizeof(iso_param), &iso_param,
 			     HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Failed to apply iso setting (%ld)", PTR_ERR(skb));
-- 
2.45.2

