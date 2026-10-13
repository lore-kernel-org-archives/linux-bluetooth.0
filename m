Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113D73822BB;
	Tue, 13 Oct 2026 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879514; cv=none; b=uXVjvlLJA+w0ZDUHfjLgZrBRNorW/ln0D+pLYPwSQmJKeYdlT5rrbQeWG47Wzsunqiv4U+4UkWRu7Pebk3fEzn6Z26vQNaEKAmxkptbj20Pe24IeZhDS7YCBN5tXcmVQFPWahGA5NMTUG2j+/XbWTVQwWJyTQeftzlo10WVp06s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879514; c=relaxed/simple;
	bh=ombfN8dcwctGQIDrX4gg69cAW+VBHVNB6WsNUHBIZK0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jKw+01sPBSgJsq0EXznj+Vr63QpcMePiVG/GgVxgyvRniV8L6g2YRqxZzAGNOlR4ZxJ78m/ik35aGeKtHU5qPXQyurMJX83VcSJPGdxCFnJ3YhIEtQRi6cZ4fxNLWhRKWCj2kNK1vx8G/XBwEMRvd568AACJBUVLOVSzMcv8AyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nGANVuxp; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nGANVuxp"
X-UUID: aa27b35ac6de11f1b1788b6acf885367-20261013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=rDqvCfFDMa3gC0A3oF+Ew8YWszwVZlkqSrTz8bpprnM=;
	b=nGANVuxpoUWgs0ENFSTw6nGIwBX/8JWuxlzY9STA3o39hO7zD3uT7209cz+aLMsGGq5Hv4CXHDM4p2+e3zlsvvMMpMbdOu0L8EmxOLuhvSC9bssvLadhBh7TbM4HwQoq8S5CemWPoQ+lc/525QrxuJauSU8m5M3dTfXIfgZCCIc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:8e3c5d5b-680c-44d0-8615-24a86648ff57,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:291e20b,CLOUDID:520bb461-631c-4dbe-b8dd-a62f5130cbf8,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: aa27b35ac6de11f1b1788b6acf885367-20261013
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 194355010; Tue, 13 Oct 2026 16:18:26 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
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
Subject: [PATCH 0/2] Bluetooth: btmtk: fix ISO data reception
Date: Tue, 13 Oct 2026 16:18:21 +0800
Message-ID: <20261013081823.817996-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Two problems in btmtk_recv_isopkt(), both found while debugging LE Audio
on MT7925. The function is shared by every MediaTek USB controller that
supports ISO data, so neither is specific to that part.

Patch 1 stops the zero padding emitted by the ISO interrupt IN endpoint
from being parsed as ISO packets. The endpoint delivers one packet per
264-byte transfer and zero-fills the rest; the driver turns every four
zero bytes into a handle 0 packet with Data_Total_Length 0 and reports it
to the stack. A single transfer can inject up to 64 of them, which is
what fills the HCI log with malformed ISO frames, and a valid SDU is lost
whenever handle 0 belongs to a live CIS/BIS.

Patch 2 corrects the receive skb being allocated 4 bytes too small, so
that a 248..251 byte payload would be rejected with -EILSEQ.
HCI_MAX_ISO_SIZE is a payload limit rather than a frame limit, and the
allocation should reflect that.

The two hunks are independent, so patch 1 applies on its own if you would
rather not take patch 2.

Based on bluetooth-next.

Chris Lu (2):
  Bluetooth: btmtk: drop zero-length ISO packets from endpoint padding
  Bluetooth: btmtk: size the ISO receive skb to hold header plus payload

 drivers/bluetooth/btmtk.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

-- 
2.45.2

