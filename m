Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738EA7CF1F;
	Tue,  2 Jul 2024 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719919866; cv=none; b=pBUEn5XXa1c/4//AYCNoujMnLeRvIcrKy+vSozdS72M/xBlQZL9K6av0mChPS9ZTglVEB5t5QSh/422wphDOhmUPLx++/ltlxlYCFMfDs/opUKMyaiKcKdrGIWx/aFkVNOCSlZPDHnyy6yC4I+SZGZOAe+0+O9LPc9P5TkMjjSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719919866; c=relaxed/simple;
	bh=TEd52duGVATpUwEpzoWdNe9mvSqhdqSIGBuITxjXiOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NqvwrY0za9s6bSv+UQu+qYDyoSp6c3NqM/nz/oUUwI8X0yt2T3DbLtM//gsnQtW+lLySOdKmeUx5eQ/yynJy3580NnnxjoCr6Otd1F3YsUuAHM+JzhwG+Timru/y2HAbnWCivN0Ev8l/01pZgetGOs5fNKIWcpuAQB9lCsbKhik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Lurz1Wbr; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Lurz1Wbr"
X-UUID: 8bd387ac386611ef99dc3f8fac2c3230-20240702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=IRsg1rpjZkP9O+7FX5ib2fnl+eWYWcxVRXO42mkwG/0=;
	b=Lurz1WbrVBw70yQMpyvz2gkAuf0ID1SuzStcKSbqUZQt+gqxrGmceUaWjOxf81Um1HtlSDWs7GtHyd+/5LANvIRYoyOtsGJXB4GNwNZ500fcd+4h/Xzz/kMXaGd6pljyfmc1x4dgNMckWGe+k1AhSLHHK2+i77ZNv4jA2WYf0s8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:7cb363f6-d8a2-4a6b-a46e-1aeb12a7f307,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:9abadcd4-0d68-4615-a20f-01d7bd41f0bb,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 8bd387ac386611ef99dc3f8fac2c3230-20240702
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 108594998; Tue, 02 Jul 2024 19:30:55 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 2 Jul 2024 19:30:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 2 Jul 2024 19:30:54 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v6 2/8] Bluetooth: btusb: mediatek: return error for failed reg access
Date: Tue, 2 Jul 2024 19:30:45 +0800
Message-ID: <20240702113051.24372-3-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240702113051.24372-1-chris.lu@mediatek.com>
References: <20240702113051.24372-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

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

