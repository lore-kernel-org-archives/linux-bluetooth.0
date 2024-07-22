Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B5C4C7D;
	Mon, 22 Jul 2024 06:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721629365; cv=none; b=ovyJgivRrZ01t686FrW/jVa+y1b5T9qA6QeB/NBCtKnBUoXfddRsM1CsAocYC46SAKQn4VTSiSPOZ84bIfXYkE9NJD4mreiRJbUbmUE3vqhE7qgVDK0OtCURBZHKWLRIHZU0hWCDUVi6cOM/X1K7RyDjzXZb9SmOOqXCi7uU+bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721629365; c=relaxed/simple;
	bh=bNc+q4Zc8RndXEm6FNdap94dUeXfeCVy2oPwT85ZZM0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VvIW5wykvb5EMmHrPlkUk770gqMs0mD4Vz4qAXKY/5FL76hU/OVZl+oUaRVSKD07ZigyzJN0nLRUS+/W4cPxW9cFaiC8uvpC1Zd1A0uAPCbWvoh9fJ+/k8TWBh4KBn5ggrSbDHTCxdWX1dwTdy+rpkuOC+stfmdSv4X+8ABY6jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Gn4f3PxT; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Gn4f3PxT"
X-UUID: c90e64f247f211efb5b96b43b535fdb4-20240722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=bkvgIktChmzkooE5NvOvL26cQeo/bI5bJkOyPX+YUEQ=;
	b=Gn4f3PxTqaOq/WUPUHaceJAaHs5AFeIOeYvuFtjI4+uaPinobYg4Mon4rVrPDIbMIqU+pCqGJwVFCnYzHnLBrlSCMbZ826OuP85erPuyMqLJczTbQMKI6QGMt6qESJc9KGISsJpgMY8P15MUJblVorcEmMpFRFKkbEW0rvcAV3g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:fc9a14e0-da6f-4a34-b900-d253d8a460c4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:60819fd5-0d68-4615-a20f-01d7bd41f0bb,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: c90e64f247f211efb5b96b43b535fdb4-20240722
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1472777845; Mon, 22 Jul 2024 14:22:35 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 22 Jul 2024 14:22:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 22 Jul 2024 14:22:35 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH] Bluetooth: btmtk: Fix function-declaration build error
Date: Mon, 22 Jul 2024 14:22:16 +0800
Message-ID: <20240722062216.16090-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Separate out the declaration of usb related function into another
if/else condition in btmtk.h, avoiding function-declaration issue
happened when CONFIG_BT_HCIBTUSB was defined but CONFIG_BT_HCIBTUSB_MTK
wasn't.

'btmtk_usb_subsys_reset';
ISO C99 and later do not support implicit
function declarations [-Wimplicit-function-declaration]
'alloc_mtk_intr_urb';
ISO C99 and later do not support implicit
function declarations [-Wimplicit-function-declaration]
'btmtk_usb_setup';
ISO C99 and later do not support implicit
function declarations [-Wimplicit-function-declaration]
'btmtk_usb_shutdown';ISO C99 and later do not support
implicit function declarations [-Wimplicit-function-declaration]

Fixes: 52828ea60dfd ("Bluetooth: btmtk: Fix btmtk.c undefined reference build error")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407200904.hRqT3JKD-lkp@intel.com/
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtk.h | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index 6fc69cd8636b..fcc44800cf29 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -201,23 +201,6 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb);
 
 void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver,
 			   u32 fw_flavor);
-
-#if IS_ENABLED(CONFIG_BT_HCIBTUSB_MTK)
-int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id);
-
-int btmtk_usb_recv_acl(struct hci_dev *hdev, struct sk_buff *skb);
-
-struct urb *alloc_mtk_intr_urb(struct hci_dev *hdev, struct sk_buff *skb,
-			       usb_complete_t tx_complete);
-
-int btmtk_usb_resume(struct hci_dev *hdev);
-
-int btmtk_usb_suspend(struct hci_dev *hdev);
-
-int btmtk_usb_setup(struct hci_dev *hdev);
-
-int btmtk_usb_shutdown(struct hci_dev *hdev);
-#endif
 #else
 
 static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
@@ -259,7 +242,25 @@ static inline void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id,
 					 u32 fw_ver, u32 fw_flavor)
 {
 }
+#endif
+
+/* USB interface related functions */
+#if IS_ENABLED(CONFIG_BT_HCIBTUSB_MTK)
+int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id);
+
+int btmtk_usb_recv_acl(struct hci_dev *hdev, struct sk_buff *skb);
+
+struct urb *alloc_mtk_intr_urb(struct hci_dev *hdev, struct sk_buff *skb,
+			       usb_complete_t tx_complete);
 
+int btmtk_usb_resume(struct hci_dev *hdev);
+
+int btmtk_usb_suspend(struct hci_dev *hdev);
+
+int btmtk_usb_setup(struct hci_dev *hdev);
+
+int btmtk_usb_shutdown(struct hci_dev *hdev);
+#else
 static inline int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 {
 	return -EOPNOTSUPP;
-- 
2.18.0

