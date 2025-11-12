Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C427514A60F;
	Wed, 12 Nov 2025 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762934026; cv=none; b=ABUtFcocDNvQNbOhSyhNGgSSFUHO0XoeujkvoMdrYOIu0/19fIlMVgtY7TqNGd1YSLO1O747CCJLt5R8TpwjoikmoAOeGwvhYnJakCj8TE1BDvsVor1bPXSN0sR7Hywddc2GrHw/qy/50NtlflyFC4TcnXCJNIkRhSjQwLKFhAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762934026; c=relaxed/simple;
	bh=vIJ7ZYlP4a69M5JNBubznZ3tH7ZxShqibc6WbGxAfPw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mRek0IAOurEzD9KiyLG4avX0IkcJMGp16+K1QZa+LAY64qdJHiVuWqFaNqPqxBgjD1Ff3pLDpxTh/PbXWFGTXchSo+tm9CX06unuhE31c3mblE3AJ4sS7VwaYS+dfrPH7otAweWi8/rFtKyaHMYNJEla+uyiTQ//LG5NPISbCMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rtgELYZy; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rtgELYZy"
X-UUID: b29b6832bf9c11f08ac0a938fc7cd336-20251112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=1G2iuVLIFfMskcE7UQQZSx1WXMQskLuTMIhO0Ja1jxc=;
	b=rtgELYZyIN3To4bGUZdsKYjHvWdSHUpkGTc5NSJnOQtwE/YFUp98YP4KyXF58zEXjdVZBZe+luTkySzi9qzv22+/ow3Jah6jquUZ07netUsf5S/EutRE8SDANRLnuVK8aPNHV6ufW0t6HZa7uG3ggsfs27FURXqAxEdiwvvnjIA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:15e8d64f-5e09-49c7-8d88-f68f0f592c7f,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:76a0ce57-17e4-43d2-bf73-55337eed999a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b29b6832bf9c11f08ac0a938fc7cd336-20251112
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 543103747; Wed, 12 Nov 2025 15:53:38 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 12 Nov 2025 15:53:36 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Wed, 12 Nov 2025 15:53:36 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Hao Qin <hao.qin@mediatek.com>, Will
 Lee <will-cy.Lee@mediatek.com>, SS Wu <ss.wu@mediatek.com>, Steve Lee
	<steve.lee@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v1] Bluetooth: btusb: mediatek: Fix kernel crash when releasing mtk iso interface
Date: Wed, 12 Nov 2025 15:53:34 +0800
Message-ID: <20251112075334.1162328-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

When performing reset tests and encountering abnormal card drop issues
that lead to a kernel crash, it is necessary to perform a null check
before releasing resources to avoid attempting to release a null pointer.

<4>[   29.158070] Hardware name: Google Quigon sku196612/196613 board (DT)
<4>[   29.158076] Workqueue: hci0 hci_cmd_sync_work [bluetooth]
<4>[   29.158154] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
<4>[   29.158162] pc : klist_remove+0x90/0x158
<4>[   29.158174] lr : klist_remove+0x88/0x158
<4>[   29.158180] sp : ffffffc0846b3c00
<4>[   29.158185] pmr_save: 000000e0
<4>[   29.158188] x29: ffffffc0846b3c30 x28: ffffff80cd31f880 x27: ffffff80c1bdc058
<4>[   29.158199] x26: dead000000000100 x25: ffffffdbdc624ea3 x24: ffffff80c1bdc4c0
<4>[   29.158209] x23: ffffffdbdc62a3e6 x22: ffffff80c6c07000 x21: ffffffdbdc829290
<4>[   29.158219] x20: 0000000000000000 x19: ffffff80cd3e0648 x18: 000000031ec97781
<4>[   29.158229] x17: ffffff80c1bdc4a8 x16: ffffffdc10576548 x15: ffffff80c1180428
<4>[   29.158238] x14: 0000000000000000 x13: 000000000000e380 x12: 0000000000000018
<4>[   29.158248] x11: ffffff80c2a7fd10 x10: 0000000000000000 x9 : 0000000100000000
<4>[   29.158257] x8 : 0000000000000000 x7 : 7f7f7f7f7f7f7f7f x6 : 2d7223ff6364626d
<4>[   29.158266] x5 : 0000008000000000 x4 : 0000000000000020 x3 : 2e7325006465636e
<4>[   29.158275] x2 : ffffffdc11afeff8 x1 : 0000000000000000 x0 : ffffffdc11be4d0c
<4>[   29.158285] Call trace:
<4>[   29.158290]  klist_remove+0x90/0x158
<4>[   29.158298]  device_release_driver_internal+0x20c/0x268
<4>[   29.158308]  device_release_driver+0x1c/0x30
<4>[   29.158316]  usb_driver_release_interface+0x70/0x88
<4>[   29.158325]  btusb_mtk_release_iso_intf+0x68/0xd8 [btusb (HASH:e8b6 5)]
<4>[   29.158347]  btusb_mtk_reset+0x5c/0x480 [btusb (HASH:e8b6 5)]
<4>[   29.158361]  hci_cmd_sync_work+0x10c/0x188 [bluetooth (HASH:a4fa 6)]
<4>[   29.158430]  process_scheduled_works+0x258/0x4e8
<4>[   29.158441]  worker_thread+0x300/0x428
<4>[   29.158448]  kthread+0x108/0x1d0
<4>[   29.158455]  ret_from_fork+0x10/0x20
<0>[   29.158467] Code: 91343000 940139d1 f9400268 927ff914 (f9401297)
<4>[   29.158474] ---[ end trace 0000000000000000 ]---
<0>[   29.167129] Kernel panic - not syncing: Oops: Fatal exception
<2>[   29.167144] SMP: stopping secondary CPUs
<4>[   29.167158] ------------[ cut here ]------------

Fixes: ceac1cb0259d ("Bluetooth: btusb: mediatek: add ISO data transmission functions")

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btusb.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e0e30f00a678..fcc62e2fb641 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2741,9 +2741,16 @@ static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void btusb_mtk_claim_iso_intf(struct btusb_data *data)
 {
-	struct btmtk_data *btmtk_data = hci_get_priv(data->hdev);
+	struct btmtk_data *btmtk_data;
 	int err;
 
+	if (!data->hdev)
+		return;
+
+	btmtk_data = hci_get_priv(data->hdev);
+	if (!btmtk_data)
+		return;
+
 	/*
 	 * The function usb_driver_claim_interface() is documented to need
 	 * locks held if it's not called from a probe routine. The code here
@@ -2765,17 +2772,30 @@ static void btusb_mtk_claim_iso_intf(struct btusb_data *data)
 
 static void btusb_mtk_release_iso_intf(struct hci_dev *hdev)
 {
-	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
+	struct btmtk_data *btmtk_data;
+
+	if (!hdev)
+		return;
+
+	btmtk_data = hci_get_priv(hdev);
+	if (!btmtk_data)
+		return;
 
 	if (test_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags)) {
 		usb_kill_anchored_urbs(&btmtk_data->isopkt_anchor);
 		clear_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags);
 
-		dev_kfree_skb_irq(btmtk_data->isopkt_skb);
-		btmtk_data->isopkt_skb = NULL;
-		usb_set_intfdata(btmtk_data->isopkt_intf, NULL);
-		usb_driver_release_interface(&btusb_driver,
-					     btmtk_data->isopkt_intf);
+		if (btmtk_data->isopkt_skb) {
+			dev_kfree_skb_irq(btmtk_data->isopkt_skb);
+			btmtk_data->isopkt_skb = NULL;
+		}
+
+		if (btmtk_data->isopkt_intf) {
+			usb_set_intfdata(btmtk_data->isopkt_intf, NULL);
+			usb_driver_release_interface(&btusb_driver,
+						     btmtk_data->isopkt_intf);
+			btmtk_data->isopkt_intf = NULL;
+		}
 	}
 
 	clear_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags);
-- 
2.45.2

