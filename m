Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229E854A7F9;
	Wed,  9 Sep 2026 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955241; cv=none; b=jRqJqoqmv/e0eeMC2e8Z520W0CuO2CFzOWSLbD/M3auXxu9YwIsysFFdgkJ9ne+jEsV2XpBWw2P5ZLnwOmAwYHXLBTsPK2oPts9WORGMMLYcbsd2UFkhvFnEE82QUUYKyw4Nb5pSmnsQrY/kmaVBxYCo9BMm1y1+XzeStE2a6mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955241; c=relaxed/simple;
	bh=dOtz2AKr00E8qGkrclr0wL4flwXXvW79+vfQ2umpkEw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UkOJ4LZQd28a5qIYVvUsLh82eX/qgz+yWNKEODt75ew0tcJuVlezGIy0vUVx9M6pCEHvn7i8M2ZSHZEIVwSvbImc4dhRKxy1n8vqcQeTh5dSMM7G1CxveFVPeVIypP22qVCyWArQ5qc30Xlg1VHcGs6IovmCmZU65kCrs4I/zzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Pw5if9Jh; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Pw5if9Jh"
X-UUID: 0b3e896aac4611f18dc8c9802ae25ab1-20260909
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=m3sWiPK0zH7UV16WLArJdnwaVECFlFqbwrSICItQElM=;
	b=Pw5if9JhboXfr5Hb7Jt2TwJ9v7RjDW+rw75TE+ZvA4CXgigMt0fCx4kWjtiGOPe00j7v5dKeLdJ7yKtv20ktz7/LnxKhv7/jiwJ8IInJwI1gbE6pAWTVFX9CKTws4wQYvRLuHPJ2YOV7/xoCD1YwKc105fJO3ygBVzPS50H/uqE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:deb899c3-a604-4ece-8723-3c1fc09eddad,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:3a729de2-72a5-4ba1-af40-18bbd6ea8ffd,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0b3e896aac4611f18dc8c9802ae25ab1-20260909
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1822170989; Wed, 09 Sep 2026 20:00:26 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
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
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH 2/3] Bluetooth: btmtk: Improve BT firmware logging
Date: Wed, 9 Sep 2026 20:00:10 +0800
Message-ID: <20260909120011.1198001-3-chris.lu@mediatek.com>
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

The firmware log line in btmtk_setup_firmware_79xx() never says which
file was requested, which matters because btmtk_fw_get_filename() derives
the name from the device id and firmware version at runtime. It reports
the firmware's own hwver field as the HW version, when the device id the
driver read from the chip is the more useful value and is already
available as dev_id. And it prints datetime, a u8[16] with no guaranteed
NUL terminator, with %s.

Log the filename before the image is parsed, so a file that fails
validation still says which file it was, report dev_id as the HW version,
and bound datetime with %.16s.

The datetime change is hardening rather than a fix, hence no Fixes: tag:
every file in linux-firmware terminates the field, and provoking the
over-read needs a malformed file in /lib/firmware.

Log output on MT7922 after the change:

  [  365.245951] Bluetooth: hci0: Loading BT firmware: mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin
  [  365.245956] Bluetooth: hci0: BT HW ver: 0x7922, SW ver: 0x008a, Build Time: 20260605203811

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Assisted-by: Claude:claude-opus-5
---
 drivers/bluetooth/btmtk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 07a7a7a3656a..cf4f40349afa 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -214,6 +214,8 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 		return err;
 	}
 
+	bt_dev_info(hdev, "Loading BT firmware: %s", fwname);
+
 	err = btmtk_fw_validate_layout(hdev, fw, &section_num);
 	if (err < 0)
 		goto err_release_fw;
@@ -222,8 +224,8 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 	fw_bin_ptr = fw_ptr;
 	hdr = (struct btmtk_patch_header *)fw_ptr;
 
-	bt_dev_info(hdev, "HW/SW Version: 0x%04x%04x, Build Time: %s",
-		    le16_to_cpu(hdr->hwver), le16_to_cpu(hdr->swver), hdr->datetime);
+	bt_dev_info(hdev, "BT HW ver: 0x%04x, SW ver: 0x%04x, Build Time: %.16s",
+		    dev_id & 0xffff, le16_to_cpu(hdr->swver), hdr->datetime);
 
 	for (i = 0; i < section_num; i++) {
 		first_block = 1;
-- 
2.45.2

