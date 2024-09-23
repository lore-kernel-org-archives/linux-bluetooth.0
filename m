Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3A81946C3;
	Mon, 23 Sep 2024 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727081239; cv=none; b=ORvJDmKLA1yx29b88uuYuIMesmSJS1zGenhQrVg2GBlYGq5eaROeK7qYhh5T3y5z3rY9FtM/zYBcFQUPRU6Y0t8bPlmC4uf2xiDig7axqHd8J9/mcm2JTLF9DkY4ErGyRoW0uHP0vfzQGVS02Dr14wJnshIS+PsMDH+/uVIvLZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727081239; c=relaxed/simple;
	bh=87DFWcyTGo0dg4T24gjmMMC+4j98eVHTpdG4EfsnYcE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eE3tOItnZcVVhKVcJyiGZqCcC4FA3dNRPRBTyEmChHuDZvqeBuyFiBLd5qbgLxsFuglvfpZRASuk6lXCdGvmCnOrGhrezau1Q0kseKs8IrZlh63U9wwWD2h4Y3v9+lK7+v7k7xpNeK/8w8HVUO4Z+H79hOwwwOxPNS6nouX8zoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DyeporG7; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DyeporG7"
X-UUID: 6bbbcdd6798811efb66947d174671e26-20240923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zR2jZOmHoceMG6Tbb4ghEYfg8RYjnsIT6gWTP2zQppo=;
	b=DyeporG74Wb+DWJB49RQCJL0sRzX3OU4sTfa7PCPFO14azOarUXf73kOW9ulkH3LA3mM6oLzwHP/uU4IEKJCtVRDbijqskV5dvDynndzIAgBSb8m2rRS+SZJKYlAorpGnY/zGDXkpb3MfPjDmn2a4RaKhaIURHsKQhtUCiLFkJs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:723a3f42-847e-416a-aac7-f3000d50c851,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:bdd31a18-b42d-49a6-94d2-a75fa0df01d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6bbbcdd6798811efb66947d174671e26-20240923
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1305469166; Mon, 23 Sep 2024 16:47:10 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Sep 2024 16:47:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 23 Sep 2024 16:47:08 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v3 4/4] Bluetooth: btusb: mediatek: change the conditions for ISO interface
Date: Mon, 23 Sep 2024 16:47:05 +0800
Message-ID: <20240923084705.14123-5-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240923084705.14123-1-chris.lu@mediatek.com>
References: <20240923084705.14123-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Change conditions for Bluetooth driver claiming and releasing usb
ISO interface for MediaTek ISO data transmission.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btusb.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a434aefe68f2..9affe4f81294 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2618,7 +2618,7 @@ static void btusb_mtk_release_iso_intf(struct hci_dev *hdev)
 {
 	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
 
-	if (btmtk_data->isopkt_intf) {
+	if (test_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags)) {
 		usb_kill_anchored_urbs(&btmtk_data->isopkt_anchor);
 		clear_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags);
 
@@ -2658,8 +2658,8 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 	if (err < 0)
 		return err;
 
-	if (test_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags))
-		btusb_mtk_release_iso_intf(hdev);
+	/* Release MediaTek ISO data interface */
+	btusb_mtk_release_iso_intf(hdev);
 
 	btusb_stop_traffic(data);
 	usb_kill_anchored_urbs(&data->tx_anchor);
@@ -2704,22 +2704,22 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 	btmtk_data->reset_sync = btusb_mtk_reset;
 
 	/* Claim ISO data interface and endpoint */
-	btmtk_data->isopkt_intf = usb_ifnum_to_if(data->udev, MTK_ISO_IFNUM);
-	if (btmtk_data->isopkt_intf)
+	if (!test_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags)) {
+		btmtk_data->isopkt_intf = usb_ifnum_to_if(data->udev, MTK_ISO_IFNUM);
 		btusb_mtk_claim_iso_intf(data);
+	}
 
 	return btmtk_usb_setup(hdev);
 }
 
 static int btusb_mtk_shutdown(struct hci_dev *hdev)
 {
-	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
 	int ret;
 
 	ret = btmtk_usb_shutdown(hdev);
 
-	if (test_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags))
-		btusb_mtk_release_iso_intf(hdev);
+	/* Release MediaTek iso interface after shutdown */
+	btusb_mtk_release_iso_intf(hdev);
 
 	return ret;
 }
-- 
2.18.0

