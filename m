Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3665935A948
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052923; cv=pass; b=ODThhNMo2047iCfcAH0gUXxRcMDMrH2L+MD+GUfpook6OT+OBbRH64sdNWsE+X0MkXRBxuzUPB/QfyRwfxNLBt5L8b0XsMbSe1gsqUOcxiVJd9L22+foTZeG5Atglho1vuhKYg80fcC6dOA2xr7UigiSI1oISmO5I7+Uc12QMuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052923; c=relaxed/simple;
	bh=pLoGxnuWtmbxrGt53cUVkyyCtaiisbPkQuHUC3v8MZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzEi8PMJWY1CtIeT4feYwWphN6fAANNeBcilcZrh7CiFRJgLvaqCIpaIiuBQbwAPbeUq+H4a9pU6w0R8RrhXbNgB4CEdlqzYRMSrUrFwXPBTBHQKPwJWoebSEZkf6DkaCxSCh60Vd0CrpmeOXjud4FOsS1pTll/drx0aenH5fJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=xo6FN+o/; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="xo6FN+o/"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d6mbn2zJSz104b;
	Thu, 13 Nov 2025 18:55:17 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763052917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2MIV5nGhe5HTeSwNx/I0sCd6O+3WmrpnlgE6VUwlfC0=;
	b=xo6FN+o/aF2JymlBKLqahcEcSmPzuDNxdmXWBUjeIp5KMKRWDc7+SWyrmwBkpED9KvNOpS
	7xABxMUyJDAqud7CJw+GlB79iE1uzp1X75PLrZWtBK9VGnargyXAnJUyJOq0YPypGV5fdQ
	LlshZ0tzt3L7BeWeJCGVyz9vZgoY7X8=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763052917;
	b=koDRNegBfuD3MOKbeyXx8EtVx97j9UyB/MY/EvlQlDHT+MMO1I3r301P3AW8GvmovXupeR
	bsb6IrZu0B3ldtTPOyVgTg5twStV+IMc8ahqqLVXLMvyIsuJCmCvXQiV3fS3f1CVislM0S
	INg0HbgGSHhcCQXqxmMB5vm5xGNMMlo=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763052917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2MIV5nGhe5HTeSwNx/I0sCd6O+3WmrpnlgE6VUwlfC0=;
	b=k3zTBkeCxHlVyWOl9V51cndgf9e9xPTJ1czz0u6dNdNvDaxwUmjHdPdJDCSr8W0Zpv8SCh
	I7KnntI9zMaC2u+kWk4K2e7wKgjj2mY+GAnU5qymd4VVvjScCkoszMoYMpHG+Zbbn7bQdz
	+D8WbnLShs9ZUyfmAoliJhwItjs5sss=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 3/4] test-bap: add tests for bt_bap_select()
Date: Thu, 13 Nov 2025 18:55:11 +0200
Message-ID: <55f2fbe7c18f8c6b04bf8b4af161ceee3ac825c4.1763052876.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <69ef74b5d531804f4f793f42032da508d1497d1b.1763052876.git.pav@iki.fi>
References: <69ef74b5d531804f4f793f42032da508d1497d1b.1763052876.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic tests for bt_bap_select(), for configurations in BAP.TS. 4.10.

UCL Select LC3 AC 1 (0a)
UCL Select LC3 AC 1 (0b)
UCL Select LC3 AC 1 (0c)
UCL Select LC3 AC 1 (0d)
UCL Select LC3 AC 1 (1)
UCL Select LC3 AC 1 (1a)
UCL Select LC3 AC 1 (1b)
UCL Select LC3 AC 1 (1c)
UCL Select LC3 AC 4 (2)
UCL Select LC3 AC 4 (2a)
UCL Select LC3 AC 4 (2b)
UCL Select LC3 AC 4 (2c)
UCL Select LC3 AC 2 (0a)
UCL Select LC3 AC 2 (0b)
UCL Select LC3 AC 2 (0c)
UCL Select LC3 AC 2 (0d)
UCL Select LC3 AC 2 (1)
UCL Select LC3 AC 2 (1a)
UCL Select LC3 AC 2 (1b)
UCL Select LC3 AC 2 (1c)
UCL Select LC3 AC 10 (2)
UCL Select LC3 AC 10 (2a)
UCL Select LC3 AC 10 (2b)
UCL Select LC3 AC 10 (2c)
UCL Select LC3 AC 3
UCL Select LC3 AC 5
UCL Select LC3 AC 7i
UCL Select VS AC 7i
UCL Select LC3 AC 6i
UCL Select LC3 AC 6ii L
UCL Select LC3 AC 6ii R
UCL Select LC3 AC 9i
UCL Select LC3 AC 9ii L
UCL Select LC3 AC 9ii R
UCL Select LC3 AC 8i
UCL Select LC3 AC 8ii L
UCL Select LC3 AC 8ii R
UCL Select LC3 AC 11i
UCL Select LC3 AC 11ii L
UCL Select LC3 AC 11ii R
UCL Select LC3 Many 2
UCL Select LC3 Many 8
---

Notes:
    v2:
    - fix checking stream counts
    - fix VS test
    - fail tests with tester_test_failed() instead of g_assert()

 unit/test-bap.c | 753 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 748 insertions(+), 5 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index b1d1a42f1..6af6c3871 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -44,6 +44,12 @@ struct test_config {
 	uint8_t state;
 	bt_bap_state_func_t state_func;
 	uint8_t streams;
+	uint32_t snk_locations[4];
+	uint32_t src_locations[4];
+	struct bt_bap_pac_qos *pac_qos;
+	struct iovec *pac_caps;
+	const struct iovec *setup_data;
+	size_t setup_data_len;
 };
 
 struct test_data {
@@ -105,6 +111,10 @@ static struct bt_bap_pac_qos lc3_qos = {
 		data.caps = &lc3_caps;				\
 		data.qos = &lc3_qos;				\
 		data.cfg = _cfg;				\
+		if (data.cfg && data.cfg->pac_caps)		\
+			data.caps = data.cfg->pac_caps;		\
+		if (data.cfg && data.cfg->pac_qos)		\
+			data.qos = data.cfg->pac_qos;		\
 		data.iovcnt = ARRAY_SIZE(iov_data(args));	\
 		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov_data(args))); \
 		data.streams = queue_new(); \
@@ -325,6 +335,185 @@ static const struct iovec setup_data[] = {
 	IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a),
 };
 
+static const struct iovec setup_data_no_location[] = {
+	/* ATT: Exchange MTU Response (0x03) len 2
+	 *   Server RX MTU: 64
+	 */
+	IOV_DATA(0x02, 0x40, 0x00),
+	/* ATT: Exchange MTU Request (0x02) len 2
+	 *    Client RX MTU: 64
+	 */
+	IOV_DATA(0x03, 0x40, 0x00),
+	/* ATT: Read By Type Request (0x08) len 6
+	 *   Handle range: 0x0001-0xffff
+	 *   Attribute type: Server Supported Features (0x2b3a)
+	 */
+	IOV_DATA(0x08, 0x01, 0x00, 0xff, 0xff, 0x3a, 0x2b),
+	/* ATT: Error Response (0x01) len 4
+	 *   Read By Type Request (0x08)
+	 *   Handle: 0x0001
+	 *   Error: Attribute Not Found (0x0a)
+	 */
+	IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a),
+	/*
+	 * ATT: Read By Group Type Request (0x10) len 6
+	 *   Handle range: 0x0001-0xffff
+	 *   Attribute group type: Primary Service (0x2800)
+	 */
+	IOV_DATA(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
+	/*
+	 * ATT: Read By Group Type Response (0x11) len 37
+	 *   Attribute data length: 6
+	 *   Attribute group list: 2 entries
+	 *   Handle range: 0x0001-0x0013
+	 *   UUID: Published Audio Capabilities (0x1850)
+	 *   Handle range: 0x0014-0x0023
+	 *   UUID: Audio Stream Control (0x184e)
+	 */
+	IOV_DATA(0x11, 0x06,
+		0x01, 0x00, 0x13, 0x00, 0x50, 0x18,
+		0x14, 0x00, 0x23, 0x00, 0x4e, 0x18),
+	/* ATT: Read By Group Type Request (0x10) len 6
+	 *   Handle range: 0x0024-0xffff
+	 *   Attribute group type: Primary Service (0x2800)
+	 */
+	IOV_DATA(0x10, 0x24, 0x00, 0xff, 0xff, 0x00, 0x28),
+	/* ATT: Error Response (0x01) len 4
+	 *   Read By Group Type Request (0x10)
+	 *   Handle: 0x0024
+	 *   Error: Attribute Not Found (0x0a)
+	 */
+	IOV_DATA(0x01, 0x10, 0x24, 0x00, 0x0a),
+	/* ATT: Read By Group Type Request (0x10) len 6
+	 *   Handle range: 0x0001-0xffff
+	 *   Attribute group type: Secondary Service (0x2801)
+	 */
+	IOV_DATA(0x10, 0x01, 0x00, 0xff, 0xff, 0x01, 0x28),
+	/* ATT: Error Response (0x01) len 4
+	 *   Read By Group Type Request (0x10)
+	 *   Handle: 0x0001
+	 *   Error: Attribute Not Found (0x0a)
+	 */
+	IOV_DATA(0x01, 0x10, 0x01, 0x00, 0x0a),
+	/* ATT: Read By Type Request (0x08) len 6
+	 *   Handle range: 0x0001-0x0023
+	 *   Attribute group type: Include (0x2802)
+	 */
+	IOV_DATA(0x08, 0x01, 0x00, 0x23, 0x00, 0x02, 0x28),
+	/* ATT: Error Response (0x01) len 4
+	 *   Read By Group Type Request (0x10)
+	 *   Handle: 0x0001
+	 *   Error: Attribute Not Found (0x0a)
+	 */
+	IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a),
+	/* ATT: Read By Type Request (0x08) len 6
+	 *   Handle range: 0x0001-0x0023
+	 *   Attribute type: Characteristic (0x2803)
+	 */
+	IOV_DATA(0x08, 0x01, 0x00, 0x23, 0x00, 0x03, 0x28),
+	/* ATT: Read By Type Response (0x09) len 57
+	 * Attribute data length: 7
+	 * Attribute data list: 8 entries
+	 *   Handle: 0x0002
+	 *   Value: 120300c92b
+	 *   Properties: 0x12
+	 *     Read (0x02)
+	 *     Notify (0x10)
+	 *   Value Handle: 0x0003
+	 *   Value UUID: Sink PAC (0x2bc9)
+	 *   Handle: 0x0008
+	 *   Value: 120900cb2b
+	 *   Properties: 0x12
+	 *     Read (0x02)
+	 *     Notify (0x10)
+	 *   Value Handle: 0x0009
+	 *   Value UUID: Source PAC (0x2bcb)
+	 *  Handle: 0x000e
+	 *  Value: 120f00cd2b
+	 *  Properties: 0x12
+	 *    Read (0x02)
+	 *    Notify (0x10)
+	 *  Value Handle: 0x000f
+	 *  Value UUID: Available Audio Contexts (0x2bcd)
+	 *  Handle: 0x0011
+	 *  Value: 121200ce2b
+	 *  Properties: 0x12
+	 *    Read (0x02)
+	 *    Notify (0x10)
+	 *  Value Handle: 0x0012
+	 *  Value UUID: Supported Audio Contexts (0x2bce)
+	 *  Handle: 0x0015
+	 *  Value: 121600c42b
+	 *  Properties: 0x12
+	 *    Read (0x02)
+	 *    Notify (0x10)
+	 *  Value Handle: 0x0016
+	 *  Value UUID: Sink ASE (0x2bc4)
+	 *   Handle: 0x001b
+	 *   Value: 121c00c52b
+	 *   Properties: 0x12
+	 *     Read (0x02)
+	 *     Notify (0x10)
+	 *   Value Handle: 0x001c
+	 *   Value UUID: Source ASE (0x2bc5)
+	 *   Handle: 0x0021
+	 *   Value: 182200c62b
+	 *   Properties: 0x18
+	 *     Write (0x08)
+	 *     Notify (0x10)
+	 *   Value Handle: 0x0022
+	 *   Value UUID: ASE Control Point (0x2bc6)
+	 */
+	IOV_DATA(0x09, 0x07,
+		/* keep same IDs as above, leaving holes */
+		0x02, 0x00, 0x12, 0x03, 0x00, 0xc9, 0x2b,
+		0x08, 0x00, 0x12, 0x09, 0x00, 0xcb, 0x2b,
+		0x0e, 0x00, 0x12, 0x0f, 0x00, 0xcd, 0x2b,
+		0x11, 0x00, 0x12, 0x12, 0x00, 0xce, 0x2b,
+		0x15, 0x00, 0x12, 0x16, 0x00, 0xc4, 0x2b,
+		0x1b, 0x00, 0x12, 0x1c, 0x00, 0xc5, 0x2b,
+		0x21, 0x00, 0x18, 0x22, 0x00, 0xc6, 0x2b),
+	/* ATT: Read By Type Request (0x08) len 6
+	 *   Handle range: 0x0022-0x0023
+	 *   Attribute type: Characteristic (0x2803)
+	 */
+	IOV_DATA(0x08, 0x22, 0x00, 0x23, 0x00, 0x03, 0x28),
+	/* ATT: Error Response (0x01) len 4
+	 *   Read By Type Request (0x08)
+	 *   Handle: 0x0022
+	 *   Error: Attribute Not Found (0x0a)
+	 */
+	IOV_DATA(0x01, 0x08, 0x22, 0x00, 0x0a),
+	/* ATT: Find Information Request (0x04) */
+	IOV_DATA(0x04, 0x04, 0x00, 0x07, 0x00),
+	/* ATT: Error Response */
+	IOV_DATA(0x01, 0x04, 0x04, 0x00, 0x0a),
+	/* ATT: Find Information Request (0x04) */
+	IOV_DATA(0x04, 0x0a, 0x00, 0x0d, 0x00),
+	/* ATT: Error Response */
+	IOV_DATA(0x01, 0x04, 0x0a, 0x00, 0x0a),
+	/* ATT: Find Information Request (0x04) */
+	IOV_DATA(0x04, 0x17, 0x00, 0x1a, 0x00),
+	/* ATT: Error Response */
+	IOV_DATA(0x01, 0x04, 0x17, 0x00, 0x0a),
+	/* ATT: Find Information Request (0x04) */
+	IOV_DATA(0x04, 0x1d, 0x00, 0x20, 0x00),
+	/* ATT: Error Response */
+	IOV_DATA(0x01, 0x04, 0x1d, 0x00, 0x0a),
+	/* ACL Data TX: Handle 42 flags 0x00 dlen 11
+	 *   ATT: Read By Type Request (0x08) len 6
+	 *   Handle range: 0x0001-0xffff
+	 *   Attribute type: Database Hash (0x2b2a)
+	 */
+	IOV_DATA(0x08, 0x01, 0x00, 0xff, 0xff, 0x2a, 0x2b),
+	/* ATT: Error Response (0x01) len 4
+	 *   Read By Type Request (0x08)
+	 *   Handle: 0x0001
+	 *   Error: Attribute Not Found (0x0a)
+	 */
+	IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a),
+};
+
 static void print_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
@@ -340,7 +529,11 @@ static void test_setup(const void *user_data)
 	struct gatt_db *db;
 	struct io *io;
 
-	io = tester_setup_io(setup_data, ARRAY_SIZE(setup_data));
+	if (!data->cfg || !data->cfg->setup_data)
+		io = tester_setup_io(setup_data, ARRAY_SIZE(setup_data));
+	else
+		io = tester_setup_io(data->cfg->setup_data,
+						data->cfg->setup_data_len);
 	g_assert(io);
 
 	att = bt_att_new(io_get_fd(io), false);
@@ -454,11 +647,13 @@ static void test_setup_pacs(struct test_data *data)
 							"test-bap-snk",
 							BT_BAP_SINK, 0x0ff,
 							0x0001, 0x0001,
-							NULL, data->caps, NULL);
+							data->qos, data->caps,
+							NULL);
 		else
 			data->snk = bt_bap_add_pac(data->db, "test-bap-snk",
 							BT_BAP_SINK, LC3_ID,
-							NULL, data->caps, NULL);
+							data->qos, data->caps,
+							NULL);
 		g_assert(data->snk);
 	}
 
@@ -468,11 +663,13 @@ static void test_setup_pacs(struct test_data *data)
 							"test-bap-src",
 							BT_BAP_SOURCE, 0x0ff,
 							0x0001, 0x0001,
-							NULL, data->caps, NULL);
+							data->qos, data->caps,
+							NULL);
 		else
 			data->src = bt_bap_add_pac(data->db, "test-bap-src",
 							BT_BAP_SOURCE, LC3_ID,
-							NULL, data->caps, NULL);
+							data->qos, data->caps,
+							NULL);
 		g_assert(data->src);
 	}
 }
@@ -8686,6 +8883,551 @@ static void test_bsrc_str(void)
 	test_bsrc_str_2b();
 }
 
+/*
+ * Configuration selection: check example cases for BAP AC.
+ */
+
+#define LC3_PAC_CAPS_NO_COUNT \
+	0x06, 0x00, 0x00, 0x00, 0x00, 0x0d, 0x03, 0x01, \
+	0xff, 0x00, 0x02, 0x02, 0x03, 0x05, 0x04, \
+	0x1a, 0x00, 0xf0, 0x00, 0x00
+
+#define UNKNOWN_PAC_CAPS \
+	0xff, 0x02, 0x00, 0x01, 0x00, 0x00, 0x00
+
+/* BAP.TS 4.10.1 configurations */
+#define DISC_SELECT_SNK(loc, caps) \
+	DISC_SRC_ASE(loc, 0, IOV_CONTENT(caps), UNKNOWN_PAC_CAPS)
+
+#define DISC_SELECT_SNK_NO_LOC(caps) \
+	DISC_SRC_ASE_NO_LOCATION(IOV_CONTENT(caps), UNKNOWN_PAC_CAPS)
+
+#define DISC_SELECT_SRC(loc, caps) \
+	DISC_SRC_ASE(0, loc, UNKNOWN_PAC_CAPS, IOV_CONTENT(caps))
+
+#define DISC_SELECT_SRC_NO_LOC(caps) \
+	DISC_SRC_ASE_NO_LOCATION(UNKNOWN_PAC_CAPS, IOV_CONTENT(caps))
+
+#define DISC_SELECT_LC3_AC1_0a	DISC_SELECT_SNK(0, LC3_PAC_CAPS(0x01))
+#define DISC_SELECT_LC3_AC1_0b	DISC_SELECT_SNK(0, LC3_PAC_CAPS_NO_COUNT)
+#define DISC_SELECT_LC3_AC1_0c	DISC_SELECT_SNK_NO_LOC(LC3_PAC_CAPS(0x01))
+#define DISC_SELECT_LC3_AC1_0d	DISC_SELECT_SNK_NO_LOC(LC3_PAC_CAPS_NO_COUNT)
+
+#define DISC_SELECT_LC3_AC1_1	DISC_SELECT_SNK(0x2, LC3_PAC_CAPS(0x01))
+#define DISC_SELECT_LC3_AC1_1a	DISC_SELECT_SNK(0x2, LC3_PAC_CAPS(0x03))
+#define DISC_SELECT_LC3_AC1_1b	DISC_SELECT_SNK(0x22, LC3_PAC_CAPS(0x01))
+#define DISC_SELECT_LC3_AC1_1c	DISC_SELECT_SNK(0x22, LC3_PAC_CAPS(0x03))
+
+#define DISC_SELECT_LC3_AC4_2	DISC_SELECT_SNK(0x44, LC3_PAC_CAPS(0x02))
+#define DISC_SELECT_LC3_AC4_2a	DISC_SELECT_SNK(0x44, LC3_PAC_CAPS(0x03))
+#define DISC_SELECT_LC3_AC4_2b	DISC_SELECT_SNK(0x444, LC3_PAC_CAPS(0x02))
+#define DISC_SELECT_LC3_AC4_2c	DISC_SELECT_SNK(0x444, LC3_PAC_CAPS(0x03))
+
+#define DISC_SELECT_LC3_AC2_0a	DISC_SELECT_SRC(0, LC3_PAC_CAPS(0x01))
+#define DISC_SELECT_LC3_AC2_0b	DISC_SELECT_SRC(0, LC3_PAC_CAPS_NO_COUNT)
+#define DISC_SELECT_LC3_AC2_0c	DISC_SELECT_SRC_NO_LOC(LC3_PAC_CAPS(0x01))
+#define DISC_SELECT_LC3_AC2_0d	DISC_SELECT_SRC_NO_LOC(LC3_PAC_CAPS_NO_COUNT)
+
+#define DISC_SELECT_LC3_AC2_1	DISC_SELECT_SRC(0x2, LC3_PAC_CAPS(0x01))
+#define DISC_SELECT_LC3_AC2_1a	DISC_SELECT_SRC(0x2, LC3_PAC_CAPS(0x03))
+#define DISC_SELECT_LC3_AC2_1b	DISC_SELECT_SRC(0x22, LC3_PAC_CAPS(0x01))
+#define DISC_SELECT_LC3_AC2_1c	DISC_SELECT_SRC(0x22, LC3_PAC_CAPS(0x03))
+
+#define DISC_SELECT_LC3_AC10_2	DISC_SELECT_SRC(0x44, LC3_PAC_CAPS(0x02))
+#define DISC_SELECT_LC3_AC10_2a	DISC_SELECT_SRC(0x44, LC3_PAC_CAPS(0x03))
+#define DISC_SELECT_LC3_AC10_2b	DISC_SELECT_SRC(0x444, LC3_PAC_CAPS(0x02))
+#define DISC_SELECT_LC3_AC10_2c	DISC_SELECT_SRC(0x444, LC3_PAC_CAPS(0x03))
+
+/* BAP.TS 4.10.2 configurations */
+#define DISC_SELECT_VS_AC1_1	DISC_SELECT_SNK(0x2, VS_PAC_CAPS_NO_COUNT)
+#define DISC_SELECT_VS_AC1_2	DISC_SELECT_SNK(0x44, VS_PAC_CAPS(0x01))
+#define DISC_SELECT_VS_AC2_1	DISC_SELECT_SRC(0x2, VS_PAC_CAPS_NO_COUNT)
+#define DISC_SELECT_VS_AC2_2	DISC_SELECT_SRC(0x44, VS_PAC_CAPS(0x01))
+
+/* BAP.TS 4.10.3 configurations
+ * Assumed Channels/Locations applies only to Sink ASE, as it's supposed
+ * to test AC 3, 5, 7(i)
+ */
+#define DISC_SELECT_LC3_AC3	DISC_SRC_ASE(0x1, 0x1, LC3_PAC_CAPS(0x01), \
+							LC3_PAC_CAPS(0x01))
+#define DISC_SELECT_LC3_AC5	DISC_SRC_ASE(0x22, 0x2, LC3_PAC_CAPS(0x02), \
+							LC3_PAC_CAPS(0x01))
+#define DISC_SELECT_LC3_AC7i	DISC_SRC_ASE(0x4, 0x4, LC3_PAC_CAPS(0x01), \
+							LC3_PAC_CAPS(0x01))
+
+/* BAP.TS 4.10.4 configurations */
+#define DISC_SELECT_VS_AC3	DISC_SRC_ASE(0x1, 0x1, VS_PAC_CAPS(0x01), \
+							VS_PAC_CAPS(0x01))
+#define DISC_SELECT_VS_AC5	DISC_SRC_ASE(0x22, 0x2, VS_PAC_CAPS(0x02), \
+							VS_PAC_CAPS(0x01))
+#define DISC_SELECT_VS_AC7i	DISC_SRC_ASE(0x4, 0x4, VS_PAC_CAPS(0x01), \
+							VS_PAC_CAPS(0x01))
+
+/* BAP.TS 4.10.5 configurations */
+#define DISC_SELECT_LC3_AC7ii_L	DISC_SELECT_SNK(0x01, LC3_PAC_CAPS(0x01))
+#define DISC_SELECT_LC3_AC7ii_R	DISC_SELECT_SRC(0x10, LC3_PAC_CAPS(0x01))
+
+/* BAP.TS 4.10.6 configurations */
+#define DISC_SELECT_LC3_AC6i	DISC_SELECT_SNK(0x11, LC3_PAC_CAPS(0x01))
+#define DISC_SELECT_VS_AC6i	DISC_SELECT_SNK(0x11, VS_PAC_CAPS(0x01))
+
+/* BAP.TS 4.10.7 configurations */
+#define DISC_SELECT_LC3_AC6ii_L	DISC_SELECT_SNK(0x01, LC3_PAC_CAPS(0x01))
+#define DISC_SELECT_LC3_AC6ii_R	DISC_SELECT_SNK(0x10, LC3_PAC_CAPS(0x01))
+#define DISC_SELECT_VS_AC6ii_L	DISC_SELECT_SNK(0x01, VS_PAC_CAPS(0x01))
+#define DISC_SELECT_VS_AC6ii_R	DISC_SELECT_SNK(0x10, VS_PAC_CAPS(0x01))
+
+/* BAP.TS 4.10.8 configurations */
+#define DISC_SELECT_LC3_AC9i	DISC_SELECT_SRC(0x11, LC3_PAC_CAPS(0x01))
+#define DISC_SELECT_VS_AC9i	DISC_SELECT_SRC(0x11, VS_PAC_CAPS(0x01))
+
+/* BAP.TS 4.10.9 configurations */
+#define DISC_SELECT_LC3_AC9ii_L DISC_SELECT_SRC(0x01, LC3_PAC_CAPS(0x01))
+#define DISC_SELECT_LC3_AC9ii_R	DISC_SELECT_SRC(0x10, LC3_PAC_CAPS(0x01))
+
+/* BAP.TS 4.10.10 configurations */
+#define DISC_SELECT_LC3_AC8i	DISC_SRC_ASE(0x11, 0x02, \
+					LC3_PAC_CAPS(0x01), LC3_PAC_CAPS(0x01))
+
+/* BAP.TS 4.10.11 configurations */
+#define DISC_SELECT_LC3_AC8ii_L	DISC_SELECT_SNK(0x1, LC3_PAC_CAPS(0x01))
+#define DISC_SELECT_LC3_AC8ii_R	DISC_SRC_ASE(0x10, 0x2, \
+					LC3_PAC_CAPS(0x01), LC3_PAC_CAPS(0x01))
+
+/* BAP.TS 4.10.12 configurations */
+#define DISC_SELECT_LC3_AC11i	DISC_SRC_ASE(0x11, 0x22, \
+					LC3_PAC_CAPS(0x01), LC3_PAC_CAPS(0x01))
+
+/* BAP.TS 4.10.13 configurations */
+#define DISC_SELECT_LC3_AC11ii_L DISC_SRC_ASE(0x01, 0x02, \
+					LC3_PAC_CAPS(0x01), LC3_PAC_CAPS(0x01))
+#define DISC_SELECT_LC3_AC11ii_R DISC_SRC_ASE(0x10, 0x20, \
+					LC3_PAC_CAPS(0x01), LC3_PAC_CAPS(0x01))
+#define DISC_SELECT_VS_AC11i_L	DISC_SRC_ASE(0x01, 0x02, \
+					VS_PAC_CAPS(0x01), VS_PAC_CAPS(0x01))
+#define DISC_SELECT_VS_AC11i_R	DISC_SRC_ASE(0x10, 0x20, \
+					VS_PAC_CAPS(0x01), VS_PAC_CAPS(0x01))
+
+/* Expected bt_bap_select() results */
+
+static struct test_config cfg_select_ac1_0ab = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0, -1 },
+	.src_locations = { -1 },
+};
+
+static struct test_config cfg_select_ac1_0cd = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0, -1 },
+	.src_locations = { -1 },
+	.setup_data = setup_data_no_location,
+	.setup_data_len = ARRAY_SIZE(setup_data_no_location),
+};
+
+static struct test_config cfg_select_ac1_1 = {
+	.snk = true,
+	.src = true,
+	.streams = 1,  /* force 1 channel; caps support also AC 4 & 6(i) */
+	.snk_locations = { 0x2, -1 },
+	.src_locations = { -1 },
+};
+
+static struct test_config cfg_select_ac4_2 = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x44, -1 },
+	.src_locations = { -1 },
+};
+
+static struct test_config cfg_select_ac2_0ab = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { -1 },
+	.src_locations = { 0, -1 },
+};
+
+static struct test_config cfg_select_ac2_0cd = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { -1 },
+	.src_locations = { 0, -1 },
+	.setup_data = setup_data_no_location,
+	.setup_data_len = ARRAY_SIZE(setup_data_no_location),
+};
+
+static struct test_config cfg_select_ac2_1 = {
+	.snk = true,
+	.src = true,
+	.streams = 1,
+	.snk_locations = { -1 },
+	.src_locations = { 0x2, -1 },
+};
+
+static struct test_config cfg_select_ac10_2 = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { -1 },
+	.src_locations = { 0x44, -1 },
+};
+
+static struct test_config cfg_select_ac3 = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x1, -1 },
+	.src_locations = { 0x1, -1 },
+};
+
+static struct test_config cfg_select_ac5 = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x22, -1 },
+	.src_locations = { 0x2, -1 },
+};
+
+static struct test_config cfg_select_ac7i = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x4, -1 },
+	.src_locations = { 0x4, -1 },
+};
+
+static struct test_config cfg_select_vs_ac7i = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x4, -1 },
+	.src_locations = { 0x4, -1 },
+	.vs = true,
+};
+
+static struct test_config cfg_select_ac6i = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x1, 0x10, -1 },
+	.src_locations = { -1 },
+};
+
+static struct test_config cfg_select_ac6ii_L = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x1, -1 },
+	.src_locations = { -1 },
+};
+
+static struct test_config cfg_select_ac6ii_R = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x10, -1 },
+	.src_locations = { -1 },
+};
+
+static struct test_config cfg_select_ac9i = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { -1 },
+	.src_locations = { 0x1, 0x10, -1 },
+};
+
+static struct test_config cfg_select_ac9ii_L = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { -1 },
+	.src_locations = { 0x1, -1 },
+};
+
+static struct test_config cfg_select_ac9ii_R = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { -1 },
+	.src_locations = { 0x10, -1 },
+};
+
+static struct test_config cfg_select_ac8i = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x1, 0x10, -1 },
+	.src_locations = { 0x2, -1 },
+};
+
+static struct test_config cfg_select_ac8ii_L = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x1, -1 },
+	.src_locations = { -1 },
+};
+
+static struct test_config cfg_select_ac8ii_R = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x10, -1 },
+	.src_locations = { 0x2, -1 },
+};
+
+static struct test_config cfg_select_ac11i = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x1, 0x10, -1 },
+	.src_locations = { 0x2, 0x20, -1 },
+};
+
+static struct test_config cfg_select_ac11ii_L = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x1, -1 },
+	.src_locations = { 0x2, -1 },
+};
+
+static struct test_config cfg_select_ac11ii_R = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x10, -1 },
+	.src_locations = { 0x20, -1 },
+};
+
+/* Additional bt_bap_select() tests */
+
+#define DISC_SELECT_MANY \
+	DISC_SRC_ASE(0x000000ff, 0, LC3_PAC_CAPS(0xf), UNKNOWN_PAC_CAPS)
+
+static struct iovec caps_select_snk_many =
+	LC3_CAPABILITIES(LC3_FREQ_ANY, LC3_DURATION_ANY, 0x0a, 26, 240);
+
+static struct test_config cfg_select_many_2 = {
+	.snk = true,
+	.snk_locations = { 0x00000003, -1 },
+	.src_locations = { -1 },
+	.pac_caps = &caps_select_snk_many,
+};
+
+static struct test_config cfg_select_many_8 = {
+	.snk = true,
+	.streams = 8,
+	.snk_locations = { 0x0000000f, 0x000000f0, -1 },
+	.src_locations = { -1 },
+	.pac_caps = &caps_select_snk_many,
+};
+
+struct test_select_data {
+	struct test_data *data;
+	unsigned int num_src;
+	unsigned int num_snk;
+	uint32_t src_locations[4];
+	uint32_t snk_locations[4];
+};
+
+static bool test_select_pac(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
+								void *user_data)
+{
+	struct test_select_data *sdata = user_data;
+	struct test_config *cfg = sdata->data->cfg;
+	int err, count = 0;
+
+	err = bt_bap_select(sdata->data->bap, lpac, rpac, cfg->streams, &count,
+							(void *)0x1, sdata);
+	if (err)
+		tester_test_failed();
+
+	return false;
+}
+
+static void bap_select_ready(struct bt_bap *bap, void *user_data)
+{
+	struct test_select_data sdata = {
+		.data = (void *)user_data,
+	};
+	struct test_config *cfg = sdata.data->cfg;
+	unsigned int i;
+
+	bt_bap_foreach_pac(bap, BT_BAP_SINK, test_select_pac, &sdata);
+	bt_bap_foreach_pac(bap, BT_BAP_SOURCE, test_select_pac, &sdata);
+
+	for (i = 0; i < sdata.num_snk; ++i)
+		if (sdata.snk_locations[i] != cfg->snk_locations[i])
+			goto fail;
+	if (i < ARRAY_SIZE(cfg->snk_locations) &&
+			cfg->snk_locations[i] != (uint32_t)-1)
+		goto fail;
+
+	for (i = 0; i < sdata.num_src; ++i)
+		if (sdata.src_locations[i] != cfg->src_locations[i])
+			goto fail;
+	if (i < ARRAY_SIZE(cfg->src_locations) &&
+			cfg->src_locations[i] != (uint32_t)-1)
+		goto fail;
+
+	tester_test_passed();
+	return;
+
+fail:
+	tester_test_failed();
+}
+
+static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
+			uint32_t location, struct bt_bap_pac_qos *qos,
+			bt_bap_pac_select_t cb, void *cb_data, void *user_data)
+{
+	struct test_select_data *sdata = cb_data;
+
+	if (bt_bap_pac_get_type(rpac) == BT_BAP_SINK) {
+		if (sdata->num_snk >= ARRAY_SIZE(sdata->snk_locations))
+			goto fail;
+		tester_debug("select SNK 0x%08x", location);
+		sdata->snk_locations[sdata->num_snk++] = location;
+	} else {
+		if (sdata->num_src >= ARRAY_SIZE(sdata->src_locations))
+			goto fail;
+		tester_debug("select SRC 0x%08x", location);
+		sdata->src_locations[sdata->num_src++] = location;
+	}
+
+	return 0;
+
+fail:
+	tester_test_failed();
+	return 0;
+}
+
+static struct bt_bap_pac_ops test_select_pac_ops = {
+	.select = pac_select,
+};
+
+static void test_select(const void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+	struct io *io;
+
+	io = tester_setup_io(data->iov, data->iovcnt);
+	g_assert(io);
+
+	tester_io_set_complete_func(NULL);
+
+	data->db = gatt_db_new();
+	g_assert(data->db);
+
+	test_setup_pacs(data);
+
+	if (data->snk)
+		bt_bap_pac_set_ops(data->snk, &test_select_pac_ops, NULL);
+	if (data->src)
+		bt_bap_pac_set_ops(data->src, &test_select_pac_ops, NULL);
+
+	data->bap = bt_bap_new(data->db, bt_gatt_client_get_db(data->client));
+	g_assert(data->bap);
+
+	bt_bap_set_debug(data->bap, print_debug, "bt_bap:", NULL);
+
+	bt_bap_ready_register(data->bap, bap_select_ready, data, NULL);
+
+	bt_bap_attach(data->bap, data->client);
+}
+
+static void test_ucl_select(void)
+{
+	define_test("UCL Select LC3 AC 1 (0a)", test_setup, test_select,
+				&cfg_select_ac1_0ab, DISC_SELECT_LC3_AC1_0a);
+	define_test("UCL Select LC3 AC 1 (0b)", test_setup, test_select,
+				&cfg_select_ac1_0ab, DISC_SELECT_LC3_AC1_0b);
+	define_test("UCL Select LC3 AC 1 (0c)", test_setup, test_select,
+				&cfg_select_ac1_0cd, DISC_SELECT_LC3_AC1_0c);
+	define_test("UCL Select LC3 AC 1 (0d)", test_setup, test_select,
+				&cfg_select_ac1_0cd, DISC_SELECT_LC3_AC1_0d);
+
+	define_test("UCL Select LC3 AC 1 (1)", test_setup, test_select,
+				&cfg_select_ac1_1, DISC_SELECT_LC3_AC1_1);
+	define_test("UCL Select LC3 AC 1 (1a)", test_setup, test_select,
+				&cfg_select_ac1_1, DISC_SELECT_LC3_AC1_1a);
+	define_test("UCL Select LC3 AC 1 (1b)", test_setup, test_select,
+				&cfg_select_ac1_1, DISC_SELECT_LC3_AC1_1b);
+	define_test("UCL Select LC3 AC 1 (1c)", test_setup, test_select,
+				&cfg_select_ac1_1, DISC_SELECT_LC3_AC1_1c);
+
+	define_test("UCL Select LC3 AC 4 (2)", test_setup, test_select,
+				&cfg_select_ac4_2, DISC_SELECT_LC3_AC4_2);
+	define_test("UCL Select LC3 AC 4 (2a)", test_setup, test_select,
+				&cfg_select_ac4_2, DISC_SELECT_LC3_AC4_2a);
+	define_test("UCL Select LC3 AC 4 (2b)", test_setup, test_select,
+				&cfg_select_ac4_2, DISC_SELECT_LC3_AC4_2b);
+	define_test("UCL Select LC3 AC 4 (2c)", test_setup, test_select,
+				&cfg_select_ac4_2, DISC_SELECT_LC3_AC4_2c);
+
+	define_test("UCL Select LC3 AC 2 (0a)", test_setup, test_select,
+				&cfg_select_ac2_0ab, DISC_SELECT_LC3_AC2_0a);
+	define_test("UCL Select LC3 AC 2 (0b)", test_setup, test_select,
+				&cfg_select_ac2_0ab, DISC_SELECT_LC3_AC2_0b);
+	define_test("UCL Select LC3 AC 2 (0c)", test_setup, test_select,
+				&cfg_select_ac2_0cd, DISC_SELECT_LC3_AC2_0c);
+	define_test("UCL Select LC3 AC 2 (0d)", test_setup, test_select,
+				&cfg_select_ac2_0cd, DISC_SELECT_LC3_AC2_0d);
+
+	define_test("UCL Select LC3 AC 2 (1)", test_setup, test_select,
+				&cfg_select_ac2_1, DISC_SELECT_LC3_AC2_1);
+	define_test("UCL Select LC3 AC 2 (1a)", test_setup, test_select,
+				&cfg_select_ac2_1, DISC_SELECT_LC3_AC2_1a);
+	define_test("UCL Select LC3 AC 2 (1b)", test_setup, test_select,
+				&cfg_select_ac2_1, DISC_SELECT_LC3_AC2_1b);
+	define_test("UCL Select LC3 AC 2 (1c)", test_setup, test_select,
+				&cfg_select_ac2_1, DISC_SELECT_LC3_AC2_1c);
+
+	define_test("UCL Select LC3 AC 10 (2)", test_setup, test_select,
+				&cfg_select_ac10_2, DISC_SELECT_LC3_AC10_2);
+	define_test("UCL Select LC3 AC 10 (2a)", test_setup, test_select,
+				&cfg_select_ac10_2, DISC_SELECT_LC3_AC10_2a);
+	define_test("UCL Select LC3 AC 10 (2b)", test_setup, test_select,
+				&cfg_select_ac10_2, DISC_SELECT_LC3_AC10_2b);
+	define_test("UCL Select LC3 AC 10 (2c)", test_setup, test_select,
+				&cfg_select_ac10_2, DISC_SELECT_LC3_AC10_2c);
+
+	define_test("UCL Select LC3 AC 3", test_setup, test_select,
+				&cfg_select_ac3, DISC_SELECT_LC3_AC3);
+	define_test("UCL Select LC3 AC 5", test_setup, test_select,
+				&cfg_select_ac5, DISC_SELECT_LC3_AC5);
+	define_test("UCL Select LC3 AC 7i", test_setup, test_select,
+				&cfg_select_ac7i, DISC_SELECT_LC3_AC7i);
+
+	define_test("UCL Select VS AC 7i", test_setup, test_select,
+				&cfg_select_vs_ac7i, DISC_SELECT_VS_AC7i);
+
+	define_test("UCL Select LC3 AC 6i", test_setup, test_select,
+				&cfg_select_ac6i, DISC_SELECT_LC3_AC6i);
+
+	define_test("UCL Select LC3 AC 6ii L", test_setup, test_select,
+				&cfg_select_ac6ii_L, DISC_SELECT_LC3_AC6ii_L);
+	define_test("UCL Select LC3 AC 6ii R", test_setup, test_select,
+				&cfg_select_ac6ii_R, DISC_SELECT_LC3_AC6ii_R);
+
+	define_test("UCL Select LC3 AC 9i", test_setup, test_select,
+				&cfg_select_ac9i, DISC_SELECT_LC3_AC9i);
+
+	define_test("UCL Select LC3 AC 9ii L", test_setup, test_select,
+				&cfg_select_ac9ii_L, DISC_SELECT_LC3_AC9ii_L);
+	define_test("UCL Select LC3 AC 9ii R", test_setup, test_select,
+				&cfg_select_ac9ii_R, DISC_SELECT_LC3_AC9ii_R);
+
+	define_test("UCL Select LC3 AC 8i", test_setup, test_select,
+				&cfg_select_ac8i, DISC_SELECT_LC3_AC8i);
+
+	define_test("UCL Select LC3 AC 8ii L", test_setup, test_select,
+				&cfg_select_ac8ii_L, DISC_SELECT_LC3_AC8ii_L);
+	define_test("UCL Select LC3 AC 8ii R", test_setup, test_select,
+				&cfg_select_ac8ii_R, DISC_SELECT_LC3_AC8ii_R);
+
+	define_test("UCL Select LC3 AC 11i", test_setup, test_select,
+				&cfg_select_ac11i, DISC_SELECT_LC3_AC11i);
+
+	define_test("UCL Select LC3 AC 11ii L", test_setup, test_select,
+				&cfg_select_ac11ii_L, DISC_SELECT_LC3_AC11ii_L);
+
+	define_test("UCL Select LC3 AC 11ii R", test_setup, test_select,
+				&cfg_select_ac11ii_R, DISC_SELECT_LC3_AC11ii_R);
+
+	define_test("UCL Select LC3 Many 2", test_setup, test_select,
+				&cfg_select_many_2, DISC_SELECT_MANY);
+
+	define_test("UCL Select LC3 Many 8", test_setup, test_select,
+				&cfg_select_many_8, DISC_SELECT_MANY);
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -8696,6 +9438,7 @@ int main(int argc, char *argv[])
 	test_bsnk_scc();
 	test_bsnk_str();
 	test_bsrc_str();
+	test_ucl_select();
 
 	return tester_run();
 }
-- 
2.51.1

