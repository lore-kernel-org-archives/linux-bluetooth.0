Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549674AA006;
	Thu, 15 Oct 2026 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052103; cv=none; b=Zo9emzQ/p97ZqDnnDJoHpgHh5C9umRZYaXQRbuxtlgjmki3Hw7owPRQDfM3VTXNY127JqmcJFEgfe2szbYPhf93JwVnhN21amXCsTMO6AG1nbTWGeGWR5OLGFo3vH9oUohtYYk+Jl6jYkAuw8vSFnqBDxP3rI8b/8qBG2M6YGz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052103; c=relaxed/simple;
	bh=oOgNjySZYnnMahV8ayretZigg8ij2oi4lLSByhjLvVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qS6O28aWNl9ngbfMBfSTWtRBwETF8HlbuUXO0RLswXrw9X5KuAeaQjSIfuU3kaBGWj8TIKn4iOBuuRtqm+kUPAiGul+GqQdF5V1wM8co88uVwfDX59ZrmwsmAYj3VvXZi/lKmpd5RJX0/ErNRcQkp4uSqURa4rjUbfLPNmAAwwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dBMcKWwn; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dBMcKWwn"
X-UUID: 801c3cf0c87011f1b1788b6acf885367-20261015
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=lg1hjzC+agABhFODF6pnEcv/7QRWTfeJl1WcUwF38/U=;
	b=dBMcKWwnIDrqG7ER/11jCyxoR22xioNpu0HwcrKjnpppmtw0l+Nx5zvBzVCwzDzjvyBqeRPwOKCdiR3sHACeGbt4J1XgXA2ExSN8yhAJa9UVehvTAuEnrP1cc6Re1KWHgxu+eo42kd787X6OXIO1nNxD1P1AgDiv+/Zw6nOjIFQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:88990eff-86bd-4037-9ee7-dce3f5ec371d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:291e20b,CLOUDID:fbb517fd-82fa-4755-85ae-ebe9525ab585,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 801c3cf0c87011f1b1788b6acf885367-20261015
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 485427639; Thu, 15 Oct 2026 16:14:53 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Oct 2026 16:14:52 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 15 Oct 2026 16:14:52 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Hao Qin <hao.qin@mediatek.com>, Wenlong Tian
	<ot_wenlong.tian@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Will Lee
	<will-cy.Lee@mediatek.com>, SS Wu <ss.wu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v2 2/3] Bluetooth: btmtk: bound the ISO payload length by the controller's MTU
Date: Thu, 15 Oct 2026 16:14:49 +0800
Message-ID: <20261015081450.1241194-3-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261015081450.1241194-1-chris.lu@mediatek.com>
References: <20261015081450.1241194-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

btmtk_recv_isopkt() bounds the Data_Total_Length reported by the
controller with skb_tailroom(skb) < hci_skb_expect(skb). That keeps the
reassembly inside the skb, but it enforces no protocol limit: the head
allocation is rounded up to the next kmalloc bucket and skb_tailroom()
reports what the bucket can hold rather than what was requested, which is
several hundred bytes more. An oversized length therefore passes, and the
parser keeps pulling bytes out of the following transfers to fill it,
swallowing the real ISO packets they carry until the frame is handed to
hci_recv_frame().

The controller reports the largest ISO_Data_Packet_Length it will send in
LE Read Buffer Size [v2], which hci_cc_le_read_buffer_size_v2() keeps in
hdev->iso_mtu. Once that is available, bound the length by it and size the
receive skb to hold that much plus the 4-byte header. HCI_MAX_ISO_SIZE is
kept only as a fallback for the window before the command completes.

Keep the skb_tailroom() test as well, because a fragment started before
hdev->iso_mtu was populated sits in an skb sized for the fallback.

Fixes: ceac1cb0259d ("Bluetooth: btusb: mediatek: add ISO data transmission functions")
Co-developed-by: Hao Qin <hao.qin@mediatek.com>
Signed-off-by: Hao Qin <hao.qin@mediatek.com>
Co-developed-by: Wenlong Tian <ot_wenlong.tian@mediatek.com>
Signed-off-by: Wenlong Tian <ot_wenlong.tian@mediatek.com>
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 869eb2176379..7c3fffcefdf1 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1169,8 +1169,15 @@ static int btmtk_recv_isopkt(struct hci_dev *hdev, void *buffer, int count)
 	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
 	struct sk_buff *skb;
 	unsigned long flags;
+	unsigned int iso_mtu;
 	int err = 0;
 
+	/* The controller reports the largest Data_Total_Length it will send in
+	 * LE Read Buffer Size [v2]. Fall back to HCI_MAX_ISO_SIZE while that
+	 * command has not completed yet.
+	 */
+	iso_mtu = hdev->iso_mtu ? hdev->iso_mtu : HCI_MAX_ISO_SIZE;
+
 	spin_lock_irqsave(&btmtk_data->isorxlock, flags);
 	skb = btmtk_data->isopkt_skb;
 
@@ -1178,7 +1185,8 @@ static int btmtk_recv_isopkt(struct hci_dev *hdev, void *buffer, int count)
 		int len;
 
 		if (!skb) {
-			skb = bt_skb_alloc(HCI_MAX_ISO_SIZE, GFP_ATOMIC);
+			skb = bt_skb_alloc(HCI_ISO_HDR_SIZE + iso_mtu,
+					   GFP_ATOMIC);
 			if (!skb) {
 				err = -ENOMEM;
 				break;
@@ -1214,7 +1222,13 @@ static int btmtk_recv_isopkt(struct hci_dev *hdev, void *buffer, int count)
 				break;
 			}
 
-			if (skb_tailroom(skb) < hci_skb_expect(skb)) {
+			/* Reject a length the controller said it would never
+			 * send. The skb_tailroom() test is kept because a
+			 * fragment started before hdev->iso_mtu was populated
+			 * sits in a smaller skb than iso_mtu now allows.
+			 */
+			if (hci_skb_expect(skb) > iso_mtu ||
+			    skb_tailroom(skb) < hci_skb_expect(skb)) {
 				kfree_skb(skb);
 				skb = NULL;
 
-- 
2.45.2

