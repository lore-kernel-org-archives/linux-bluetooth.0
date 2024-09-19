Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D292195B18;
	Thu, 19 Sep 2024 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732179; cv=none; b=ddScAB5XEooe6V4eoz878zgboXufoIdfvTiYI4ovG8HGhfMxCBvXB0C2C2G7QMpBaO2e6LOVdeAERJrMdtNKTsYzimiM1H+8OHkWhyokM+NVQYfgK/VHz+0WvbPk2OcCxPYpF216pNpWI8HwR0QqQSipZqm0Kd+y+AqJvMjUugc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732179; c=relaxed/simple;
	bh=jR4pNNMrVF5eHW9z98Mx+XRPXtc83p/n+p1TIJ2o0P8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nkl/ljMo8lJdm7zdpq35dhNd779OZn7iikakHDbS3n1JZaZlNoSyfpU+CqTFKhj4dfl5ycUJp3p3xYfduiCZVV9UvdTg0HbhKlKzNbvPGr3JRiLy+4++qqe1W4Ha2vFu0SkjGdjGxxPifD6XMhC7vwHa9WJlzywwnRiuGuJMcAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pxAS+aDA; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pxAS+aDA"
X-UUID: b3100ff6765b11efb66947d174671e26-20240919
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=R7PfRKskVGwT9r2F1Yqlbbe6a3JQ6+g4PrqqXljQYNI=;
	b=pxAS+aDADa5XdR+KPJ7AWXje7zK+jOlJBb7iDupMH8NvSvhc0z6yhhHq41LO0YyiFwSwKvb/8QteN7Wz5w7dIVBrCHwD3Si+KXrr3+LHYqYO6uQbHR88n9XExbglrZJwv1ui4SEN6qdGdzhBbTlCitfVhmokmvV0VzKUur8k6Js=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:ae3bfb59-9043-41a8-b3f2-039d049dd607,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:63db3a9e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b3100ff6765b11efb66947d174671e26-20240919
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1343040907; Thu, 19 Sep 2024 15:49:29 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 19 Sep 2024 00:49:27 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 19 Sep 2024 15:49:27 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v2 1/4] Bluetooth: btusb: mediatek: move Bluetooth power off command position
Date: Thu, 19 Sep 2024 15:49:22 +0800
Message-ID: <20240919074925.22860-2-chris.lu@mediatek.com>
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

Move MediaTek Bluetooth power off command before releasing
usb ISO interface.

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

