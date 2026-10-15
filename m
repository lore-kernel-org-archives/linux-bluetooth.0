Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387904AB1BD;
	Thu, 15 Oct 2026 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052107; cv=none; b=XmR63Ysqfs8EexfysvLLkX4aQcN1QbXDCREGWa+BZqPD6CbM3WC9rj3pKgnyVesXFckP6GYbwvjJRiroP0ly4FxIjSt1LkWFYOnkorv6oNKM78wYuO2EnOzuIjex9DodcvSJhf5R2qTKnLajxiUZpYTH+j0mlpq9pX9Yp/IiesM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052107; c=relaxed/simple;
	bh=3fM1qbcBxfYnCrAG4hozKhTAh7vF/lhMVvtmrkh02Js=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X/uyQjizaAU2ACaIoBWIwMntfPmhoxpwkzjxsd01vgIZxP+hdB9U4JnbIgdsCqUbUYT6yaLqCTLdqLcyM4YjWNw/DmUOZ/ED/M6jF0UugvxQi0K4On8Yv3DBR6DAysM96jJSDO55tIRIBITWxuuowWdmTgq0FvonmrinPohLa/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZzUqmt9S; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZzUqmt9S"
X-UUID: 7f7badf8c87011f18dc8c9802ae25ab1-20261015
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=dtGFljm52cyuIn+hi7p/IuJvrI5isfxkKWbhMEgIJIk=;
	b=ZzUqmt9SnQv6fzU3ZuNiohVhxwaO9YMFE1NBjSvxiy9y+O+te0jWa9E2lewl7zGgMirXV/QYTHlPsGwgQoxg7VXcVNPfVBBgObf6a3RygdplyHJfI5CFFa4iTOtKVQm5qlQUNFSfHYH2a22W17YE0y5R/s4wCxkJd/7HqtrVrNQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:3058bfa2-af1f-4aa7-878c-a7c96eb913d1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:291e20b,CLOUDID:c509d8f5-edce-4c2f-b0fd-70b87eb23d10,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7f7badf8c87011f18dc8c9802ae25ab1-20261015
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1543376465; Thu, 15 Oct 2026 16:14:52 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
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
Subject: [PATCH v2 0/3] Bluetooth: btmtk: fix ISO data reception
Date: Thu, 15 Oct 2026 16:14:47 +0800
Message-ID: <20261015081450.1241194-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Three fixes for ISO data handling in btmtk, found while debugging LE Audio
on MT7925. The code is shared by every MediaTek USB controller that
supports ISO data, so none of this is specific to that part.

Patch 1 drops the zero padding that the ISO interrupt IN endpoint appends
to each transfer instead of parsing it as ISO packets. The driver turns
that padding into handle 0 packets with a Data_Total_Length of zero and
hands them to the stack, which is what fills the HCI log with malformed
ISO frames, and a valid SDU is lost whenever handle 0 belongs to a live
CIS/BIS.

Patch 2 bounds Data_Total_Length by hdev->iso_mtu. The existing
skb_tailroom() test enforces no protocol limit, because the skb head
allocation is rounded up to a kmalloc bucket and skb_tailroom() reports
the bucket size rather than what was requested.

Patch 3 updates the mt79xx ISO data transmission setting.

The three hunks do not overlap, so any prefix of the series applies on its
own.

Changes in v2:
- Patch 2 reworked and retitled. v1 only enlarged the receive skb, which
  turned out to be a no-op, and added no bound at all. v2 bounds
  Data_Total_Length by hdev->iso_mtu and sizes the skb from the same
  value.
- Patch 3 added.
- Patch 1 unchanged.

Based on bluetooth-next.

Chris Lu (3):
  Bluetooth: btmtk: drop zero-length ISO packets from endpoint padding
  Bluetooth: btmtk: bound the ISO payload length by the controller's MTU
  Bluetooth: btmtk: derive the firmware ISO setting from
    MTK_ISO_THRESHOLD

 drivers/bluetooth/btmtk.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

-- 
2.45.2

