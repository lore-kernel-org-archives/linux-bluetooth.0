Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAE6134BD;
	Wed, 23 Oct 2024 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729683434; cv=none; b=uErLoCTtBd2uSPP9uYfQUVLz2ppK4myc11d+Mp5hAjyTGSfVCtcGuEM9fYsIf0nARvQ8GCo0wzB42aZzH/2Oyr1g6pIl9blq1jQYtoOt1MB6+y7QAkhU6pmNNjIia159wCHVbYAr0co8jN7dXdvVe6mlFoqNZjzYkYKgFAo4ekw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729683434; c=relaxed/simple;
	bh=mZrEOKndn1ubO1KyDFbGQ7nCrbe5by9dY9IAUlOdyc0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HI0tPU/8frQqSkwxxO+R2qVRsg8BrfoiW33SyTDfMUS8MIo8E7D2pddb8GZuo4eNJw9jOxQW95UzHW/UUGUUvUULTWNZ4/xDMiyo4ndHtIieleI/bFPaA9nwmh7Q6msd/eh7WUy9ccGzjuERyIyGMHLttl/ZIbQ9QB6TZ39BVmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bkcZMLmw; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bkcZMLmw"
X-UUID: 1da3d004913311efbd192953cf12861f-20241023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=mvzEvHiDHJCSQ9OPPoA+/DQ5g+AxJier5h97qmDMLdE=;
	b=bkcZMLmwbHMDE2hb5JlIxG0W4yUtg5Djo6AemnuScBdnl5zseL9BtOG0d8QgBZgtZFxZaZN8ODXHnzW9aAEEwyW7+VbUSVoEewHPAozpCQMRQTiIZ5yIGo3Px87XFDh5WOawvjP4hjmfYtxEADapzh/9rYCklTnBuoqti+pmlV8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:b39d38b6-ca0e-4b16-865f-02b6b96a9b38,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:b0fcdc3,CLOUDID:a979fd2d-a7a0-4b06-8464-80be82133975,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1da3d004913311efbd192953cf12861f-20241023
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 792397769; Wed, 23 Oct 2024 19:36:59 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 23 Oct 2024 19:36:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 23 Oct 2024 19:36:58 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v1] Bluetooth: btmtk: adjust the position to init iso data anchor
Date: Wed, 23 Oct 2024 19:36:26 +0800
Message-ID: <20241023113626.12236-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

MediaTek iso data anchor init should be move to where MediaTek
claims iso data interface.
If there is an unexpected usb disconnect during setup flow,
it will cause a NULL pointer crash issue when releasing iso
anchor since the anchor wan't been init yet. Adjust the position
to do iso data anchor init.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 1 -
 drivers/bluetooth/btusb.c | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

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
index 9970470c9d15..15c0885c37cd 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2628,6 +2628,8 @@ static void btusb_mtk_claim_iso_intf(struct btusb_data *data)
 	struct btmtk_data *btmtk_data = hci_get_priv(data->hdev);
 	int err;
 
+	init_usb_anchor(&btmtk_data->isopkt_anchor);
+
 	err = usb_driver_claim_interface(&btusb_driver,
 					 btmtk_data->isopkt_intf, data);
 	if (err < 0) {
-- 
2.18.0

