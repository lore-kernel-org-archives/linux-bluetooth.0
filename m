Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEieu81S"
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F46D138
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Dec 2023 14:15:45 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-464752da340so629461137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Dec 2023 14:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701728143; x=1702332943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6VARjn0CWiByFx2DKSnsDI32pinxmI34vf9VNZr5tg=;
        b=hEieu81S17cNSnuTBcAweFOPO7d03L+dlGXFMYlGrn6oZyDe6oRoqWaeBGJOXJx3p9
         /c4tyCbwHtxfiEGiEL99mcDrK3dWSvKzhqsU05qAs5rsPMK4ntgxxx4cYGxBiHdh5F9y
         cqJTVELlSQCAI93hGAdGPHBW6sjeXk4rhEUyIVcPgSHxU8YWWl74tyncNumkM2MnE98h
         Du0ULXSupsjOKKPt3VfEIuiQKGrgZ+ifi7UKBb8O4EPF4zkI+dE/XgeIaa1rzb3y0e/A
         h4Vwv7nJXeeNXQ9Quws0KXLUFPj83kOmEDqXsYXaQ5wMj8HgbXN153/jSqSTsQY5vTKp
         ibVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728143; x=1702332943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6VARjn0CWiByFx2DKSnsDI32pinxmI34vf9VNZr5tg=;
        b=gT6vTfOL5BG6dZ2WyLZH/GEMe7fbRD2YrcBVJkLMFtu4qiRqTXV1R1hHIMQd690gv1
         CvDaXEDEBJ4B6HT14AluK7DkTTfuMk9NFtdlYlR7pmw1IRIvPnLrdRlrIkejyffiy+Nj
         1ct82ZDiLvPIfOZprpLiE8qUulsRckdJjHmHHL/D0h4PKG4eVho+DBjZuEGbZlGig8RP
         nhu93WcrzRO1rCB2lfJZQtqpKbwpjg1TrqPRDy4zo3DnYNz/AFd6UjTogKUgK9Ggzjb4
         MmrfS98dwtQm5xTF9vmh8uMBP86kzkUS5dSL/lcmQLL+YjhzZNKy6g1A9NFpPNG9M9eN
         ItGA==
X-Gm-Message-State: AOJu0YwFEKVTM2OVVBc0Q7xaKKdHVexQX8IeLG6SqN9I9oCSiGL9n2lG
	3vavrA1Oxbwb92q8S4EL4mXsard/G3o=
X-Google-Smtp-Source: AGHT+IEUzrKwi4k7zWU+HJ3tCKyycGZCqwceofo30FVhb96x/iZS1rfWEPlyijL9bwdt0lfrzHaTSw==
X-Received: by 2002:a67:f308:0:b0:464:5a0e:b62e with SMTP id p8-20020a67f308000000b004645a0eb62emr2907095vsf.14.1701728143008;
        Mon, 04 Dec 2023 14:15:43 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id bl13-20020a056102508d00b0044d4e63aa03sm1136612vsb.25.2023.12.04.14.15.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 14:15:42 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 8/8] test-bap: Add SCC Update Metadata tests
Date: Mon,  4 Dec 2023 17:15:27 -0500
Message-ID: <20231204221527.2990674-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204221527.2990674-1-luiz.dentz@gmail.com>
References: <20231204221527.2990674-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

4.8.8 Unicast Client Initiates Update Metadata Operation (Page 53):

  Test Purpose:
  Verify that a Unicast Client IUT can update the Metadata of an ASE by
  initiating an Update Metadata operation.

  Pass verdict:
  The IUT successfully writes to the ASE Control Point characteristic with the
  opcode set to 0x07 (Update Metadata) and the specified parameters.

Test Summary
------------
BAP/UCL/SCC/BV-115-C [UCL SNK Update Metadata in Enabling State] Passed
BAP/UCL/SCC/BV-116-C [UCL SRC Update Metadata in Enabling or Streaming state]
Passed
BAP/UCL/SCC/BV-117-C [UCL SNK Update Metadata in Streaming State] Passed
Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0
---
 unit/test-bap.c | 139 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index fa6e65219beb..ecd5e2897093 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -2687,6 +2687,144 @@ static void test_scc_release(void)
 			SCC_SRC_DISABLE_RELEASE);
 }
 
+static void bap_metadata(struct bt_bap_stream *stream,
+					uint8_t code, uint8_t reason,
+					void *user_data)
+{
+	if (code)
+		tester_test_failed();
+}
+
+static void state_enable_metadata(struct bt_bap_stream *stream,
+					uint8_t old_state, uint8_t new_state,
+					void *user_data)
+{
+	struct test_data *data = user_data;
+	struct iovec iov = {};
+	uint8_t id;
+
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_ENABLING:
+		id = bt_bap_stream_metadata(data->stream, &iov, bap_metadata,
+						data);
+		g_assert(id);
+		break;
+	}
+}
+
+static struct test_config cfg_snk_metadata = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = LC3_QOS_16_2_1,
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_ENABLING,
+	.state_func = state_enable_metadata
+};
+
+/* ATT: Write Command (0x52) len 23
+ *  Handle: 0x0022
+ *    Data: 07010100
+ * ATT: Handle Value Notification (0x1b) len 7
+ *  Handle: 0x0022
+ *    Data: 0701010000
+ * ATT: Handle Value Notification (0x1b) len 37
+ *   Handle: 0x0016
+ *     Data: 01010102010a00204e00409c00204e00409c00_qos
+ */
+#define ASE_SNK_METADATA \
+	IOV_DATA(0x52, 0x22, 0x00, 0x07, 0x01, 0x01, 0x00), \
+	IOV_DATA(0x1b, 0x22, 0x00, 0x07, 0x01, 0x01, 0x00, 0x00), \
+	IOV_NULL, \
+	IOV_DATA(0x1b, 0x16, 0x00, 0x01, 0x05, 0x00, 0x00, 0x4c, 0x1d, 0x00, \
+			0x00, 0x02, 0x1a, 0x00, 0x02, 0x08, 0x00, 0x40, 0x9c, \
+			0x00)
+
+#define SCC_SNK_METADATA \
+	SCC_SNK_ENABLE, \
+	ASE_SNK_METADATA
+
+static struct test_config cfg_src_metadata = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = LC3_QOS_16_2_1,
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_ENABLING,
+	.state_func = state_enable_metadata
+};
+
+/* ATT: Write Command (0x52) len 23
+ *  Handle: 0x0022
+ *    Data: 07010300
+ * ATT: Handle Value Notification (0x1b) len 7
+ *  Handle: 0x0022
+ *    Data: 0701030000
+ * ATT: Handle Value Notification (0x1b) len 37
+ *   Handle: 0x001c
+ *     Data: 030300000403020100
+ */
+#define ASE_SRC_METADATA \
+	IOV_DATA(0x52, 0x22, 0x00, 0x07, 0x01, 0x03, 0x00), \
+	IOV_DATA(0x1b, 0x22, 0x00, 0x07, 0x01, 0x03, 0x00, 0x00), \
+	IOV_NULL, \
+	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x05, 0x00, 0x00, 0x4c, 0x1d, 0x00, \
+			0x00, 0x02, 0x1a, 0x00, 0x04, 0x08, 0x00, 0x40, 0x9c, \
+			0x00)
+#define SCC_SRC_METADATA \
+	SCC_SRC_ENABLE, \
+	ASE_SRC_METADATA
+
+static void state_start_metadata(struct bt_bap_stream *stream,
+					uint8_t old_state, uint8_t new_state,
+					void *user_data)
+{
+	struct test_data *data = user_data;
+	struct iovec iov = {};
+	uint8_t id;
+
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_STREAMING:
+		id = bt_bap_stream_metadata(data->stream, &iov, bap_metadata,
+						data);
+		g_assert(id);
+		break;
+	}
+}
+
+static struct test_config cfg_src_metadata_streaming = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = LC3_QOS_16_2_1,
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+	.state_func = state_start_metadata
+};
+
+#define SCC_SRC_METADATA_STREAMING \
+	SCC_SRC_ENABLE, \
+	ASE_SRC_START, \
+	ASE_SRC_METADATA
+
+/* Unicast Client Initiates Update Metadata Operation
+ *
+ * Test Purpose:
+ * Verify that a Unicast Client IUT can update the Metadata of an ASE by
+ * initiating an Update Metadata operation.
+ *
+ * Pass verdict:
+ * The IUT successfully writes to the ASE Control Point characteristic with the
+ * opcode set to 0x07 (Update Metadata) and the specified parameters.
+ */
+static void test_scc_metadata(void)
+{
+	define_test("BAP/UCL/SCC/BV-115-C [UCL SNK Update Metadata in Enabling "
+			"State]",
+			test_client, &cfg_src_metadata, SCC_SRC_METADATA);
+	define_test("BAP/UCL/SCC/BV-116-C [UCL SRC Update Metadata in Enabling "
+			"or Streaming state]",
+			test_client, &cfg_snk_metadata, SCC_SNK_METADATA);
+	define_test("BAP/UCL/SCC/BV-117-C [UCL SNK Update Metadata in Streaming"
+			" State]",
+			test_client, &cfg_src_metadata_streaming,
+			SCC_SRC_METADATA_STREAMING);
+}
+
 static void test_scc(void)
 {
 	test_scc_cc_lc3();
@@ -2696,6 +2834,7 @@ static void test_scc(void)
 	test_scc_enable();
 	test_scc_disable();
 	test_scc_release();
+	test_scc_metadata();
 }
 
 int main(int argc, char *argv[])
-- 
2.43.0

