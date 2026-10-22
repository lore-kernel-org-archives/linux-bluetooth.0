Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=60.244.123.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792639321;
	b=TdpRc2R8XrAY7HXiQWCQiXSpA5e24+GJP5nJWI2/IoLgCuIZtPxuzKSyFWpjobn/KjCe
	 30ATnRgFUqO2ytQR0ZFu5vchAKHhL8J39aOpjdaBFIlO3Z8nNcar8bNZqSVAXyOk6oIU8
	 FO0Dca5tJgLqfSksqBRPOc62xRcsJM6DBjpYuDV6QSFZ5nOQGFsoklYVe3XbAVVkR66I1
	 sJwWjkS4Y4WsnUX0acc4Y0wkaWKD0VIHmkvcYLopl6cWcXx07gLEdmYva5qTNT1h6/Q/o
	 l4aIHGbdeZ4z8SKTAcIZjKaVVk/2K1zPrQxraKtTkVEhw5L1Ehyx0QkUjXlJMNcrAcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792639321;
	h=DMARC-Filter:X-UUID:DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=luEQ8J4MhGajwFijyZ+PbTGIi826kYjhnh4/syUk0kM=;
	b=VHGSqZJYxXu4jGjf/P9PeeEDnqm22085kbcaBluYE9ky2h/LaLIz1KFpiFAnyvYOyRHU
	 UqICOcNe03FMTnY9ENABsX23+Ku+QJlpciD+AOVupi7gyA2c+UEhFG59XcGlLhzl1Shs5
	 XFVpoozmgIkL/FEHA96Jotw1wBpZA+Kq6Ga7cvOMWztBuyDqLmZL+q8YtnQsuI6XYh4s2
	 CKjDQNs6/nMs5QQbz5JoL4wQH9/h/lBgVU8jAqhHx+0HFtZpW3ws8XxD7zFhMXHPsNIIq
	 qJp8Nhd43uSYblh+D1ck5nB7XQcpHENowAgpW41s7s0f9wae2osTyr5o/7qQh1yTUmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mediatek.com;
	spf=pass smtp.mailfrom=mediatek.com;
	dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=lgLW6a2l;
	arc=none smtp.remote-ip=60.244.123.138
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ABA606A31A;
	Thu, 22 Oct 2026 03:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20ABA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=lgLW6a2l
X-UUID: baaa801ecdc711f1b1788b6acf885367-20261022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=luEQ8J4MhGajwFijyZ+PbTGIi826kYjhnh4/syUk0kM=;
	b=lgLW6a2lBgEjYo92Xlx/n4z3QnN+QpxK0x88sPL24X+8j/xSS90+uAnPS7tUuOQ/YWP+7g/7+Vv9pDuvngTKaQygiOS8RnruiO2Tc0ahbMW5ErCJwVKFJyOlCLsNuJuq1MEq1HpuKMGa0DsBioHPUSgL0g3QQu4CEFOWqN12Crk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:0e400710-a43a-4d4d-9d61-49fca84e080a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:291e20b,CLOUDID:6b471865-e866-403f-bcf0-32cb50bc2f0b,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: baaa801ecdc711f1b1788b6acf885367-20261022
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 106713506; Thu, 22 Oct 2026 11:21:53 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 22 Oct 2026 11:21:52 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 22 Oct 2026 11:21:52 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Hao Qin <hao.qin@mediatek.com>, Wenlong Tian
	<ot_wenlong.tian@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Will Lee
	<will-cy.Lee@mediatek.com>, SS Wu <ss.wu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v4 2/3] Bluetooth: btmtk: bound the ISO payload length by the controller's MTU
Date: Thu, 22 Oct 2026 11:21:49 +0800
Message-ID: <20261022032150.2213479-3-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261022032150.2213479-1-chris.lu@mediatek.com>
References: <20261022032150.2213479-1-chris.lu@mediatek.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
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
index 01d5ad2479f4..f2224eb0bf6b 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1557,8 +1557,15 @@ static int btmtk_recv_isopkt(struct hci_dev *hdev, void *buffer, int count)
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
 
@@ -1574,7 +1581,8 @@ static int btmtk_recv_isopkt(struct hci_dev *hdev, void *buffer, int count)
 			if (mem_is_zero(buffer, count))
 				break;
 
-			skb = bt_skb_alloc(HCI_MAX_ISO_SIZE, GFP_ATOMIC);
+			skb = bt_skb_alloc(HCI_ISO_HDR_SIZE + iso_mtu,
+					   GFP_ATOMIC);
 			if (!skb) {
 				err = -ENOMEM;
 				break;
@@ -1608,7 +1616,13 @@ static int btmtk_recv_isopkt(struct hci_dev *hdev, void *buffer, int count)
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

