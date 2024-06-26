Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9238BEF;
	Wed, 26 Jun 2024 02:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719370426; cv=none; b=p1QsauGgDAy5VCTux8YgV5jvHpCjtS5Lkz/3GZsumnwbVGip8Fob5nvSaQZtxukhZvXrb59zhXWqmLBSxk7s9yb+ofvcQj4riisQDztQ/NfBR5rUUv6rqxf7c7LzI9OSYaBOSA8cRA+u0F/eRAEpEW6hrONQoRiHfUUjLKIaAws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719370426; c=relaxed/simple;
	bh=uKy0SbbFL4gQfYPaiaVjsbDKiqx+kG2iwEAOHH5Pd44=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OGJC2JsWxo0jX1i6FH8kYhKTGN0sXxkkckT3Ew2VGTMfYFyPHEHI11oqXTDssaRaBBGIIEN+pxvEXuxM3818e0l7KyiuBqjG9F/6+UIs1s7iV3E0ueg+e9jm9rU4vnK9z2CuQoD4zsejfZ7oMX5k7Kd+mO44On3mecKrZb4Gnf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=on4FJmcA; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="on4FJmcA"
X-UUID: 49b8c19c336711ef99dc3f8fac2c3230-20240626
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=xrJjjex+pryUYcuqmpL7n9xnY0OIkC6OfRPDoOD75a4=;
	b=on4FJmcAK8UfFLr4Z0OySR1g8mrTgXm4bX66B5jNtbBbkWfSc0NeBAJN8CuJ27dRp4f5RkAWeQiDn+B8v7bVh/kwbQ88nVoCMiAgTX0ASyjk8t0F8J18F5f/jVwwPxNsjShLSYraUr6X0SUe0/GQPL+t7UjSkllFg2TBY7hixc4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:afb2df67-a6f9-4780-a2ce-5ec9aab44715,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:51b08985-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 49b8c19c336711ef99dc3f8fac2c3230-20240626
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 584761978; Wed, 26 Jun 2024 10:53:38 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 26 Jun 2024 10:53:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 26 Jun 2024 10:53:36 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v5 0/8] Bluetooth: btmtk: MediaTek ISO data transmission support
Date: Wed, 26 Jun 2024 10:53:21 +0800
Message-ID: <20240626025329.26424-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.948900-8.000000
X-TMASE-MatchedRID: cjXKuyuuhFvaYQdwXEMf70j2sPWKvtn0DRi0jfY6gL1oNGY/OdYkWWAI
	1go6d1sNmMN+S0FpW+8dHzBmTYIGm/Iejw19Z0aTQpxiLlDD9FUTdZ2aR9/IIMA5YKm8dwM65iW
	++W4offuhgX3ZJWxx+ebscccSLJTlMkaIaLbJ6ufISPeZE8elXnN3sLsG0mhuR2YNIFh+clGdvq
	NEU7XXSK9TdAKl5NW53/0OX7sbFJq2ILqdj6sZoJciNJzaqUX1ftnnpG0AB3WdohxAwFG9tKPFj
	JEFr+olwXCBO/GKkVqOhzOa6g8Kre1QnRQ5v628yJPOovzJLNdhUoDdzioa4qH4ldHLhRgbcGLq
	LRUkZt5DDKa3G4nrLQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.948900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 15C7CBCC36B7D4F50908B845C25BFD85F7EA021A19AF33C3DB8295A3D7DA76782000:8

Since SIG has not yet clearly defined the specification for ISO data
transmission over USB, MediaTek has adopted a method of adding an
additional interrupt endpoint for ISO data transmission. This approach
differs from the current method used in the Bluetooth upstream driver,
which utilizes existing bulk endpoints. The interrupt endpoint provides
guaranteed bandwidth, sufficient maximum data length for ISO packets
and error checking.

Driver sets up ISO interface and endpoints in btusb_mtk_setup and clears
the setup in btusb_mtk_shutdown. These flow can't move to btmtk.c due to
btusb_driver is only defined in btusb.c when claiming/relaesing interface.
Once ISO interface is claimed, driver can use specific interrupt endpoint
to send and receive iso data. ISO packet anchor stops when driver
suspending and resubmit interrupt urb for ISO data when driver resuming.

---
Change v5:
-Add two patch MediaTek submit previusly
-Remove v4,1/4 & v4,3/4 , becasue it's not necessary
-Add patch to move most function from btusb.c to btmtk.c to make btusb.c more simple
-refactor MediaTek ISO transmission function and implement in btmtk.c

---

Chris Lu (8):
  Bluetooth: btusb: mediatek: remove the unnecessary goto tag
  Bluetooth: btusb: mediatek: return error code for failed register access
  Bluetooth: btmtk: rename btmediatek_data
  Bluetooth: btusb: add callback function in btusb suspend/resume
  Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c
  Bluetooth: btmtk: move btusb_mtk_[setup, shutdown] to btmtk.c
  Bluetooth: btmtk: move btusb_recv_acl_mtk to btmtk.c
  Bluetooth: btusb: mediatek: add ISO data transmission functions

 drivers/bluetooth/btmtk.c | 1058 ++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btmtk.h |   93 +++-
 drivers/bluetooth/btusb.c |  751 +++-----------------------
 3 files changed, 1218 insertions(+), 684 deletions(-)

-- 
2.18.0

