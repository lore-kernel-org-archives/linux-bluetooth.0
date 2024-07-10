Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9CB83A0D;
	Wed, 10 Jul 2024 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720597125; cv=none; b=CxUCZyE33xtQ5N2fYQH01UQkWoXKi3KDXQOhvbtL3/AY8Z0NNSw5dtPeaChP3T+jrKotRp0r8YAcds9bBQNAr23LfphcV8lOzdFALExHYtG110J0/FK8slgPu/94ymVEFPXQ/j40ba7I4no3gcZ0nGd5XyKhOCSFdPsgzsSggKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720597125; c=relaxed/simple;
	bh=p37UAUNUsUJN0YgOa0VEOZL/K037gFMz9T9TMFx2Enw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kwfbg/oGze/rbuyffHgUadTsc6RPwaBqSv5kjQFxRUiC0vX85N+Yf13vBjgNK+htZ+b0Qg3SXnOf8YqJnxHJGIR89ekt65kbUvWn9gmBQ9yM9UbP2mIOUYsF9DMGQZZTpo9XWy0b770StCymisTHLFaG4YU//fZ2vlvXvT9i5Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Tmpgs1ij; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Tmpgs1ij"
X-UUID: 68a813fe3e8f11ef87684b57767b52b1-20240710
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=mvSw0YCcP6OkaKMinb0d5io/X3LmFsIcP7XhTzkLI/c=;
	b=Tmpgs1ijDkccsmszzkw+X3d4HdfbngcDEraO9w7+VF++5p8Gd4h4HRmF/3nR474RZgQkJfi856M5LXxSoVJ8R1BO2E/5469ci2QkCvtbtgNifP8iK/+BaLk5PmzPzTZjoLxp1vSvisaKt0Q7ngRV3/BYaw2DWccj6JMvakkFFEw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:b6c99462-9bf0-44fe-8237-a00c4fdeba69,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:5be24ed1-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 68a813fe3e8f11ef87684b57767b52b1-20240710
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1630659267; Wed, 10 Jul 2024 15:38:32 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 Jul 2024 15:38:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 Jul 2024 15:38:33 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH] Bluetooth: btmtk: Fix btmtk.c undefined reference build error
Date: Wed, 10 Jul 2024 15:38:32 +0800
Message-ID: <20240710073832.4381-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.091700-8.000000
X-TMASE-MatchedRID: IL7zMc1rB96iwkztVCsqbzl6J+7ealtWvtVce6w5+K8sfFlFugSGUDAx
	/Q55TgrfZW9aUrh/vYDSwA55kcDk3Pww9Stut6YHmNvbnzNu6oL4qCLIu0mtICz+5QCTrE/sI6q
	q9xPsXYiTFmqgSxbocNnFK+oGmxAsIzPPScfZfh+gx+na8dyT1fqtWPv3hAK2Cjo47SvV0k1Xvy
	lpgLr3gMrdT5sfS91sBFQhScLIoJdAW3ODyfm3/gwfhKwa9GwDftnnpG0AB3VdhPmPvbogbKPFj
	JEFr+olwXCBO/GKkVqOhzOa6g8KrUWRK7Bl4Dml/FhLcV2i0H//0q3VBjI4L5bjsrNE7+gtGl94
	w95vR5c=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.091700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 5E7C9090678A3D3D1A6745644C61EEA5F16F33400E3FA696709DF94C7AE55AC22000:8

MediaTek move some usb interface related function to btmtk.c which
may cause build failed if BT USB Kconfig wasn't enabled.
Fix undefined reference by adding config check.

Fixes: 39a9e1c69e74 Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407091928.AH0aGZnx-lkp@intel.com/
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
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

