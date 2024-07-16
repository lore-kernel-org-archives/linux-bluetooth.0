Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEE71CD32;
	Tue, 16 Jul 2024 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721116204; cv=none; b=IM7GovAqd9Ey1j+WpzpFLTiCwRiCm/KcOn8a2U1YHPocF37cBwxX2pURz8cFI2e9GDH0njy7n4Ln/oykamdIknGnEseEt99OI62p+LwVcXOySV2dARcPz3aJmIRZnMED+EYKd9Kh+Xq85S4V6XH+mNm9YRh1bVR4YCbT8NdQgqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721116204; c=relaxed/simple;
	bh=jz/DmT+uq15DdBd/YGRWs9zGl/TZdMb9r9s/NlgxgU8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h31zjZBN0otbSF99o0IZYDvdh98rBywmGfLGHafBHVWFA8+9b/vkzCpJiNN44f01nSmUuCHypkphNdupPV7WwcLaONVHlTAWBz/b3gT8cR0wJswJ8ls76YoQJvToDsaye9bvufBJQGDzAOe7B9RzEHNP64tjIFlUxneweDLu8k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rNOrfHJ1; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rNOrfHJ1"
X-UUID: f96c439e434711ef87684b57767b52b1-20240716
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=5d3PYqUvAD9RWL4rfXNfg3ItuJTaoeexBHixM7y+rvA=;
	b=rNOrfHJ1tx1DiZgE7UvERafz7z3e7Kaew+NirjFJhjcSfnI5vM/32pvJKcEphyp1c0hfndoIZZJ1SlxOH8wrUJixNasXgPsy2JbGhbBrShM5buzVFAfVKaHDXbzVIDCFwFWW9Y1fliL6oEutFPc2uneV8a027gy+eeSYiJoSNFk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:f68bafed-b981-4e5b-a9b2-235650543c56,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:8f34830d-46b0-425a-97d3-4623fe284021,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: f96c439e434711ef87684b57767b52b1-20240716
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 763591218; Tue, 16 Jul 2024 15:49:47 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 16 Jul 2024 15:49:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 16 Jul 2024 15:49:49 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v1] Bluetooth: btmtk: Fix kernel crash when entering btmtk_usb_suspend
Date: Tue, 16 Jul 2024 15:49:47 +0800
Message-ID: <20240716074947.23073-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

If MediaTek's Bluetooth setup is unsuccessful, a NULL pointer issue
occur when the system is suspended and the anchored kill function
is called. To avoid this, add protection to prevent executing the
anchored kill function if the setup is unsuccessful.

[    6.922106] Hardware name: Acer Tomato (rev2) board (DT)
[    6.922114] Workqueue: pm pm_runtime_work
[    6.922132] pstate: 804000c9
(Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    6.922147] pc : usb_kill_anchored_urbs+0x6c/0x1e0
[    6.922164] lr : usb_kill_anchored_urbs+0x48/0x1e0
[    6.922181] sp : ffff800080903b60
[    6.922187] x29: ffff800080903b60
x28: ffff2c7b85c32b80 x27: ffff2c7bbb370930
[    6.922211] x26: 00000000000f4240
x25: 00000000ffffffff x24: ffffd49ece2dcb48
[    6.922255] x20: ffffffffffffffd8
x19: 0000000000000000 x18: 0000000000000006
[    6.922276] x17: 6531656337386238
x16: 3632373862333863 x15: ffff800080903480
[    6.922297] x14: 0000000000000000
x13: 303278302f303178 x12: ffffd49ecf090e30
[    6.922318] x11: 0000000000000001
x10: 0000000000000001 x9 : ffffd49ecd2c5bb4
[    6.922339] x8 : c0000000ffffdfff
x7 : ffffd49ecefe0db8 x6 : 00000000000affa8
[    6.922360] x5 : ffff2c7bbb35dd48
x4 : 0000000000000000 x3 : 0000000000000000
[    6.922379] x2 : 0000000000000000
x1 : 0000000000000003 x0 : ffffffffffffffd8
[    6.922400] Call trace:
[    6.922405]  usb_kill_anchored_urbs+0x6c/0x1e0
[    6.922422]  btmtk_usb_suspend+0x20/0x38
[btmtk 5f200a97badbdfda4266773fee49acfc8e0224d5]
[    6.922444]  btusb_suspend+0xd0/0x210
[btusb 0bfbf19a87ff406c83b87268b87ce1e80e9a829b]
[    6.922469]  usb_suspend_both+0x90/0x288
[    6.922487]  usb_runtime_suspend+0x3c/0xa8
[    6.922507]  __rpm_callback+0x50/0x1f0
[    6.922523]  rpm_callback+0x70/0x88
[    6.922538]  rpm_suspend+0xe4/0x5a0
[    6.922553]  pm_runtime_work+0xd4/0xe0
[    6.922569]  process_one_work+0x18c/0x440
[    6.922588]  worker_thread+0x314/0x428
[    6.922606]  kthread+0x128/0x138
[    6.922621]  ret_from_fork+0x10/0x20
[    6.922644] Code: f100a274 54000520 d503201f d100a260 (b8370000)
[    6.922654] ---[ end trace 0000000000000000 ]---

Fixes: ceac1cb0259d ("Bluetooth: btusb: mediatek: add ISO data transmission functions")
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index b7c348687a77..191bc6925120 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1262,7 +1262,8 @@ int btmtk_usb_suspend(struct hci_dev *hdev)
 	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
 
 	/* Stop urb anchor for iso data transmission */
-	usb_kill_anchored_urbs(&btmtk_data->isopkt_anchor);
+	if (test_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags))
+		usb_kill_anchored_urbs(&btmtk_data->isopkt_anchor);
 
 	return 0;
 }
-- 
2.18.0

