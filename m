Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0736354B1BA;
	Wed,  9 Sep 2026 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955240; cv=none; b=G70OL1dElnzc6hm4BFE32dfNyBZDF6KsaAsCNZVa6lmtmbxwiokjZ4jbEBsFvUmIzH/gjUaop3creUoPJZkC3R//Zc9lDBK97MCqcyeU4pMuGgY2rDBPBxvxhiP9xpvTAWBDU2U/zoemz9SSw8HKVLaW3p1pl5zhnwDieh9WE9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955240; c=relaxed/simple;
	bh=EoetN9/NImTDhaoE0wS8sS+HTR5LBrab8isYMPt9PPI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWveWMmiGuah2Azw8+rfd/vWoEiI1wRlHnBOvFC4ZfAgkYs7JR0AdWzlVQoU/KS/V8XYBWOirwtFxLtc4El8FouMxVFDTndh2+1UetZgerGDgB9b1rbj/wXB2QplUT9X4s3h3Yz7JxHN2ngSICYHVPzGmSbKvCfIqXe++nqca1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XLnIsUNr; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XLnIsUNr"
X-UUID: 0b561940ac4611f1b1788b6acf885367-20260909
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ddDa8Pcac/66Av7vO+vyv+NZ+Btz97Nekx/77mfvno0=;
	b=XLnIsUNrYb7pI49IJxpUdEBLCD96jjXaLUI8SCJUY4uJnggYmqv8G4FJ00tqBIfYVleeTiEVgIxvrCv3Gq2WRzCR8XpuQ3dttLvIQbOyYhBIIWdUsP/dz+s92Jps8gi8TqhSeOZ2dToUakwle4FDBcYRfIHhc/3cHWVQ7iyF8no=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:6739e390-e04c-4e82-98d5-10c1ff79e2c7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:76cb1728-9ebf-4787-bb42-3cd26eee85aa,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0b561940ac4611f1b1788b6acf885367-20260909
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1323661430; Wed, 09 Sep 2026 20:00:26 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 9 Sep 2026 20:00:25 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 9 Sep 2026 20:00:25 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>, Paul
 Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 3/3] Bluetooth: btmtk: Replace magic numbers with WMT packet flag enum
Date: Wed, 9 Sep 2026 20:00:11 +0800
Message-ID: <20260909120011.1198001-4-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260909120011.1198001-1-chris.lu@mediatek.com>
References: <20260909120011.1198001-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The flag field of a BTMTK_WMT_PATCH_DWNLD packet tells the device where
the packet sits in the download sequence, but both download loops write
the bare values 1, 2 and 3, so the reader has to infer the meaning from
the surrounding conditionals.

Add enum btmtk_wmt_pkt_flag and use it in btmtk_setup_firmware_79xx()
and btmtk_setup_firmware(). No functional change.

The other bare flag values in this driver belong to different WMT
opcodes (BTMTK_WMT_FUNC_CTRL, BTMTK_WMT_RST, BTMTK_WMT_SEMAPHORE and so
on), where the field means something else entirely, so they are left
alone.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Assisted-by: Claude:claude-opus-5
---
 drivers/bluetooth/btmtk.c | 12 ++++++------
 drivers/bluetooth/btmtk.h |  9 +++++++++
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index cf4f40349afa..660ed5b02841 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -300,12 +300,12 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 			while (dl_size > 0) {
 				dlen = min_t(int, 250, dl_size);
 				if (first_block == 1) {
-					flag = 1;
+					flag = BTMTK_WMT_PKT_START;
 					first_block = 0;
 				} else if (dl_size - dlen <= 0) {
-					flag = 3;
+					flag = BTMTK_WMT_PKT_END;
 				} else {
-					flag = 2;
+					flag = BTMTK_WMT_PKT_CONTINUE;
 				}
 
 				wmt_params.flag = flag;
@@ -384,7 +384,7 @@ int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
 
 	fw_size -= 30;
 	fw_ptr += 30;
-	flag = 1;
+	flag = BTMTK_WMT_PKT_START;
 
 	wmt_params.op = BTMTK_WMT_PATCH_DWNLD;
 	wmt_params.status = NULL;
@@ -394,9 +394,9 @@ int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
 
 		/* Tell device the position in sequence */
 		if (fw_size - dlen <= 0)
-			flag = 3;
+			flag = BTMTK_WMT_PKT_END;
 		else if (fw_size < fw->size - 30)
-			flag = 2;
+			flag = BTMTK_WMT_PKT_CONTINUE;
 
 		wmt_params.flag = flag;
 		wmt_params.dlen = dlen;
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index bc26148ec544..e8ad281a93a0 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -67,6 +67,15 @@ enum {
 	BTMTK_WMT_ON_PROGRESS,
 };
 
+/* Position of a BTMTK_WMT_PATCH_DWNLD packet within a download sequence,
+ * carried in struct btmtk_wmt_hdr's flag field.
+ */
+enum btmtk_wmt_pkt_flag {
+	BTMTK_WMT_PKT_START = 1,
+	BTMTK_WMT_PKT_CONTINUE = 2,
+	BTMTK_WMT_PKT_END = 3,
+};
+
 struct btmtk_wmt_hdr {
 	u8	dir;
 	u8	op;
-- 
2.45.2

