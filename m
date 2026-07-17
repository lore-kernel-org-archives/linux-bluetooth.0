Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5753E44E8;
	Fri, 17 Jul 2026 08:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784278497; cv=none; b=uomPCnD4MIsTAMvsVYHEwthPEnTjNHcxj05oRNeW0MCQyHR/YT5UIFomoYU2n/3QewMgDU+em8em9qzBmIpmDbMa82yguO2+/Qu8vdyH6pcy0eIDQEW8iDo4rrPOawuT9jlnda621AeBWIk483islPu4mAqXsBaaaT88zdMs3Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784278497; c=relaxed/simple;
	bh=pR8p7SA2PrGwmlsJ5hWOx6OcqaRJK45+2+NjxO464w4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8G5mTuvVbxJ0c00VewWMJMnD9JaNp0mTzVgpu7tfgfXxMmLQJSSBvXO/3GIc5hSyITiV0GfkdGmP8KRGWqDh0CNkmDkkvL/mmyLa3zcMJnGG/SmgYiaOqOs+KQAsyG9aOPPGu/icQDGkMBHml3SZJ2AHGYS2usw85Z3NXFNtx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=I7+ZG5fU; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="I7+ZG5fU"
X-UUID: 0c9bd2a081bb11f18dc8c9802ae25ab1-20260717
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JHebVX3uufPtej3tISmY4aw/qYZynF2oybqtvVa6CAc=;
	b=I7+ZG5fUMC03xx0RDGTz1lj0URf8NnISdLcP3vG/1VHGKGRmN49PXT65MPAP+XIHwSMjVp1MALG/2+bmy63r+d8z2CFpVEA7OkD5F8rvr6Xc67jrZeIb+U0OweP0T0E/at0chaZWRN7vlwckIEMNBE/Kr1RCkTI5c1NzMw69q+A=;
X-CID-CACHE: Type:Local,Time:202607171542+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18,REQID:03ea4707-04ed-4e79-9c44-12a17a89e0f4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:8a735a6,CLOUDID:753d965f-762a-4584-baab-4eebe609beea,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99|200|213,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0c9bd2a081bb11f18dc8c9802ae25ab1-20260717
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1817113123; Fri, 17 Jul 2026 16:39:39 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 17 Jul 2026 16:39:38 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 17 Jul 2026 16:39:38 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v16 5/7] Bluetooth: btmtk: Improve BT firmware logging
Date: Fri, 17 Jul 2026 16:39:34 +0800
Message-ID: <20260717083936.2923891-6-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260717083936.2923891-1-chris.lu@mediatek.com>
References: <20260717083936.2923891-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Improve firmware loading log messages to provide more useful information:

- Add firmware filename before loading to help identify which file
  is being loaded
- Display chip ID (dev_id) as HW version instead of firmware's hwver
  field, which provides more meaningful hardware identification
- Use %.16s format specifier for hdr->datetime field to prevent
  potential buffer over-read, as the field is a 16-byte array that
  may not be null-terminated

log output with MT7922
[  212.878783] Bluetooth: hci1: Loading BT firmware: mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin
[  212.889614] Bluetooth: hci1: BT HW ver: 0x7922, SW ver: 0x008a, Build Time: 20260224103448
[  216.048877] Bluetooth: hci1: Device setup in 3096530 usecs
[  216.048890] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
[  216.114179] Bluetooth: hci1: AOSP extensions version v1.00
[  216.114220] Bluetooth: hci1: AOSP quality report is supported
[  216.116782] Bluetooth: MGMT ver 1.23

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Assisted-by: Claude:Sonnet-4.5
---
 drivers/bluetooth/btmtk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 3491060b3ae9..0fd6ce09a313 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -154,6 +154,8 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 		return err;
 	}
 
+	bt_dev_info(hdev, "Loading BT firmware: %s", fwname);
+
 	/* Validate minimum firmware size for header and global descriptor */
 	if (fw->size < MTK_FW_ROM_PATCH_HEADER_SIZE + MTK_FW_ROM_PATCH_GD_SIZE) {
 		bt_dev_err(hdev, "Firmware file too small: size=%zu, expected at least %u bytes",
@@ -188,8 +190,8 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 		goto err_release_fw;
 	}
 
-	bt_dev_info(hdev, "HW/SW Version: 0x%04x%04x, Build Time: %s",
-		    le16_to_cpu(hdr->hwver), le16_to_cpu(hdr->swver), hdr->datetime);
+	bt_dev_info(hdev, "BT HW ver: 0x%04x, SW ver: 0x%04x, Build Time: %.16s",
+		    dev_id & 0xffff, le16_to_cpu(hdr->swver), hdr->datetime);
 
 	for (i = 0; i < section_num; i++) {
 		first_block = 1;
-- 
2.45.2

