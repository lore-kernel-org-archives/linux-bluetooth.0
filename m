Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15311922FC;
	Thu, 19 Sep 2024 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732179; cv=none; b=eBGEesw+nA6KulNSZrbQpM24HMjvkT6HFHotVXoqcWc+eTL3cRKWuZO6Gc7PPX/rBjQstwE4lva/76Pe2S2B7psHQkhFtwMC7z44iDYNFsOkfgPm2c0a/1WYONr1ARk+++JjUyOJgxPKpcPrwCxjCu1P0M7P1euNbziKn1Wowxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732179; c=relaxed/simple;
	bh=7Cr9VhPMDwnRNLiIL7+m8/3rWzCM49GIUfzF/MBixIE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tfR2nllFnNLcPpO+ADpe30XEYqnwrVWY4HtTVPWi1cWcHwORWvfjiIVDikQGMRtwfmDYsUUFRk2lv5xpk6RiWSvAx7aS14uEuneVfcYf/mYSZODzq0ytMSAuvCwHWkwSbVCrPAW6Zc77nq7/olnoi7Z3vpvf7inr/7ohgPY3P2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=h55JzmvB; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="h55JzmvB"
X-UUID: b38604cc765b11ef8b96093e013ec31c-20240919
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=O4TdeVTUr7HCvk3t4yV7pe/FuldFzTHqn08P93ET+3E=;
	b=h55JzmvB48JKLJT9CQV9OZCqus8PB7KxukOmptQkVSQCNnMEkLTxOoEUoRTtbY0DFkVm9emcrxuiw45zWVSKBAEY1eOtcJC60tKqMtKuarKdD9y08OpM5vuqBlDtfX1YBYTGgVAB6OHvDBS2Rc9/ZsaANZJ/WMwdlS2tVZQm/DE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:f34ad53a-6b7f-4e58-aa22-a6adbe531ffc,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6dc6a47,CLOUDID:7fdb3a9e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:1,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b38604cc765b11ef8b96093e013ec31c-20240919
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 530432070; Thu, 19 Sep 2024 15:49:29 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 19 Sep 2024 15:49:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 19 Sep 2024 15:49:27 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v2 0/4] Bluetooth: btusb: Mediatek ISO interface claim/release adjustment
Date: Thu, 19 Sep 2024 15:49:21 +0800
Message-ID: <20240919074925.22860-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.751400-8.000000
X-TMASE-MatchedRID: 6FmBHFM7d0n1c76/u1t0kEj2sPWKvtn0KFFZAe4nyZ77efdnqtsaE1UR
	GqiTsOWOCPoQvKo1bz0e8agj4OvcJXnYsjCinlm9cfsdX+Y7hRMrHkgIan9a0VO5j251EiYgMH1
	xx17eFtSpB8l8zTGMcnPdr6zR5iwi+uobhwVz9gBPuMJi/ZAk8e+aBTJJYa54wA2tjhGpvsYzvr
	CMQwONiqqs7oCmmNfOgDLqnrRlXrZ8nn9tnqel2LI7zVffJqTzvWUyOoXuNL+SJhCgyxh1ZWUif
	23WVRfSzqgzstWZKO+czQmXJSxDGH7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.751400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	07C2037D0F73455F3A943E6A55D24A843399C1CAA9788BDA70181087A5A186532000:8

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
---

Chris Lu (4):
  Bluetooth: btusb: mediatek: move Bluetooth power off command position
  Bluetooth: btusb: mediatek: add callback function in btusb_disconnect
  Bluetooth: btusb: mediatek: add intf release flow when usb disconnect
  Bluetooth: btusb: mediatek: change the conditions for ISO interface

 drivers/bluetooth/btusb.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

-- 
2.18.0

