Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C57D364DC;
	Thu, 22 Aug 2024 05:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724304206; cv=none; b=s8hrICTOU/GY3iKMaIPdVciutt85a49Nhg3lVH+hRXcNmAW2QFTqSAJ3Tehm37QKH9CJirngFcqJkNKsN+4CV1I+ET+aUJIZ2HaUKZ5l1ZHPABJw3sY72VhTEtLzTLYPkK0DmL3mbgzG6iXMiOqflvGltoi5+klfVVHZs1Rav/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724304206; c=relaxed/simple;
	bh=JvviZ/TvdZzyy0lB23E39wSs1MZdbpxISdkQn13dXe0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WyIFsBHqUbbtUUmrktlcy4eIZLsu4IhOm63vSp1bzPvSnyleTBpL4qiyvvvbHLfT2yWEDVF254KTvXGyMX6mNt5MUKusbCsZSR/EX1HzHRXvCtCA1scfXgYOtZ1Sds6hC3p10CHGKUeCWSj2YPnBQdZ6wDT5ljKiTOqMZZvoYn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EJr90hX4; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EJr90hX4"
X-UUID: a1d68574604611ef8593d301e5c8a9c0-20240822
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Zi1oFdwslpFsySYhI5Npfy3fFU8blZB+R3aDcpwYrDk=;
	b=EJr90hX42QkxH5dLceei7o5zekXmK+Pwhs2mRyBjUfQcBcwmw+KL9cbzmRLLGJ4O36eiUkKLgrejl+OfoRCKiURwE7/J+zc/N/nUEO51kpaLfk73jzFlOkhW+lZBOilPRGLXw/s5vP/eTkVKxP+c9NHAJ6JsvgYqpakZAA8sSKg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:4e655bc7-c2a6-4667-8ea7-e762cb4a6147,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:48e7fdce-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a1d68574604611ef8593d301e5c8a9c0-20240822
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <hao.qin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1287319304; Thu, 22 Aug 2024 13:23:15 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 22 Aug 2024 13:23:14 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 22 Aug 2024 13:23:13 +0800
From: Hao Qin <hao.qin@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Chris Lu <chris.lu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Deren Wu <deren.Wu@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>, "Steve
 Lee" <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Hao Qin <hao.qin@mediatek.com>
Subject: [PATCH] Bluetooth: btmtk: Remove resetting mt7921 before downloading the fw
Date: Thu, 22 Aug 2024 13:23:10 +0800
Message-ID: <20240822052310.25220-1-hao.qin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.498600-8.000000
X-TMASE-MatchedRID: hQ3LGvLpFaKGsPek1xLHVhuZoNKc6pl+Kx5ICGp/WtGIoW+1yT7Gw43q
	EYKsEnZO8DRYXhYkzdkwc9Bdak/KgMcUiDRLzlgWRlqShqb35p59LQinZ4QefPcjNeVeWlqY+gt
	Hj7OwNO34ZhR52Rc1ar8VznWR013yuuTZ49+OrM4KkaNHlVdn53Hot+sf2xIPIBp7MM+pUoZl7Z
	Lan9xbOfC4Kd09x+FJ9Wlxn6Xuslj+Nzym4pugNUma3zYT97IFAYfQIAUhBayZvmCbKVb49sZL6
	x5U/HridGByp+zdaDg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.498600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	CC8BD9FB5F7243A38A9609A53706687D8166E6C3555EE50B17BC3AC959645F4E2000:8

Remove resetting mt7921 before downloading the fw, as it may cause
command timeout when performing the reset.

Signed-off-by: Hao Qin <hao.qin@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 2b7c80043aa2..a46f70135cbd 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1326,7 +1326,6 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 		fwname = FIRMWARE_MT7668;
 		break;
 	case 0x7922:
-	case 0x7961:
 	case 0x7925:
 		/* Reset the device to ensure it's in the initial state before
 		 * downloading the firmware to ensure.
@@ -1334,7 +1333,8 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 
 		if (!test_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags))
 			btmtk_usb_subsys_reset(hdev, dev_id);
-
+		fallthrough;
+	case 0x7961:
 		btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev_id,
 				      fw_version, fw_flavor);
 
-- 
2.18.0

