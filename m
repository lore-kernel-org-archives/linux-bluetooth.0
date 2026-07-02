Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0A63B6BF3
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997850; cv=none; b=VCJJRJVx7MCX9iFPsRkd09BSNMw3pkkwA1Oz3zK88e7uEioSs2ToGqG2ZD+/u1w3IEqiTSXbaHITRJ839osdyXGt5z4PvHPJvWfYHN3OhDoMmmorsBC8zxFJXF8/ijsxMLxq+ZknREx+1mp/bqeO5BeNBd0GhluVP2NTDpq6Ex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997850; c=relaxed/simple;
	bh=78mtDWBVbkAp/jJ90EX1iKaDPTYhyDIJ4NDH8Yb/erc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pusqLPA+/viZ/J2OxbIzmDSqCHb0Kv6r/YsBlAlp9ehGtXz/+RHZGHGTkKY+nD5H9tZt7kt9B81k5oTgEMgsutTFQJ2Xk3rDyeKfHQ3p6JewRsFRhN7w1nc3fss8hH3Jnu3CGrol15YwPe2/ZQ/Joh6MhDKuBc1NyeHnxNgjctM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PzFLFq8Q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PzFLFq8Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782997847;
	bh=78mtDWBVbkAp/jJ90EX1iKaDPTYhyDIJ4NDH8Yb/erc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PzFLFq8QiNMmrWab6/f1vpd6nlZB79cGNf5tdniYUBtCtEVKEwzhq1IT5GSA0nfQX
	 UXyahg0//9E3Vxp0NBUFHxRV3N1ZatZeLWrBilR538R4ZH8DD2NZ401ozUDOZPihEH
	 dDhLhIViBRSEX9d7+bjXhcCqGS41BDu6ijx+fJq0hGa5O2OKNy+9RK0gb0SN4jEBJm
	 HIY0Qx6+Om6zgjfzj9VBhLMbQlW9BVw4nl61z7nurm5jPuSm6D7C0F45tJ1P7bUM7c
	 L5iWFrjrhjjbzUp5U+9H/sTk6sFLcjpNzfpuXPGaC2jkdSoRzGDtNySkBdgYEkW+w7
	 CC2/NYNmurH+Q==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EDC5F17E0180;
	Thu,  2 Jul 2026 15:10:46 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghavendra <raghavendra.rao@collabora.com>
Subject: [BlueZ PATCH 4/4] unit/bap: Add invalid ASCS control point tests
Date: Thu,  2 Jul 2026 18:39:07 +0530
Message-ID: <20260702130907.49942-5-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702130907.49942-1-raghavendra.rao@collabora.com>
References: <20260702130907.49942-1-raghavendra.rao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: raghavendra <raghavendra.rao@collabora.com>

Adds coverage for PTS tests ASCS/SR/SPE/BI-01-C and BI-07-C to BI-10-C.
---
 unit/test-bap.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 4e89ba6af..60190ef69 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -4446,11 +4446,82 @@ static void test_usr_spe(void)
 			SPE_METADATA_INVALID_CONTEXT(SRC_ID(0)));
 }
 
+/* Audio Stream Control Service Procedure Errors */
+
+#define ASCS_CONFIG_CODEC_INVALID(_ase) \
+	DISC_SRC_ASE_LC3, \
+	IOV_DATA(SCC_PDU(1), SCC_PDU_ASE(_ase, \
+			0x06, 0x01, 0x00, 0x01, 0x00, \
+			0x0a, 0x02, 0x01, 0x03, 0x02, 0x02, 0x01, \
+			0x03, 0x04, 0x28, 0x00)), \
+	ASE_CP_RSP(0x01, _ase, 0x09, 0x01), \
+	IOV_DATA(SCC_PDU(1), SCC_PDU_ASE(_ase, \
+			LC3_CODEC_ID_DATA, 0x03, 0x02, 0x02, 0x0a)), \
+	ASE_CP_RSP(0x01, _ase, 0x09, 0x02)
+
+#define ASCS_QOS_REQ(_ase, _i0, _i1, _i2, _framing, _phy) \
+	IOV_DATA(QOS_PDU(1), QOS_PDU_ASE(_ase, 0, _i0, _i1, _i2, \
+			_framing, _phy, \
+			0x28, 0x00, 0x02, 0x0a, 0x00, 0x40, 0x9c, 0x00))
+
+#define ASCS_QOS_INVALID(_ase) \
+	DISC_SRC_ASE_LC3, \
+	SCC_SRC(LC3_CODEC_ID_DATA, \
+			0x0a, 0x02, 0x01, 0x03, 0x02, 0x02, 0x01, \
+			0x03, 0x04, 0x28, 0x00), \
+	ASCS_QOS_REQ(_ase, 0xfe, 0x00, 0x00, 0x00, 0x02), \
+	ASE_CP_RSP(0x02, _ase, 0x09, 0x03), \
+	ASCS_QOS_REQ(_ase, 0x10, 0x27, 0x00, 0x02, 0x02), \
+	ASE_CP_RSP(0x02, _ase, 0x09, 0x04), \
+	ASCS_QOS_REQ(_ase, 0x10, 0x27, 0x00, 0x00, 0x80), \
+	ASE_CP_RSP(0x02, _ase, 0x09, 0x05)
+
+#define ASCS_QOS_INVALID_STATE(_ase) \
+	DISC_SRC_ASE_LC3, \
+	ASCS_QOS_REQ(_ase, 0x10, 0x27, 0x00, 0x00, 0x80), \
+	ASE_CP_RSP(0x02, _ase, 0x04, 0x00)
+
+#define ASCS_CP_UNSUPPORTED(_op) \
+	DISC_SRC_ASE_LC3, \
+	IOV_DATA(0x12, CP_HND, _op, 0x01), \
+	IOV_DATA(0x13), \
+	IOV_DATA(0x1b, CP_HND, _op, 0xff, 0x00, 0x01, 0x00)
+
+#define ASCS_METADATA_FOLLOWING_UNSUPPORTED(_ase) \
+	SCC_SRC_ENABLE, \
+	IOV_DATA(0x52, CP_HND, 0x07, 0x01, _ase, 0x06, \
+			0x03, 0x02, 0x01, 0x00, 0x01, 0xf0), \
+	ASE_CP_RSP(0x07, _ase, 0x0a, 0xf0)
+
+static void test_ascs_sr_spe(void)
+{
+	define_test("ASCS/SR/SPE/BI-01-C",
+			test_setup_server, test_server, NULL,
+			ASCS_CP_UNSUPPORTED(0xff));
+	define_test("ASCS/SR/SPE/BI-07-C",
+			test_setup_server, test_server, NULL,
+			ASCS_CONFIG_CODEC_INVALID(SRC_ID(0)));
+	define_test("ASCS/SR/SPE/BI-08-C",
+			test_setup_server, test_server, NULL,
+			ASCS_QOS_INVALID(SRC_ID(0)));
+	define_test("ASCS/SR/SPE/BI-09-C",
+			test_setup_server, test_server, &cfg_src_enable,
+			ASCS_METADATA_FOLLOWING_UNSUPPORTED(SRC_ID(0)));
+	define_test("ASCS/SR/SPE/BI-10-C",
+			test_setup_server, test_server, NULL,
+			ASCS_QOS_INVALID_STATE(SRC_ID(0)));
+}
+
 static void test_spe(void)
 {
 	test_usr_spe();
 }
 
+static void test_ascs(void)
+{
+	test_ascs_sr_spe();
+}
+
 #define SNK_ENABLE \
 	IOV_DATA(0x52, 0x22, 0x00, 0x03, 0x01, 0x01, 0x04, 0x03, 0x02, 0x01, \
 			00), \
@@ -10405,6 +10476,7 @@ int main(int argc, char *argv[])
 
 	test_disc();
 	test_spe();
+	test_ascs();
 	test_scc();
 	test_bsrc_scc();
 	test_bsnk_scc();
