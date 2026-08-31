Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D6D1C6FF5
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 01:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788140826; cv=none; b=Mv0dKg6Xozc3WFOIgvF2aC3HgVEMUjJXW20PZsFgczKeZ6DLd8xA5n/tE3MRjwTfavaIXmwV9/kMnDQdrOFa71ra53sOvMbyr3mLWJLAcdboI53HzszcX19KYA0MSTv1Yka48/wOr8FRI6Ny+6Ia4VH1KA+eI5xAdWsuyNJ5wGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788140826; c=relaxed/simple;
	bh=SdT9+nz/5j9cGoCHm9ULP7U7jCw0edTfveH67fnJJeg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=MkHLQTgTuunZ0prZbeAAvPNFIWcCbNxpAxpyH7bUFnxevHDd1iLZWBXpczfQOY2sUUIOvfOFja5zXw9TOZMVQXrPm29yoWz/wsmmXPkm2COZO5r5jL7dkepJnfz3x5HOcsRPjbJs+frZKsgQNOo4Vl02GDaV7XI3+BdEWW8YMXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d9d0b64ca4dd11f19a56ed5b684f684d-20260831
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a23ad594-aab1-4dd7-9a72-c70f788451db,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:51969239c759ede337f1b65f487211ee,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d9d0b64ca4dd11f19a56ed5b684f684d-20260831
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1285041527; Mon, 31 Aug 2026 09:46:57 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH v6] Bluetooth: pm: use DEFINE_SIMPLE_DEV_OPS for pm struct
Date: Mon, 31 Aug 2026 09:46:38 +0800
Message-Id: <20260831014638.123808-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

use DEFINE_SIMPLE_DEV_PM_OPS for btmrvl_sdio_pm_ops, and add the value of
'.freeze, .thaw, .poweroff, .restore'. if these address are null,
may cause error in s4. pm_sleep_ptr() to safely drop the references without
triggering compiler warnings. This macro automatically handles
CONFIG_PM_SLEEP configuration and generates freeze/thaw/poweroff/restore
callbacks, reducing boilerplate code.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
Changes:
-Corrected grammar and spell errors in comment.
-Replace SIMPLE_DEV_OPS with DEFINE_SIMPLE_DEV_OPS.
-Add a description of pm_sleep_ptr().
-Add pm_sleep_ptr(&btmrvl_sdio_pm_ops) for bt_mrvl_sdio struct.
---
 drivers/bluetooth/btmrvl_sdio.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index b91fc63bc9fe..a250a83a031d 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1726,10 +1726,7 @@ static int btmrvl_sdio_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops btmrvl_sdio_pm_ops = {
-	.suspend	= btmrvl_sdio_suspend,
-	.resume		= btmrvl_sdio_resume,
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(btmrvl_sdio_pm_ops, btmrvl_sdio_suspend, btmrvl_sdio_resume);
 
 static struct sdio_driver bt_mrvl_sdio = {
 	.name		= "btmrvl_sdio",
@@ -1738,7 +1735,7 @@ static struct sdio_driver bt_mrvl_sdio = {
 	.remove		= btmrvl_sdio_remove,
 	.drv = {
 		.coredump = btmrvl_sdio_coredump,
-		.pm = &btmrvl_sdio_pm_ops,
+		.pm = pm_sleep_ptr(&btmrvl_sdio_pm_ops),
 	}
 };
 
-- 
2.25.1

