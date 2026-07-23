Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF633E49DD
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784795747; cv=none; b=I87S6PfqEvTGFAcwHvHb+vOOUqOfLkYFcF//mm3QmN9+X2dQeJwWCi+Fsbo/xPzrG5nedol91Sce4TV2keWpt/CUHXSCG14v7iVMh61CAb6TbwPNK24ULM9kV9lfa+VkuD5PbaD5CpJaJuxVA/bk8nwIyeDas7eWQKv3PFJcSaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784795747; c=relaxed/simple;
	bh=LHrqbYlgqZJZlThMauHdxQmA0ndlPt3NovyhUyfXxOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WUawshh/EDP4rhfcgo8lQMgCMuIK3EQHr8QJAUs/D5WhEc8Api8wgw7KFhK8HD1cC6qyrNggO2Qd9x5T4G34ENLiVDUEZepXCMKrjx4jbiSR0qoSfaizq/uOBonWMrt0Ct4aPqnldPDkhK8atbyFYxW8uA3ssbNM9ilz3upevMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 79098be8867111f1aa26b74ffac11d73-20260723
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
X-CID-O-INFO: VERSION:1.3.12,REQID:b63372d9-737e-4e1c-b4d2-c76a987e14dc,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:b63372d9-737e-4e1c-b4d2-c76a987e14dc,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:70b0d169dc73897747b59238b1a384f8,BulkI
	D:26072316335209M9SW20,BulkQuantity:1,Recheck:0,SF:17|19|66|78|102|127|850
	|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 79098be8867111f1aa26b74ffac11d73-20260723
X-User: zuohongsheng@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zuohongsheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1879624054; Thu, 23 Jul 2026 16:35:34 +0800
From: zuohsh <zuohongsheng@kylinos.cn>
To: linux-bluetooth@vger.kernel.org
Cc: zuohsh <zuohongsheng@kylinos.cn>
Subject: [PATCH BlueZ] lib: Add bt_realloc
Date: Thu, 23 Jul 2026 16:35:08 +0800
Message-ID: <20260723083508.93096-1-zuohongsheng@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a bt_realloc wrapper that takes a pointer-to-pointer and only updates
the original on success, so that a failed realloc cannot leak the
existing buffer or leave a NULL pointer for the caller to dereference.

shared/ad: use bt_realloc in bt_ad_add_data(),
           bt_ad_add_manufacturer_data() and  bt_ad_add_service_data().
shared/bap: use  bt_realloc in ascs_ase_rsp_add().
lib/sdp: use bt_realloc in sdp_service_attr_req(), sdp_process() and
        sdp_service_search_attr_req().
---
 lib/bluetooth/bluetooth.c | 13 +++++++++++++
 lib/bluetooth/bluetooth.h |  2 ++
 lib/bluetooth/sdp.c       | 22 +++++++++++++++++++---
 src/shared/ad.c           |  9 ++++++---
 src/shared/bap.c          |  3 ++-
 5 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/lib/bluetooth/bluetooth.c b/lib/bluetooth/bluetooth.c
index 6e0977360..38f92f9e8 100644
--- a/lib/bluetooth/bluetooth.c
+++ b/lib/bluetooth/bluetooth.c
@@ -178,6 +178,19 @@ void *bt_malloc0(size_t size)
 	return calloc(size, 1);
 }
 
+bool bt_realloc(void *ptr, size_t size)
+{
+	void **pptr = ptr;
+	void *tmp;
+
+	tmp = realloc(*pptr, size);
+	if (!tmp)
+		return false;
+
+	*pptr = tmp;
+	return true;
+}
+
 void bt_free(void *ptr)
 {
 	free(ptr);
diff --git a/lib/bluetooth/bluetooth.h b/lib/bluetooth/bluetooth.h
index f9f22c3f7..5151c50f2 100644
--- a/lib/bluetooth/bluetooth.h
+++ b/lib/bluetooth/bluetooth.h
@@ -20,6 +20,7 @@ extern "C" {
 
 #include <stdio.h>
 #include <stdint.h>
+#include <stdbool.h>
 #include <string.h>
 #include <endian.h>
 #include <byteswap.h>
@@ -458,6 +459,7 @@ int basnprintf(char *str, size_t size, const char *format, ...);
 
 void *bt_malloc(size_t size);
 void *bt_malloc0(size_t size);
+bool bt_realloc(void *ptr, size_t size);
 void bt_free(void *ptr);
 
 int bt_error(uint16_t code);
diff --git a/lib/bluetooth/sdp.c b/lib/bluetooth/sdp.c
index 8c0865398..0e49ae2a6 100644
--- a/lib/bluetooth/sdp.c
+++ b/lib/bluetooth/sdp.c
@@ -3697,7 +3697,12 @@ sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle,
 			cstate = cstate_len > 0 ? (sdp_cstate_t *) (pdata + rsp_count) : 0;
 
 			/* build concatenated response buffer */
-			rsp_concat_buf.data = realloc(rsp_concat_buf.data, rsp_concat_buf.data_size + rsp_count);
+			if (!bt_realloc(&rsp_concat_buf.data,
+					rsp_concat_buf.data_size + rsp_count)) {
+				SDPERR("Failed to reallocate buffer");
+				status = -1;
+				goto end;
+			}
 			rsp_concat_buf.buf_size = rsp_concat_buf.data_size + rsp_count;
 			targetPtr = rsp_concat_buf.data + rsp_concat_buf.data_size;
 			memcpy(targetPtr, pdata, rsp_count);
@@ -4338,7 +4343,13 @@ int sdp_process(sdp_session_t *session)
 	 * This is a split response, need to concatenate intermediate
 	 * responses and the last one which will have cstate length == 0
 	 */
-	t->rsp_concat_buf.data = realloc(t->rsp_concat_buf.data, t->rsp_concat_buf.data_size + rsp_count);
+	if (!bt_realloc(&t->rsp_concat_buf.data,
+			t->rsp_concat_buf.data_size + rsp_count)) {
+		SDPERR("Failed to reallocate buffer");
+		status = 0xffff;
+		t->err = ENOMEM;
+		goto end;
+	}
 	targetPtr = t->rsp_concat_buf.data + t->rsp_concat_buf.data_size;
 	t->rsp_concat_buf.buf_size = t->rsp_concat_buf.data_size + rsp_count;
 	memcpy(targetPtr, pdata, rsp_count);
@@ -4560,7 +4571,12 @@ int sdp_service_search_attr_req(sdp_session_t *session, const sdp_list_t *search
 			cstate = cstate_len > 0 ? (sdp_cstate_t *) (pdata + rsp_count) : 0;
 
 			/* build concatenated response buffer */
-			rsp_concat_buf.data = realloc(rsp_concat_buf.data, rsp_concat_buf.data_size + rsp_count);
+			if (!bt_realloc(&rsp_concat_buf.data,
+					rsp_concat_buf.data_size + rsp_count)) {
+				SDPERR("Failed to reallocate buffer");
+				status = -1;
+				goto end;
+			}
 			targetPtr = rsp_concat_buf.data + rsp_concat_buf.data_size;
 			rsp_concat_buf.buf_size = rsp_concat_buf.data_size + rsp_count;
 			memcpy(targetPtr, pdata, rsp_count);
diff --git a/src/shared/ad.c b/src/shared/ad.c
index b1d1b8461..35aafd437 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -386,7 +386,8 @@ static bool ad_replace_data(struct bt_ad *ad, uint8_t type, const void *data,
 	if (new_data) {
 		if (new_data->len == len && !memcmp(new_data->data, data, len))
 			return false;
-		new_data->data = realloc(new_data->data, len);
+		if (!bt_realloc(&new_data->data, len))
+			return false;
 		memcpy(new_data->data, data, len);
 		new_data->len = len;
 		return true;
@@ -844,7 +845,8 @@ bool bt_ad_add_manufacturer_data(struct bt_ad *ad, uint16_t manufacturer_id,
 	if (new_data) {
 		if (new_data->len == len && !memcmp(new_data->data, data, len))
 			return false;
-		new_data->data = realloc(new_data->data, len);
+		if (!bt_realloc(&new_data->data, len))
+			return false;
 		memcpy(new_data->data, data, len);
 		new_data->len = len;
 		return true;
@@ -980,7 +982,8 @@ bool bt_ad_add_service_data(struct bt_ad *ad, const bt_uuid_t *uuid, void *data,
 	if (new_data) {
 		if (new_data->len == len && !memcmp(new_data->data, data, len))
 			return false;
-		new_data->data = realloc(new_data->data, len);
+		if (!bt_realloc(&new_data->data, len))
+			return false;
 		memcpy(new_data->data, data, len);
 		new_data->len = len;
 		return true;
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 1660b8b2c..319de76dd 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1000,7 +1000,8 @@ static void ascs_ase_rsp_add(struct iovec *iov, uint8_t id,
 	}
 
 	iov->iov_len += sizeof(*rsp);
-	iov->iov_base = realloc(iov->iov_base, iov->iov_len);
+	if (!bt_realloc(&iov->iov_base, iov->iov_len))
+		return;
 
 	rsp = iov->iov_base + (iov->iov_len - sizeof(*rsp));
 	rsp->ase = id;
-- 
2.43.0

