Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D93331A5B;
	Thu, 16 Jul 2026 01:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784167175; cv=none; b=kLpOidKqXKd838PRnrfbJ8YoYY1gMdkhawDFjLwjw2QWVQ8inrvwW/cFOM04S/yHeH4g7Ua15bdY9dDhhwfAhue7GfFFPLLkc9yIIUkFQ4OYeUz8DiJ+YQglt/C0w3kmZ2ZMuQhClSBU3NH+D7PzzGPzoyc3phJYblxY79jy21Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784167175; c=relaxed/simple;
	bh=3d2nHyZT9JflRsqQ/GMt1q28kpYluI31HEx2nRczg+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6Sp/DgLlUXDqpZe1f0U+e9V41q8J+M7baZP+EjtisWevzRbNCC8EjVyHXCGxl/aunv5HhA+s5sL9pL4QAAMyYRphL+kp3T3mAK0rjI1213JqfJimD5YiDDEMVl79TRxd+Q/01+IS2PMS9XgJuZ3+ht7ACBeDzdE56pcDEBMN0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nu5PvytG; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nu5PvytG"
X-UUID: f738e64880b911f1b1788b6acf885367-20260716
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sxdUfGPBVa6Aw8luxjq4cHzkvDH6P8rvTLiY6Rrhyd8=;
	b=nu5PvytGzrvuklGve906KK4vddQyjYBH9c9gq8Vme9yjPEsJNsJcK6j1egCv4FxFoQ2bwwtQ0mNHWdWUyJIhv9lYqBw88A9vwExc1OkdJekG5VQoleR7s7xEmS8tqXUq45FdhhBkdr4ylOT9n7GRsWqKHB47S/qxQDzs2VpjH1A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:fbdda30f-3de6-40dd-b444-b5d5a924c9cd,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:d497b38,CLOUDID:296b513f-46cf-453a-bd84-ad9fc7cb0e8c,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99|200|213,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f738e64880b911f1b1788b6acf885367-20260716
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1148466690; Thu, 16 Jul 2026 09:59:23 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
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
Subject: [PATCH v12 3/7] Bluetooth: btmtksdio: Pass hardware dev_id to mt79xx_setup()
Date: Thu, 16 Jul 2026 09:59:15 +0800
Message-ID: <20260716015920.1886719-4-chris.lu@mediatek.com>
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

mt79xx_setup() hardcodes dev_id=0 when calling btmtk_setup_firmware_79xx(),
causing SDIO devices to log incorrect chip ID "BT HW ver: 0x0000" instead
of the actual hardware version read from register 0x70010200.

Pass the hardware dev_id to mt79xx_setup() and forward it to
btmtk_setup_firmware_79xx() to match USB driver behavior and display
correct chip identification.

Fixes: 28b7c5a6db74 ("Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support")
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index feda1ea8f256..088fdfb56231 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -901,14 +901,14 @@ static int mt76xx_setup(struct hci_dev *hdev, const char *fwname)
 	return 0;
 }
 
-static int mt79xx_setup(struct hci_dev *hdev, const char *fwname)
+static int mt79xx_setup(struct hci_dev *hdev, const char *fwname, u32 dev_id)
 {
 	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
 	struct btmtk_hci_wmt_params wmt_params;
 	u8 param = 0x1;
 	int err;
 
-	err = btmtk_setup_firmware_79xx(hdev, fwname, mtk_hci_wmt_sync, 0);
+	err = btmtk_setup_firmware_79xx(hdev, fwname, mtk_hci_wmt_sync, dev_id);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to setup 79xx firmware (%d)", err);
 		return err;
@@ -1167,7 +1167,7 @@ static int btmtksdio_setup(struct hci_dev *hdev)
 		snprintf(fwname, sizeof(fwname),
 			 "mediatek/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
 			 dev_id & 0xffff, (fw_version & 0xff) + 1);
-		err = mt79xx_setup(hdev, fwname);
+		err = mt79xx_setup(hdev, fwname, dev_id);
 		if (err < 0)
 			return err;
 
-- 
2.45.2

