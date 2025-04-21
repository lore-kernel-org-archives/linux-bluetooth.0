Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3407C1EB18A;
	Mon, 21 Apr 2025 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745220571; cv=none; b=nvzAu8R8OLEbGtlHFoOUEGH5EvPykQ4hjQ3TDHFB7KMfH8ZVO5lj+051zRhg4H5bZMb4OLnwXaCPRnwWXd/JybLnXA7ymsxnOSqe3mqezPniGEcT1BUI+ZMYRVFcsi682MVfxDDvhgbPv06IYMDl5yC66ayOPWyXFbPYhH6Rdbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745220571; c=relaxed/simple;
	bh=292FoGcHwUZgCucbDBEYlEZscqpkUAGLzivOGoUWhUQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=On2g87WhHvPeqEZr+RBtnmezWxXbEigS/PbeyeSLMtkokrCeiPDmQjVUNJH9fxSchJG72yWFMBVfuWN6p5+//m54kZAYjnq6i/KyPgaylxmOBkQh/o4pZaGTB6w/pZEwnC0xVIg/NFasKC15CwKGxJnVHeF18ff2i5EZH7CuSpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Yxms9N0o; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Yxms9N0o"
X-UUID: 57bee8961e8211f0980a8d1746092496-20250421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=MVirZaX7mqDjLeR4gMWjacsh/SmBHOzvxK+omyEcQhA=;
	b=Yxms9N0oPngqv0fZExw8/nmeYtcNkPhUEVR8TXPzXwbG5lFF2NHc9Jx2hpReiJFhj2k2Sojgj+oK9U+BRYUxt16cuXUTZLnJMBqh/JYGPIs+MoPpoPAhFk2XAKz+5eEk9H2J5ej0gJa+MTe1OLr2OZHAOdxg4L76uSyDv0/eq/A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:7c500bed-9d5d-4dc3-b726-0eadbfb984d5,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:09e67c8b-0afe-4897-949e-8174746b1932,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 57bee8961e8211f0980a8d1746092496-20250421
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1714880010; Mon, 21 Apr 2025 15:29:21 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 21 Apr 2025 15:29:20 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 21 Apr 2025 15:29:20 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Jiande Lu <jiande.lu@mediatek.com>,
	Will Lee <will-cy.lee@mediatek.com>, SS Wu <ss.wu@mediatek.com>, Steve Lee
	<steve.lee@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v1 2/2] Bluetooth: btmtksdio: Do close if SDIO card removed without close
Date: Mon, 21 Apr 2025 15:29:14 +0800
Message-ID: <20250421072914.466092-3-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250421072914.466092-1-chris.lu@mediatek.com>
References: <20250421072914.466092-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

To prevent Bluetooth SDIO card from being physically removed suddenly,
driver needs to ensure btmtksdio_close is called before btmtksdio_remove
to disable interrupts and txrx workqueue.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 3c66e3ee9834..c16a3518b8ff 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1447,11 +1447,15 @@ static void btmtksdio_remove(struct sdio_func *func)
 	if (!bdev)
 		return;
 
+	hdev = bdev->hdev;
+
+	/* Make sure to call btmtksdio_close before removing sdio card */
+	if (test_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state))
+		btmtksdio_close(hdev);
+
 	/* Be consistent the state in btmtksdio_probe */
 	pm_runtime_get_noresume(bdev->dev);
 
-	hdev = bdev->hdev;
-
 	sdio_set_drvdata(func, NULL);
 	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
-- 
2.45.2

