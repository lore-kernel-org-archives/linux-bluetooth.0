Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A205E26A1AC
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 06:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787120635; cv=none; b=kYgQJVUqnyzcEaMCyMdsXUB2CeEVRDHMppGrB0XKLdElGBeuIyzO1MfJP0QPAU3WmW1NAUcOttg9PgGUQJ5rjunAJRhg1p91VRXqqFYRImv9+3XES/swbwLdyiyMP1kbi6fr6PymWsTRV1mWfE3oL7p1XmhMU2BDc1jZEJcjB1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787120635; c=relaxed/simple;
	bh=c86hLblBIO3lmEuqJU8On0dsgo3xUNivIPQ3Gs7YcL0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ueOQfLgLZuw1po1VqWjVmvHWySJQZOyNVTNKPiOEgt+qLAp5NDlPKMceSMFH0j+/qroHHSGr5oTr9FtvfJpI7o36SlNIrZSzvM+Tm+EycY83aMs06VR++WS9batuQoMDxzrTCg5pz7iI/PPOVyAaeDRfd0BUAgFPJdBk08VTt5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8a32e6149b9611f19a56ed5b684f684d-20260819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:9d8dca89-a040-4b6d-b1e4-7a7141de6720,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:f0691bc6c80bc37b37acc2e9672f3ecc,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8a32e6149b9611f19a56ed5b684f684d-20260819
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 798721394; Wed, 19 Aug 2026 14:23:49 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] bluetooth: pm: use SIMPLE_DEV_OPS for pm struct
Date: Wed, 19 Aug 2026 14:23:34 +0800
Message-Id: <20260819062334.2410737-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

use SIMPLE_DEV_PM_OPS for btmrvl_sdio_pm_ops,and add the value of
.freeze .thaw .poweroff .restore.if these address are null, may cause
error in s4.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 drivers/bluetooth/btmrvl_sdio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index b91fc63bc9fe..197237e78a3c 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1726,10 +1726,7 @@ static int btmrvl_sdio_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops btmrvl_sdio_pm_ops = {
-	.suspend	= btmrvl_sdio_suspend,
-	.resume		= btmrvl_sdio_resume,
-};
+SIMPLE_DEV_PM_OPS(btmrvl_sdio_pm_ops, btmrvl_sdio_suspend, btmrvl_sdio_resume);
 
 static struct sdio_driver bt_mrvl_sdio = {
 	.name		= "btmrvl_sdio",
-- 
2.25.1

