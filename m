Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=60.244.123.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792567457;
	b=zGS5Arw9+tHh2wgqAf+6n/pfCj1tx7pz9dt3+dWv6R5utFmLu9914OIeLA8tqLiC3pqS
	 QcGWa88bLE8F5lmq5scGFKy9p//OrxDj8+A6qgqO36sgF3GdytYvpYXLHYMiAxfzaqh0W
	 jkS9KiOBdr79li0hRiXLHp4DNohM73KA03brgJexBBFBVYZ0IYz26pDraEOpCO5ef3Awu
	 Ler/hfEm0aDx0E5anUHUgOENmgMtje9WfA6QRjkuMrSrw2/hmb7AdvLsmL0+UaSGRY4R3
	 bDsumNsEimW2b+I6Y3a/jT6fzzBWbn09UaRoSrUjplrEhLiRVhe2/bvH4ao6b3DASgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567457;
	h=DMARC-Filter:X-UUID:DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=B4w3VfD1CsFEPvf0JUg0GejZencD2dFWVaSgkTbJa0U=;
	b=zQpQhwtrqFzT+HgGKSgAE6Woif/YRc4DpJHbUpYXzIDu9hbpam8JrLlSKYgtrFoVRDEb
	 U7XW8Q0DHmuYudMSfeWq55UApaA34Av1SkkUsfwhRLUOmMiZL0c7nbHmRLENCQGByJ/6N
	 yx8m3Z0/vYmDWwEfcFtsXI39gK+FvWDIjc0t1l/yObRoRClwPBSELzVD9P5r5+5s2Zyoc
	 bjaN/fJD/ZLFY8IcQYkN/WB82PplZ50E50+oxt90D3s9GbpwzVpwKGGD7AfL6SOOyChzx
	 LYRusDpwylSzC1vHgMrz2vaue1WJVPmF6bvwB65UZjMADW4RJaLV/Qo1YZ+QjnZm5cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mediatek.com;
	spf=pass smtp.mailfrom=mediatek.com;
	arc=none smtp.remote-ip=60.244.123.138
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E246B606A31D;
	Wed, 21 Oct 2026 07:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E246B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 61cd7bf6cd2011f1b1788b6acf885367-20261021
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=B4w3VfD1CsFEPvf0JUg0GejZencD2dFWVaSgkTbJa0U=;
	b=Y6h6g1x2k0n4BMN8z1Ot9mPwjAaLx4FI+bSqUtJnzZXWQ7zNBWDx15MDySbODF2dDALUePxsOrGjnf2n95fbooUwu91I7HQTjmQKBhdAFbMDbQ2vbXTZjuqTYaGJZN+Hjfj/mpsAn7kyuEXRhSHtEpZgyiuAJEtHT6/sfHhPsKw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:725e6a1c-a660-4f5e-b788-82e93af6d6e5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:291e20b,CLOUDID:8d77e38a-9b15-4dfd-88b6-b4385d95ae05,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 61cd7bf6cd2011f1b1788b6acf885367-20261021
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1308916624; Wed, 21 Oct 2026 15:23:58 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 21 Oct 2026 15:23:57 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 21 Oct 2026 15:23:57 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Hao Qin <hao.qin@mediatek.com>, Wenlong Tian
	<ot_wenlong.tian@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Will Lee
	<will-cy.Lee@mediatek.com>, SS Wu <ss.wu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v3 0/3] Bluetooth: btmtk: fix ISO data reception
Date: Wed, 21 Oct 2026 15:23:52 +0800
Message-ID: <20261021072356.1449539-1-chris.lu@mediatek.com>
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

