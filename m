Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D4B1EEA31;
	Wed, 20 May 2026 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779243329; cv=none; b=F+CnfhfKXVBYK6FnRXGLHa+SSyB4ioUFqYecW7cd+oWyNa9IlZPnZwSTHugItmDHgPoDlV7XyTM7EJvRNAKdJl9nKTBRhkanAsFuhLMOUK2U2PVdbvoUZltlXayG9nCUhdIYhDXm+I9fY5eL+yPO08UM1MzrtZtGKlPL+Oqmm90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779243329; c=relaxed/simple;
	bh=IlFcVSGYnP4CZioj5QK3amPqVXAoqDwpqd7DjVHMmUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QR3xFWx9PBMLFlMB8dHQMtCkCDEcTOIc7BqqivoXSjMqOZ8XlJFPF3Aw12pkET3wNhPDM/qzOICCnko9bxMUgPjrNpafGVoDbdHFF3+CpGVMKxuY4ynvziI6y52N5NQMr0oXMu5XTekJZa1e0SSjgSx4fJGLFAaSXZPSu4hR8Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c0371a2e53f111f1aa26b74ffac11d73-20260520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:5f95d278-0ca8-4f62-be13-634d09b3a2a4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:887d1953b4785460769cf36a49e66563,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c0371a2e53f111f1aa26b74ffac11d73-20260520
X-User: liujiajia@kylinos.cn
Received: from nature.lan [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liujiajia@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 909766949; Wed, 20 May 2026 10:15:20 +0800
From: Jiajia Liu <liujiajia@kylinos.cn>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Jiajia Liu <liujiajia@kylinos.cn>
Subject: [PATCH] Bluetooth: btmtk: remove extra copy in cmd array init
Date: Wed, 20 May 2026 10:15:00 +0800
Message-ID: <20260520021500.13504-1-liujiajia@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In btmtk_setup_firmware_79xx, the data length indicated by wmt_params.dlen
in the cmd buffer is MTK_SEC_MAP_NEED_SEND_SIZE + 1. Except for the first
byte, the remaining length is MTK_SEC_MAP_NEED_SEND_SIZE. memcpy copied one
more byte to cmd + 1 than the remaining length. Align the length passed to
memcpy to avoid exceeding current section map.

Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
---
 drivers/bluetooth/btmtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index ea7a031000cd..53cba71cb07f 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -188,7 +188,7 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 				       MTK_FW_ROM_PATCH_GD_SIZE +
 				       MTK_FW_ROM_PATCH_SEC_MAP_SIZE * i +
 				       MTK_SEC_MAP_COMMON_SIZE,
-				       MTK_SEC_MAP_NEED_SEND_SIZE + 1);
+				       MTK_SEC_MAP_NEED_SEND_SIZE);
 
 				wmt_params.op = BTMTK_WMT_PATCH_DWNLD;
 				wmt_params.status = &status;
-- 
2.53.0

