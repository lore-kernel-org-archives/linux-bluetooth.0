Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9DF2EA732;
	Tue, 25 Aug 2026 03:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787629005; cv=none; b=AdCuiM+CKGOv/bIDIzXRJ1O9d48U3Vl7FXsT2xZFjFav+EO3k4a2fUoTXyyJr7cOoxJ/vM931pYvdOxn+034EbLOZWWNn953X59VLbZ8hteq+s0tVxo/HbM0cEptZWjvPOTHYb+usi3XFOC0k7aPqu31yLAONVdoATrpyuR17lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787629005; c=relaxed/simple;
	bh=VRW8EpEoQznUB5amel8wUXCuBuaVhFdTaer982hKk2U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2VCU0bDvmKOXoGqqOe/i+ZypdGDbZWZtEcS1S13bCZ5r4/JEbDkqSqPaIoXoPudBBii6IcAMVtNmJHHbq30OfgQuBoWR1sjjUU9/BIZk8G0f5n/zOPOyoeqNCTiL6pH+5Ky+WPaHmWNCZRj5w4bqMAqqz/pAvsX94zzntBMvbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bNDXBo2I; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bNDXBo2I"
X-UUID: 2d61bdc6a03611f1b1788b6acf885367-20260825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+8iN+sJuf9qZpCW4bDkdt8mpJpBz2Tzn+okDLJqUG/k=;
	b=bNDXBo2IuO82VCk6OHPYNl89XgjQRMAcL88lNWgdXOoCWanTlfvsksLYP/osfEKESv8kKMnLGxc33i575OrdaYpjF0KdTDXO+c7aBAwbmrqTwXSqSvnGxcf5guP0bnDdqiYYQOkgDRNrm5jpnydjBCq1HpVybScScnfetqehQmE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:5aa510c1-e3bd-484b-bc3c-b40ac3e1289e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:5631ddbf-c80f-4882-940d-2cf94d6b76c2,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2d61bdc6a03611f1b1788b6acf885367-20260825
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 763252493; Tue, 25 Aug 2026 11:36:37 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Aug 2026 11:36:36 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 25 Aug 2026 11:36:36 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH 1/2] Bluetooth: btmtksdio: Remove redundant firmware filename override
Date: Tue, 25 Aug 2026 11:36:33 +0800
Message-ID: <20260825033634.499118-2-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260825033634.499118-1-chris.lu@mediatek.com>
References: <20260825033634.499118-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

btmtksdio_setup() derives the firmware filename with
btmtk_fw_get_filename() and then overwrites it with an snprintf() that
open-codes that helper's fallback format. Commit 7f935b21bee4 ("Bluetooth:
btmtk: apply the common btmtk_fw_get_filename") added the helper call
without removing the snprintf() it was meant to replace.

None of the device ids the helper special-cases can appear here: 0x6639,
0x7925 and the flavored 0x7961 belong to parts with no SDIO interface, and
btmtksdio_setup() passes a flavor of 0 accordingly. The helper always falls
through to the snprintf()'s own format, so both produce the same string and
removing it is a no-op.

Remove it anyway, since it silently defeats the helper for any device id
the helper special-cases.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Assisted-by: Claude:claude-opus-5
---
 drivers/bluetooth/btmtksdio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index b7f0be7fc42a..a5709cecd4b5 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1162,9 +1162,6 @@ static int btmtksdio_setup(struct hci_dev *hdev)
 		btmtk_fw_get_filename(fwname, sizeof(fwname), dev_id,
 				      fw_version, 0);
 
-		snprintf(fwname, sizeof(fwname),
-			 "mediatek/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
-			 dev_id & 0xffff, (fw_version & 0xff) + 1);
 		err = mt79xx_setup(hdev, fwname);
 		if (err < 0)
 			return err;
-- 
2.45.2

