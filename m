Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOAWTFpy"
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB51183
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Dec 2023 14:15:37 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-464811e5b3cso1406204137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Dec 2023 14:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701728136; x=1702332936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jzu0Gbgf988x22ji0B5m/8VKcTqn+nCtaQs42XgrVkw=;
        b=XOAWTFpyajHscvNBUJNflcu1YELR9cyYI9oJxZGdumlIrOh/4OZM6VWCu1tMaxiY4F
         VvKd44SNf8mn0OhdcPINO/7J6RyofGkm+PaB6nqPOGXL6yZOBkK8rFhngwMKh9UzRUhL
         /wdrFNKXkkzNtuD6PCp/oqyu8hH3Ct5M3q8gGNZHuMu/4FtImS3gTap3ffxzyXWXpSXj
         aqQYicWAUuoL/votVKs/OxHlzRvHFZ8rx7KZst6aDSKf+IdqR6IG25C4WWGC+vNzCpGA
         01YmpMxpjmkidxzgxTJdjjR4NHPT35ItymE4IBNewvmRHOZluIkT2Iv6qTnHxSwLM9QW
         rvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728136; x=1702332936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jzu0Gbgf988x22ji0B5m/8VKcTqn+nCtaQs42XgrVkw=;
        b=V4CGftM6NV7EBoFVt+r4X3d0ZRK3Ht+Z9cfgNCbbKL1AkK6VBbGNY3SgX1rtDeELC4
         a0nFEOd9r20qrheoRZgte7WU0m2Bcuqa13FVe/JrWjVIe13Xq0LHM/SmAX9gLXNo2bQ/
         XqphzbFpX/DLTqdC0d/pw/dSX6kCJkKg0u2ozwJoOh2R7X6Z1AIV4AsMmvq+pyttj4ET
         nLdLkNqzdVNdu1IOdFyPzstSjoSuuHv5JHZ8rAPtzlfguaivipWGnShEFwGyR5KU8dPG
         TXc+EYB8jsJ/gGGFaxOhmYTpOw/9kuJYtLj6hWD2USPXQSI9eb4Cu6knw+ykeNMwKXTu
         Pnmw==
X-Gm-Message-State: AOJu0Ywg7pourUucl7uwOLSUQJeT++tdP+NSMTSCU8dYu4m8su1/1RiF
	Ri2GJ3x5IzDYsGr+m9WpRPjkn55RsJ8=
X-Google-Smtp-Source: AGHT+IFLsX6tkqAtUjB+vJaQLUx4T2hbT4PdCTFoi8HFx4y2uizQ4WhGbDPsk13HVkCnAHP34Kf8zw==
X-Received: by 2002:a05:6102:390d:b0:464:9159:ba8e with SMTP id e13-20020a056102390d00b004649159ba8emr715773vsu.31.1701728135823;
        Mon, 04 Dec 2023 14:15:35 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id bl13-20020a056102508d00b0044d4e63aa03sm1136612vsb.25.2023.12.04.14.15.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 14:15:34 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/8] test-bap: Add SCC Enable tests
Date: Mon,  4 Dec 2023 17:15:23 -0500
Message-ID: <20231204221527.2990674-4-luiz.dentz@gmail.com>
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

4.8.5 Unicast Client Initiates Enable Operation (Page 48)

  Test Purpose:
  Verify that a Unicast Client IUT can initiate an Enable operation for an ASE
  with a Unicast Server that is either in the Audio Sink role or the Audio
  Source role.

  Pass verdict:
  The IUT successfully writes to the ASE Control Point characteristic with the
  opcode set to 0x03 (Enable) and the specified parameters.

Test Summary
------------
BAP/UCL/SCC/BV-101-C [UCL SRC Enable]                Passed
BAP/UCL/SCC/BV-102-C [UCL SNK Enable]                Passed
Total: 2, Passed: 2 (100.0%), Failed: 0, Not Run: 0
---
 unit/test-bap.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index fdfedde6b965..9369983ba97d 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -335,7 +335,7 @@ static void test_complete_cb(const void *user_data)
 	tester_test_passed();
 }
 
-static void bap_qos(struct bt_bap_stream *stream,
+static void bap_enable(struct bt_bap_stream *stream,
 					uint8_t code, uint8_t reason,
 					void *user_data)
 {
@@ -343,6 +343,26 @@ static void bap_qos(struct bt_bap_stream *stream,
 		tester_test_failed();
 }
 
+static void bap_qos(struct bt_bap_stream *stream,
+					uint8_t code, uint8_t reason,
+					void *user_data)
+{
+	struct test_data *data = user_data;
+
+	if (code) {
+		tester_test_failed();
+		return;
+	}
+
+	if (data->cfg->state > BT_BAP_STREAM_STATE_QOS) {
+		unsigned int qos_id;
+
+		qos_id = bt_bap_stream_enable(data->stream, true, NULL,
+							bap_enable, data);
+		g_assert(qos_id);
+	}
+}
+
 static void bap_config(struct bt_bap_stream *stream,
 					uint8_t code, uint8_t reason,
 					void *user_data)
@@ -2188,12 +2208,82 @@ static void test_scc_qos_vs(void)
 			test_client, &cfg_snk_qos_vs, SCC_SNK_QOS_VS);
 }
 
+static struct test_config cfg_snk_enable = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = LC3_QOS_16_2_1,
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_ENABLING
+};
+
+/* ATT: Write Command (0x52) len 23
+ *  Handle: 0x0022
+ *    Data: 03010104030201
+ * ATT: Handle Value Notification (0x1b) len 7
+ *  Handle: 0x0022
+ *    Data: 0301010000
+ * ATT: Handle Value Notification (0x1b) len 37
+ *   Handle: 0x0016
+ *     Data: 0101010300403020100
+ */
+#define SCC_SNK_ENABLE \
+	SCC_SNK_16_2_1, \
+	IOV_DATA(0x52, 0x22, 0x00, 0x03, 0x01, 0x01, 0x04, 0x03, 0x02, 0x01, \
+			00), \
+	IOV_DATA(0x1b, 0x22, 0x00, 0x03, 0x01, 0x01, 0x00, 0x00), \
+	IOV_NULL, \
+	IOV_DATA(0x1b, 0x16, 0x00, 0x01, 0x03, 0x00, 0x00, 0x04, 0x03, 0x02, \
+			0x01, 0x00)
+
+static struct test_config cfg_src_enable = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = LC3_QOS_16_2_1,
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_ENABLING
+};
+
+/* ATT: Write Command (0x52) len 23
+ *  Handle: 0x0022
+ *    Data: 0301030403020100
+ * ATT: Handle Value Notification (0x1b) len 7
+ *  Handle: 0x0022
+ *    Data: 0301030000
+ * ATT: Handle Value Notification (0x1b) len 37
+ *   Handle: 0x001c
+ *     Data: 030300000403020100
+ */
+#define SCC_SRC_ENABLE \
+	SCC_SRC_16_2_1, \
+	IOV_DATA(0x52, 0x22, 0x00, 0x03, 0x01, 0x03, 0x04, 0x03, 0x02, 0x01, \
+			00), \
+	IOV_DATA(0x1b, 0x22, 0x00, 0x03, 0x01, 0x01, 0x00, 0x00), \
+	IOV_NULL, \
+	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x03, 0x00, 0x00, 0x04, 0x03, 0x02, \
+			0x01, 0x00)
+
+/* Test Purpose:
+ * Verify that a Unicast Client IUT can initiate an Enable operation for an ASE
+ * with a Unicast Server that is either in the Audio Sink role or the Audio
+ * Source role.
+ *
+ * Pass verdict:
+ * The IUT successfully writes to the ASE Control Point characteristic with the
+ * opcode set to 0x03 (Enable) and the specified parameters.
+ */
+static void test_scc_enable(void)
+{
+	define_test("BAP/UCL/SCC/BV-101-C [UCL SRC Enable]",
+			test_client, &cfg_snk_enable, SCC_SNK_ENABLE);
+	define_test("BAP/UCL/SCC/BV-102-C [UCL SNK Enable]",
+			test_client, &cfg_src_enable, SCC_SRC_ENABLE);
+}
+
 static void test_scc(void)
 {
 	test_scc_cc_lc3();
 	test_scc_cc_vs();
 	test_scc_qos_lc3();
 	test_scc_qos_vs();
+	test_scc_enable();
 }
 
 int main(int argc, char *argv[])
-- 
2.43.0

