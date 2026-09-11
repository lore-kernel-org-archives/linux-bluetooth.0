Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA48943B3F9;
	Fri, 11 Sep 2026 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123371; cv=none; b=qu8u6Itgiprvo/b7lODeSPRrYiwVKhiFji1Vzi8GEITEkKrgGAzAvNHfcaa2fwY69GuLbKEshKzZOMRFTuUta9ecb0q/bXdg0FWyDfOAf7hU3xQ4mOiVU1gxUuXHcnNtJui2aZ+gOLWa3OG8UPNbpk2xCg0sLLF4Arh9Ke1zpz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123371; c=relaxed/simple;
	bh=sqTo87R/5U/IbzUEAJv0F1dVUlKprtkGokpln0tvhBo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JjQqERDKQ6+Nx9q4S2pqweVkdGbQotEBSFvdFapNMQ4ed4qERwQJxIa9HuMCp43DNG5w2jdm5yAWTJTV60HBZg6XAITNzbUDEYSKIIXBLDALZGX3GHvXYUs8UCeqX1yVHQ1jGv1a+BR5j4WCIDWmDOoeKFk2OIciplSe3JVYBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TEtnid3t; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TEtnid3t"
X-UUID: 81c82572adcd11f18dc8c9802ae25ab1-20260911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=xHKh2ur1SC89+M37Jy0ih6zuudaICpT10+VsOS5BA6Y=;
	b=TEtnid3tCh4+fxf9e5ZcwVwGyCdQWamo+H6RoGoVvm0vjVABMHCuz5NKbnzK2QKViTiy0VqF/7ozDUaxGkh6vT3xsHg3xUk6nufOVmX4xAMwNV+Ae8mY+PiyreFNLrZYkhzdOKv4M6/U/3WevHYrKmC2jxbkAqVq8lVhiOZP0MI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:bfbc8588-a785-45e8-9f01-28b77d35e580,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:c8e0a8dc-e2a3-4c41-83fa-4adacd638ae3,B
	ulkID:nil,BulkQuantity:0,SF:102|136|836|865|888|898,TC:-5,Content:0|15|50|
	99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 81c82572adcd11f18dc8c9802ae25ab1-20260911
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 323679709; Fri, 11 Sep 2026 18:42:38 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 11 Sep 2026 18:42:37 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 11 Sep 2026 18:42:36 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH 0/3] Bluetooth: btmtk: firmware debug event routing and WMT FUNC_CTRL status fixes
Date: Fri, 11 Sep 2026 18:42:31 +0800
Message-ID: <20260911104234.2276126-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series bundles three independent MediaTek Bluetooth driver fixes:

Patch 1 is a resend of a fix submitted on 25 Aug 2026
("Bluetooth: btmtk: Route firmware debug event to the diag channel")
that received no review feedback. There are no code changes since
that submission; resending it alongside the two related fixes below.

Patches 2-3 fix how btmtk_usb_hci_wmt_sync() (and its btmtksdio.c /
btmtkuart.c counterparts) interpret a WMT FUNC_CTRL event that carries
only the WMT header and no trailing 2-byte status word. Such an event
is a normal firmware ack for a plain enable/disable request, with the
result carried in the header's own flag byte, not a failure as the
current code assumes:

  - Patch 2 fixes this for btmtk.c, where a bounds check already
    existed (added by e3ac0d9f1a20) but defaulted to the wrong
    result.
  - Patch 3 applies the same fix to btmtksdio.c and btmtkuart.c, which
    never had a bounds check for this event at all and read 2 bytes
    past the end of the received SKB whenever firmware sent the short
    form. While there, it also adds the missing base WMT header length
    check that btmtk.c already has (skb_pull_data() before touching
    wmt_evt->whdr.op), since these two files were unconditionally
    dereferencing that field with no length validation at all.

Chris Lu (3):
  Bluetooth: btmtk: Route firmware debug event to the diag channel
  Bluetooth: btmtk: fix wrong status for short WMT FUNC_CTRL events
  Bluetooth: btmtksdio, btmtkuart: validate WMT event length before
    struct access

 drivers/bluetooth/btmtk.c     |  8 +++++++-
 drivers/bluetooth/btmtksdio.c | 20 +++++++++++++++++++-
 drivers/bluetooth/btmtkuart.c | 19 ++++++++++++++++++-
 3 files changed, 44 insertions(+), 3 deletions(-)

--
2.45.2
