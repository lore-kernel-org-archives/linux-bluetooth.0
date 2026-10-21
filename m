Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.61.82.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572230;
	b=oJc3tU6zV8iBNtiTUGp8GjL+3o2BSmxAe39CiUCuqHGj4VkXJsm+eChNGLsWm8udsr0z
	 S2Fi8gzQuPvb2v4NMOKZvLvGBYQsvCwBDIlmXzP5p1JYPvvuP/1B3i7SAJ3noQrdLazh0
	 yeogyb1WRCz+uP/qAzxiFjT0YsaaDXEhr9H104pSVja3dcyI01VroGzfBaHN+gh6XJzjB
	 BSJ0xS7+p8ZKpCA0MLLStTuMz2LJQVtFK6F9lootFc5A+7akUQ5JYJv/r7Dg7ZU8g7lPT
	 84eoFOg7LuATQPa7NUxwbA6qLjOEGyTfpkKfYrBBozppdznqZ9HhfswSsEsnwud+eMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572230;
	h=DMARC-Filter:X-UUID:DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=1Q/Gh3x6yW6P8XJJtj/UojJ6c3+w9rN4cOin2QaMhHA=;
	b=A1sBrnfvgEbnX9e3DnDZxAmrLyZkRsQCUz4ucsy9qkKBzR9cLFHK/I74t86JLJSKABUV
	 eWQQ0Ff7rTd1aQRT8PFGblqMMJeiCN5EozTkCHm0g1YlNPY0NxJ2UMFudONTX4Z8cZSZT
	 yPxoyx2sT3+uvK1UQZvxLcVsrzymLm+BqV8Jlvba9nCSwKSmUjI4F4O7J8UafB3NgLUDy
	 MC3RT52gxUV7fqOAL1hbu3FZygywtihJSKPAvyBBef6ofXza7XvmtH8bfDSCLZEG8Oonr
	 WNDVrhZJx/jf0XCi36ztzEGQSfoObn8wKHpxC9DBriDIKPOiGMNyAx2D/lfuQZdutSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mediatek.com;
	spf=pass smtp.mailfrom=mediatek.com;
	dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=rqAn8pPK;
	arc=none smtp.remote-ip=210.61.82.184
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BFF606A31C;
	Wed, 21 Oct 2026 08:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4BFF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=rqAn8pPK
X-UUID: 8392621ecd2b11f18dc8c9802ae25ab1-20261021
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1Q/Gh3x6yW6P8XJJtj/UojJ6c3+w9rN4cOin2QaMhHA=;
	b=rqAn8pPKB0iyuKLzBykHj4aYMK4YjFWLHFSJ3mDOvTOk8BPCuKrUKTLStLtyeIW/RwVm17eLKD1SM9gNybAWFQ3MU63166M6wqs9vnSuV5V0qexUhWHfjE3CAYKmutMZqEgt898fgkPSwYCU7B2cE+ELoe00J2iQaB2gerPPVaI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:c2968529-cbcc-40cf-a9f1-f06a68204b3f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:291e20b,CLOUDID:e1f81e3d-b757-4b4b-8cbf-eac98f8734fd,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8392621ecd2b11f18dc8c9802ae25ab1-20261021
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 225957092; Wed, 21 Oct 2026 16:43:39 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 21 Oct 2026 16:43:38 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 21 Oct 2026 16:43:38 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Hao Qin <hao.qin@mediatek.com>, Wenlong Tian
	<ot_wenlong.tian@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Will Lee
	<will-cy.Lee@mediatek.com>, SS Wu <ss.wu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v3 RESEND 1/3] Bluetooth: btmtk: drop zero-length ISO packets from endpoint padding
Date: Wed, 21 Oct 2026 16:43:35 +0800
Message-ID: <20261021084337.1515468-2-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261021084337.1515468-1-chris.lu@mediatek.com>
References: <20261021084337.1515468-1-chris.lu@mediatek.com>
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
never part of the stream. Confirm that the rest of the transfer is
zero-filled before dropping it, since the padding runs to the end of the
transfer.

This was observed on MT7925, but btmtk_recv_isopkt() is shared by every
MediaTek USB controller that supports ISO data.

Fixes: ceac1cb0259d ("Bluetooth: btusb: mediatek: add ISO data transmission functions")
Co-developed-by: Hao Qin <hao.qin@mediatek.com>
Signed-off-by: Hao Qin <hao.qin@mediatek.com>
Co-developed-by: Wenlong Tian <ot_wenlong.tian@mediatek.com>
Signed-off-by: Wenlong Tian <ot_wenlong.tian@mediatek.com>
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 75483d8230e1..90463208385b 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -7,6 +7,7 @@
 #include <linux/usb.h>
 #include <linux/iopoll.h>
 #include <linux/overflow.h>
+#include <linux/string.h>
 #include <linux/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -1588,6 +1589,25 @@ static int btmtk_recv_isopkt(struct hci_dev *hdev, void *buffer, int count)
 			/* Complete ISO header */
 			hci_skb_expect(skb) = __le16_to_cpu(dlen);
 
+			if (!hci_skb_expect(skb)) {
+				/* The interrupt endpoint zero-fills the
+				 * remainder of the transfer after the one
+				 * packet it carries. Confirm that is what
+				 * this is before dropping it.
+				 */
+				if (!mem_is_zero(buffer, count)) {
+					kfree_skb(skb);
+					skb = NULL;
+
+					err = -EILSEQ;
+					break;
+				}
+
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

