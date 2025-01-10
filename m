Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35BB18A95A;
	Fri, 10 Jan 2025 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502966; cv=none; b=ONnfC0y59uarviySZoGZJMFO9xQYgmidyoKmRtBOlPAahl3KOOCBV/9101m3V7SkEF0wt96kwxJOj1w1zwARSyqNCxov9OqP4yGaky3rWgfUo7DkjBr5ilSyvW2j3l1f7yMFTS0GWJSB9AQGaSiLDH3M0OYMFDE9KwOBXszwBi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502966; c=relaxed/simple;
	bh=RPorsnRcA0PWwqMHdkUM/vGaVlZ5ye/iaQwsGcjXeJ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i0w8Vze5UP8ZAsH0IizsI1UtVF0FdIfNBj3oOTeuT1pleXNUDLaDeqxnQi8b2fSDUJY8MlzVrnWt/f4+8cxlnJs7wVsV7tNdLnlTGCFcL56od/C+QxDVV3gK1/OSvwi8s+NgUswQ8Imn4Z5D/AAeW4A78PynRKdzMAKmefkKdpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JGFMbeWW; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JGFMbeWW"
X-UUID: 152159c6cf3911efbd192953cf12861f-20250110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=rJHn1hIuDy3wpzxn0d+QeBZ3v7dLeGqCXQL2jcmbX3E=;
	b=JGFMbeWWXEmYnUCh3grrjlt3IZdNAh+ft1A7ctyvYXZuwhPkPoNTgxSJXtA2gkjWkJzpa4EtzGeS1tcas6cBp0r7RYtthnRgM2xYCo7YkPZCGQQfCWt7+VOXvPbnxEBxpcJDFhbu3RUhFSGaP/T/uhezb/tYFkmfbD8u1Vu1oUE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:cf7242a5-bade-44fc-b7df-3df7907c4d17,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:60aa074,CLOUDID:0eec4c13-8831-4185-8e40-f83b1917e828,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 152159c6cf3911efbd192953cf12861f-20250110
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <hao.qin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1567910610; Fri, 10 Jan 2025 17:55:54 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 10 Jan 2025 17:55:53 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 10 Jan 2025 17:55:52 +0800
From: Hao Qin <hao.qin@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>, Chris Lu <chris.lu@mediatek.com>, Steve
 Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Hao Qin <hao.qin@mediatek.com>
Subject: [PATCH] Bluetooth: btmtk: Remove resetting mt7921 before downloading the fw
Date: Fri, 10 Jan 2025 17:55:48 +0800
Message-ID: <20250110095548.12761-1-hao.qin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Remove resetting mt7921 before downloading the fw, as it may cause
command timeout when performing the reset.

Signed-off-by: Hao Qin <hao.qin@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 224eafc27dbe..68846c5bd4f7 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1329,7 +1329,6 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 		fwname = FIRMWARE_MT7668;
 		break;
 	case 0x7922:
-	case 0x7961:
 	case 0x7925:
 		/* Reset the device to ensure it's in the initial state before
 		 * downloading the firmware to ensure.
@@ -1337,7 +1336,8 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 
 		if (!test_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags))
 			btmtk_usb_subsys_reset(hdev, dev_id);
-
+		fallthrough;
+	case 0x7961:
 		btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev_id,
 				      fw_version, fw_flavor);
 
-- 
2.18.0

