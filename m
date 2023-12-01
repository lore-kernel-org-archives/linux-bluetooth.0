Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gI+Z3pVC"
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E0ED54
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Dec 2023 14:39:18 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-67a91751ba8so8452106d6.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Dec 2023 14:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701470357; x=1702075157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KtIEJOo0bH7uN3S+paD2i9Xj09nYjIM1rX/qwhOf5xE=;
        b=gI+Z3pVC/EMm+sbW0SfRMrNjrVMW8+XN+t1k8E9n55e1+/ErN/rjANmmUzwbkro1yf
         IvvMXb3IgNUCv/56eA0piflt0DBUnBzm46C4La7auHXUbPZunAaD/llLyKJZHhANogzP
         hF97C2x0lR+zPKs+Ei8WMhOm0Ngc5lN5DrYuXE9tu4xg5OzZXUoiE0CcosXbFUw2YVrG
         RbC4x1VbKHwf2WsqS/jQtHhLP56Fm+HYOeYTg38UBRNkjPs0RxHCwSd9TKryqi0sQK8J
         uxW/zsfYLoUj1VasZhvDZbKY5my2dtIFLeAtzBWqCRAiZolurXqkWZKIIAOFNElzoXcd
         oAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701470357; x=1702075157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtIEJOo0bH7uN3S+paD2i9Xj09nYjIM1rX/qwhOf5xE=;
        b=rvpYZPytCxXNk3+a8BqkUL2h6HaVEzSBKrVTuvKw53IJpjSs4/KB8lGhZpAw/LGmzI
         rwV5yiiIJsbjcupWEOK41XDPhxhk6LuRKytIEOaHCgGxKrN7VI1G0z+BHPoO8qp6P11a
         bQ9tc85ZzxrpVLTuQHU/0nYHH7N64ZuyHpEMjx+BUvVUjPPznRz008kcjLEGQgEYsrgB
         EYAvvWgEmTMoVcnKlIX582VJ7pKET/z8rWAXZBMPmHIebNxypD331n3HV9VZW8eQicPc
         +ejTWTeUZSz1LBNmcLOdZVe8oAz7MWbkjY1sNxkHpXRlwuEWriSTkxrnBPvq0MemONVs
         kqoA==
X-Gm-Message-State: AOJu0YzixTTVTPDguwrhjMk3LMRQWXq8TIlKDv4DFCMGGiWHNDqKO3ID
	W8FzxLRWHZzt3+vCmEomgtUV2GHVd2yw7A==
X-Google-Smtp-Source: AGHT+IGP8gLloRzoA1ndIuCV+vyqkWd8ZR/OSKalLB2I1LjHHFWxvNeyR8CUR6YL0mp7v4WcdiRvzw==
X-Received: by 2002:a0c:f8c5:0:b0:67a:a793:b379 with SMTP id h5-20020a0cf8c5000000b0067aa793b379mr134965qvo.30.1701470356772;
        Fri, 01 Dec 2023 14:39:16 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id b18-20020a0c9b12000000b0065b13180892sm1915411qve.16.2023.12.01.14.39.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:39:14 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 7/7] test-bap: Add SCC Release tests
Date: Fri,  1 Dec 2023 17:39:00 -0500
Message-ID: <20231201223900.2498565-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201223900.2498565-1-luiz.dentz@gmail.com>
References: <20231201223900.2498565-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

4.8.7 Unicast Client Initiates Release Operation (Page 51):

  Test Purpose:
  Verify that a Unicast Client IUT can release an ASE by initiating a Release
  operation.

  Pass verdict:
  The IUT successfully writes to the ASE Control Point characteristic with the
  opcode set to 0x08 (Release) and the specified parameters.

Test Summary
------------
BAP/UCL/SCC/BV-106-C [UCL SNK Release in Codec Configured state] Passed
BAP/UCL/SCC/BV-107-C [UCL SRC Release in Codec Configured state] Passed
BAP/UCL/SCC/BV-108-C [UCL SNK Release in QoS Configured state] Passed
BAP/UCL/SCC/BV-109-C [UCL SRC Release in QoS Configured state] Passed
BAP/UCL/SCC/BV-110-C [UCL SNK Release in Enabling state] Passed
BAP/UCL/SCC/BV-111-C [UCL SRC Release in Enabling or Streaming state] Passed
BAP/UCL/SCC/BV-112-C [UCL SNK Release in Streaming state] Passed
BAP/UCL/SCC/BV-113-C [UCL SNK Release in Disabling state] Passed
Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
---
 unit/test-bap.c | 287 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 274 insertions(+), 13 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 4e518b010def..fa6e65219beb 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -40,6 +40,7 @@ struct test_config {
 	bool src;
 	bool vs;
 	uint8_t state;
+	bt_bap_state_func_t state_func;
 };
 
 struct test_data {
@@ -347,17 +348,8 @@ static void bap_start(struct bt_bap_stream *stream,
 					uint8_t code, uint8_t reason,
 					void *user_data)
 {
-	struct test_data *data = user_data;
-	unsigned int id;
-
-	if (code) {
+	if (code)
 		tester_test_failed();
-		return;
-	}
-
-	id = bt_bap_stream_disable(data->stream, true, bap_disable, data);
-
-	g_assert(id);
 }
 
 static void bap_enable(struct bt_bap_stream *stream,
@@ -507,6 +499,10 @@ static void test_client(const void *user_data)
 
 	bt_bap_ready_register(data->bap, bap_ready, data, NULL);
 
+	if (data->cfg && data->cfg->state_func)
+		bt_bap_state_register(data->bap, data->cfg->state_func, NULL,
+						data, NULL);
+
 	bt_bap_attach(data->bap, data->client);
 }
 
@@ -2371,18 +2367,35 @@ static struct test_config cfg_src_disable = {
 	IOV_DATA(0x52, 0x22, 0x00, 0x05, 0x01, 0x03), \
 	IOV_DATA(0x1b, 0x22, 0x00, 0x05, 0x01, 0x03, 0x00, 0x00), \
 	IOV_NULL, \
-	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x02, 0x00, 0x00, 0x4c, 0x1d, 0x00, \
-			0x00, 0x02, 0x1a, 0x00, 0x02, 0x08, 0x00, 0x40, 0x9c, \
+	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x05, 0x00, 0x00, 0x4c, 0x1d, 0x00, \
+			0x00, 0x02, 0x1a, 0x00, 0x04, 0x08, 0x00, 0x40, 0x9c, \
 			0x00)
 #define SCC_SRC_DISABLE \
 	SCC_SRC_ENABLE, \
 	ASE_SRC_DISABLE
 
+static void state_start_disable(struct bt_bap_stream *stream,
+					uint8_t old_state, uint8_t new_state,
+					void *user_data)
+{
+	struct test_data *data = user_data;
+	uint8_t id;
+
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_STREAMING:
+		id = bt_bap_stream_disable(data->stream, true, bap_disable,
+						data);
+		g_assert(id);
+		break;
+	}
+}
+
 static struct test_config cfg_src_disable_streaming = {
 	.cc = LC3_CONFIG_16_2,
 	.qos = LC3_QOS_16_2_1,
 	.src = true,
-	.state = BT_BAP_STREAM_STATE_STREAMING
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+	.state_func = state_start_disable
 };
 
 /* ATT: Write Command (0x52) len 23
@@ -2427,6 +2440,253 @@ static void test_scc_disable(void)
 			SCC_SRC_DISABLE_STREAMING);
 }
 
+static void bap_release(struct bt_bap_stream *stream,
+					uint8_t code, uint8_t reason,
+					void *user_data)
+{
+	if (code)
+		tester_test_failed();
+}
+
+static void state_cc_release(struct bt_bap_stream *stream,
+					uint8_t old_state, uint8_t new_state,
+					void *user_data)
+{
+	struct test_data *data = user_data;
+	uint8_t id;
+
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_CONFIG:
+		id = bt_bap_stream_release(data->stream, bap_release, data);
+		g_assert(id);
+		break;
+	}
+}
+
+static struct test_config cfg_src_cc_release = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = QOS_UCAST,
+	.src = true,
+	.state_func = state_cc_release,
+};
+
+/* ATT: Write Command (0x52) len 23
+ *  Handle: 0x0022
+ *    Data: 080103
+ * ATT: Handle Value Notification (0x1b) len 7
+ *  Handle: 0x0022
+ *    Data: 0801030000
+ * ATT: Handle Value Notification (0x1b) len 37
+ *   Handle: 0x001c
+ *     Data: 0300
+ */
+#define ASE_SRC_RELEASE \
+	IOV_DATA(0x52, 0x22, 0x00, 0x08, 0x01, 0x03), \
+	IOV_DATA(0x1b, 0x22, 0x00, 0x08, 0x01, 0x03, 0x00, 0x00), \
+	IOV_NULL, \
+	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x00)
+
+#define SCC_SRC_CC_RELEASE \
+	SCC_SRC_16_2, \
+	ASE_SRC_RELEASE
+
+static struct test_config cfg_snk_cc_release = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = QOS_UCAST,
+	.snk = true,
+	.state_func = state_cc_release,
+};
+
+/* ATT: Write Command (0x52) len 23
+ *  Handle: 0x0022
+ *    Data: 080101
+ * ATT: Handle Value Notification (0x1b) len 7
+ *  Handle: 0x0022
+ *    Data: 0801010000
+ * ATT: Handle Value Notification (0x1b) len 37
+ *   Handle: 0x0016
+ *     Data: 0300
+ */
+#define ASE_SNK_RELEASE \
+	IOV_DATA(0x52, 0x22, 0x00, 0x08, 0x01, 0x01), \
+	IOV_DATA(0x1b, 0x22, 0x00, 0x08, 0x01, 0x01, 0x00, 0x00), \
+	IOV_NULL, \
+	IOV_DATA(0x1b, 0x16, 0x00, 0x03, 0x00)
+
+#define SCC_SNK_CC_RELEASE \
+	SCC_SNK_16_2, \
+	ASE_SNK_RELEASE
+
+static void state_qos_release(struct bt_bap_stream *stream,
+					uint8_t old_state, uint8_t new_state,
+					void *user_data)
+{
+	struct test_data *data = user_data;
+	uint8_t id;
+
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_QOS:
+		id = bt_bap_stream_release(data->stream, bap_release, data);
+		g_assert(id);
+		break;
+	}
+}
+
+static struct test_config cfg_src_qos_release = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = LC3_QOS_16_2_1,
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_QOS,
+	.state_func = state_qos_release,
+};
+
+#define SCC_SRC_QOS_RELEASE \
+	SCC_SRC_16_2_1, \
+	ASE_SRC_RELEASE
+
+static struct test_config cfg_snk_qos_release = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = LC3_QOS_16_2_1,
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_QOS,
+	.state_func = state_qos_release,
+};
+
+#define SCC_SNK_QOS_RELEASE \
+	SCC_SNK_16_2_1, \
+	ASE_SNK_RELEASE
+
+static void state_enable_release(struct bt_bap_stream *stream,
+					uint8_t old_state, uint8_t new_state,
+					void *user_data)
+{
+	struct test_data *data = user_data;
+	uint8_t id;
+
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_ENABLING:
+		id = bt_bap_stream_release(data->stream, bap_release, data);
+		g_assert(id);
+		break;
+	}
+}
+
+static struct test_config cfg_src_enable_release = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = LC3_QOS_16_2_1,
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_ENABLING,
+	.state_func = state_enable_release,
+};
+
+#define SCC_SRC_ENABLE_RELEASE \
+	SCC_SRC_ENABLE, \
+	ASE_SRC_RELEASE
+
+static struct test_config cfg_snk_enable_release = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = LC3_QOS_16_2_1,
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_ENABLING,
+	.state_func = state_enable_release,
+};
+
+#define SCC_SNK_ENABLE_RELEASE \
+	SCC_SNK_ENABLE, \
+	ASE_SNK_RELEASE
+
+static void state_start_release(struct bt_bap_stream *stream,
+					uint8_t old_state, uint8_t new_state,
+					void *user_data)
+{
+	struct test_data *data = user_data;
+	uint8_t id;
+
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_STREAMING:
+		id = bt_bap_stream_release(data->stream, bap_release, data);
+		g_assert(id);
+		break;
+	}
+}
+
+static struct test_config cfg_src_start_release = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = LC3_QOS_16_2_1,
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+	.state_func = state_start_release,
+};
+
+#define SCC_SRC_START_RELEASE \
+	SCC_SRC_ENABLE, \
+	ASE_SRC_START, \
+	ASE_SRC_RELEASE
+
+static void state_disable_release(struct bt_bap_stream *stream,
+					uint8_t old_state, uint8_t new_state,
+					void *user_data)
+{
+	struct test_data *data = user_data;
+	uint8_t id;
+
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_DISABLING:
+		id = bt_bap_stream_release(data->stream, bap_release, data);
+		g_assert(id);
+		break;
+	}
+}
+
+static struct test_config cfg_src_disable_release = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = LC3_QOS_16_2_1,
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_DISABLING,
+	.state_func = state_disable_release,
+};
+
+#define SCC_SRC_DISABLE_RELEASE \
+	SCC_SRC_DISABLE, \
+	ASE_SRC_RELEASE
+
+/* Test Purpose:
+ * Verify that a Unicast Client IUT can release an ASE by initiating a Release
+ * operation.
+ *
+ * Pass verdict:
+ * The IUT successfully writes to the ASE Control Point characteristic with the
+ * opcode set to 0x08 (Release) and the specified parameters.
+ */
+static void test_scc_release(void)
+{
+	define_test("BAP/UCL/SCC/BV-106-C [UCL SNK Release in Codec Configured"
+			" state]",
+			test_client, &cfg_src_cc_release, SCC_SRC_CC_RELEASE);
+	define_test("BAP/UCL/SCC/BV-107-C [UCL SRC Release in Codec Configured"
+			" state]",
+			test_client, &cfg_snk_cc_release, SCC_SNK_CC_RELEASE);
+	define_test("BAP/UCL/SCC/BV-108-C [UCL SNK Release in QoS Configured"
+			" state]",
+			test_client, &cfg_src_qos_release, SCC_SRC_QOS_RELEASE);
+	define_test("BAP/UCL/SCC/BV-109-C [UCL SRC Release in QoS Configured"
+			" state]",
+			test_client, &cfg_snk_qos_release, SCC_SNK_QOS_RELEASE);
+	define_test("BAP/UCL/SCC/BV-110-C [UCL SNK Release in Enabling state]",
+			test_client, &cfg_src_enable_release,
+			SCC_SRC_ENABLE_RELEASE);
+	define_test("BAP/UCL/SCC/BV-111-C [UCL SRC Release in Enabling or"
+			" Streaming state]",
+			test_client, &cfg_snk_enable_release,
+			SCC_SNK_ENABLE_RELEASE);
+	define_test("BAP/UCL/SCC/BV-112-C [UCL SNK Release in Streaming state]",
+			test_client, &cfg_src_start_release,
+			SCC_SRC_START_RELEASE);
+	define_test("BAP/UCL/SCC/BV-113-C [UCL SNK Release in Disabling state]",
+			test_client, &cfg_src_disable_release,
+			SCC_SRC_DISABLE_RELEASE);
+}
+
 static void test_scc(void)
 {
 	test_scc_cc_lc3();
@@ -2435,6 +2695,7 @@ static void test_scc(void)
 	test_scc_qos_vs();
 	test_scc_enable();
 	test_scc_disable();
+	test_scc_release();
 }
 
 int main(int argc, char *argv[])
-- 
2.43.0

