Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6208F185B48;
	Tue, 22 Apr 2025 01:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745284929; cv=none; b=vGtCk7W9tIrMj/lwYyDsZHJpsV27CYidbNDF/ewc+GwE4Wl/pwmOPyKzAAFyOIDyh4mF1BF5TgE8Wv+H+cOM037N5Z0PZzwI/SkGvgxJI4wBEpYZbmbVciVx7nsET2ZbxiWvEVddGPDYLD6G2JzLxAUMjMt/VhU8mefg+icqSB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745284929; c=relaxed/simple;
	bh=d39wYXddYwuaCFz9yYCpeGTvr6DSC4adeaQeJ3iQTNk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NJk+PtGmJnvOWGyASD2akUaeYQB7oGt4miIbIxgvZ1Zff6jnE6oM2esoRjhideNCZ7HM7Z6EkoX5y8r7I06GCeBQUVnE+xI83QSh8krQOSvFFhbpsK7mnOr0pNnEjLoI9Kn0P2+GNIWpSCEL9/70iZXg2FFa8ybAk4MtwOWNJh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=tMFBaXbN; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tMFBaXbN"
X-UUID: 3084a2201f1811f0980a8d1746092496-20250422
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=bxJ9xVr+bWsUPq5pZ49UQFeAPTX6wfXQHs3mOpxc1y0=;
	b=tMFBaXbNxxwf9OgFiTzoYrMlMRznRhe4tMFtmWqtTVK1KrLor6X017UEnYugo70vT4dgwzZ1HoPy+kkpvrmVACUsu7XAyu59cmxPoARw1Q8lHrkynzwTUQFzGANgPdT0AHXccW31MBYq8Ci4dLOcwINAttv2dYqTeAl1KymjoSA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:a0e75468-70c9-4d68-b076-d12f9974bf89,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:b52ee08d-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3084a2201f1811f0980a8d1746092496-20250422
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1857275076; Tue, 22 Apr 2025 09:22:00 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 22 Apr 2025 09:21:58 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 22 Apr 2025 09:21:58 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Jiande Lu <jiande.lu@mediatek.com>,
	Will Lee <will-cy.lee@mediatek.com>, SS Wu <ss.wu@mediatek.com>, Steve Lee
	<steve.lee@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v2 0/2] Bluetooth: btmtksdio: ensure btmtksdio_close is executed before btmtksdio_remove
Date: Tue, 22 Apr 2025 09:21:54 +0800
Message-ID: <20250422012156.586600-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

If Bluetooth SDIO card is unexpectedly removed due to hardware removal
or SDIO issue, it is possible for remove to be called before close.
If an interrupt occurs during this process, it may cause kernel panic.
Therefore, it is necessary to ensure that close is executed before
remove to stop interrupts and cancel txrx workqueue.

Chris Lu (2):
  Bluetooth: btmtksdio: Check function enabled before doing close
  Bluetooth: btmtksdio: Do close if SDIO card removed without close

 drivers/bluetooth/btmtksdio.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.45.2

