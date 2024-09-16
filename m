Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067E54962E;
	Mon, 16 Sep 2024 11:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487692; cv=none; b=mbQkluoFNehLXQD8BhzCShy8WGLQ8btu9Iktsw5hSACfTfQM6lI516EMOQtmJBoliUB+510rTLk4P2go8zHvivnB03TriZFOWW5dhbwgobQBH/skou+XMBtTJqlYZgBSA9kIfFOWJmozodH65eXCW05U2HHQa2RyLmNoxitrn1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487692; c=relaxed/simple;
	bh=Hjcj1TGJjgWgp9A03PePIin+64eYkNyZdQQE86sW2MI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bRQTXXVFGRD9CF9D9D7OzbT2Y2MAVxCWNeibAoUk5jp0rzZ7EKQT9h2itTcJdTSVthYjPR0NTzSSXbGU99njhjh5r1R1Z9h2UODJQjaJjLAezGlqOY5iepNls0ZApF/YnMPyT26XDqUcqnduB4YON6JDfhpfB/zJ+UqHm8e0g5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=jhxDCcUQ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jhxDCcUQ"
X-UUID: 5d87228c742011efb66947d174671e26-20240916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=38IMJE5WIH2ScTHkA+IUKdspIObV4usS2GG6oZTIqTY=;
	b=jhxDCcUQfj8x1AKi4hfzAODBlr8VP2hVuJ/6phat2W4ZkOQMQ5eYNpqQrTUULMLD3K8f55nmec3VfvdqAKHuRbhtl82MumcyCuOQag8bP966h52AMdMXNZoXyaSObwlv0AHBA2MkiedNQlzAG/hNpubbeqWga7anHYDOO//1h9g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:27932da2-6919-4645-9469-0f9583d5e65e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:4e6317b7-8c4d-4743-b649-83c6f3b849d4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5d87228c742011efb66947d174671e26-20240916
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 715248476; Mon, 16 Sep 2024 19:39:42 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 16 Sep 2024 19:39:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 16 Sep 2024 19:39:41 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH 0/4] Bluetooth: btusb: Mediatek ISO interface cliam/release adjustment
Date: Mon, 16 Sep 2024 19:39:34 +0800
Message-ID: <20240916113938.30285-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

MediaTek performs some test on the platform which can support LE audio and
ISO data transmission with kernel driver. We found the additional interface
claim and release flow issue need some adjustment.

These patches mainly add a callback function within the usb_disconnect function
to prevent a kernel panic caused by interfaces not being released when the BT USB
dongle is physically removed. Additionally, the condition for claiming/releasing
ISO usb interface have also been adjusted to make driver works as expected.

Chris Lu (4):
  Bluetooth: btusb: mediatek: move Bluetooth power off in
    btusb_mtk_shutdown
  Bluetooth: btusb: add callback function in btusb_disconnect
  Bluetooth: btusb: mediatek: add intf release flow in usb disconnect
  Bluetooth: btusb: mediatek: change the conditions for
    claiming/releasing iso interface

 drivers/bluetooth/btusb.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

-- 
2.18.0

