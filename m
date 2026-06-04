Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6E423A9BD
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 05:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780550485; cv=none; b=jHthe/yo6QOk88vpq4I3xcH9kgZder4vAEBzL16HsxYyxE54ccfHL52mah7QgVVSh31C7HTOfW3oPywYKbox+ChTVVIZk8k9NBP5/ogZWv5BdWA7Gpb1by3wFvdpL2I5FWIKRZASv+V+fSCmWCQgRZeIZ1Drw6frIZAAHyfaFvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780550485; c=relaxed/simple;
	bh=jLOoGO3hGwxYmIhn25kjNur4tR3hZndlr0Y+bRZdnGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKH6jtbpM1ulHa7oIjPxIv1EhvX+Cv71fBf6MQysZQAplWhh6WlAHb4OBiMMHu2grWsN3dWlrLWml4d+IukHtSW/YcbXtRqGqumXFc5UluuethELuVNcHobYS4z4RHojnx6Sp87DQOA+j1/VzHNEEFURiQutcayU21qWB2DoDXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Rd6nIqTu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Rd6nIqTu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1780550477;
	bh=jLOoGO3hGwxYmIhn25kjNur4tR3hZndlr0Y+bRZdnGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rd6nIqTuyA1IP7/I5sLeRPEG0N19ChyYa9GAssXDRTmgnHvmPYziA6qOHBIpOEvMR
	 5KP9lyuNZK5wgGSAw6Tv1sndiczS8DLnWLRQ4zKKjdhSVA1IVnCKH+6s6mRdGHQCUY
	 5LxgG9xPV8YOBjVLn40r5KDe+K8qqh2+BjcttARMA7RJoGEBlGH9PyyR/fBKh8/L8o
	 IvqfBuriRHyeIm5qnT0b6WpkN3Rm2eHWVNTdB2AReJleLoENXWT2GWS3IrZdxy8KkC
	 roQyhevVu4FV6RWnbeCeHImOCK7Q8Oogx0Kx6T0TpDPVzTVwS1BHKFQJ4pdna51eHh
	 dpOSO6kfjaEVg==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9183F17E062B;
	Thu,  4 Jun 2026 07:21:16 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghavendra <raghavendra.rao@collabora.com>
Subject: [BlueZ PATCH v2 1/1] shared/bap: add ASE Control Point error responses
Date: Thu,  4 Jun 2026 10:50:52 +0530
Message-ID: <20260604052052.10667-2-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604052052.10667-1-raghavendra.rao@collabora.com>
References: <CABBYNZ+UzUk+MHSo87vttd7YF-s3Zuzsywf+wnoOboaD2bLhFg@mail.gmail.com>
 <20260604052052.10667-1-raghavendra.rao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: raghavendra <raghavendra.rao@collabora.com>

Add SPE unit tests.
These changes are required to Pass BAP/USR/SPE/BI-01[5]-C tests.
---
 src/shared/bap.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++--
 unit/test-bap.c  | 64 ++++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+), 2 deletions(-)

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
 
diff --git a/unit/test-bap.c b/unit/test-bap.c
index 3a67e7016..e43d1d2ef 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -4349,6 +4349,69 @@ static void test_scc_metadata(void)
 	test_usr_scc_metadata();
 }
 
+#define ASE_CP_RSP(_op, _ase, _code, _reason) \
+	IOV_DATA(0x1b, CP_HND, _op, 0x01, _ase, _code, _reason)
+
+#define ASE_CP_RSP_TRUNCATED(_op) \
+	IOV_DATA(0x1b, CP_HND, _op, 0xff, 0x00, 0x02, 0x00)
+
+#define SPE_CP_TRUNCATED(_op) \
+	IOV_DATA(0x52, CP_HND, _op), \
+	ASE_CP_RSP_TRUNCATED(_op)
+
+#define SPE_CP_ZERO_ASES(_op) \
+	IOV_DATA(0x52, CP_HND, _op, 0x00), \
+	ASE_CP_RSP_TRUNCATED(_op)
+
+#define SPE_METADATA_TRUNCATED(_ase) \
+	IOV_DATA(0x52, CP_HND, 0x07, 0x01, _ase), \
+	ASE_CP_RSP_TRUNCATED(0x07)
+
+#define SPE_METADATA_UNSUPPORTED(_ase) \
+	SCC_SRC_ENABLE, \
+	IOV_DATA(0x52, CP_HND, 0x07, 0x01, _ase, 0x02, 0x01, 0xfc), \
+	ASE_CP_RSP(0x07, _ase, 0x0a, 0xfc)
+
+#define SPE_METADATA_INVALID_CONTEXT(_ase) \
+	SCC_SRC_ENABLE, \
+	IOV_DATA(0x52, CP_HND, 0x07, 0x01, _ase, 0x04, 0x03, 0x02, \
+			0x00, 0x10), \
+	ASE_CP_RSP(0x07, _ase, 0x0c, 0x02)
+
+/* Unicast Server Rejects Invalid ASE Control Point Procedures
+ *
+ * Test Purpose:
+ * Verify the behavior of a Unicast Server IUT when a Unicast Client writes
+ * invalid ASE Control Point parameters.
+ *
+ * Pass verdict:
+ * The IUT sends a notification of the ASE Control Point characteristic with
+ * the expected Response_Code and Reason values.
+ */
+static void test_usr_spe(void)
+{
+	define_test("BAP/USR/SPE/BI-01-C [USR ASE Control Point truncated]",
+			test_setup_server, test_server, NULL,
+			SPE_CP_TRUNCATED(0x03));
+	define_test("BAP/USR/SPE/BI-02-C [USR ASE Control Point zero ASEs]",
+			test_setup_server, test_server, NULL,
+			SPE_CP_ZERO_ASES(0x03));
+	define_test("BAP/USR/SPE/BI-03-C [USR Update Metadata truncated]",
+			test_setup_server, test_server, NULL,
+			SPE_METADATA_TRUNCATED(SRC_ID(0)));
+	define_test("BAP/USR/SPE/BI-04-C [USR Update Metadata unsupported]",
+			test_setup_server, test_server, &cfg_src_enable,
+			SPE_METADATA_UNSUPPORTED(SRC_ID(0)));
+	define_test("BAP/USR/SPE/BI-05-C [USR Update Metadata invalid context]",
+			test_setup_server, test_server, &cfg_src_enable,
+			SPE_METADATA_INVALID_CONTEXT(SRC_ID(0)));
+}
+
+static void test_spe(void)
+{
+	test_usr_spe();
+}
+
 #define SNK_ENABLE \
 	IOV_DATA(0x52, 0x22, 0x00, 0x03, 0x01, 0x01, 0x04, 0x03, 0x02, 0x01, \
 			00), \
@@ -10259,6 +10322,7 @@ int main(int argc, char *argv[])
 	tester_init(&argc, &argv);
 
 	test_disc();
+	test_spe();
 	test_scc();
 	test_bsrc_scc();
 	test_bsnk_scc();
