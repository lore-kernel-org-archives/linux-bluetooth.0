Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF0C40DB3B
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784796164; cv=none; b=bnyWTKhMULa4tGyzc2mceEgdfvJJx7BC44MHnSTAjscAxOaSaB6g+r7ybiAzqO8p1i3Aol61oNJRdCaiBopnlt/1q0c/nM6NeNPd4wi23RIJ+AxOslrx4v7eW7qKz0fPRrGd+kMqyO2XhYlGSixvq8EVUUQsnpYAdNM+sEYRs3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784796164; c=relaxed/simple;
	bh=q/RcMnJZ/diZPSy+yPe1SRpKSatTJiYsQ2Ul/0IvedI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e7oxV0BEo73Z5x2NgegDOFMl5CT2+FFNRnhorIcnnqV2PytVZvCXid2UGC7SXa2GzdHtf0kIVwozDPEVAjDR8XRJH0cFkg+fzWDpe7lD1bSdR2ZKX2vEOsURqVScpW5M15RYwgh6V4Ay6HacoA7XgbUlNfkIsBF0QStAntrH0Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 74ba065c867211f1aa26b74ffac11d73-20260723
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_LOWREP
	SA_EXISTED, SN_UNTRUSTED, SN_LOWREP, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:864396b3-c534-4ded-96c6-9f0b7b904fee,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:864396b3-c534-4ded-96c6-9f0b7b904fee,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:97653631e7977a864664749f4a638103,BulkI
	D:260723164237OCX6FZDL,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|850
	|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 74ba065c867211f1aa26b74ffac11d73-20260723
X-User: zuohongsheng@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zuohongsheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1356021096; Thu, 23 Jul 2026 16:42:36 +0800
From: zuohsh <zuohongsheng@kylinos.cn>
To: linux-bluetooth@vger.kernel.org
Cc: zuohsh <zuohongsheng@kylinos.cn>
Subject: [PATCH BlueZ] gatt-server: Fix integer overflow
Date: Thu, 23 Jul 2026 16:42:31 +0800
Message-ID: <20260723084231.93626-1-zuohongsheng@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By using size_t for realloc len and rejecting allocations exceeding
UINT16_MAX , to prevent truncation into the uint16_t field.
---
 src/shared/gatt-server.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 709a8f94b..328755566 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1174,12 +1174,12 @@ static bool append_prep_data(struct prep_write_data *prep_data, uint16_t handle,
 					uint16_t length, uint8_t *value)
 {
 	uint8_t *val;
-	uint16_t len;
+	size_t len;
 
 	if (!length)
 		return true;
 
-	len = prep_data->length + length;
+	len = (size_t)prep_data->length + (size_t)length;
 
 	val = realloc(prep_data->value, len);
 	if (!val)
@@ -1188,7 +1188,11 @@ static bool append_prep_data(struct prep_write_data *prep_data, uint16_t handle,
 	memcpy(val + prep_data->length, value, length);
 
 	prep_data->value = val;
-	prep_data->length = len;
+
+	if (len > UINT16_MAX) {
+		return false;
+	}
+	prep_data->length = (uint16_t)len;
 
 	return true;
 }
-- 
2.43.0

