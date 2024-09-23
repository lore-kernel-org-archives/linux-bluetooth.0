Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7B519343E;
	Mon, 23 Sep 2024 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727081237; cv=none; b=d37EvF42wOkXorJpjiJegKJ+jzO44v3rny93roKAH7XouYLZCXXILBYb49xDM7XphHcPf8aYOl4664Vw2nC6T878feKbjDdiXYonDSJOgFea6JMUPpfyK5lOUCn7e3taBhk+ZtQ/HmNdios8c9eRr5hMEaqJVtgy/S69envhDGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727081237; c=relaxed/simple;
	bh=jR4pNNMrVF5eHW9z98Mx+XRPXtc83p/n+p1TIJ2o0P8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=um4w76hs2x7teev69+SBJhGi2aGKd2pAnJy4/FoDONkG58sTXxnbhm6ZrsKYW0dyqUKCkrGrW7VgYC7IVhbkgnFBCZfFlNKXJ/QE6bvpebSU+QlGqPOehKWzbTtLOUL3rcAumVydnHVm50EZShUE9w2zWDpbvSvxFwok9U9RzV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=q5ZS8qjn; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="q5ZS8qjn"
X-UUID: 6be2eed4798811ef8b96093e013ec31c-20240923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=R7PfRKskVGwT9r2F1Yqlbbe6a3JQ6+g4PrqqXljQYNI=;
	b=q5ZS8qjny04/H4bVbXjmYzgEygO8REWZqinpjb0HxlV2m24RUUGSUuAg4Y4m3zKOblghJLz+oGulupelvMfCUC3BgvmrmSC7XkcK36WoMTM7j/qplFcQwImKsVEzDcc91I9uZZNyCuHcJhmb/iaIhkI643juDr3b8wBrlpsF25M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:e1b7014e-8064-4b1f-a28f-e1f2e51e865b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:d6276a9e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6be2eed4798811ef8b96093e013ec31c-20240923
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 934710522; Mon, 23 Sep 2024 16:47:10 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Sep 2024 16:47:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 23 Sep 2024 16:47:08 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v3 1/4] Bluetooth: btusb: mediatek: move Bluetooth power off command position
Date: Mon, 23 Sep 2024 16:47:02 +0800
Message-ID: <20240923084705.14123-2-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240923084705.14123-1-chris.lu@mediatek.com>
References: <20240923084705.14123-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.896600-8.000000
X-TMASE-MatchedRID: uBK5O+9wx1H9jxte3IFskCmjEOrcO6AyTJDl9FKHbrkKogmGusPLb1Rw
	2bAU6/Xp4vM1YF6AJbZhyT3WNjppUtAtbEEX0MxBxEHRux+uk8ifEzJ5hPndGWE2zAPzjeJcFYG
	LjtbYxOuAcoXqsszlIOBwlKjaWOxqIhQQ1YNJEQ6Qevzt5Pblqb/4zoQq0vAalqQnhpXEWk7KW8
	lyn96FsnmVKZusLp922v9OjYWA2uMMswg45VMfPadst5iAforfVlxr1FJij9s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.896600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 8494FE5B73917A51B060E8BCB5049AA4273515BDA073E1D14D47D35F19A8FAA52000:8

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

