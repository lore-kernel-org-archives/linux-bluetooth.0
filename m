Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B7117BB3F;
	Mon, 16 Dec 2024 03:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734319121; cv=none; b=NIEM78zgH4lLhrIH2J8daM373sst4J4PfyW8Sz34abYQDnFn9csvHUNadZ3pLQMPNrGjofTLkWkDuf/L8kZaPit24TJgnpz67eVic+g3v+1aDBmIbO1Qjrmm9pZIWijscMSPRLQXviGqcLSOaCIwcmOMtZNFWjIA6vqLGTGFfmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734319121; c=relaxed/simple;
	bh=ZuxJ7H73Bb/8mvjXtchJMvvIq5ZLi53jfAWmDnhRDvI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DCVSPDPCeHp53NsVBaQOBp98IzfDnrVi2m3w84pRNhhbQeCT7BvI/SswyYRPZtbQosrtucaKF0WHKTyQubFJlbPkDgcDkPou5krJ3qc74eOV7fvnkpztag5q6ybyCi/wMPsufj3k4eRJqkHNEQ2kbfeE9/P1VMUBG11EyG9qQPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WQZt7toF; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WQZt7toF"
X-UUID: 68b520c2bb5c11ef99858b75a2457dd9-20241216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=obhTzeAbHx2ZiSwSAJdHjfQ1nVeRgUQ/g8ZesBg5PeU=;
	b=WQZt7toFkP0my/zqHx6CcQQH4OuN4WPH9nsEFaZeY+ttTZFZPidkDTe6ItRiiegaCc14WXqv2ZZuTese7vmaj5mo5xEy/os/krAek0KJ4lcoeuj2vTbIzen1+n9c1u51G3nygCNAYswgB/hYbvAxcLv2TM1pdzds1KBvEl5QtwA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:ed74907a-7aac-422f-abf9-bf1870b4e0ad,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:1cba2e13-8f5d-4ac6-9276-7b9691c7b8d6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: 68b520c2bb5c11ef99858b75a2457dd9-20241216
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1423428965; Mon, 16 Dec 2024 11:18:23 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 16 Dec 2024 11:18:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 16 Dec 2024 11:18:20 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Hao Qin <hao.qin@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>, "Steve
 Lee" <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v2] Bluetooth: btmtk: add quirk to support HCI_QUIRK_SIMULTANEOUS_DISCOVERY
Date: Mon, 16 Dec 2024 11:18:18 +0800
Message-ID: <20241216031818.19284-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.032100-8.000000
X-TMASE-MatchedRID: 6pbNFWS8cDtocr5vRHCIao6MisxJraxH5kzxLgNhSimdCqKtxM6bhxdm
	/aPya3SyxiqnR+5LS89/hUfrylyBijcpdZ3fQiLdFEUknJ/kEl5jFT88f69nG/oLR4+zsDTt9xS
	3mVzWUuCMx6OO8+QGvgetIhGhsuhDF7o48gWgv8Miwmhn8iBkjERG86KnAodXqJKPM4GiabiefT
	+TsWHDqcKd7SaEpEvJ8R2g6KTVG2fplTbAbQzJMHmVKZusLp922v9OjYWA2uMMswg45VMfPadst
	5iAforfVlxr1FJij9s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.032100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 8DA7A549AD1C3288F4F0B332D70D5EC6568DC4617637280265C1A1B8B118BB952000:8

Add quirk to support HCI_QUIRK_SIMULTANEOUS_DISCOVERY for MediaTek chipset.
The feature is related to allow controller do both LE scan and BR/EDR at
the same time.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
v2: update commit message
---
 drivers/bluetooth/btmtk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 8a3f7c3fcfec..562d6ecf0b71 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1367,6 +1367,9 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 			return err;
 		}
 
+		/* Apply common HCI quirks for MediaTek chipset */
+		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+
 		hci_set_msft_opcode(hdev, 0xFD30);
 		hci_set_aosp_capable(hdev);
 
-- 
2.18.0

