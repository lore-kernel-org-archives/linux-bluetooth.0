Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4061A073E;
	Thu,  4 Jul 2024 06:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720072890; cv=none; b=VRGIPOhyLl6phwBdBY4rqXaGSnnajfs7Xi/ZYs6m1aBEH3Q+8oWsrr5ekbX0n+OO4zdvzZbQgpZI5zS2EDidueFAJMA2FCHgF9uWkQptNgRyAkav+RII7XBW9Rgd4RwGRnm1t0/6dZ8Tu8Q3HFXtMAaOza03QhFaLfElI2JwX2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720072890; c=relaxed/simple;
	bh=TEd52duGVATpUwEpzoWdNe9mvSqhdqSIGBuITxjXiOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwPFHCVXKseQN/XOsOHZVpdEGFsLEOS4obVSqO0Y6U90DENKu5AbzURAN77wZRkYoFauw95qsPQmyOO3NdxHKYb0sn4XZzrBByrzRiR4HwQH+cefj6AxhcI6gmKk9t+MVxeOYftU0fDRtsOeFRKN5BtS+U5wlCPL1EPAmkXGJq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SzFTqRFa; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SzFTqRFa"
X-UUID: d600ea0839ca11ef99dc3f8fac2c3230-20240704
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=IRsg1rpjZkP9O+7FX5ib2fnl+eWYWcxVRXO42mkwG/0=;
	b=SzFTqRFakBtDoqV2t/WIqyFkS7QKWW9gvv1tbRVQOJdwiW4Cmqp3X2Lk835/O14E5HC95PgjsLmynsHGFUccoj48xu6bpl+3VYSLWaT4HK3Pr03wuvuks9t745Hm3RKrbAURECh1NLNx7SiaMmU8q3LbxkjmnFGYujn70mLdaf0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:0fb6a305-e781-4987-9a61-a324350e1a79,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:ba885a6,CLOUDID:206e13d1-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:1,IP:nil,UR
	L:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d600ea0839ca11ef99dc3f8fac2c3230-20240704
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1227883653; Thu, 04 Jul 2024 14:01:20 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 4 Jul 2024 14:01:18 +0800
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
Subject: [PATCH v7 2/8] Bluetooth: btusb: mediatek: return error for failed reg access
Date: Thu, 4 Jul 2024 14:01:10 +0800
Message-ID: <20240704060116.16600-3-chris.lu@mediatek.com>
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.402100-8.000000
X-TMASE-MatchedRID: UOztdLtJXr0BM5SnKo8xnMnUT+eskUQP0nXvwjW2mSUKOjjtK9XSTY3q
	EYKsEnZOThbvLLI8RvPaW6+hzTvxgeOwSINwNY6o3fn7n/ZHGqYK3n1SHen81dnu97SXKBPYnn4
	xcc1ghaDnGJSPQW/h/ezw0k3S3hZKkfRhdidsajMURSScn+QSXt0H8LFZNFG7CKFCmhdu5cWetB
	ZUW7JCM4bXxYPTWWSCG1l0pv+MNhpBGDzSpJ7t0o1cCqANCXYi0DZT6vCTPInPSf3b0CQ1A0ckt
	/0Dx7CDPAVnBn0fhjAXRoPmWO3jekxwdkPqCq7vDEyN+J8hd+jCS9WgDXVPCp6oP1a0mRIj
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.402100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: A2D85EB183EBF389E7527259F0EB9FE9975E8693B8A0905F2E1B8320ADA8472F2000:8

Update the code to immediately return an error code if accessing a
related register fails. This ensures that our desired logic for
subsequent register operations is maintained and allows us to promptly
catch any unexpected errors.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btusb.c | 114 ++++++++++++++++++++++++++++----------
 1 file changed, 84 insertions(+), 30 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index fcdd660add19..8239d9c891e6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3037,47 +3037,98 @@ static int btusb_mtk_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 	int err;
 
 	if (dev_id == 0x7922) {
-		btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
+		err = btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
+		if (err < 0)
+			return err;
 		val |= 0x00002020;
-		btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
-		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001);
-		btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
+		err = btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
+		if (err < 0)
+			return err;
 		val |= BIT(0);
-		btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
+		err = btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
+		if (err < 0)
+			return err;
 		msleep(100);
 	} else if (dev_id == 0x7925) {
-		btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
+		err = btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
+		if (err < 0)
+			return err;
 		val |= (1 << 5);
-		btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
-		btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
+		err = btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
+		if (err < 0)
+			return err;
 		val &= 0xFFFF00FF;
+		if (err < 0)
+			return err;
 		val |= (1 << 13);
-		btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
-		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001);
-		btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
+		err = btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
+		if (err < 0)
+			return err;
 		val |= (1 << 0);
-		btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
-		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
-		btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
-		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000000FF);
-		btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
+		err = btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000000FF);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
+		if (err < 0)
+			return err;
 		msleep(100);
 	} else {
 		/* It's Device EndPoint Reset Option Register */
 		bt_dev_dbg(hdev, "Initiating reset mechanism via uhw");
-		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
-		btusb_mtk_uhw_reg_read(data, MTK_BT_WDT_STATUS, &val);
-
+		err = btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_read(data, MTK_BT_WDT_STATUS, &val);
+		if (err < 0)
+			return err;
 		/* Reset the bluetooth chip via USB interface. */
-		btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 1);
-		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
-		btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
-		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000000FF);
-		btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
+		err = btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 1);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000000FF);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
+		if (err < 0)
+			return err;
 		/* MT7921 need to delay 20ms between toggle reset bit */
 		msleep(20);
-		btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 0);
-		btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
+		err = btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 0);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
+		if (err < 0)
+			return err;
 	}
 
 	err = readx_poll_timeout(btusb_mtk_reset_done, hdev, val,
@@ -3085,11 +3136,14 @@ static int btusb_mtk_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 	if (err < 0)
 		bt_dev_err(hdev, "Reset timeout");
 
-	if (dev_id == 0x7922)
-		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
+	if (dev_id == 0x7922) {
+		err = btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
+		if (err < 0)
+			return err;
+	}
 
-	btusb_mtk_id_get(data, 0x70010200, &val);
-	if (!val)
+	err = btusb_mtk_id_get(data, 0x70010200, &val);
+	if (err < 0 || !val)
 		bt_dev_err(hdev, "Can't get device id, subsys reset fail.");
 
 	return err;
-- 
2.18.0

