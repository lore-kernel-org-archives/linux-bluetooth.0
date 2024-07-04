Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABAA1A270;
	Thu,  4 Jul 2024 06:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720072886; cv=none; b=Wy/xkCC6grkV811QKcBOFlhnCGUut7Rf+MsJIMBToRmrQeHK2t7+Z5pSM9po5NJHapDDnV9qXAw232iC0Zao99xbAsA5jkJx27oF96kQNnbWxD7E4w0vNF9ZMKwp3+ZvQTGFO9K0c97/Swrpj/wbmJo94Jts0bCTK8Z1PTzKvsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720072886; c=relaxed/simple;
	bh=uCu68Z1bpcRG5OT0Z3gl5xWAnsWzMuJTChZVlqhueZQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2JhDAmel5DSUJjqKQ5k4KR49HKHgd9DAkgdKoY1Li4P3AUDFriHqPFEs1mqpR7WC8uvXDUpMAjSOWT795v2rfazwJbvDkiXg9PZ6fDTNbUN0F5v5sVYDWrZHwzdz6U14ZKVXs6cMIiXs2WL5cugfWWK5oD8IUvoO48MIoikGkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=HyG7FiOR; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HyG7FiOR"
X-UUID: d4eb0edc39ca11ef99dc3f8fac2c3230-20240704
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rz5boOxsi/u+gkabvKEweLBuuQ8l1CKIHW5Q1pnKZyU=;
	b=HyG7FiORzAnFw/BTdXvw2SB/vpyFjujkdlXj+ti9XrdmExaintFiA6wuSuUErw21N8oEanJHYQloeJy9Z6KjI3RuyFCWKk+MQOhRaebgNK3kdgQ/WaxBxkqR26TgBbAOkTdHos8Za/KzEOrB7ihx0KTBLgpei/7WuJOxbRDkFEw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:6486b454-5c35-4d6d-ae6a-a83bb7eb0e35,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:ba885a6,CLOUDID:1a62f0d4-0d68-4615-a20f-01d7bd41f0bb,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d4eb0edc39ca11ef99dc3f8fac2c3230-20240704
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 379660069; Thu, 04 Jul 2024 14:01:19 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Jul 2024 23:01:18 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 4 Jul 2024 14:01:18 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v7 1/8] Bluetooth: btusb: mediatek: remove the unnecessary goto tag
Date: Thu, 4 Jul 2024 14:01:09 +0800
Message-ID: <20240704060116.16600-2-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240704060116.16600-1-chris.lu@mediatek.com>
References: <20240704060116.16600-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Remove the unnecessary goto tag whether there is an error or not, we have
to free the buffer at the end of the function.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btusb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 79aefdb3324d..fcdd660add19 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2953,12 +2953,9 @@ static int btusb_mtk_uhw_reg_write(struct btusb_data *data, u32 reg, u32 val)
 			      0x5E,
 			      reg >> 16, reg & 0xffff,
 			      buf, 4, USB_CTRL_SET_TIMEOUT);
-	if (err < 0) {
+	if (err < 0)
 		bt_dev_err(hdev, "Failed to write uhw reg(%d)", err);
-		goto err_free_buf;
-	}
 
-err_free_buf:
 	kfree(buf);
 
 	return err;
-- 
2.18.0

