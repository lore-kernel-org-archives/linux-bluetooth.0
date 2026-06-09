Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B63E3F58E7
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000778; cv=none; b=HO+b87APjRwvyqnLTE8tDNQehhelrNrRcPFgJww1NDnfk6zC0PQeWqDuR2Xwsrp2uGYn6CQrw5h9MXchylOKH12EPIfkqHipFpX5w+KX2tKPXWRqfKcXOlAQH+g1RiPD6dRlUSe4OBvXohzp9mH4qXqWRBs8GtGXot9utqGLPsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000778; c=relaxed/simple;
	bh=rV5DspxWK02U00+TesXFoZ4Nsyb6PG3zvCc9fmTUMx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1RWtid8TZtcEHLDkkaOimY42DmN11yhMgms9nuGft7vz8fV+Pe2ek0oNJDKs4EbL70pmSdJmG2olryS01dzrMclyTjeStL60diDqySPrze/AHYtfBEfx0WK/PTv0SXOTZu9rRkvARFJFjW7aKBpQK9fW6TaP38w0g4K3IwJzRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SqHmHAPB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SqHmHAPB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1781000776;
	bh=rV5DspxWK02U00+TesXFoZ4Nsyb6PG3zvCc9fmTUMx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SqHmHAPBgFmgo1hY1T3Nw1kAWkjJVpOqPBjbUOx8K8fbPs0rdEXmPkO7x21qhyq6+
	 6C97jULVTgouhkFFHs0bhbxDKyHuVSJF+jiSUFBWlESvSnStXVKUHbx8DiaYPzL0wT
	 XZWm2y37bt2p5UXyN+ItaAKkQ4nhBECGPjN0QlHtC8OJ9V6w9gZoOGcWqmA8rgiZsj
	 dWw8IRxOPeKJikuRR55b1SiH1MNdGlTAKmRvhoccxtEfuhA+Eln2MwV0oq5THUOGhi
	 Rsls+b+/JfLcHqfilxWtt7tYmRXxzhwZEGE/vUlBGBcVNYdOfK3kLF6rW2T4te+VaF
	 n7Ixbpl0a4sZQ==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2908817E0D03;
	Tue,  9 Jun 2026 12:26:15 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghu447 <raghavendra.rao@collabora.com>
Subject: [BlueZ PATCH v3 2/2] unit/bap: add SPE tests
Date: Tue,  9 Jun 2026 15:55:48 +0530
Message-ID: <20260609102548.6887-3-raghavendra.rao@collabora.com>
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

Add unit tests for the PTS BAP/USR/SPE/BI-01[5]-C tests.
---
 unit/test-bap.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

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
