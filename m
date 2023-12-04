Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TY+fsEjr"
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C8D18A
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Dec 2023 14:15:39 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7c51dd41046so1000547241.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Dec 2023 14:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701728137; x=1702332937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3b7r1p1Ur3sHOjYjWNF6OJfv/yxkBqTEAW1r1VZz9c=;
        b=TY+fsEjrij7+R/9Uvf1WlDhAy75AtJwLKf7Lp9xVPshgHCp5AtNc+OUlJRVuWQNFtm
         bnJZ8BFKTKeUqRERofFjk7lA3C8r5dPbULwEttcMd3Z5xAxerqeAGjYGqrqbfTIV5z+N
         pYbn363g5r9JmxcrWXyq8qDWwHhOHKfXjDKauT9MThu0G+CQk1TMQ7/qThcX/Q/un3UN
         tJo6DPVKK0xEHhj3Hq8Z5lWcuJ7AzwHzVn942IEDKCpogMNODVgO+AU4ogALDLq5FVDz
         iOKrQnoLSw3faPOEkUl4caaJHYpXXJ30k8XUPaRV8jwhGvOQnmGsaxDPdi+j2iBEeKUb
         N5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728137; x=1702332937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3b7r1p1Ur3sHOjYjWNF6OJfv/yxkBqTEAW1r1VZz9c=;
        b=shjrgSyHI4y1qZBXMsa22tagZmOTUBF6RBeX4XhHiyhVYi9SwANWxBa0QG7G1CZGxN
         SDw1XJkWwu4iddSZgYmmCDyTn2EguxYFkhDugKm6ktnyiPSjqMvLKmTlBcC/RUtabFjv
         bnM3/YCyHK+2h40C+4lHQHifIxOoXRWFKeoJ7eCONjK+lJ/J6PUAiT5KZDByh1AgqhGc
         MVL1of6IbMeuvrZdND9hGiJaoTIxn11K7s17sW49UQ4lToRnYMK04xG8P99sCLAysdJZ
         6fPRIoeP6/LYRSSKuuztbUhwrwUxb76+5KALNMyzhATl8szGk2a3xlUGmBwJyfFtCx/T
         NUdw==
X-Gm-Message-State: AOJu0YwX/tlYYMPoOWs9j1oOhe3iq7+kXYzgHEgMd3tNAAvqhBII6G4S
	xKpAz+Q2pzqmpoJDsUOZn1uALbYPPqI=
X-Google-Smtp-Source: AGHT+IHdrJb7dApSKeu0WwkhokbtkJFv+hV366Cv8e3k3tS9MRXWYrf+7WDhPQd1cQpBYuvmFnNZLg==
X-Received: by 2002:a67:fc14:0:b0:465:390b:3c96 with SMTP id o20-20020a67fc14000000b00465390b3c96mr10325vsq.2.1701728137340;
        Mon, 04 Dec 2023 14:15:37 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id bl13-20020a056102508d00b0044d4e63aa03sm1136612vsb.25.2023.12.04.14.15.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 14:15:36 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 5/8] test-bap: Add SCC Disable tests
Date: Mon,  4 Dec 2023 17:15:24 -0500
Message-ID: <20231204221527.2990674-5-luiz.dentz@gmail.com>
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

4.8.6 Unicast Client Initiates Disable Operation (Page 50):

  Test Purpose:
  Verify that a Unicast Client IUT can initiate a Disable operation for an ASE
  in the Enabling or Streaming state.

  Pass verdict:
  The IUT successfully writes to the ASE Control Point characteristic with the
  opcode set to 0x05 (Disable) and the specified parameters.

Test Summary
------------
BAP/UCL/SCC/BV-103-C [UCL SNK Disable in Enabling State] Passed
BAP/UCL/SCC/BV-104-C [UCL SRC Disable in Enabling or Streaming state] Passed
BAP/UCL/SCC/BV-105-C [UCL SNK Disable in Streaming State] Passed
Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0
---
 unit/test-bap.c | 153 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 152 insertions(+), 1 deletion(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 9369983ba97d..4e518b010def 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -335,7 +335,7 @@ static void test_complete_cb(const void *user_data)
 	tester_test_passed();
 }
 
-static void bap_enable(struct bt_bap_stream *stream,
+static void bap_disable(struct bt_bap_stream *stream,
 					uint8_t code, uint8_t reason,
 					void *user_data)
 {
@@ -343,6 +343,50 @@ static void bap_enable(struct bt_bap_stream *stream,
 		tester_test_failed();
 }
 
+static void bap_start(struct bt_bap_stream *stream,
+					uint8_t code, uint8_t reason,
+					void *user_data)
+{
+	struct test_data *data = user_data;
+	unsigned int id;
+
+	if (code) {
+		tester_test_failed();
+		return;
+	}
+
+	id = bt_bap_stream_disable(data->stream, true, bap_disable, data);
+
+	g_assert(id);
+}
+
+static void bap_enable(struct bt_bap_stream *stream,
+					uint8_t code, uint8_t reason,
+					void *user_data)
+{
+	struct test_data *data = user_data;
+	unsigned int id = 0;
+
+	if (code) {
+		tester_test_failed();
+		return;
+	}
+
+	switch (data->cfg->state) {
+	case BT_BAP_STREAM_STATE_ENABLING:
+		return;
+	case BT_BAP_STREAM_STATE_DISABLING:
+		id = bt_bap_stream_disable(data->stream, true, bap_disable,
+						data);
+		break;
+	case BT_BAP_STREAM_STATE_STREAMING:
+		id = bt_bap_stream_start(data->stream, bap_start, data);
+		break;
+	}
+
+	g_assert(id);
+}
+
 static void bap_qos(struct bt_bap_stream *stream,
 					uint8_t code, uint8_t reason,
 					void *user_data)
@@ -2277,6 +2321,112 @@ static void test_scc_enable(void)
 			test_client, &cfg_src_enable, SCC_SRC_ENABLE);
 }
 
+static struct test_config cfg_snk_disable = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = LC3_QOS_16_2_1,
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_DISABLING
+};
+
+/* ATT: Write Command (0x52) len 23
+ *  Handle: 0x0022
+ *    Data: 050101
+ * ATT: Handle Value Notification (0x1b) len 7
+ *  Handle: 0x0022
+ *    Data: 0501010000
+ * ATT: Handle Value Notification (0x1b) len 37
+ *   Handle: 0x0016
+ *     Data: 01010102010a00204e00409c00204e00409c00_qos
+ */
+#define ASE_SNK_DISABLE \
+	IOV_DATA(0x52, 0x22, 0x00, 0x05, 0x01, 0x01), \
+	IOV_DATA(0x1b, 0x22, 0x00, 0x05, 0x01, 0x01, 0x00, 0x00), \
+	IOV_NULL, \
+	IOV_DATA(0x1b, 0x16, 0x00, 0x01, 0x02, 0x00, 0x00, 0x4c, 0x1d, 0x00, \
+			0x00, 0x02, 0x1a, 0x00, 0x02, 0x08, 0x00, 0x40, 0x9c, \
+			0x00)
+
+#define SCC_SNK_DISABLE \
+	SCC_SNK_ENABLE, \
+	ASE_SNK_DISABLE
+
+static struct test_config cfg_src_disable = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = LC3_QOS_16_2_1,
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_DISABLING
+};
+
+/* ATT: Write Command (0x52) len 23
+ *  Handle: 0x0022
+ *    Data: 050103
+ * ATT: Handle Value Notification (0x1b) len 7
+ *  Handle: 0x0022
+ *    Data: 0301030000
+ * ATT: Handle Value Notification (0x1b) len 37
+ *   Handle: 0x001c
+ *     Data: 030300000403020100
+ */
+#define ASE_SRC_DISABLE \
+	IOV_DATA(0x52, 0x22, 0x00, 0x05, 0x01, 0x03), \
+	IOV_DATA(0x1b, 0x22, 0x00, 0x05, 0x01, 0x03, 0x00, 0x00), \
+	IOV_NULL, \
+	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x02, 0x00, 0x00, 0x4c, 0x1d, 0x00, \
+			0x00, 0x02, 0x1a, 0x00, 0x02, 0x08, 0x00, 0x40, 0x9c, \
+			0x00)
+#define SCC_SRC_DISABLE \
+	SCC_SRC_ENABLE, \
+	ASE_SRC_DISABLE
+
+static struct test_config cfg_src_disable_streaming = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = LC3_QOS_16_2_1,
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING
+};
+
+/* ATT: Write Command (0x52) len 23
+ *  Handle: 0x0022
+ *    Data: 040101
+ * ATT: Handle Value Notification (0x1b) len 7
+ *  Handle: 0x0022
+ *    Data: 0401010000
+ * ATT: Handle Value Notification (0x1b) len 37
+ *   Handle: 0x0016
+ *     Data: 0101010400403020100
+ */
+#define ASE_SRC_START \
+	IOV_DATA(0x52, 0x22, 0x00, 0x04, 0x01, 0x03), \
+	IOV_DATA(0x1b, 0x22, 0x00, 0x04, 0x01, 0x03, 0x00, 0x00), \
+	IOV_NULL, \
+	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x04, 0x00, 0x00, 0x04, 0x03, 0x02, \
+			0x01, 0x00)
+
+#define SCC_SRC_DISABLE_STREAMING \
+	SCC_SRC_ENABLE, \
+	ASE_SRC_START, \
+	ASE_SRC_DISABLE
+
+/* Test Purpose:
+ * Verify that a Unicast Client IUT can initiate a Disable operation for an ASE
+ * in the Enabling or Streaming state.
+ *
+ * Pass verdict:
+ * The IUT successfully writes to the ASE Control Point characteristic with the
+ * opcode set to 0x05 (Disable) and the specified parameters.
+ */
+static void test_scc_disable(void)
+{
+	define_test("BAP/UCL/SCC/BV-103-C [UCL SNK Disable in Enabling State]",
+			test_client, &cfg_src_disable, SCC_SRC_DISABLE);
+	define_test("BAP/UCL/SCC/BV-104-C [UCL SRC Disable in Enabling or "
+			"Streaming state]",
+			test_client, &cfg_snk_disable, SCC_SNK_DISABLE);
+	define_test("BAP/UCL/SCC/BV-105-C [UCL SNK Disable in Streaming State]",
+			test_client, &cfg_src_disable_streaming,
+			SCC_SRC_DISABLE_STREAMING);
+}
+
 static void test_scc(void)
 {
 	test_scc_cc_lc3();
@@ -2284,6 +2434,7 @@ static void test_scc(void)
 	test_scc_qos_lc3();
 	test_scc_qos_vs();
 	test_scc_enable();
+	test_scc_disable();
 }
 
 int main(int argc, char *argv[])
-- 
2.43.0

