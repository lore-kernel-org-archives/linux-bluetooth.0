Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=60.244.123.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792639318;
	b=Z204L53uLzMc91+BlFf5wBE5b3/BEaRg61D+mOXsIM5NAzJ/ODOUBfLkZA8U9dEasGkI
	 pwD3mdCRBgc2rU49FfVK1g1jxefVoT+hSMK2JF52sxpmgEGrusv7s+C06mMx4Ti2acVdb
	 Tv5rPPqrqCS7gdDVRb655jJH7O8tue6xsCQWDfB7ZXAEFq/xF62j8HYUcInkMf3MhKR/f
	 h1e7Q0GDy+nN1qErJDel3lRgGXxVnMcCIdiboIFvfkWgJ5P74XQOQPgHicIXu8hoB2j2E
	 tqAP4S59NGrbh67wau9LUu0Y3r8XYzMKjjWrPLfQYL+9Ueus92P/dldaerfqrKvmhtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792639318;
	h=DMARC-Filter:X-UUID:DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=nUCgUjmNbN6TcToRQfveewWV+E0+qBY6zOXb84C174g=;
	b=3YGjPWR2BhRWqjMGj7hxXZOb4Wve8P7fu3CqnJ7VHW6PodtvAb3VdNNZu+ewC9QBwCm0
	 2Gzc9WSTyzWHr8TucUDCvKIzuItfT42B3pL74HrqYWbJksaGM4Ck4vz5mz+dwdST4U/Hd
	 gG6Mxg3BmsjiAMafIcSn0w+V0HWoypXnJaq/4RRPZcandTxwcc82AEvLGImW+7KXBzy6a
	 OeQJc76b5IqFdEu5Vkj5zb8E1WbtnVbmHL0ciwcefBcpwaTy3d3GTlFCF08a/hZcqPpxj
	 5ox3TmRsllgHlxs4R2Vdmc3Ap2rt3sCQ2IXS4cc8xaMhsTWkTXnQg3KvtNxJ5TAHU9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mediatek.com;
	spf=pass smtp.mailfrom=mediatek.com;
	dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=IaO23Iyw;
	arc=none smtp.remote-ip=60.244.123.138
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C471A606A319;
	Thu, 22 Oct 2026 03:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C471A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=IaO23Iyw
X-UUID: ba0ce93acdc711f1b1788b6acf885367-20261022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=nUCgUjmNbN6TcToRQfveewWV+E0+qBY6zOXb84C174g=;
	b=IaO23Iywh1Q4mBrjJLPPezw1MWofJtNevAMTkEReh0j4Ldp6RKrW28PBvwxAKTitzGs0m0dNAY2WB2XYN8YZh3Ik48H8XH5kofGFsbxSBedUZhimUYuxetQCnzB85IbBWyHTQlFsPpyk8RqRE1rR8ZbaYei4at4NkzqKP0Evsr4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:6dc39425-693d-470a-99ec-e1e37b5f81e0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:291e20b,CLOUDID:b2224cce-02bc-447e-ab88-2baec399874a,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ba0ce93acdc711f1b1788b6acf885367-20261022
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 279510183; Thu, 22 Oct 2026 11:21:52 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
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
Subject: [PATCH v4 0/3] Bluetooth: btmtk: fix ISO data reception
Date: Thu, 22 Oct 2026 11:21:47 +0800
Message-ID: <20261022032150.2213479-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
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

Two fixes for btmtk_recv_isopkt(), found while debugging LE Audio on
MT7925, plus an update to the ISO data transmission setting. The function
is shared by every MediaTek USB controller that supports ISO data, so none
of this is specific to that part.

Patch 1 drops the zero padding that the ISO interrupt IN endpoint appends
to each transfer instead of parsing it as ISO packets.

Patch 2 bounds Data_Total_Length by hdev->iso_mtu.

Patch 3 updates the mt79xx ISO data transmission setting.

The three hunks do not overlap, so any prefix of the series applies on its
own.

Changes in v4:
- Patch 1: check for the endpoint's zero-filled padding before starting
  to parse a new frame, rather than after assembling a 4-byte header.
  Otherwise a zero-filled remainder shorter than an ISO header (1-3
  bytes) would be held across calls as a partial header and corrupt the
  next transfer's framing. This also avoids allocating and immediately
  freeing an skb for a fully zero-filled remainder.
- Patch 2, 3: unchanged.

Changes in v3:
- Patch 1: instead of dropping a packet solely because Data_Total_Length
  is zero, also confirm that the rest of the transfer is zero-filled
  before treating it as padding.
- Patch 2, 3: unchanged.

Changes in v2:
- Patch 2 reworked and retitled.
- Patch 3 added.

Based on bluetooth-next.

Chris Lu (3):
  Bluetooth: btmtk: drop zero-length ISO packets from endpoint padding
  Bluetooth: btmtk: bound the ISO payload length by the controller's MTU
  Bluetooth: btmtk: derive the firmware ISO setting from
    MTK_ISO_THRESHOLD

 drivers/bluetooth/btmtk.c | 44 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

-- 
2.45.2

