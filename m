Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F4D4AB1BD;
	Thu, 15 Oct 2026 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052102; cv=none; b=LWqxC5fzLMWucPlt7McK1/sa9i6Ko0KNkwYut1El9tSs1gDHhO4qMDpdbgJcJLyoIktnGTs6fi/bNvgSaAuFrmtSjI/Q0Uk2OnppJxQTkB/nUyJLUgd8daoYj7kMPbJoy7zQA6cU8/PGqxRKyDxOb1B07M4AnIHA3tHdIEv83P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052102; c=relaxed/simple;
	bh=MpXQWuU/6pTmzsnH6jc5zSg0pvwduOYIIBJUHdngvXE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beBkOBO8UayM0WoH1LV0WRb8NZ5/msgPIjwfXwiBEPaumN3YudvLfZc6HaM4zWmC87id6PpUTHR65wpTFa0cEkuTf1WcVlcJ9qn4frQmKblTs0VKVp7vMW0tHKFJ1InrPi9rErk/imrEjYf/TFD1tkIXQdXbHfaRfOmCmUfCFN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=vGIlXLrM; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="vGIlXLrM"
X-UUID: 800862b6c87011f1b1788b6acf885367-20261015
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rY3D9mNBBjC7e3FDz4IfdKuwe8YGEsVKS9z7QrGZfpE=;
	b=vGIlXLrMgzDorKLWy0QcccPGA9300yyHsqolaATEzBRZSfQ34NdSD5Ktvn+V0Dfoc+oFtUgx2y64qZkiYbur8Je8MIBasaVM4+5R5D9WX4niA2QePruj67FcWXxXOxgsyK3uhyxmr/J4RcZLzVNv6jBuzJdpryT3/HRAFTbQXiI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:8e0f1815-c75a-45ba-95b8-5c83e39712c7,IP:0,U
	RL:0,TC:0,Content:50,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:50
X-CID-META: VersionHash:291e20b,CLOUDID:186ae3fc-d852-4ec7-93a7-9872a6d9e58d,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:3|15|5
	0|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 800862b6c87011f1b1788b6acf885367-20261015
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1954058223; Thu, 15 Oct 2026 16:14:53 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
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
Subject: [PATCH v2 1/3] Bluetooth: btmtk: drop zero-length ISO packets from endpoint padding
Date: Thu, 15 Oct 2026 16:14:48 +0800
Message-ID: <20261015081450.1241194-2-chris.lu@mediatek.com>
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

The ISO interrupt IN endpoint delivers a fixed-size transfer that holds
one HCI ISO packet and zero-fills the remainder. That padding belongs to
the transfer rather than to the stream, so it has to be dropped instead of
reported to the host.

btmtk_recv_isopkt() keeps parsing it: the zero bytes read as an ISO header
with handle 0 and a Data_Total_Length of zero, and each one is passed to
hci_recv_frame() as a complete frame. A single transfer yields a long run
of them, which is what fills the HCI log with malformed ISO packets, and
iso_recv() drops the SDU it is reassembling whenever handle 0 belongs to a
live CIS/BIS.

A zero Data_Total_Length carries no ISO Data Load, so such a packet is
never part of the stream. The padding runs to the end of the transfer, so
stop parsing once one is seen.

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

