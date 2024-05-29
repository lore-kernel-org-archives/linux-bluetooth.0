Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CFF15A855;
	Wed, 29 May 2024 03:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716953448; cv=none; b=JVykzRKHk/KLcKdqfrH2xazHAC+rcbefrtyTfbhR/czLDOIIHXtnZ1v5axKNYaIfLKhSV/nKZSIUjfSFiF1ZJ6sZ8kkdNbqbRvbg1Td2Zx/dOTVb2SWgSNeLh0OYl0S0nO2MsOs+DLM5p13n48X1pHH3zhE9y+t63sT5n2plaTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716953448; c=relaxed/simple;
	bh=xL9ffgj8ECADyDd5UAvUtyWmf7r5zRrwShyMG8xrDLg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HHcCf2VMABGi88hf5fRhMhtIPXPRNaG0yfZ/wkyE26K7QINBxJ1Ca2sUalX9LYvfiwa2xXUSS5/A5iyb9B3frU7ev/lAvJfTteFLkbsBka00QVzXu9nGstvmvLKn7d0SlDT9Xzs42D2dFxqbVTzyozsDpVbP/KlZeIR8z16EJFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hBnK7hz3; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hBnK7hz3"
X-UUID: d39c3e781d6b11ef8c37dd7afa272265-20240529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=K7lqLTLsGSV7DHnyTmq6v65NX0/0mNc9+lxlhGDwmvI=;
	b=hBnK7hz3Ei5k448cdIr1zIwLmnJLwVZxJPg1hqzzTRgdNvaBkW2BG4vbvUiI9hgtrlmI1woPig3oFC9ZXKiNiqsMk10M5jtEXFJhEqFMuFdrWkBsEe7ZG19xafPuH3veFr8Dx9fcRkMXpbxbNmqjxqkCmFJWfvhphPNcN6+75+g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:34f93bd7-f387-40f0-8f4a-197df445d090,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:f2c2ee43-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d39c3e781d6b11ef8c37dd7afa272265-20240529
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 176390028; Wed, 29 May 2024 11:30:42 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 29 May 2024 11:30:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 29 May 2024 11:30:40 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH 0/3] Bluetooth: btusb: MediaTek ISO data transmission support
Date: Wed, 29 May 2024 11:30:35 +0800
Message-ID: <20240529033038.28458-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Since SIG hasn't clearly defined the specification about ISO data over USB 
transmission yet, MediaTek adopts a method by adding an additional interrupt
endpoint for ISO data transmission which is different from current way
on Bluetooth upstream driver using existed bulk. Interrupt endpoint has
guaranteed bandwidth, sufficient max data length for LE audio packet and
support error checking. These characteristics are similar to the use of ISO data.

Chris Lu (3):
  Bluetooth: net: add hci_iso_hdr function for iso data
  Bluetooth: btmtk: add macro to get/set/clear MediaTek defined flags
  Bluetooth: btusb: mediatek: add MediaTek ISO data transmission
    function

 drivers/bluetooth/btmtk.c   |  35 +++++
 drivers/bluetooth/btmtk.h   |  46 ++++++
 drivers/bluetooth/btusb.c   | 293 +++++++++++++++++++++++++++++++++++-
 include/net/bluetooth/hci.h |   5 +
 4 files changed, 378 insertions(+), 1 deletion(-)

-- 
2.18.0

