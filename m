Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E5113C816;
	Thu,  6 Jun 2024 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717665832; cv=none; b=W7H3cltc7X744vQ9zlRUZh1C1XTv+TbFz9w3JrtZGCnwZxaEPp5wqEWQo/nYLOBHLaMnbkamoVnVQxLttL/AVzbNtdulPSDWFskM5G/cv60cjtkMIIn7t/XhFAONqTIabEVaOUYIJqk07/ruYovUBhXasXf6r0APlDIY3bMXFYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717665832; c=relaxed/simple;
	bh=wHvXWElO6jsBeJGkAS0R0PtO32uQ3rTua3ys+4HojWo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l+h0bv2uuGcuU9/P+UGbv0aNreUfHA6rJ2GhJHgL4vN4XF+mMuigoG4SAX2gvIXTFME9wi/YzHF6gWCpbiYXvzkFF6YsS9YoHHDG3d9ekoXOriGOSLHoHpaKlJBCWhkAb0H9ePFVpTYJDsPCOb/IaHVvXo1rd0KNaJ6OmjTZG/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OwR9xt3Y; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OwR9xt3Y"
X-UUID: 7932251623e611efa54bbfbb386b949c-20240606
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=XQ9ak821eXByMY+QdSWsGgzwxrORtfb3fHozOaAo82o=;
	b=OwR9xt3YPKMXqIzfxN5ForQ9TefvaOAYfWgSfg5qRCDC8GixaLr2DMYmFGmv1NnfmYgdYGKHjcbVhhfI1TGDg9hA38QQK5fTGOCHoOzHMukqiBz01K9zuntjHOYe6yyoSXWlF2DeEdWSI+eFDImfI2D5g5HM6EIh0nbfMns20/c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:6128a54c-2d4a-46eb-aa72-3378517682c3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:00d8c984-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7932251623e611efa54bbfbb386b949c-20240606
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 954380074; Thu, 06 Jun 2024 17:23:45 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 6 Jun 2024 17:23:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 6 Jun 2024 17:23:42 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v3 0/4] Bluetooth: btusb: MediaTek ISO data transmission
Date: Thu, 6 Jun 2024 17:23:36 +0800
Message-ID: <20240606092340.27675-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.321600-8.000000
X-TMASE-MatchedRID: Xmc9pn+G6/3aYQdwXEMf70j2sPWKvtn0DRi0jfY6gL1oNGY/OdYkWWAI
	1go6d1sNmMN+S0FpW+8dHzBmTYIGm/Iejw19Z0aTuIwLnB3Aqp1A8I/PJy4EU70rWM4nIpJrA4e
	V6z+cHCdlEs7ay6jM0o8X8tv4W+1B5JVxYapKMGA0JY9d6s3vaRQK/sD1nu4xq8z7POX8FJNdpM
	SiKlvaL+LzNWBegCW2wgn7iDBesS15zdAzex5xZnyYiUbOQn1QobgMoGjAF6AlHeB0Vcx6dQHeq
	RoPqTlD98lGCtircYmUTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.321600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	86E486E2C6DC60E90F5EAA27F591247998E9FC8835B962B9047EC150F0EBA8742000:8

Since SIG has not yet clearly defined the specification for ISO data
transmission over USB, MediaTek has adopted a method of adding an
additional interrupt endpoint for ISO data transmission. This approach
differs from the current method used in the Bluetooth upstream driver,
which utilizes existing bulk endpoints. The interrupt endpoint provides
guaranteed bandwidth, sufficient maximum data length for ISO packets
and error checking.

Certain new functions related to USB transportation, such as urb
allocation and submission, are implemented in btusb.c to leverage
existing functions and data structures defined therein. Meanwhile,
vendor-specific functions unrelated to transportation have been moved
to btmtk.c to streamline btusb.c.

Chris Lu (4):
  Bluetooth: net: add hci_iso_hdr function for iso data
  Bluetooth: btusb: add callback function in btusb suspend/resume
  Bluetooth: btmtk: add macro to get/set/clear MediaTek defined flags
  Bluetooth: btusb: mediatek: add ISO data transmission functions

 drivers/bluetooth/btmtk.c   |  92 ++++++++++++
 drivers/bluetooth/btmtk.h   |  61 ++++++++
 drivers/bluetooth/btusb.c   | 276 ++++++++++++++++++++++++++++++++++++
 include/net/bluetooth/hci.h |   5 +
 4 files changed, 434 insertions(+)

-- 
2.18.0

