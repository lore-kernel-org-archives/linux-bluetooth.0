Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.61.82.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572229;
	b=26VhR8zuoPs6/rNEA2gcL+zmSw0sfJwnznXTh5ZEq57/U1ZM3fNVruYpFHJhU3HmH0+g
	 J69DH2HHtTi1z5jEss/+5xyIGgUp/8l7UTIQoD+2U0wvgkU6W2QcJyhXvJkzR5Imk5Npy
	 fIuU4ZiLNPY5wW7d7al9vYWHkBzo41bSwicFNaDNxk4JPhnyxwgrvgJ1UFHOHW4oBknxP
	 xvK1kckjTM/iRjqoocGIFcLosSKF73S4+v85dNiswgQ4wVIW9+bGQzgq8bjo80pb5Ls0a
	 A1kMo/4DbcV1800+waYGIna6SI42Y8CHyYWGfXeA45IlYcZDrMIfKpXP1uyboPZmxkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572229;
	h=DMARC-Filter:X-UUID:DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=DfR6r0jQYKv4ohBiQ+/IkPgThMUgQanf2jGLMzUddBo=;
	b=jidQXb2fe08Yj0u3C6CRrn9VvU8k+4qgc/gf9p9rWoRz7Y0fm/8ZSaItZWwl9nxcgtCF
	 41pHWRe7H+JnTrSqUMJ5tUAZcTY7GwDEyIdUGK31efAZboujIBy2IKh3qRTxQIcjWqpen
	 Tov/Mypmhe0xaiyPoGGvS1AYXSNx9P9HNuxbyoMtq5tYZX8TMCEyco6BL1WSr10WLn79O
	 9pPI/jL8v3jiI5X7U5bMd+UgETR+yvwSCA3sYQZ7XAgwX50tT6bcMv0S9fthTnW19+Hty
	 I3jj5kJ/ktdQsLJ7AQE1kP5aGLNi8Q6Ob/xZjUhfZOe5q87rA/fH6TLqBYQOSEPt3ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mediatek.com;
	spf=pass smtp.mailfrom=mediatek.com;
	dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=ueo2ON0R;
	arc=none smtp.remote-ip=210.61.82.184
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BCF606A31A;
	Wed, 21 Oct 2026 08:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4BCF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=ueo2ON0R
X-UUID: 8359fd7acd2b11f18dc8c9802ae25ab1-20261021
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=DfR6r0jQYKv4ohBiQ+/IkPgThMUgQanf2jGLMzUddBo=;
	b=ueo2ON0R15e8z9bU+nhKaHmHqWJuUQpXwBLc1YPiih6VMokQ09F9pSXqDi8dT/FbhOu2pYIrgepqPjp/pYbt4M4iaFfiV/FfL/5zlpAfaBwrxEpcGp+i/VQNPnkbWnG23lr09BDg0thFHMO3krE7j//nsSnF2t4rqpMZCFbdA54=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:f102846d-b564-4438-b626-41196ee2318f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:291e20b,CLOUDID:dff81e3d-b757-4b4b-8cbf-eac98f8734fd,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8359fd7acd2b11f18dc8c9802ae25ab1-20261021
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 820366785; Wed, 21 Oct 2026 16:43:39 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
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
Subject: [PATCH v3 RESEND 0/3] Bluetooth: btmtk: fix ISO data reception
Date: Wed, 21 Oct 2026 16:43:34 +0800
Message-ID: <20261021084337.1515468-1-chris.lu@mediatek.com>
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

Resend due to rebase: the base this series was previously posted against
no longer exists in bluetooth-next's history, which is why it failed to
apply. Rebased onto current bluetooth-next; no content changes from v3.

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

Changes in v3 RESEND:
- Resend due to rebase. No content changes.

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

