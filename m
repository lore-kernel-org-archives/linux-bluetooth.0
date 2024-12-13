Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6680918FDDF;
	Fri, 13 Dec 2024 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082893; cv=none; b=DlC9ewsnG3SPhE2mgSrnI5yCRKv7iYa1jYHzev3VAfrTjS5jpwihzjY490zz5DVLc5lftRW6hehrBwBUZp5jGFjJpuDqpnefQpbNCAbCZLpdxahyiMwRKFB3dz1wrvZpvCPgiEUUyCnmc5Su8gM7GA1OmXkxvvbS76zxQxfoPew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082893; c=relaxed/simple;
	bh=xOXiS2wRIDztLaIqs5qYSwXYJdPN5DTOH3N7PYSnCUc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J+etidfA12OFtdRt5oVCghp7kyvRPPf7QpTYxkJiI5h72KgKSt8jmVHsaPNSCeS+CP5b1IwhNPtSRZj/HzQpyfBBLUjeF4nQ0+Puj1Wj74rAuRY3TcIWBtPvJk0AhCA/vkgVZ1O/tMNjd5cAyGYbG6iUfhMyF/ofckUGu6v1obc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ProEbuOs; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ProEbuOs"
X-UUID: 6bfe8a20b93611ef99858b75a2457dd9-20241213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=LrfMJ3h3u1jnLMa7N2XZu8l1yWiNNUJSdAbw5NA1lr0=;
	b=ProEbuOsj8K154YQtZb9p2clWWXNhER+iRpQX4XuPB8Ak8X+Ec7lJ/dkhcLt5D/slJ7O1H+UP1hEfxV0uvGWaQFrFS2VD6lzknVWlM9vuWPMSi7gkQKPvJZ0BFxj3UEKXgz07KLSi1/D7vJu3n2al+7IANptlUDHWBwt+HmKDs4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:6840c50e-ba88-4aa5-a160-83e296f94a2b,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:b2581513-8f5d-4ac6-9276-7b9691c7b8d6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:1,IP:nil,UR
	L:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 6bfe8a20b93611ef99858b75a2457dd9-20241213
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 276874414; Fri, 13 Dec 2024 17:41:26 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 13 Dec 2024 17:41:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 13 Dec 2024 17:41:22 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Hao Qin <hao.qin@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>, "Steve
 Lee" <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH] Bluetooth: btmtk: add quirk to support HCI_QUIRK_SIMULTANEOUS_DISCOVERY
Date: Fri, 13 Dec 2024 17:41:18 +0800
Message-ID: <20241213094118.23647-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.642100-8.000000
X-TMASE-MatchedRID: tiRXYRqWr+tocr5vRHCIaibMb0f5D0uqTJDl9FKHbrmtwWMX5hmdv6PF
	jJEFr+olKE0Je8DR/D4NXwNUB3oA790H8LFZNFG7MGpgBNI6BaPvMA9WW7X2a/mHADpWjR4Nxll
	YNXARfpWxz8p0BoLSI+B+R4NVzQv5shljvamtnvY1mT6tqJoFqKL8uYddyDmU+IfoVuvrGMeAhO
	caQrQ0U1GyRcoeF18qmKP0zzpTAeGwod8xOMKmvMCBO+zxAW5pftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.642100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	CEC39923689531D895F816C4BA509C57F9BD1D15EBDF4B59EB11286153AEA5682000:8

Add quirk to support HCI_QUIRK_SIMULTANEOUS_DISCOVERY feature for MT79xx
series chipset.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
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

