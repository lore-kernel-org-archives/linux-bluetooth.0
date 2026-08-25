Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29979313547;
	Tue, 25 Aug 2026 03:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787629012; cv=none; b=e26gQshAc4GuN1N5zyhaKt9c+7KfxKdgvYL9jcl/vUNxt7OPHl8VNEUU0xt92C5UjikV0hYKyU+bJNW/K7X7+GWCnhfYByyQ6aznAbBYK013qioimRljDqzTHjTU3HGPLfpak4TE3/bUvsHFpKgo0dggzVNFt9rFXzOyC3KPii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787629012; c=relaxed/simple;
	bh=YDpx9mcj5XrNwAf4TJgFZyISmrGJdIJbBPKZdt/3u7U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i/Ld0UpwHa4vBZIWIfMuQAoYFcihjARtHUMmfWot5TxQS7AZzwdTLdzzz/y4tekB3LzCcZ2FO6McjK4TzqP2BJOHprcQqae/YLs4/kXNIC0rA/40GNoD61AoBCR2YTIZ4kvJ7b3PoCc3OV7htlkpDsUVHchG8UJ5O5oIbW0wR/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sM+wIYFg; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sM+wIYFg"
X-UUID: 2d4ffdc0a03611f18dc8c9802ae25ab1-20260825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=PVXP7JyQSs8OYWK+OQgStDZmgSbIG44BJIzJ8IlkJEQ=;
	b=sM+wIYFgPf5TjVfeqJFT1VbPuFGmPSlRbtW1m2rHFH0VhhAFohpV7RnYpzMUuhynjcV4jMjGmmJZ9fzB9ztNjKsHf/RdbSRtBW1Puqdgi4MSPBI01qowhLLf+vp4NASpGweTrtUZEDVVxoSJ3KUPQb5h7mbL2AR6LTg7jOQD2ns=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:fc1cc095-73b7-43fc-8f56-27f04dd77c96,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:a165a48f-75c4-4497-8020-eecee5178183,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2d4ffdc0a03611f18dc8c9802ae25ab1-20260825
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 120723677; Tue, 25 Aug 2026 11:36:37 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Aug 2026 11:36:36 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 25 Aug 2026 11:36:36 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH 0/2] Bluetooth: btmtksdio: Stop discarding the hardware device id
Date: Tue, 25 Aug 2026 11:36:32 +0800
Message-ID: <20260825033634.499118-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

btmtksdio_setup() reads the device id from register 0x70010200 and then
throws it away twice: an snprintf() overwrites the filename that
btmtk_fw_get_filename() derived from it, and mt79xx_setup() passes a
hardcoded 0 on to btmtk_setup_firmware_79xx().

Neither matters on supported hardware, since the device ids that would
make a difference - 0x6639, 0x7925 and a flavored 0x7961 - all belong to
parts with no SDIO interface. So this targets bluetooth-next with no
Fixes: tags. What it buys is that the two functions stop silently ignoring
their input, which is a trap for the next chip added to this driver.

Both patches come from a larger MT7928 series [1], where they were
described as fixing firmware load failures on MT6639, MT7925 and MT7928.
That does not hold for the SDIO driver and has been dropped.

Tested on a Chromebook with MT7921S, whose chip id register reports
0x7961: before and after, the driver requests
mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin, the firmware loads, and the
controller powers on and connects to an A2DP device.

[1] https://lore.kernel.org/linux-bluetooth/20260717072133.2858136-1-chris.lu@mediatek.com/

Chris Lu (2):
  Bluetooth: btmtksdio: Remove redundant firmware filename override
  Bluetooth: btmtksdio: Pass the hardware device id to mt79xx_setup()

 drivers/bluetooth/btmtksdio.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

-- 
2.45.2

