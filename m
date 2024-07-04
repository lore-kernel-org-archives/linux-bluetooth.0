Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D971A01B9;
	Thu,  4 Jul 2024 06:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720072889; cv=none; b=Rnqdssq/6IVxy+Ez9Aj34Wc+PR58qrV3gPSVDVN8Xh9TdKGYHUgQd+2kRh9XsT2sD1O4+iCkazxogQn0yA9tP90WCgOGNFq4XuGzIokUw8wd9um9Ljw5Yii54ubuJhxU7JxmSMyp7l8cU/1VTlmQKAVXQVOKGYdB0MkE6Z/SiME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720072889; c=relaxed/simple;
	bh=gjHTLWCSB0O+k/haqZdrXI9h+KWPYhJ0YOpE1ToZPJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iP9wSIoiZDCC9V/aDzkMDT4ppdGP0EN+FIGFGGlF5kJ6BEi3ndxqyQFjgxVVdd4K+Gk9KpGO6HQAm78IwvtRUHoaDqewu5yTie9rHFEej5GXLas2/ORE0Ov0LOt5Z0dzf07y2teOXr0eiQdncNyrAovKugyr/TxSglFJptbDQ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=L0QRFxTT; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="L0QRFxTT"
X-UUID: d5ff776839ca11ef99dc3f8fac2c3230-20240704
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bVodKyRsOcT/STMe2Z91D8J6McJz8ssQ55PR5jZhylM=;
	b=L0QRFxTT5gMgy9NwIyxVeqKt2D7rQkrUGFuY36kgkzVJPuawoqQrdZBcPH3j5/8+Mj4FGgZRSNBaNAl6uQJ7zLR/0j2ZdVTnq5yv5uGlSuhX57M9fvvkGvI0er+P/iu4iDlt0m5W4/aMdMTaPz9lp03iFP29YrHQEoEYGasXfZE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:5c3e5067-d33a-4a3c-82e0-df249ceb7d94,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:5f500d0d-46b0-425a-97d3-4623fe284021,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: d5ff776839ca11ef99dc3f8fac2c3230-20240704
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 172192818; Thu, 04 Jul 2024 14:01:20 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 4 Jul 2024 14:01:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 4 Jul 2024 14:01:18 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v7 3/8] Bluetooth: btmtk: rename btmediatek_data
Date: Thu, 4 Jul 2024 14:01:11 +0800
Message-ID: <20240704060116.16600-4-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240704060116.16600-1-chris.lu@mediatek.com>
References: <20240704060116.16600-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.330500-8.000000
X-TMASE-MatchedRID: xmxiBNXCzGYJjMBl75E2Dm3NvezwBrVmgDRlwc+wR6fADa2OEam+xnB4
	4IkzjfYyThbvLLI8RvPS5T3gQEi/FFVju37PDEAuHcQQBuf4ZFvq0SQ1Mgx5CMSiwizsgluQ17y
	gTjX1DW8ybDSrJJxJgiKdpy+2RQAX6EovbiVesMnPmshbRFtLmJKLNrbpy/A0w01zN1c0miKCjh
	4HUudaCB+LGgER62NbSZnPb0iDSC5I5aNiVPKgsR5GbmCaemIUJ/I0ITC6MIWbKItl61J/yZ+in
	TK0bC9eKrauXd3MZDUiXFDPMIaZGLc4+dW4JMQIqi8P0rY7CxseaZccRBusvZ9q2KbmHVphwL6S
	xPpr1/I=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.330500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 2B416677F6A7ACE3C2DDE2D3DC78A66F1F94EF380257591D191292F3729535C42000:8

Rename btmediatek_data to have a consistent prefix throughout the driver.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 10 +++++-----
 drivers/bluetooth/btmtk.h |  2 +-
 drivers/bluetooth/btusb.c |  9 ++++-----
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index a27c251bf56e..6489e4a63fb6 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -64,7 +64,7 @@ static void btmtk_coredump(struct hci_dev *hdev)
 
 static void btmtk_coredump_hdr(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct btmediatek_data *data = hci_get_priv(hdev);
+	struct btmtk_data *data = hci_get_priv(hdev);
 	char buf[80];
 
 	snprintf(buf, sizeof(buf), "Controller Name: 0x%X\n",
@@ -85,7 +85,7 @@ static void btmtk_coredump_hdr(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void btmtk_coredump_notify(struct hci_dev *hdev, int state)
 {
-	struct btmediatek_data *data = hci_get_priv(hdev);
+	struct btmtk_data *data = hci_get_priv(hdev);
 
 	switch (state) {
 	case HCI_DEVCOREDUMP_IDLE:
@@ -355,7 +355,7 @@ EXPORT_SYMBOL_GPL(btmtk_set_bdaddr);
 
 void btmtk_reset_sync(struct hci_dev *hdev)
 {
-	struct btmediatek_data *reset_work = hci_get_priv(hdev);
+	struct btmtk_data *reset_work = hci_get_priv(hdev);
 	int err;
 
 	hci_dev_lock(hdev);
@@ -371,7 +371,7 @@ EXPORT_SYMBOL_GPL(btmtk_reset_sync);
 int btmtk_register_coredump(struct hci_dev *hdev, const char *name,
 			    u32 fw_version)
 {
-	struct btmediatek_data *data = hci_get_priv(hdev);
+	struct btmtk_data *data = hci_get_priv(hdev);
 
 	if (!IS_ENABLED(CONFIG_DEV_COREDUMP))
 		return -EOPNOTSUPP;
@@ -387,7 +387,7 @@ EXPORT_SYMBOL_GPL(btmtk_register_coredump);
 
 int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct btmediatek_data *data = hci_get_priv(hdev);
+	struct btmtk_data *data = hci_get_priv(hdev);
 	int err;
 
 	if (!IS_ENABLED(CONFIG_DEV_COREDUMP)) {
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index e76b8a358be8..dde6fbdeb2b3 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -135,7 +135,7 @@ struct btmtk_coredump_info {
 	int state;
 };
 
-struct btmediatek_data {
+struct btmtk_data {
 	u32 dev_id;
 	btmtk_reset_sync_func_t reset_sync;
 	struct btmtk_coredump_info cd_info;
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8239d9c891e6..7612f10f9d39 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3152,7 +3152,7 @@ static int btusb_mtk_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
-	struct btmediatek_data *mtk_data;
+	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
 	int err;
 
 	/* It's MediaTek specific bluetooth reset mechanism via USB */
@@ -3167,9 +3167,8 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 
 	btusb_stop_traffic(data);
 	usb_kill_anchored_urbs(&data->tx_anchor);
-	mtk_data = hci_get_priv(hdev);
 
-	err = btusb_mtk_subsys_reset(hdev, mtk_data->dev_id);
+	err = btusb_mtk_subsys_reset(hdev, btmtk_data->dev_id);
 
 	usb_queue_reset_device(data->intf);
 	clear_bit(BTUSB_HW_RESET_ACTIVE, &data->flags);
@@ -3191,7 +3190,7 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 	char fw_bin_name[64];
 	u32 fw_version = 0, fw_flavor = 0;
 	u8 param;
-	struct btmediatek_data *mediatek;
+	struct btmtk_data *mediatek;
 
 	calltime = ktime_get();
 
@@ -4419,7 +4418,7 @@ static int btusb_probe(struct usb_interface *intf,
 		data->recv_event = btusb_recv_event_realtek;
 	} else if (id->driver_info & BTUSB_MEDIATEK) {
 		/* Allocate extra space for Mediatek device */
-		priv_size += sizeof(struct btmediatek_data);
+		priv_size += sizeof(struct btmtk_data);
 	}
 
 	data->recv_acl = hci_recv_frame;
-- 
2.18.0

