Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F38101F7;
	Fri, 25 Oct 2024 06:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729836454; cv=none; b=e1kB9XRd2hX3ewFPYE0T73zJa9t/73nOFCdm2Og4aaDVdTG19G7O+ngQRpbilsbzvpss1323M5pbtzFlUCxO7ajdQNGzX6K9ftTnn7tOTChQfz2U/gJiZY7T+sVC8DAlyCcbc44VBOoRQQCORxS0pq+p1gniYb6nldtOs40tgv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729836454; c=relaxed/simple;
	bh=ydHnqzELf7YkaHmqOFyQqCxgYJBXZiisPc/vhUuqwy4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q3Ctv9sVcO9wCwB73U+teVlqWAtjTwbZlZqpBIckMBNj8v4q/vopEiA25de6bPnMXK1G++ecufB12MShrX9Lu2sv4KhQ/IIqneRxX7HGpeG+R04Pa9W2iOiok55gsY31EvW9Yu0/qhKQwLmrVUwBopqupdy3jmzdSbVuOxHsn+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LXO7b4yG; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LXO7b4yG"
X-UUID: 67985972929711efb88477ffae1fc7a5-20241025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=uebIGAECSA7kj5SFYs/XoyxqDb5gH9esbAFRRW37R7I=;
	b=LXO7b4yGORpaMbkaoRNqXylJ2plSG1SJxo7DCKu6lZJBietrhkiTmhuwT5TcMl4FIHcEQtQ8w8P+nDzRNQ3t3tML2c6Z+Ngc+Q3NGzka8d67W06H7ZG54Hw8LkhCsRqNGfEN5Nv1TEaTH6ckm5/xtMzX6fWvosJnEfjWhz7PemU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:147d1858-9d18-4d5f-a337-05e88ab7ca42,IP:0,U
	RL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:b0fcdc3,CLOUDID:1b18d8cc-110e-4f79-849e-58237df93e70,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: 67985972929711efb88477ffae1fc7a5-20241025
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 943782294; Fri, 25 Oct 2024 14:07:24 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 25 Oct 2024 14:07:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 25 Oct 2024 14:07:23 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v2] Bluetooth: btmtk: adjust the position to init iso data anchor
Date: Fri, 25 Oct 2024 14:07:17 +0800
Message-ID: <20241025060717.24222-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

MediaTek iso data anchor init should be moved to where MediaTek
claims iso data interface.
If there is an unexpected BT usb disconnect during setup flow,
it will cause a NULL pointer crash issue when releasing iso
anchor since the anchor wasn't been init yet. Adjust the position
to do iso data anchor init.

[   17.137991] pc : usb_kill_anchored_urbs+0x60/0x168
[   17.137998] lr : usb_kill_anchored_urbs+0x44/0x168
[   17.137999] sp : ffffffc0890cb5f0
[   17.138000] x29: ffffffc0890cb5f0 x28: ffffff80bb6c2e80
[   17.144081] gpio gpiochip0: registered chardev handle for 1 lines
[   17.148421]  x27: 0000000000000000
[   17.148422] x26: ffffffd301ff4298 x25: 0000000000000003 x24: 00000000000000f0
[   17.148424] x23: 0000000000000000 x22: 00000000ffffffff x21: 0000000000000001
[   17.148425] x20: ffffffffffffffd8 x19: ffffff80c0f25560 x18: 0000000000000000
[   17.148427] x17: ffffffd33864e408 x16: ffffffd33808f7c8 x15: 0000000000200000
[   17.232789] x14: e0cd73cf80ffffff x13: 50f2137c0a0338c9 x12: 0000000000000001
[   17.239912] x11: 0000000080150011 x10: 0000000000000002 x9 : 0000000000000001
[   17.247035] x8 : 0000000000000000 x7 : 0000000000008080 x6 : 8080000000000000
[   17.254158] x5 : ffffffd33808ebc0 x4 : fffffffe033dcf20 x3 : 0000000080150011
[   17.261281] x2 : ffffff8087a91400 x1 : 0000000000000000 x0 : ffffff80c0f25588
[   17.268404] Call trace:
[   17.270841]  usb_kill_anchored_urbs+0x60/0x168
[   17.275274]  btusb_mtk_release_iso_intf+0x2c/0xd8 [btusb (HASH:5afe 6)]
[   17.284226]  btusb_mtk_disconnect+0x14/0x28 [btusb (HASH:5afe 6)]
[   17.292652]  btusb_disconnect+0x70/0x140 [btusb (HASH:5afe 6)]
[   17.300818]  usb_unbind_interface+0xc4/0x240
[   17.305079]  device_release_driver_internal+0x18c/0x258
[   17.310296]  device_release_driver+0x1c/0x30
[   17.314557]  bus_remove_device+0x140/0x160
[   17.318643]  device_del+0x1c0/0x330
[   17.322121]  usb_disable_device+0x80/0x180
[   17.326207]  usb_disconnect+0xec/0x300
[   17.329948]  hub_quiesce+0x80/0xd0
[   17.333339]  hub_disconnect+0x44/0x190
[   17.337078]  usb_unbind_interface+0xc4/0x240
[   17.341337]  device_release_driver_internal+0x18c/0x258
[   17.346551]  device_release_driver+0x1c/0x30
[   17.350810]  usb_driver_release_interface+0x70/0x88
[   17.355677]  proc_ioctl+0x13c/0x228
[   17.359157]  proc_ioctl_default+0x50/0x80
[   17.363155]  usbdev_ioctl+0x830/0xd08
[   17.366808]  __arm64_sys_ioctl+0x94/0xd0
[   17.370723]  invoke_syscall+0x6c/0xf8
[   17.374377]  el0_svc_common+0x84/0xe0
[   17.378030]  do_el0_svc+0x20/0x30
[   17.381334]  el0_svc+0x34/0x60
[   17.384382]  el0t_64_sync_handler+0x88/0xf0
[   17.388554]  el0t_64_sync+0x180/0x188
[   17.392208] Code: f9400677 f100a2f4 54fffea0 d503201f (b8350288)
[   17.398289] ---[ end trace 0000000000000000 ]---

Fixes: ceac1cb0259d ("Bluetooth: btusb: mediatek: add ISO data transmission functions")
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 1 -
 drivers/bluetooth/btusb.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index b7fc14aafc74..8a3f7c3fcfec 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1215,7 +1215,6 @@ static int btmtk_usb_isointf_init(struct hci_dev *hdev)
 	struct sk_buff *skb;
 	int err;
 
-	init_usb_anchor(&btmtk_data->isopkt_anchor);
 	spin_lock_init(&btmtk_data->isorxlock);
 
 	__set_mtk_intr_interface(hdev);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9970470c9d15..514d593923ad 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2637,6 +2637,7 @@ static void btusb_mtk_claim_iso_intf(struct btusb_data *data)
 	}
 
 	set_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags);
+	init_usb_anchor(&btmtk_data->isopkt_anchor);
 }
 
 static void btusb_mtk_release_iso_intf(struct hci_dev *hdev)
-- 
2.18.0

