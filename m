Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B763D472F95;
	Wed, 22 Jul 2026 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706210; cv=none; b=j+remPrfxFD5UOLKY6mEnGne6S7zztiip+Rn6VbatYzV18oOXqJBDUbXkPVrXIBlnCpbl7gLiAtaOC/u2HGPRtB3GmMWa3sZFtCHeWhbqhOGR6AH9WMnJg3C/Khpw5xZy/4ZhEZ0cwTWBdFgmlFdjQc6ey4J7Tqhe36PjZq+nr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706210; c=relaxed/simple;
	bh=WcM6FO6Cg7QPz1OrbWLVal1+nvZxMj2xaNZlVgj2Wyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gDyHZ+Zu6N3Jh5aDaN57TEl9L/O4i8g7AnXLPMo8J94KLjrSDJk6UkhCWlK0o0FObDOYVqlC98CGePx5s+tsfzDkQ2eMhp9GZoSlgCqw8CURH8fpyTactO+/NHAGVJnS/mVOtI+7Cwsl75vi75BzoIY7/ZyX7KbCbWeQODf0aJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 020538d885a111f1aa26b74ffac11d73-20260722
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c1db5c82-ccef-4c59-bdfd-6a3879baacb3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:0f27bca146efcdd0efd8790d3174ca56,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 020538d885a111f1aa26b74ffac11d73-20260722
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1063080780; Wed, 22 Jul 2026 15:43:19 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ccc194101@163.com,
	Chen Changcheng <chenchangcheng@kylinos.cn>
Subject: [PATCH] Bluetooth: btintel_pcie: Remove unreachable break after goto
Date: Wed, 22 Jul 2026 15:43:15 +0800
Message-Id: <20260722074315.166919-1-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the switch-case block for hardware variant detection, the
default case has an unreachable 'break' statement following
'goto exit_error'. Remove the dead code.

Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
---
 drivers/bluetooth/btintel_pcie.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 2b7231be5973..50929e3e50f4 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2363,7 +2363,6 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 			   INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
 		err = -EINVAL;
 		goto exit_error;
-		break;
 	}
 
 	data->dmp_hdr.cnvi_top = ver_tlv.cnvi_top;
-- 
2.25.1

