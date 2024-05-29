Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9040B160787;
	Wed, 29 May 2024 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716964201; cv=none; b=LnPHSKvVj/aNABXKNXNxwn3jHlDXU0UvYu5FJYk7WI3A+6Kgl6qESds0gftfNiDMKZqNJMCFPqoBDvCVfFcOLbgLoCyMtKT+fyaW2N8tsIREjC3icrJ3UZIFfMzgbYLuC5A5NUkqpCrF+ESLY7KtP3mKSOh6rN+mlxHUryMTjOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716964201; c=relaxed/simple;
	bh=mEozOdyq3JhE4NZ9GAdH3wSUhRyds+L/Hs1E9DZ0gv8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RktPL4/vSawJhBOFC1S6Y4uJgbMj0oPuAu9Rglzy8sFIOTba5/rOHCxKPgEVefLvC+zo3HQHch2OeD+eHsMjw9nlEgJ9tKgM1bTMtZJ9ckA8uxj5OU5adzxnoLBrBBPggKNpwWqnIrfJWqcuPn2eNCXjJfTJ2eHNa/csEpVw4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DKkFp48A; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DKkFp48A"
X-UUID: db004e981d8411efbfff99f2466cf0b4-20240529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=LKjKCz6MWko6tQGKhAEekON+68KMgjRQz4EtM95IYls=;
	b=DKkFp48A4uCrVNcYBECyuq3/ntL6QDR5rt02icL9lIUNbGxzHxpWF5F6umNtMzl6QR+0XCXEMyXJldGdY9iixHPUtLdMh8GhGzXkEbAEAk5tbWJnJ9M5Zi65JeZUozpfP36CXqV/xpQXPClhXjUvN7BZtTpEg78G8anEA1IK2tk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:f91756df-95d4-4978-b631-94da13339f7f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:c9487384-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: db004e981d8411efbfff99f2466cf0b4-20240529
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1807475487; Wed, 29 May 2024 14:29:51 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 29 May 2024 14:29:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 29 May 2024 14:29:50 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v2 2/3] Bluetooth: btmtk: add macro to get/set/clear MediaTek defined flags
Date: Wed, 29 May 2024 14:29:45 +0800
Message-ID: <20240529062946.5655-3-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240529062946.5655-1-chris.lu@mediatek.com>
References: <20240529062946.5655-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Define a enumeration to store MediaTek specific flags and
macro function to set/test/clear the flags in data structure.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtk.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index e76b8a358be8..6a0697a22b16 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -128,6 +128,10 @@ struct btmtk_hci_wmt_params {
 
 typedef int (*btmtk_reset_sync_func_t)(struct hci_dev *, void *);
 
+enum {
+	__BTMTK_NUM_FLAGS,
+};
+
 struct btmtk_coredump_info {
 	const char *driver_name;
 	u32 fw_version;
@@ -136,11 +140,30 @@ struct btmtk_coredump_info {
 };
 
 struct btmediatek_data {
+	DECLARE_BITMAP(flags, __BTMTK_NUM_FLAGS);
+
 	u32 dev_id;
 	btmtk_reset_sync_func_t reset_sync;
 	struct btmtk_coredump_info cd_info;
 };
 
+#define btmtk_set_flag(hdev, nr)						\
+	do {									\
+		struct btmediatek_data *mediatek = hci_get_priv((hdev));	\
+		set_bit((nr), mediatek->flags);					\
+	} while (0)
+
+#define btmtk_clear_flag(hdev, nr)						\
+	do {									\
+		struct btmediatek_data *mediatek = hci_get_priv((hdev));	\
+		clear_bit((nr), mediatek->flags);				\
+	} while (0)
+
+#define btmtk_get_flag(hdev)							\
+	(((struct btmediatek_data *)hci_get_priv(hdev))->flags)
+
+#define btmtk_test_flag(hdev, nr)	test_bit((nr), btmtk_get_flag(hdev))
+
 typedef int (*wmt_cmd_sync_func_t)(struct hci_dev *,
 				   struct btmtk_hci_wmt_params *);
 
-- 
2.18.0

