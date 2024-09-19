Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E499A196C7C;
	Thu, 19 Sep 2024 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732180; cv=none; b=NuFs8kQGd1N+SmmK35yjeghB1y0y4iN9iJCd9DDM6yNiuUVtp41gzU1I4JWBHTyxFzoB/wuyTbn+Ta+tzlt/DQ3gvc9CtmCLVMc5ZRRxb6ktn77DCtGWshGTCpZOAw6KRr9j3UmDOVZ2vGsU3/UcbRA6I0bPRho65rX1o+922bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732180; c=relaxed/simple;
	bh=r1cXFTfwn7yTEwq72n7R++KWICFpO9L7KdZt8lSPK+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVgQIPwSLGvnddkAr/MrffMlREzfV0GZIf4dEjTQmAgEABxAjSKBK+OP9HMJZPf8bXs3PehcC12z/OAl8FkwsJcJP/64Vh09Uji0KJiPacTjPIWfGqGGkCPNsdTX08F2jU45ctdH3PYX6lzz7wakkD3mfaP5l8U9cyoNWrooEVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sHLFICmK; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sHLFICmK"
X-UUID: b3539e24765b11ef8b96093e013ec31c-20240919
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mMiJYM6LFq/ZFiBJD1Iufm69acB1VIDo+EHB1kP4RNc=;
	b=sHLFICmKEhSwhcfvATQf8cqmIaeywIkdYNXTpDusUi6ym7xVSjv6YOQtLuC0AFnLTibXQpTuk1mmNfcBKlUpA4UUs+pcWxW3Nqw6xXaLk+O/Quqa+E8/GjGXBbLpfbtTiWUQveOvzMbsfsK/0ZqohS81JH/nKVxMbM9wfyRvcrQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:a0aa84f5-124a-4b51-b116-520d25087ce3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:80db3a9e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b3539e24765b11ef8b96093e013ec31c-20240919
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 387824893; Thu, 19 Sep 2024 15:49:29 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 19 Sep 2024 15:49:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 19 Sep 2024 15:49:28 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v2 4/4] Bluetooth: btusb: mediatek: change the conditions for ISO interface
Date: Thu, 19 Sep 2024 15:49:25 +0800
Message-ID: <20240919074925.22860-5-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240919074925.22860-1-chris.lu@mediatek.com>
References: <20240919074925.22860-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Change conditions for Bluetooth driver claiming and releasing usb
ISO interface for MediaTek ISO data transmission.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btusb.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 37e67b451b34..bb28a9b2dc11 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2618,7 +2618,7 @@ static int btusb_mtk_release_iso_intf(struct hci_dev *hdev)
 {
 	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
 
-	if (btmtk_data->isopkt_intf) {
+	if (test_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags)) {
 		usb_kill_anchored_urbs(&btmtk_data->isopkt_anchor);
 		clear_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags);
 
@@ -2650,7 +2650,7 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 	if (err < 0)
 		return err;
 
-	if (test_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags))
+	if (test_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags))
 		btusb_mtk_release_iso_intf(hdev);
 
 	btusb_stop_traffic(data);
@@ -2696,9 +2696,10 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 	btmtk_data->reset_sync = btusb_mtk_reset;
 
 	/* Claim ISO data interface and endpoint */
-	btmtk_data->isopkt_intf = usb_ifnum_to_if(data->udev, MTK_ISO_IFNUM);
-	if (btmtk_data->isopkt_intf)
+	if (!test_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags)) {
+		btmtk_data->isopkt_intf = usb_ifnum_to_if(data->udev, MTK_ISO_IFNUM);
 		btusb_mtk_claim_iso_intf(data);
+	}
 
 	return btmtk_usb_setup(hdev);
 }
@@ -2710,7 +2711,7 @@ static int btusb_mtk_shutdown(struct hci_dev *hdev)
 
 	ret = btmtk_usb_shutdown(hdev);
 
-	if (test_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags))
+	if (test_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags))
 		btusb_mtk_release_iso_intf(hdev);
 
 	return ret;
-- 
2.18.0

