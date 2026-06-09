Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F483F4DEF
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000781; cv=none; b=JVO272H7GyRk+mlTDqFXO9ccu8KSjvZxg7kb2DBSdWLPgd3tkzWVTH9auDuiUgUY2uZ7vesyoY4A4vQabDAIix0PjYbRD/Gx6yXW+YUS1buln1yFgNjgEpbAE2/1o1s9W1bzRWLrf6HK7HOU4S/gmfBwF6hA8hKF1nXpHKg9Yj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000781; c=relaxed/simple;
	bh=fwb4jIMwLvSGx1zvY+dy+u2gJnYZQm3Iu48XlAx/XMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+O9a/qIkONSvm79ewltRPIEFyLJldpGcU5e72CAxGmSAUHiDFzuwkOn2NcIHMg6aoLXvDYdKRwRS1/Nr74Pa5ohBswX5pe1+8YQh1yJDe5R7wC5Rv7YcqM+GimZGiaQi5962wnCJjT48T2s5b9wVu+hUfszR3VY3wCRdsDLC4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qNEYdDyG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qNEYdDyG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1781000773;
	bh=fwb4jIMwLvSGx1zvY+dy+u2gJnYZQm3Iu48XlAx/XMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qNEYdDyGmUryPqUO9dGx+ECdiCDQUvLJedlotXX80Aq2JX9tQwoEWtzOEOP9WQf48
	 M2JuUtQujmtLUDaXwZJkqp9PdFALwRQMMCgnjVmNar56mhfROj0vxWVA3D0dg1a2BN
	 2EnCLhtjTP5xoZR6DEkaHNxlocbyuoNwgzZzBm3BM1k9p34j2aoUtLOlu8eWb0kAib
	 bXF47wnLvNElgeeDUCr7y5Y6fPRcs0Y48jKJK1SpajXOedoUCL2VIccnxsvY6rFsEP
	 WDisc1pVxSRMNVtjpSD6aHwqaVpji5FwT0L/92s+zw4axNtIMLtsTWPFKFOBdvMymf
	 drzrxvC5MFtfA==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 32CD117E0416;
	Tue,  9 Jun 2026 12:26:11 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghu447 <raghavendra.rao@collabora.com>
Subject: [BlueZ PATCH v3 1/2] shared/bap: add ASE Control Point error responses
Date: Tue,  9 Jun 2026 15:55:47 +0530
Message-ID: <20260609102548.6887-2-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609102548.6887-1-raghavendra.rao@collabora.com>
References: <CABBYNZKQuFeXvtEE3d3nOUbkKZTAFsfB=1=NDFp48CFEg2e-=Q@mail.gmail.com>
 <20260609102548.6887-1-raghavendra.rao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These changes are required to Pass BAP/USR/SPE/BI-01[5]-C tests.
---
 src/shared/bap.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 8fc2fb14d..edb84efca 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -57,6 +57,11 @@
 		(1<<BAP_DURATION_LTV_TYPE)|\
 		(1<<BAP_FRAME_LEN_LTV_TYPE))
 
+#define BAP_METADATA_PREF_CONTEXT_LTV_TYPE	0x01
+#define BAP_METADATA_CONTEXT_LTV_TYPE		0x02
+#define BAP_METADATA_PROGRAM_INFO_LTV_TYPE	0x03
+#define BAP_METADATA_LANGUAGE_LTV_TYPE		0x04
+
 struct bt_bap_pac_changed {
 	unsigned int id;
 	bt_bap_pac_func_t added;
@@ -3304,6 +3309,40 @@ static uint8_t stream_enable(struct bt_bap_stream *stream, struct iovec *meta,
 	return 0;
 }
 
+static bool ascs_metadata_rsp(struct bt_bap_endpoint *ep, struct iovec *meta,
+							struct iovec *rsp)
+{
+	struct bt_ltv *ltv;
+	uint16_t supported_context = 0;
+	uint16_t context;
+
+	if (ep->stream && ep->stream->lpac)
+		supported_context = ep->stream->lpac->qos.supported_context;
+
+	ltv = meta->iov_base;
+	if (meta->iov_len >= sizeof(*ltv) &&
+			(ltv->type < BAP_METADATA_PREF_CONTEXT_LTV_TYPE ||
+			ltv->type > BAP_METADATA_LANGUAGE_LTV_TYPE)) {
+		ascs_ase_rsp_add(rsp, ep->id,
+				BT_ASCS_RSP_METADATA_UNSUPPORTED, ltv->type);
+		return true;
+	}
+
+	if (meta->iov_len >= sizeof(*ltv) + sizeof(context) &&
+			ltv->type == BAP_METADATA_CONTEXT_LTV_TYPE &&
+			ltv->len == sizeof(context) + 1) {
+		context = get_le16(ltv->value);
+		if (!context || (context & ~supported_context)) {
+			ascs_ase_rsp_add(rsp, ep->id,
+					BT_ASCS_RSP_METADATA_INVALID,
+					ltv->type);
+			return true;
+		}
+	}
+
+	return false;
+}
+
 static uint8_t ep_enable(struct bt_bap_endpoint *ep, struct bt_bap *bap,
 			struct bt_ascs_enable *req, struct iovec *iov,
 			struct iovec *rsp)
@@ -3335,6 +3374,9 @@ static uint8_t ep_enable(struct bt_bap_endpoint *ep, struct bt_bap *bap,
 		return 0;
 	}
 
+	if (ascs_metadata_rsp(ep, &meta, rsp))
+		return 0;
+
 	if (!ep->stream) {
 		DBG(bap, "No stream found");
 		ascs_ase_rsp_add(rsp, ep->id,
@@ -3568,6 +3610,9 @@ static uint8_t ep_metadata(struct bt_bap_endpoint *ep,
 	meta.iov_base = util_iov_pull_mem(iov, req->len);
 	meta.iov_len = req->len;
 
+	if (ascs_metadata_rsp(ep, &meta, rsp))
+		return 0;
+
 	return stream_metadata(ep->stream, &meta, rsp);
 }
 
@@ -3673,6 +3718,23 @@ static struct iovec *ascs_ase_cp_rsp_new(uint8_t op)
 	return iov;
 }
 
+static void ascs_ase_cp_rsp_add_truncated(struct iovec *rsp)
+{
+	ascs_ase_rsp_add_errno(rsp, 0x00, -ENOMSG);
+}
+
+static bool ascs_ase_cp_rsp_invalid_len(uint8_t op, size_t len, uint8_t num)
+{
+	switch (op) {
+	case BT_ASCS_METADATA:
+		return len == num;
+	case BT_ASCS_RELEASE:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static void ascs_ase_cp_write(struct gatt_db_attribute *attrib,
 				unsigned int id, uint16_t offset,
 				const uint8_t *value, size_t len,
@@ -3697,7 +3759,7 @@ static void ascs_ase_cp_write(struct gatt_db_attribute *attrib,
 		return;
 	}
 
-	if (len < sizeof(*hdr)) {
+	if (!len) {
 		DBG(bap, "invalid len %u < %u sizeof(*hdr)", len,
 							sizeof(*hdr));
 		gatt_db_attribute_write_result(attrib, id,
@@ -3705,9 +3767,26 @@ static void ascs_ase_cp_write(struct gatt_db_attribute *attrib,
 		return;
 	}
 
+	if (len < sizeof(*hdr)) {
+		DBG(bap, "invalid len %u < %u sizeof(*hdr)", len,
+							sizeof(*hdr));
+
+		rsp = ascs_ase_cp_rsp_new(value[0]);
+		ascs_ase_cp_rsp_add_truncated(rsp);
+		ret = 0;
+		goto respond;
+	}
+
 	hdr = util_iov_pull_mem(&iov, sizeof(*hdr));
 	rsp = ascs_ase_cp_rsp_new(hdr->op);
 
+	if (!hdr->num) {
+		DBG(bap, "invalid Number_of_ASEs 0");
+		ascs_ase_cp_rsp_add_truncated(rsp);
+		ret = 0;
+		goto respond;
+	}
+
 	for (handler = handlers; handler && handler->str; handler++) {
 		if (handler->op != hdr->op)
 			continue;
@@ -3716,7 +3795,14 @@ static void ascs_ase_cp_write(struct gatt_db_attribute *attrib,
 			DBG(bap, "invalid len %u < %u "
 				  "hdr->num * handler->size", len,
 				  hdr->num * handler->size);
-			ret = BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
+
+			if (ascs_ase_cp_rsp_invalid_len(hdr->op, iov.iov_len,
+								hdr->num)) {
+				ascs_ase_cp_rsp_add_truncated(rsp);
+				ret = 0;
+			} else
+				ret = BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
+
 			goto respond;
 		}
 
