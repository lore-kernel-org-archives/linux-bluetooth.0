Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC15395AD8;
	Tue, 13 Oct 2026 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879514; cv=none; b=EIy69Fq13LWLLacjpogAw5VizLKFnCt4n4S4mj7OaLwyGUp6r71MId3mgB4p0tIcy8x9sLJ600698p3oKkcUHz/bghKlJYm5gJg6nRL80zUY11tVifO2g5Whzi1bUFy4eDZR7d52yA5KEArb0pzxETSO0u5dTAweb+T7PLIe7ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879514; c=relaxed/simple;
	bh=iX1z4hYs1xGMKxZNFFSUBKA3OyBxB1X/Y69H5Q4/vv4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bG3hP5dyS41fcv35xW4i0C0KddFSQD0kXv5GA+/PNGIMwN/xGfcdN7Y0WzZe3LYEU//Tk3d4fj6937dMccC2X0hBk+7k2w97xR/7JqhydQKPlMWi2QB2c5rjZtf+M5bg9vw1vlOpEdIZ0zdUj/Jed4rhz8keh3fk4ZoAonAG2bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QS4ceZSe; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QS4ceZSe"
X-UUID: aa41f058c6de11f1b1788b6acf885367-20261013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=2M+6YRfMNY+0ECvIUo2haTqwMfsnHsigkBlfpT0Km0M=;
	b=QS4ceZSeBZrLNksdLCpMveSNh0tCMJo+0FUiUuNov2kw4t7xCNIxpPmA/53j/W5wINOgUOl2nP2WmfXkvFtMTwletzJjmYR4PF/G7rbrk+eGRYEJY9qITCJklkFCWV3ZvWSXx/m5RVJHvP+oY+L3ZwwOZOH0XSXhDM+0VrhYd80=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:5b0897ca-4e43-428a-9c03-c66ff9edbf81,IP:0,U
	RL:0,TC:0,Content:47,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:47
X-CID-META: VersionHash:291e20b,CLOUDID:ff524995-3103-4fdb-b79c-08de0e281a5d,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:3|15|5
	0|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: aa41f058c6de11f1b1788b6acf885367-20261013
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 856566701; Tue, 13 Oct 2026 16:18:26 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Oct 2026 16:18:25 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 13 Oct 2026 16:18:25 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Hao Qin <hao.qin@mediatek.com>, Wenlong Tian
	<ot_wenlong.tian@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Will Lee
	<will-cy.Lee@mediatek.com>, SS Wu <ss.wu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH 1/2] Bluetooth: btmtk: drop zero-length ISO packets from endpoint padding
Date: Tue, 13 Oct 2026 16:18:22 +0800
Message-ID: <20261013081823.817996-2-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261013081823.817996-1-chris.lu@mediatek.com>
References: <20261013081823.817996-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The ISO interrupt IN endpoint delivers one HCI ISO packet per 264-byte
transfer and zero-fills the remainder. btmtk_recv_isopkt() keeps parsing
that padding: every four zero bytes look like an ISO header with handle 0
and Data_Total_Length 0, and are passed to hci_recv_frame() as a complete
frame. A single transfer can inject up to 64 of them, which is what fills
the HCI log with malformed ISO packets. If handle 0 belongs to a live
CIS/BIS, iso_recv() also drops the SDU it is reassembling.

A zero Data_Total_Length carries no ISO Data Load at all, and the
controller never emits one -- these are produced purely by parsing the
padding. The padding always runs to the end of the transfer, so stop
parsing once one is seen.

This was observed on MT7925, but btmtk_recv_isopkt() is shared by every
MediaTek USB controller that supports ISO data.

Fixes: ceac1cb0259d ("Bluetooth: btusb: mediatek: add ISO data transmission functions")
Co-developed-by: Hao Qin <hao.qin@mediatek.com>
Signed-off-by: Hao Qin <hao.qin@mediatek.com>
Co-developed-by: Wenlong Tian <ot_wenlong.tian@mediatek.com>
Signed-off-by: Wenlong Tian <ot_wenlong.tian@mediatek.com>
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index bdc85147b97f..869eb2176379 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1201,6 +1201,19 @@ static int btmtk_recv_isopkt(struct hci_dev *hdev, void *buffer, int count)
 			/* Complete ISO header */
 			hci_skb_expect(skb) = __le16_to_cpu(dlen);
 
+			/* The interrupt endpoint zero-fills the remainder of
+			 * each transfer, and that padding parses as a header
+			 * with a zero Data_Total_Length. Such a packet carries
+			 * no ISO Data Load at all and is never emitted by the
+			 * controller, so stop parsing here rather than hand a
+			 * bogus handle 0 packet to the stack.
+			 */
+			if (!hci_skb_expect(skb)) {
+				kfree_skb(skb);
+				skb = NULL;
+				break;
+			}
+
 			if (skb_tailroom(skb) < hci_skb_expect(skb)) {
 				kfree_skb(skb);
 				skb = NULL;
-- 
2.45.2

