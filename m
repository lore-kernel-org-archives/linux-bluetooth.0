Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AA93911C6;
	Thu,  2 Jul 2026 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782977332; cv=none; b=UfDh9OtR3JG2Uz2xW4mej6/XjO+pZfdOhD0RyZf80t+91BPNJFkYxGc1DGL6U6Xbqmj9AJP6d5xtK6gVXv+SlFgcJMaLUqZtdF0ZCo1XJNvQQbc0SgJWEk4t8wR26d8QvciTsX4uev+ZHizhlhr450LyS+NjtAoIG2cWMYJx4KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782977332; c=relaxed/simple;
	bh=x5JfdoIyajkz5eMbaYQ4e1Kaq5/u2IYIV1g4cYcxRGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2W98xmzmpb7S+UHYrJLyl9Ms7HCVWowHG4I0Sn2+OqiVCVuR4p2GCItT8dF+RaWo0hXVOJaOx3sppA6HlovI+nHMeTJodfdHqXYetvH6VsIsEGcol5w3EaUIpY+JH91bOpHJvyUeGx2iRBpcw81TChDmePDsvVmS2VEaIRurk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=l8yGpp3j; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="l8yGpp3j"
X-UUID: a7989c6475e711f18dc8c9802ae25ab1-20260702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bkFUJifpybKz0LfV4Z4vncqravLYtZw0TyRRPfXkG9E=;
	b=l8yGpp3jWWYXtDuuzgk13pIU92i8xlcSb+nkgk1i1HbZ7Ndoeck4IO+9ksYbSs9ASVOwZSSxKnYRaw7uVMPs8uvcNr+McZkaBn2Luzi3kLtL8RUIaeeB/WYtPtP2gFT7USCx8cZGc5H6lz9vUhBRhjqxC881TEVArl7ob2yMZ70=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:32798e93-9551-4897-993c-fbb9a2c3efb9,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:d497b38,CLOUDID:959db4c4-4062-4a8f-9776-acbccc936972,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99|200|213,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a7989c6475e711f18dc8c9802ae25ab1-20260702
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 301800448; Thu, 02 Jul 2026 15:28:43 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 2 Jul 2026 15:28:42 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 2 Jul 2026 15:28:42 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
	Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v8 2/5] Bluetooth: btmtksdio: Pass hardware dev_id to mt79xx_setup()
Date: Thu, 2 Jul 2026 15:28:37 +0800
Message-ID: <20260702072840.1712057-3-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260702072840.1712057-1-chris.lu@mediatek.com>
References: <20260702072840.1712057-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Pass the device ID read from hardware register (0x70010200) to
mt79xx_setup() instead of hardcoded 0, ensuring SDIO devices display
the correct chip ID in firmware logs.

This matches the USB driver behavior which reads from the same hardware
register. The hardware register is the authoritative source for chip
identification, superior to using the static chipid from device table.

Fixes: 28b7c5a6db74 ("Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support")
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Assisted-by: Claude:Sonnet-4.5
---
 drivers/bluetooth/btmtksdio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 5b0fab7b89b5..c90b3fa8ba5a 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -876,14 +876,14 @@ static int mt76xx_setup(struct hci_dev *hdev, const char *fwname)
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
@@ -1142,7 +1142,7 @@ static int btmtksdio_setup(struct hci_dev *hdev)
 		snprintf(fwname, sizeof(fwname),
 			 "mediatek/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
 			 dev_id & 0xffff, (fw_version & 0xff) + 1);
-		err = mt79xx_setup(hdev, fwname);
+		err = mt79xx_setup(hdev, fwname, dev_id);
 		if (err < 0)
 			return err;
 
-- 
2.45.2

