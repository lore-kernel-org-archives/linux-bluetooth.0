Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE19188A3A;
	Tue, 22 Apr 2025 01:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745284929; cv=none; b=LF7LUIJOGLfc5rgVte6/JjdP4kxPsWXPYjwkNXZrsifqt7YnsLUnzVAwWU/35D5dLRV5VKlbh1rIMlcqzYKIhs3rrywzHQUpSEHkwSNZwCAnYkhZCF7yGnZrEJ+6fSjSdBApYh8TQ3LazXcFpARxukBc+kBKrIhBZMp+09NEwhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745284929; c=relaxed/simple;
	bh=6QGlnw2jHwXkkNNCoM1dUt1McE6mBt7MX34pDSc84wM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQ1YyuZN1gu5qE3BweY4itLBRkh5cEmfclY/PGKmydqK5gHF9LH+WtOpG0VGZZ0es56FIT/sGNRupFek44DELkyS56L/6vTA0Uahehcy91zO8JA4lt/3IRemqS6yiZFuaHQi5ngbUWRFr7ZBJbZfq7V0LpKlNbv3nSIEchPQ8SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JiZWUFFC; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JiZWUFFC"
X-UUID: 319b27b01f1811f09b6713c7f6bde12e-20250422
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xmyijcP5S2sV/ccF3DyXRzQkQCOzGZ8LtuwtyLN4L88=;
	b=JiZWUFFClsTHw/KvoJZfIfhDY+fbf3d+T9V4UUdZBwoFl5Jec8SEjLu6mzspu8cJcj1ZyMTlbQwJI2VFTcpEH1pO/QlfFlE5H8cbdcapOlVOFAidndxhm8PSnAYy5EiPq6croBWlEblE4JkxyS0juoJ1V0OQ98rIYBAy248AVFI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:e0818ab1-38ff-4dc6-894f-ac8f6648e3ba,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:195b58a6-c619-47e3-a41b-90eedbf5b947,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 319b27b01f1811f09b6713c7f6bde12e-20250422
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1252919819; Tue, 22 Apr 2025 09:22:02 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 22 Apr 2025 09:22:00 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 22 Apr 2025 09:22:00 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Jiande Lu <jiande.lu@mediatek.com>,
	Will Lee <will-cy.lee@mediatek.com>, SS Wu <ss.wu@mediatek.com>, Steve Lee
	<steve.lee@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v2 1/2] Bluetooth: btmtksdio: Check function enabled before doing close
Date: Tue, 22 Apr 2025 09:21:55 +0800
Message-ID: <20250422012156.586600-2-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250422012156.586600-1-chris.lu@mediatek.com>
References: <20250422012156.586600-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Check BTMTKSDIO_FUNC_ENABLED flag before doing close to prevent
btmtksdio_close been called twice.

Fixes: c4233afb9a ("Bluetooth: btmtksdio: Prevent enabling interrupts after IRQ handler removal")
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 566c136e83bf..3c66e3ee9834 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -723,6 +723,10 @@ static int btmtksdio_close(struct hci_dev *hdev)
 {
 	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
 
+	/* Skip btmtksdio_close if BTMTKSDIO_FUNC_ENABLED isn't set */
+	if (!test_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state))
+		return 0;
+
 	sdio_claim_host(bdev->func);
 
 	/* Disable interrupt */
-- 
2.45.2

