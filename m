Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6E6440648
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 03:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787283152; cv=none; b=aCj/iUUWcQg1wQwtQjn+LTGGiwn3Bwq2uqwVMICYws6/J+pRCN4AeJSAgHeqgY8mBFnXF0afUVqn3del1MvXboVsZJhEgHa4e8WRhxV3g5tPJPEOWAfzYPymqkyk8j78Z/cxgk35/bFjz/JrgXN3td2d6WOaTiBDy0QAhKak+aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787283152; c=relaxed/simple;
	bh=7sqrZko+E8kFHB4oBPgmE1rlw38GGAIqmPQRovdQkgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxqV82m/OmMld3H94rZHChYotiHsitqA17ggG2PVb5ADw2E0uiu4I8H84PT+sN35fqR3M3ScMCh9oC8YA/Gi52sLluDbubgd4lf5nappUGaH89Z6af9c7zGohS17g9DAxbcREIPYKBG9TAIKx97EHTiPtseH3Ie1VgEgIyfxIbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ea47e7909d1011f19a56ed5b684f684d-20260821
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:efc32fa9-b820-4469-8b43-9b8f8efed34a,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:efc32fa9-b820-4469-8b43-9b8f8efed34a,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:ba45afa239db0e9ffa70aa12ce6043e2,BulkI
	D:2608211130244FAODLUV,BulkQuantity:1,SF:17|19|66|78|81|82|102|127|850|865
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ea47e7909d1011f19a56ed5b684f684d-20260821
X-User: zuohongsheng@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zuohongsheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 572295357; Fri, 21 Aug 2026 11:32:20 +0800
From: zuohsh <zuohongsheng@kylinos.cn>
To: linux-bluetooth@vger.kernel.org
Cc: zuohsh <zuohongsheng@kylinos.cn>
Subject: [PATCH v2] gatt-server: Fix integer overflow
Date: Fri, 21 Aug 2026 11:31:51 +0800
Message-ID: <20260821033214.82863-1-zuohongsheng@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723084231.93626-1-zuohongsheng@kylinos.cn>
References: <20260723084231.93626-1-zuohongsheng@kylinos.cn>
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
 src/shared/gatt-server.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 709a8f94b..1ec826a69 100644
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
@@ -1188,7 +1188,10 @@ static bool append_prep_data(struct prep_write_data *prep_data, uint16_t handle,
 	memcpy(val + prep_data->length, value, length);

 	prep_data->value = val;
-	prep_data->length = len;
+
+	if (len > UINT16_MAX)
+		return false;
+	prep_data->length = (uint16_t)len;

 	return true;
 }
--
2.43.0

Handle the CheckPatch failure reported by BluezTestBot.
