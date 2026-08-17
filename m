Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E353AB47E;
	Mon, 17 Aug 2026 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960426; cv=none; b=s0aaTKsLAptE7IpY7LuOJH/gLacMIdp3Y6JNdmUST4AoTsiTrBMKSWNbpXFSe5eHUUDvyLS7vA1VW0Cb0YZUtjvVMiC+08V1XNK06yhJ8V8PlzSUhM3VEhYFtwlJ4e+CCIy1fd4Is2winaR/KnpCLZYyGGfJ5WHM5hEutBJiR4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960426; c=relaxed/simple;
	bh=ptglmIE8OTK2JUeG9XEi81G9PtO4seqBpkSTOJ3EHlI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OOYTS7cmH0gBGcVmUNtYkKluQf8/Gyc1iianhapdp6FI4JY2ArJaRa+v5GArSbh3Ok+HZPyhbnrJg1KYUYC2vi8yBicCJNN+2JdT/nuWSwymbY3EcHMnEtv15FObTFFhgYlLwvOFll4odds1wyNwzpTMy8GyN9aEj/JFvP1Z+Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Xyuvl0gA; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Xyuvl0gA"
X-UUID: 83a6874a9a2111f1b1788b6acf885367-20260817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+apygaq/YUCV3RE1Ys0Qckcc5sV7s5aZ8LqZEreUi9Y=;
	b=Xyuvl0gAAFAc+idcSEkjl4C4BnWLp+OhjwncljHeq+tyA+lr316SPmqLkiN9ttxMYe+6KwziWYlVDP8XA9kEK3TdyqXAM9p3OlXgeTSp7c/gfsKsMyNBfVoh48XSth1W+CBqF1KlqbJqr5ZgACM98IW0ZtfOgpPhH8RRQDAXYS4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:523a6b61-269e-445a-844c-2f348bdc6fb9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:f9f48ee2-71f1-405e-92eb-6802d6af74fd,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 83a6874a9a2111f1b1788b6acf885367-20260817
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1084708623; Mon, 17 Aug 2026 17:53:35 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 17 Aug 2026 17:53:34 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 17 Aug 2026 17:53:34 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH 0/2] Bluetooth: btmtksdio: Fix SKB handling in the TX path
Date: Mon, 17 Aug 2026 17:53:30 +0800
Message-ID: <20260817095332.182994-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

btmtksdio_tx_packet() rounds the SDIO transfer size up to the 256 byte
block size, but never grows the SKB accordingly, so the host controller
reads up to 255 bytes of uninitialised memory and sends it to the device,
and can read past the end of the buffer as well.

Patch 2 fixes that by padding the SKB with zeros. The padding is written
behind skb->tail, which is only safe once the driver owns the data
buffer, so patch 1 replaces the open-coded headroom check with
skb_cow_head() first. Patch 1 on its own changes no observable
behaviour, but it is a hard prerequisite, so both patches carry the same
Fixes: tag.

Both patches were previously part of a larger MT7928 series [1]. They
are unrelated to MT7928 and to the USB driver, so they are sent
separately here. The remaining parts of that series will follow as
separate topic branches.

Tested on a Chromebook with MT7921S: Bluetooth power on, then A2DP
connect and stream continuously for one hour without failure. The padding
added by patch 2 covers every packet whose length is not a multiple of
the block size, and the reallocation added by patch 1 covers every HCI
command, which hci_send_cmd_sync() always clones into hdev->sent_cmd.

[1] https://lore.kernel.org/linux-bluetooth/20260717072133.2858136-1-chris.lu@mediatek.com/

Chris Lu (2):
  Bluetooth: btmtksdio: Take exclusive ownership of the SKB before TX
  Bluetooth: btmtksdio: Fix out-of-bounds DMA read in the TX path

 drivers/bluetooth/btmtksdio.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

-- 
2.45.2

