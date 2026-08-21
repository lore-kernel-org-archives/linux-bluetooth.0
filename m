Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4AB3AF64F
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787297949; cv=none; b=fWt0m07OlpCCaibF1HezxSGXMMpcs4SafZAokFfSZ5b4J0o/NjoalP1CsLS0DEuR7/7Rp9Vx3c+QEN42zicyGh/EyXc0weA3dEuni18dUWblM3haxX3jhPqm2IjB1ex4XycY5cmBiD7TfJimLjCSZ8jNAwpxGocBbb9vZ3b2L6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787297949; c=relaxed/simple;
	bh=dNQwRED3kmRzK5us7XCTf7rOcujQ+Z1hpyq4e8gkBT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFPNOKNLYh30Wh5BkJugNf0ypbY1vZ5pYfRESma7JnPRalaK3PqommIrXehbbVm1JfKWoXwfN3l1NHNL/gauvIed2mQKFkohq5FsVul7I1RktkHb70uXPGInzC5wr+4m44OzlMvqGLWCI+UVSUMc6qn/4XAhFgH2TUtn4oKAFLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5d52533e9d3311f19a56ed5b684f684d-20260821
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, UD_TRUSTED, CIE_BAD, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_COMM, GTI_C_CI, GTI_FG_IT
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:e4140b00-8b09-438c-98a5-edf245ab4bf5,IP:10,
	URL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-10
X-CID-INFO: VERSION:1.3.19,REQID:e4140b00-8b09-438c-98a5-edf245ab4bf5,IP:10,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:7db8b62,CLOUDID:8a533b994170dc6dd008f9478a655a5b,BulkI
	D:260821153859O6M7T1XU,BulkQuantity:0,SF:17|19|66|78|81|82|102|127|850|865
	|898,TC:nil,Content:0|15|50,EDM:1|-100,IP:-2,URL:1,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,
	TF_CID_SPAM_AEC
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5d52533e9d3311f19a56ed5b684f684d-20260821
X-User: zuohongsheng@kylinos.cn
Received: from localhost.localdomain [(223.104.42.203)] by mailgw.kylinos.cn
	(envelope-from <zuohongsheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 844063514; Fri, 21 Aug 2026 15:38:55 +0800
From: zuohsh <zuohongsheng@kylinos.cn>
To: linux-bluetooth@vger.kernel.org
Cc: zuohsh <zuohongsheng@kylinos.cn>
Subject: [PATCH v3] gatt-server: Fix integer overflow and 3 CI VLA wanings
Date: Fri, 21 Aug 2026 15:35:16 +0800
Message-ID: <20260821073850.118299-1-zuohongsheng@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6a87d831.de89bd77.362314.3ace@mx.google.com>
References: <6a87d831.de89bd77.362314.3ace@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By using size_t for realloc len and rejecting allocations exceeding
UINT16_MAX , to prevent truncation into the uint16_t field.

Fix CI warnings: Variable length array is used, use malloc/free instead.
---
 src/shared/gatt-server.c | 42 ++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 709a8f94b..516fceb8e 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -268,7 +268,7 @@ static void read_by_grp_type_cb(struct bt_att_chan *chan, uint16_t mtu,
 	uint16_t start, end;
 	bt_uuid_t type;
 	bt_uuid_t prim, snd;
-	uint8_t rsp_pdu[mtu];
+	uint8_t *rsp_pdu = NULL;
 	uint16_t rsp_len;
 	uint8_t ecode = 0;
 	uint16_t ehandle = 0;
@@ -319,6 +319,12 @@ static void read_by_grp_type_cb(struct bt_att_chan *chan, uint16_t mtu,
 		goto error;
 	}

+	rsp_pdu = malloc(mtu);
+	if (!rsp_pdu) {
+		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
+		goto error;
+	}
+
 	if (!encode_read_by_grp_type_rsp(server->db, q, server->att, mtu,
 							rsp_pdu, &rsp_len)) {
 		ecode = BT_ATT_ERROR_UNLIKELY;
@@ -330,11 +336,14 @@ static void read_by_grp_type_cb(struct bt_att_chan *chan, uint16_t mtu,
 	bt_att_chan_send_rsp(chan, BT_ATT_OP_READ_BY_GRP_TYPE_RSP,
 						rsp_pdu, rsp_len);

+	free(rsp_pdu);
+
 	return;

 error:
 	queue_destroy(q, NULL);
 	bt_att_chan_send_error_rsp(chan, opcode, ehandle, ecode);
+	free(rsp_pdu);
 }

 static void async_read_op_destroy(struct async_read_op *op)
@@ -611,7 +620,7 @@ static void find_info_cb(struct bt_att_chan *chan, uint16_t mtu, uint8_t opcode,
 {
 	struct bt_gatt_server *server = user_data;
 	uint16_t start, end;
-	uint8_t rsp_pdu[mtu];
+	uint8_t *rsp_pdu = NULL;
 	uint16_t rsp_len;
 	uint8_t ecode = 0;
 	uint16_t ehandle = 0;
@@ -648,6 +657,12 @@ static void find_info_cb(struct bt_att_chan *chan, uint16_t mtu, uint8_t opcode,
 		goto error;
 	}

+	rsp_pdu = malloc(mtu);
+	if (!rsp_pdu) {
+		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
+		goto error;
+	}
+
 	if (!encode_find_info_rsp(server->db, q, mtu, rsp_pdu, &rsp_len)) {
 		ecode = BT_ATT_ERROR_UNLIKELY;
 		goto error;
@@ -657,11 +672,14 @@ static void find_info_cb(struct bt_att_chan *chan, uint16_t mtu, uint8_t opcode,

 	queue_destroy(q, NULL);

+	free(rsp_pdu);
+
 	return;

 error:
 	bt_att_chan_send_error_rsp(chan, opcode, ehandle, ecode);
 	queue_destroy(q, NULL);
+	free(rsp_pdu);

 }

@@ -709,7 +727,7 @@ static void find_by_type_val_cb(struct bt_att_chan *chan, uint16_t mtu,
 	struct bt_gatt_server *server = user_data;
 	uint16_t start, end, uuid16;
 	struct find_by_type_val_data data;
-	uint8_t rsp_pdu[mtu];
+	uint8_t *rsp_pdu = NULL;
 	uint16_t ehandle = 0;
 	bt_uuid_t uuid;

@@ -718,6 +736,12 @@ static void find_by_type_val_cb(struct bt_att_chan *chan, uint16_t mtu,
 		goto error;
 	}

+	rsp_pdu = malloc(mtu);
+	if (!rsp_pdu) {
+		data.ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
+		goto error;
+	}
+
 	data.pdu = rsp_pdu;
 	data.len = 0;
 	data.mtu = mtu;
@@ -752,10 +776,13 @@ static void find_by_type_val_cb(struct bt_att_chan *chan, uint16_t mtu,
 	bt_att_chan_send_rsp(chan, BT_ATT_OP_FIND_BY_TYPE_RSP,
 					data.pdu, data.len);

+	free(rsp_pdu);
+
 	return;

 error:
 	bt_att_chan_send_error_rsp(chan, opcode, ehandle, data.ecode);
+	free(rsp_pdu);
 }

 static void async_write_op_destroy(struct async_write_op *op)
@@ -1174,12 +1201,12 @@ static bool append_prep_data(struct prep_write_data *prep_data, uint16_t handle,
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
@@ -1188,7 +1215,10 @@ static bool append_prep_data(struct prep_write_data *prep_data, uint16_t handle,
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

Add fixing for CI reported wanings: https://github.com/bluez/bluez/actions/runs/32445843490/job/96665153549?pr=2422
2026-08-21T04:46:41.2241065Z src/shared/gatt-server.c:271:25: warning: Variable length array is used.src/shared/gatt-server.c:614:25: warning: Variable length array is used.src/shared/gatt-server.c:712:25: warning: Variable length array is used.src/shared/gatt-server.c:271:25: warning: Variable length array is used.src/shared/gatt-server.c:614:25: warning: Variable length array is used.src/shared/gatt-server.c:712:25: warning: Variable length array is used.src/shared/gatt-server.c:271:25: warning: Variable length array is used.src/shared/gatt-server.c:614:25: warning: Variable length array is used.src/shared/gatt-server.c:712:25: warning: Variable length array is used.
