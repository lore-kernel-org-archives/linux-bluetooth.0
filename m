Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1A3FC0A;
	Thu,  4 Jul 2024 06:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720072885; cv=none; b=sMj6W70fxvu4DsXyJrz2CnyVcM0XRU1Hq1K5R6e4RUIyf4ziN52CB57F427FjYW7SBRUWPhDT4fJeR3A0xv5O4E3LJDFmLa8ntwicoHyfs95VXhsSML6nKFhBHhtNxjEcNCdkObai5cq5kkwbL6dYudNIhqPCCRpb35O9VNgkKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720072885; c=relaxed/simple;
	bh=TZp6LdQbekxg8ujIj8CtUQp6tbSZVNMc97I066qFnMI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PDS7J2IuJNojKH0tIaiVgf5Fvtwd9GJ3X8yqPpYJDMbebM/9/dUC/7BuzvP4I+8G69JAFjliAaY5qekRQWtDaDD31YFlAtWd6dpcQVdFWWWBRZQsolHpy9N0QyxEdAeMm0mnwxn3bJPu08W+GlXJJCACB6tip+izs8mNIF27j2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=S5Clwi6a; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="S5Clwi6a"
X-UUID: d4e91cc639ca11ef99dc3f8fac2c3230-20240704
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=XZ2w6rgUW63JWu5hiwpZZVRpDZ9Lbj5AyGKEHyG2EUk=;
	b=S5Clwi6aBiL8tcs4QEns+h/3yY/pMSWEkrH0M5JeHCQ8br2LiPVhNRmA4e1CD6/58I64NTcVylyAmful2cwtw9/n9iJX2/6/1tMpwATdIsiGJEpKDxNk1KEILi/Jd5emv25ecC2Z7FI2ZKTqPp8qbk7qgCWb4V8R88r6BfzPl90=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:81348ee9-7ff1-48f0-a228-ca36c0b1a75b,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:ba885a6,CLOUDID:1962f0d4-0d68-4615-a20f-01d7bd41f0bb,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:1,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d4e91cc639ca11ef99dc3f8fac2c3230-20240704
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1099953806; Thu, 04 Jul 2024 14:01:18 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Jul 2024 23:01:18 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 4 Jul 2024 14:01:18 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v7 0/8] Bluetooth: btmtk: MediaTek ISO data transmission support
Date: Thu, 4 Jul 2024 14:01:08 +0800
Message-ID: <20240704060116.16600-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

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
Change from v6 to v7:
-Change MediaTek's specific suspend/resume function naming to
btmtk_usb_suspend/resume and add comment to explain the purpose of function.
---

Chris Lu (8):
  Bluetooth: btusb: mediatek: remove the unnecessary goto tag
  Bluetooth: btusb: mediatek: return error for failed reg access
  Bluetooth: btmtk: rename btmediatek_data
  Bluetooth: btusb: add callback function in btusb suspend/resume
  Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c
  Bluetooth: btmtk: move btusb_mtk_[setup, shutdown] to btmtk.c
  Bluetooth: btmtk: move btusb_recv_acl_mtk to btmtk.c
  Bluetooth: btusb: mediatek: add ISO data transmission functions

 drivers/bluetooth/btmtk.c     | 1067 ++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btmtk.h     |   91 ++-
 drivers/bluetooth/btmtksdio.c |    1 +
 drivers/bluetooth/btmtkuart.c |    1 +
 drivers/bluetooth/btusb.c     |  751 +++--------------------
 5 files changed, 1227 insertions(+), 684 deletions(-)

-- 
2.18.0

