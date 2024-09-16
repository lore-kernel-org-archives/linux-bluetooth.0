Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B94155359;
	Mon, 16 Sep 2024 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726486797; cv=none; b=Vedd0RKVoO+fgE3YTaVBu3/lg+86mtiYaXfg7bQB/SQqRAYb/M9THxcl0yrIrUtzj50VJrxqoaF6++OlBMMRsOjXFpk3NeJrzreBwKTHkq1bNyLPBHSHrs9lZJNdrcKYPRbD3lUtoU93A//mysaqghfLCpjYH+0gcRE78BbbDRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726486797; c=relaxed/simple;
	bh=PA6xSdEtmuongAiXsnKef4lOe0hIerFc6lyTNoUathQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YoKtKl0aBAsvzfsTjOt1vjdP7uWFnPugDZr4rJR/RVA471Lr9yxATOBH8G2QVejesGFCpYLP3HkBh6u1KM6T/GNH29RKpdR6k2QeggV5/tve0lgMMAlb5+X82s8SF123awuWc1hpMXoQwB8uxYSbKO5IN+I2bGHay7zRxYe/NhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BB8RzsRt; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BB8RzsRt"
X-UUID: 5f30fc84742011ef8b96093e013ec31c-20240916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=HGRY36cizd3vIsMXg/Xz0M1o276dGUlCXfwKHKK62zU=;
	b=BB8RzsRtJQ2jTh72vESFrciuJqWMG/IbrNu5dQtaKBH8FskUauSLYLr64pjNQy0gEwV/KGtoUC540tKPFarVkgNVWjyqghYRvJYW62kTvysYDwXDNKKPTyfVIRPJYZCvz1sxsO5D9aRHh4MzsDdUZvnyqiqoUiIWCzj+DI4Ww8U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:6d01a3f8-f7e0-407e-98fd-3086c1acd912,IP:0,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:6dc6a47,CLOUDID:277c0ac0-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 5f30fc84742011ef8b96093e013ec31c-20240916
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2009708872; Mon, 16 Sep 2024 19:39:45 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 16 Sep 2024 04:39:44 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 16 Sep 2024 19:39:44 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH 1/4] Bluetooth: btusb: mediatek: move Bluetooth power off in btusb_mtk_shutdown
Date: Mon, 16 Sep 2024 19:39:35 +0800
Message-ID: <20240916113938.30285-2-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240916113938.30285-1-chris.lu@mediatek.com>
References: <20240916113938.30285-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Move MediaTek Bluetooth power off command before releasing usb ISO interface.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btusb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 6c9c761d5b93..6cf1729a8225 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2704,11 +2704,14 @@ static int btusb_mtk_shutdown(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
+	int ret;
+
+	ret = btmtk_usb_shutdown(hdev);
 
 	if (test_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags))
 		btusb_mtk_release_iso_intf(data);
 
-	return btmtk_usb_shutdown(hdev);
+	return ret;
 }
 
 #ifdef CONFIG_PM
-- 
2.18.0

