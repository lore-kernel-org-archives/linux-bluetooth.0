Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493BF3AFAE4
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784794821; cv=none; b=rk4SeRn1sc8vWtTm5SCNgtvzICg9Xu39+rDHAoOH0XP3ovEaNeFb3ZEEQCgPF/L6uGm0dY+LxRwWj7nKDtsIJwXJxvFVMFk1HEpAQs4iuCBG6TyzIkpX1KD0zWugQuXmHOuLCEFbt3H3WpfydUCmz1YQH/C12QAgTKYGdBnLeX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784794821; c=relaxed/simple;
	bh=qljayQdiQkL3haCVhShrSt5OOGFGqFD2fkGGwZJVibk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KKcvaJ+oIPWCd9zILmhY+TIOHav2WeEXJR12F/ECx4/2YR+mBUSg30e8gj22MilLA8QXXlntgrYJen3PZCEYm0QwcXyiHQLJas6gOwxQOi9nBj2o8+Jk08Zmubr8C9HVMQgXS+/GD6rJ9+BHERMCgZg5H3fKviv0ImAzviVeRlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 509bede2866f11f1aa26b74ffac11d73-20260723
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
X-CID-O-INFO: VERSION:1.3.12,REQID:d3d254c3-bd47-42fc-8244-b70176d34864,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:d3d254c3-bd47-42fc-8244-b70176d34864,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:d0dc8f99ccbaac51aa5bdfbe5128e073,BulkI
	D:260723161348HGIOZO2G,BulkQuantity:1,Recheck:0,SF:19|66|72|78|102|127|136
	|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bul
	k:41,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,
	BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 509bede2866f11f1aa26b74ffac11d73-20260723
X-User: zuohongsheng@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zuohongsheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1665372855; Thu, 23 Jul 2026 16:20:07 +0800
From: zuohsh <zuohongsheng@kylinos.cn>
To: linux-bluetooth@vger.kernel.org
Cc: zuohsh <zuohongsheng@kylinos.cn>
Subject: [PATCH BlueZ] sdpd-request: Fix unchecked malloc
Date: Thu, 23 Jul 2026 16:19:52 +0800
Message-ID: <20260723081952.92162-1-zuohongsheng@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix unchecked malloc in request processing in service_search_attr_req()
and process_request().Also add SDP_INSUFFICIENT_RESOURCES (0x0006) which
is defined by the Bluetooth Core Specification but was missing from sdp.h.
---
 lib/bluetooth/sdp.h |  1 +
 src/sdpd-request.c  | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/lib/bluetooth/sdp.h b/lib/bluetooth/sdp.h
index 6f05d4321..30a99ec14 100644
--- a/lib/bluetooth/sdp.h
+++ b/lib/bluetooth/sdp.h
@@ -413,6 +413,7 @@ extern "C" {
 #define SDP_INVALID_SYNTAX		0x0003
 #define SDP_INVALID_PDU_SIZE		0x0004
 #define SDP_INVALID_CSTATE		0x0005
+#define SDP_INSUFFICIENT_RESOURCES	0x0006
 
 /*
  * SDP PDU
diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index c78bfdffa..7d169482b 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -909,6 +909,10 @@ static int service_search_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 	svcList = sdp_get_record_list();
 
 	tmpbuf.data = malloc(USHRT_MAX);
+	if (!tmpbuf.data) {
+		status = SDP_INSUFFICIENT_RESOURCES;
+		goto done;
+	}
 	tmpbuf.data_size = 0;
 	tmpbuf.buf_size = USHRT_MAX;
 	memset(tmpbuf.data, 0, USHRT_MAX);
@@ -1013,6 +1017,12 @@ static void process_request(sdp_req_t *req)
 	uint8_t *buf = malloc(USHRT_MAX);
 	int status = SDP_INVALID_SYNTAX;
 
+	if (!buf) {
+		free(req->buf);
+		req->buf = NULL;
+		return;
+	}
+
 	memset(buf, 0, USHRT_MAX);
 	rsp.data = buf + sizeof(sdp_pdu_hdr_t);
 	rsp.data_size = 0;
-- 
2.43.0

