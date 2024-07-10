Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3DB84A5B;
	Wed, 10 Jul 2024 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720603585; cv=none; b=uum8kLrhK/GHl7192uA9A6bE/3NnF7knzvJDkERShpp/3fGgM3F7627jtTGUYuimd/g7iCcSbO8NeFFqW4WE5D+EYaAoPzh7Kr4cZG2jNFtuCBSwcv67Zhwh8l5i2EdC4kpCDkkvTw9MtCB3+yCufrIxoS+Qqj2/AEcPplwTFDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720603585; c=relaxed/simple;
	bh=1zElswsvJ3pJJN6VbPn+rOgECvzW/EETLvmAKoGVLuA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XbHSPeB9/H7871PFO9wDYcBV/PT3eL+8mMLO2GFgTfAK93Rv1f+GKODZDQSz4nZDp/froImXa17Ag7KpQDWSpHuR705h2ijPjfHAiTATiwiUJAzN7Amij0UOeIDSWDG3YL2DAWqMIybcK6mrcwTQU6bT43UsctInofbTqRfkCDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=faewIIti; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="faewIIti"
X-UUID: 7386eb9c3e9e11ef87684b57767b52b1-20240710
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=5JQ5bL4uRYPelWxEtL/T3yFSFEnrFbUa7wxiQo1QJ1Q=;
	b=faewIItifotUUTQ87g8hRaU+6aNxhAB84yvqUfuRVWEJISzaFBCmgSjPUqvJ4JBTmfPRBeKIrRA5mQkRJq1gYM9DTG0Wv0H4RQvCst84KohsiXcQ/Fb2m3naq42TtgWu0Brsjx8/qyEU00xHgHzkzNWp3SEkTO2k+gwwpGphXYo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:caa6c047-9202-4507-976c-1b1bc9897b53,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:c10e4a0d-46b0-425a-97d3-4623fe284021,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7386eb9c3e9e11ef87684b57767b52b1-20240710
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1161178547; Wed, 10 Jul 2024 17:26:13 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 Jul 2024 02:26:15 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 Jul 2024 17:26:15 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v2] Bluetooth: btmtk: Fix btmtk.c undefined reference build error
Date: Wed, 10 Jul 2024 17:26:14 +0800
Message-ID: <20240710092614.7297-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

MediaTek move some usb interface related function to btmtk.c which
may cause build failed if BT USB Kconfig wasn't enabled.
Fix undefined reference by adding config check.

btmtk.c:(.text+0x89c): undefined reference to `usb_alloc_urb'
btmtk.c:(.text+0x8e3): undefined reference to `usb_free_urb'
btmtk.c:(.text+0x956): undefined reference to `usb_free_urb'
btmtk.c:(.text+0xa0e): undefined reference to `usb_anchor_urb'
btmtk.c:(.text+0xb43): undefined reference to `usb_autopm_get_interface'
btmtk.c:(.text+0xb7e): undefined reference to `usb_autopm_put_interface'
btmtk.c:(.text+0xf70): undefined reference to `usb_disable_autosuspend'
btmtk.c:(.text+0x133a): undefined reference to `usb_control_msg'

Fixes: 39a9e1c69e74 ("Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407091928.AH0aGZnx-lkp@intel.com/
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
Change from v1 to v2:
-fix and update commit message warning
---
 drivers/bluetooth/btmtk.c | 2 ++
 drivers/bluetooth/btmtk.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index b7c348687a77..9789296ad4f6 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -437,6 +437,7 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(btmtk_process_coredump);
 
+#if IS_ENABLED(CONFIG_BT_HCIBTUSB_MTK)
 static void btmtk_usb_wmt_recv(struct urb *urb)
 {
 	struct hci_dev *hdev = urb->context;
@@ -1487,6 +1488,7 @@ int btmtk_usb_shutdown(struct hci_dev *hdev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btmtk_usb_shutdown);
+#endif
 
 MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
 MODULE_AUTHOR("Mark Chen <mark-yw.chen@mediatek.com>");
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index 453ed5131a37..890dbe9beff8 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -165,6 +165,7 @@ struct btmtk_data {
 	btmtk_reset_sync_func_t reset_sync;
 	struct btmtk_coredump_info cd_info;
 
+#if IS_ENABLED(CONFIG_BT_HCIBTUSB_MTK)
 	struct usb_device *udev;
 	struct usb_interface *intf;
 	struct usb_anchor *ctrl_anchor;
@@ -177,6 +178,7 @@ struct btmtk_data {
 
 	/* spinlock for ISO data transmission */
 	spinlock_t isorxlock;
+#endif
 };
 
 typedef int (*wmt_cmd_sync_func_t)(struct hci_dev *,
@@ -202,6 +204,7 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb);
 void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver,
 			   u32 fw_flavor);
 
+#if IS_ENABLED(CONFIG_BT_HCIBTUSB_MTK)
 int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id);
 
 int btmtk_usb_recv_acl(struct hci_dev *hdev, struct sk_buff *skb);
@@ -216,6 +219,7 @@ int btmtk_usb_suspend(struct hci_dev *hdev);
 int btmtk_usb_setup(struct hci_dev *hdev);
 
 int btmtk_usb_shutdown(struct hci_dev *hdev);
+#endif
 #else
 
 static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
-- 
2.18.0

