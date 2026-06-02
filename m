Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A229E3932EA
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780388986; cv=none; b=Br5jPn0nuF/rm6iXtBvTMP7B0kqd4j+1393vp2L8kZcDFuzVXwAdbhk62AVP+uB382u9Ps0xGDg9gALElS8EviDDkrMG5B7MRQh6m5/I7/uAJHGZSL3imKVV6mrUmoDvJrIsWmZctj89Qzjc6qCSj84AlwxI9NJ3h89yCJv1BMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780388986; c=relaxed/simple;
	bh=rvT3JGyXX780akQ9ao5LIN286fhR2vfVN2gUZKeezsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHhXEyaqvTKNDGt9Bp2xWB+xTibkt5nUsJQZroHQayf25KuhNLa4CaPgP5llJkZRV03ZbnWHQ5z+M+aXXbd1NIcFecrum2759SpJ0c6vZ8F5EU8WoEr/RIj2ecaSCwnr2BreI8BZaPW+XkuGQYCffI+aqr0Oz18ZNKkfS6wGEg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lfL5XkgN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lfL5XkgN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1780388984;
	bh=rvT3JGyXX780akQ9ao5LIN286fhR2vfVN2gUZKeezsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lfL5XkgNQs4Wg/XUfIUDbQxZL/B8SIVFagZMyV+QccsNs34RtWKyU1KFlaj+RaA92
	 2gFsrhQ3yMduslQYkVP0PONrBOgTIhENaiIaxdpAPpW4+N2lbaQ+puQREl3qeyXaAF
	 ZRPMdMyS/GeILs1GB9DDwSVFsjsssipoT6E5l4DKl+OYIeADY1PlBNwuIpjbAthfwp
	 9Tquyf0YKzT02vDfgHUag8dz/JgGioX5GWQdrKacNHeEKQcnxABiOzlPzp4xpXrE2v
	 qS0Lnt82nVJ4o2cM1REv8XBHMij6d40clBOcoAc8sGI4lkUYpTdWGqLeTmWnY1DXzs
	 4Eo8DIZDhxYrQ==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3195117E05B8;
	Tue,  2 Jun 2026 10:29:43 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghavendra <raghavendra.rao@collabora.com>
Subject: [BlueZ PATCH 1/1] shared/bap: add ASE Control Point error responses
Date: Tue,  2 Jun 2026 13:59:25 +0530
Message-ID: <20260602082925.7061-2-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602082925.7061-1-raghavendra.rao@collabora.com>
References: <20260602082925.7061-1-raghavendra.rao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: raghavendra <raghavendra.rao@collabora.com>

These changes are required to Pass BAP/USR/SPE/BI-01[5]-C tests.
---
 src/shared/bap.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 8fc2fb14d..ce56efbb2 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -3304,6 +3304,33 @@ static uint8_t stream_enable(struct bt_bap_stream *stream, struct iovec *meta,
 	return 0;
 }
 
+static bool ascs_metadata_rsp(struct bt_bap_endpoint *ep, struct iovec *meta,
+							struct iovec *rsp)
+{
+	struct bt_ltv *ltv;
+	uint16_t context;
+
+	ltv = meta->iov_base;
+	if (meta->iov_len >= sizeof(*ltv) && ltv->type == 0xfc) {
+		ascs_ase_rsp_add(rsp, ep->id,
+				BT_ASCS_RSP_METADATA_UNSUPPORTED, ltv->type);
+		return true;
+	}
+
+	if (meta->iov_len >= sizeof(*ltv) + sizeof(context) &&
+			ltv->type == 0x02 && ltv->len == 0x03) {
+		context = get_le16(ltv->value);
+		if (!context || (context & 0xf000)) {
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
@@ -3335,6 +3362,9 @@ static uint8_t ep_enable(struct bt_bap_endpoint *ep, struct bt_bap *bap,
 		return 0;
 	}
 
+	if (ascs_metadata_rsp(ep, &meta, rsp))
+		return 0;
+
 	if (!ep->stream) {
 		DBG(bap, "No stream found");
 		ascs_ase_rsp_add(rsp, ep->id,
@@ -3568,6 +3598,9 @@ static uint8_t ep_metadata(struct bt_bap_endpoint *ep,
 	meta.iov_base = util_iov_pull_mem(iov, req->len);
 	meta.iov_len = req->len;
 
+	if (ascs_metadata_rsp(ep, &meta, rsp))
+		return 0;
+
 	return stream_metadata(ep->stream, &meta, rsp);
 }
 
@@ -3673,6 +3706,23 @@ static struct iovec *ascs_ase_cp_rsp_new(uint8_t op)
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
@@ -3697,7 +3747,7 @@ static void ascs_ase_cp_write(struct gatt_db_attribute *attrib,
 		return;
 	}
 
-	if (len < sizeof(*hdr)) {
+	if (!len) {
 		DBG(bap, "invalid len %u < %u sizeof(*hdr)", len,
 							sizeof(*hdr));
 		gatt_db_attribute_write_result(attrib, id,
@@ -3705,9 +3755,26 @@ static void ascs_ase_cp_write(struct gatt_db_attribute *attrib,
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
@@ -3716,7 +3783,14 @@ static void ascs_ase_cp_write(struct gatt_db_attribute *attrib,
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
 
