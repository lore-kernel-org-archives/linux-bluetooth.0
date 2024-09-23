Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DFD4776E;
	Mon, 23 Sep 2024 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727081236; cv=none; b=nV24ns6D/r2Kmp/kOKaPJrGKNSjtI81KdBP0HjCDCz5JyTNwRx9MWrCIeWDODes21q9b7F9vgyiikjx1N0qj64mtMzTD4DAPwplLCqK/6OHhsnzJqlGiroRptkZILcEsxU1Wudnf8BmtwslcerHe8kuOALxLVI2t5c71BixhUDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727081236; c=relaxed/simple;
	bh=0gS3t9FFgQOXGmaMzim8FVgg3aHxhDLWvQG1yupXzqI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MESJRcukB2wq8TAw4Mon7BZCnhchekAkQF6aYmfj4E4UpTFUKg0ZuVS0PUzvKMG1f/y61AIOtksde79zmgNGHmkmUc9e/3dw0vA5/n47skr3G4ooWQ5CszvOZetXvYDV5iMNriwJ+4djYqGRDLdNCnQQhjNRcdYpsIHOSTl+WDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gBAR75iP; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gBAR75iP"
X-UUID: 6ae0faee798811ef8b96093e013ec31c-20240923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=FzLvhQcWZsQvjaoIgoAliOI/aIPhR/X+B9IVKKAWhVI=;
	b=gBAR75iPR01t38eeefwFVzIybCrZ01ooVXKarT+fJKRsccUPrp8+9KsWDUDnZHL86RphuwQ5/UbJaHYRLS+yDyj6Y+t0nJDIUYBu+BRbZi3GsY2UK3jDUo1lfxbSbZPckYJjELpOm1p5n+dUWHXgpIhVwpq++3sBYP4oFOxUxH8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:fb60ca85-8bfe-4f86-bf67-95ef428e79d5,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6dc6a47,CLOUDID:d5276a9e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:1,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6ae0faee798811ef8b96093e013ec31c-20240923
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1685664799; Mon, 23 Sep 2024 16:47:08 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Sep 2024 16:47:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 23 Sep 2024 16:47:08 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v3 0/4] Bluetooth: btusb: Mediatek ISO interface claim/release adjustment
Date: Mon, 23 Sep 2024 16:47:01 +0800
Message-ID: <20240923084705.14123-1-chris.lu@mediatek.com>
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

These patches mainly add a callback function within the usb_disconnect
function to prevent a kernel panic caused by interfaces not being released
when the BT USB dongle is physically removed. Additionally, the condition
for claiming/releasing ISO usb interface have also been adjusted to make
driver works as expected.

---
v2: fix commit message typo and over maximum chars per line warning.
v3: [patch 3/4] add new function btusb_mtk_disconnect for releasing MediaTek
                ISO interface
    [patch 4/4] remove redundant condition statements
---

Chris Lu (4):
  Bluetooth: btusb: mediatek: move Bluetooth power off command position
  Bluetooth: btusb: mediatek: add callback function in btusb_disconnect
  Bluetooth: btusb: mediatek: add intf release flow when usb disconnect
  Bluetooth: btusb: mediatek: change the conditions for ISO interface

 drivers/bluetooth/btusb.c | 41 +++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

-- 
2.18.0

