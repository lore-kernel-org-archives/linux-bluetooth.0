Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BE513A89B;
	Mon, 16 Sep 2024 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726486794; cv=none; b=HggK8U9rivAjLPDDGd5//4JfGbTscnMo2VJRZHQPkGPeWn6r1XJQ9IK06r2k0BZ/IT+rGlJ/5HBWaZrfaj0ggiGyBUz5N8rVbTPE2+KsnG0S5/sUIKGAcsVx2gWpUhX3rn1yd0n19LgtdRauMFkx+e/MwIbqdi4aLWZsjg1eDgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726486794; c=relaxed/simple;
	bh=9n6EpwcmhFk4hnuFnJuP3xdLrvol/PQ6EpHT7lX9I/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QVVOuZ8vCizOV/ow8t/9EQUFFyLbFupIVGd+PdKYF4x59HfMkTRgCg7HY/35vw9i7H+zrFgevnQkvh8DReFAhqQmq6C4E1MSuIfmSWJV9x1p4CJaIHrA46jUScoWCbuKfgOkscn0MAuKRIqFoDnTIciPxmPglBkYKz01IWMaYVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eupIRYzq; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eupIRYzq"
X-UUID: 60aa7eaa742011efb66947d174671e26-20240916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Yh9Cv4MEik5r9AmsOV9eCf9ar3VkQAvVhfAiCwvPCIs=;
	b=eupIRYzq3FsuCgx6znuJ36+9L2p8DaxlXZ647LB2rBbkIUuF7/Pkx6J1X3V1TlH8e1iZUHFlnwETYHJjdoItESvX6OLgW1NmBrTE/VwnNfKJMnfbYiDLIH7BBZsQdf58Qc6iPrjuSoplvxTMQkcvdpP4AbTqVu3kxT2gQG46Hk8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:f4d961fb-443e-46ca-935d-0594812c27c0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:766317b7-8c4d-4743-b649-83c6f3b849d4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 60aa7eaa742011efb66947d174671e26-20240916
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1805997456; Mon, 16 Sep 2024 19:39:48 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 16 Sep 2024 19:39:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 16 Sep 2024 19:39:46 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH 3/4] Bluetooth: btusb: mediatek: add intf release flow in usb disconnect
Date: Mon, 16 Sep 2024 19:39:37 +0800
Message-ID: <20240916113938.30285-4-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240916113938.30285-1-chris.lu@mediatek.com>
References: <20240916113938.30285-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

MediaTek claim an special usb intr interface for ISO data transmission.
The interface need to be released before unregistering hci device when
usb disconnect. Removing BT usb dongle without properly releasing the
interface may cause Kernel panic while unregister hci device.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btusb.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index dfc42bdc8aaf..37e67b451b34 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2614,9 +2614,9 @@ static void btusb_mtk_claim_iso_intf(struct btusb_data *data)
 	set_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags);
 }
 
-static void btusb_mtk_release_iso_intf(struct btusb_data *data)
+static int btusb_mtk_release_iso_intf(struct hci_dev *hdev)
 {
-	struct btmtk_data *btmtk_data = hci_get_priv(data->hdev);
+	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
 
 	if (btmtk_data->isopkt_intf) {
 		usb_kill_anchored_urbs(&btmtk_data->isopkt_anchor);
@@ -2630,6 +2630,8 @@ static void btusb_mtk_release_iso_intf(struct btusb_data *data)
 	}
 
 	clear_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags);
+
+	return 0;
 }
 
 static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
@@ -2649,7 +2651,7 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 		return err;
 
 	if (test_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags))
-		btusb_mtk_release_iso_intf(data);
+		btusb_mtk_release_iso_intf(hdev);
 
 	btusb_stop_traffic(data);
 	usb_kill_anchored_urbs(&data->tx_anchor);
@@ -2703,14 +2705,13 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 
 static int btusb_mtk_shutdown(struct hci_dev *hdev)
 {
-	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
 	int ret;
 
 	ret = btmtk_usb_shutdown(hdev);
 
 	if (test_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags))
-		btusb_mtk_release_iso_intf(data);
+		btusb_mtk_release_iso_intf(hdev);
 
 	return ret;
 }
@@ -3824,6 +3825,7 @@ static int btusb_probe(struct usb_interface *intf,
 		data->recv_acl = btmtk_usb_recv_acl;
 		data->suspend = btmtk_usb_suspend;
 		data->resume = btmtk_usb_resume;
+		data->disconnect = btusb_mtk_release_iso_intf;
 	}
 
 	if (id->driver_info & BTUSB_SWAVE) {
-- 
2.18.0

