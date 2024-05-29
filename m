Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A8038DE8;
	Wed, 29 May 2024 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716964200; cv=none; b=GC/kozDYpAhOdSnhzxTlPvoaNW2ZomclNJLzZO5xtWOPNOihL6ZZiUO6ZgsajHG9DLQ0t6grshxvHRXnTvOYn1A6vt4uK/uVsld6t6eEjUU2W4mbYSyDq7sATb67YUkr3umkoM2h1d0FRHDJhoFJ2XbtgpukqhywynmyMeM54xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716964200; c=relaxed/simple;
	bh=yNc6c575wO24db/jZO4zY7I3tzRguESPoDF5QbE9vik=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=stREXJngOZtaqu+yVwpda9mRfWWhKAh3ML/wlNVNEQZnTbDsKv1N6rBbovSyIsZzuW+ZCPY9LcV4F/w+ntA39Zk+aowMTlW/CYzGefyN6GLxg5/trng+7a+HEz0f5MTX286rWoF96kBpd/sslRGww4NFKpSVLtCqlzEHu1GLnwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=lIyriiu/; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lIyriiu/"
X-UUID: daa1c1ca1d8411efbfff99f2466cf0b4-20240529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=hcavv1HUZOV2kpbFyPSmjWELv5BZ8Lp1wgJMCPBS5Og=;
	b=lIyriiu/9avvEGCB6E6Dg6Va18+yOVhK2mwdcFbipSrmLlcDs+34aSROWc/DsUBP+mC2CPiXtQvn/FCxuzKoGD4rp5TcyZCSs9dutw2/Qnlu0biOz9zGEr6y50MGsJbkaSiiX4aC/IosqBDHlewclfePlJgne3fOge2IMKH4Fbw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:e58c5c33-99a4-41c5-8a17-65ec32467035,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:832c5a93-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: daa1c1ca1d8411efbfff99f2466cf0b4-20240529
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1469422158; Wed, 29 May 2024 14:29:51 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 29 May 2024 14:29:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 29 May 2024 14:29:48 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v2 0/3] Bluetooth: btusb: MediaTek ISO data transmission support
Date: Wed, 29 May 2024 14:29:43 +0800
Message-ID: <20240529062946.5655-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.018000-8.000000
X-TMASE-MatchedRID: nzUT9qf9ruiopRmPeyAwLqMVgdN9w+TCjzwigoyOACRV1D0dmUzw/HBy
	D++CQ+qklGAD91lyLGe/W5EIysmFeG8f0ErdfVpsMJoQm3jo+mmENvZav9mwIXv3ioAd9KrS9Gb
	SSaq0f4NlEs7ay6jM0o8X8tv4W+1B5JVxYapKMGCWLCkl1lq7BytovaaHxlUrukphpDG2sc6jxY
	yRBa/qJcFwgTvxipFa9xS3mVzWUuCMx6OO8+QGviNDRblz//Syvq6Lo4Zo2hOKkyNgFcVMNKEq1
	CRF2XMzaQKqTUL7aor3Tv2Rn9W+/Xl2LFQeBovDI9tLypyWnhcSx1TcvNihU3mVKZusLp922v9O
	jYWA2uMMswg45VMfPadst5iAforfVlxr1FJij9s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.018000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	2CE555D1B8F43AB53DD8199D70524341E05A4676D3B9DB65AC2F429F4B069C272000:8

Since SIG hasn't clearly defined the specification about ISO data over USB
transmission yet, MediaTek adopts a method by adding an additional interrupt
endpoint for ISO data transmission which is different from current way
on Bluetooth upstream driver using existed bulk. Interrupt endpoint has
guaranteed bandwidth, sufficient max data length for LE audio packet and
support error checking. These characteristics are similar to the use of ISO data.

---
Change in v2:
-Fix warning report from bluez.test.bot in btusb.c, align with other
packet type to parsing dlen when getting iso data.
---
Chris Lu (3):
  Bluetooth: net: add hci_iso_hdr function for iso data
  Bluetooth: btmtk: add macro to get/set/clear MediaTek defined flags
  Bluetooth: btusb: mediatek: add MediaTek ISO data transmission
    function

 drivers/bluetooth/btmtk.c   |  35 +++++
 drivers/bluetooth/btmtk.h   |  46 ++++++
 drivers/bluetooth/btusb.c   | 295 +++++++++++++++++++++++++++++++++++-
 include/net/bluetooth/hci.h |   5 +
 4 files changed, 380 insertions(+), 1 deletion(-)

-- 
2.18.0

