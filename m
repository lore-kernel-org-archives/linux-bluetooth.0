Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F0D3032A;
	Mon, 23 Sep 2024 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727081236; cv=none; b=JMnZdOsbf9gkD6mNaiIyf8f4Tb9vg26bIQ5mHuFC3znanKsMYVD0D8DGkd7F45RmjmqFFFDMUPz1pi9Q/z7i9A/6UjRD6XMZkYLOE50dOejWWfXsvyah23zZ7Y5PPp3OiJXRKO6Xmh5JHJ/Yj4TAvYg52Bwf3I1nIZkdwB82jIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727081236; c=relaxed/simple;
	bh=3eBThKPx00BqamOCCs/0dhkLCI+140Bn9iiw/lSAbS0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ed8/wcdxI6TE3KeTnrXKReEgZDlHnFZNcaj2TQewQkmWi63qzjkj/FqKV50KJguELAXVzvl/DMsLlCul/qaKByZXPyGqCObaEpq+PzXkOrwnlz583G8lrVYPMT/X8luXegYUuC16WEsxpkHAEv4f3SDLEdAuAR7RYnep9sb57fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gB0nzu+R; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gB0nzu+R"
X-UUID: 6aeaa026798811efb66947d174671e26-20240923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=YrLQBkr+4O7imCtu0pzv5R4puxbMisvPpZU/zFZINAI=;
	b=gB0nzu+RJ9z7B9RMTB8UVzV5axbU5sPQMvt6kHSto4DP7JKLMJKZSj5X0+C77qmcsRLkUNZlyz4W+8KT/a6qsWPKz81T46DddCRDv4gAb3fvMvX8G2CH6QR1Xda8cB/V2gDt1m9NFKNrr9ncCpdT9QTFlwzjhkgaqV5Ix9vOTeE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:0b5f89bc-b52b-4a54-a86a-11cf3d3c6366,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:a9276a9e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6aeaa026798811efb66947d174671e26-20240923
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 394688150; Mon, 23 Sep 2024 16:47:08 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
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
Subject: [PATCH v3 3/4] Bluetooth: btusb: mediatek: add intf release flow when usb disconnect
Date: Mon, 23 Sep 2024 16:47:04 +0800
Message-ID: <20240923084705.14123-4-chris.lu@mediatek.com>
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

MediaTek claim an special usb intr interface for ISO data transmission.
The interface need to be released before unregistering hci device when
usb disconnect. Removing BT usb dongle without properly releasing the
interface may cause Kernel panic while unregister hci device.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btusb.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index dfc42bdc8aaf..a434aefe68f2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2614,9 +2614,9 @@ static void btusb_mtk_claim_iso_intf(struct btusb_data *data)
 	set_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags);
 }
 
-static void btusb_mtk_release_iso_intf(struct btusb_data *data)
+static void btusb_mtk_release_iso_intf(struct hci_dev *hdev)
 {
-	struct btmtk_data *btmtk_data = hci_get_priv(data->hdev);
+	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
 
 	if (btmtk_data->isopkt_intf) {
 		usb_kill_anchored_urbs(&btmtk_data->isopkt_anchor);
@@ -2632,6 +2632,16 @@ static void btusb_mtk_release_iso_intf(struct btusb_data *data)
 	clear_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags);
 }
 
+static int btusb_mtk_disconnect(struct hci_dev *hdev)
+{
+	/* This function describes the specific additional steps taken by MediaTek
+	 * when Bluetooth usb driver's resume function is called.
+	 */
+	btusb_mtk_release_iso_intf(hdev);
+
+	return 0;
+}
+
 static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -2649,7 +2659,7 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 		return err;
 
 	if (test_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags))
-		btusb_mtk_release_iso_intf(data);
+		btusb_mtk_release_iso_intf(hdev);
 
 	btusb_stop_traffic(data);
 	usb_kill_anchored_urbs(&data->tx_anchor);
@@ -2703,14 +2713,13 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 
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
@@ -3824,6 +3833,7 @@ static int btusb_probe(struct usb_interface *intf,
 		data->recv_acl = btmtk_usb_recv_acl;
 		data->suspend = btmtk_usb_suspend;
 		data->resume = btmtk_usb_resume;
+		data->disconnect = btusb_mtk_disconnect;
 	}
 
 	if (id->driver_info & BTUSB_SWAVE) {
-- 
2.18.0

