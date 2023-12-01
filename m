Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWvS0SUe"
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E799D54
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Dec 2023 14:39:12 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-67a35b68c34so15323256d6.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Dec 2023 14:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701470350; x=1702075150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jzu0Gbgf988x22ji0B5m/8VKcTqn+nCtaQs42XgrVkw=;
        b=TWvS0SUeJnFu4oxe9IpsSJtPx6rXlKsFW8eJb1Y5rQX+RWZp8nKQjcwnjpkzK9+/k8
         jR97RWZHyH3rSy55j/UmmWFhFanBkZV5sblJspTkRCwIDRPUWUy8cjORkkqI0oCmDZgu
         fsyHSU919G8zrc2Zr5VpKHv0DNPMuYBszyqoUD4Bs9r1rCL5nUIae5kqLcZyP1MU7H56
         JdfD8z2Mca2VbePgCbr5unQTfHI6iNOuIDw3Sq71nny3TfhZwBw05RADzCIclObl1ev0
         V1kykW7tSyfKOnmEPv2MoJDD5McpOJTOiYdDC9pIXuYL9LDHkD6BxbjeoADiBxyk43yG
         eenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701470350; x=1702075150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jzu0Gbgf988x22ji0B5m/8VKcTqn+nCtaQs42XgrVkw=;
        b=JXdwjLOvMmv3Itk7FSPV1PJ4KqS+8v9swkBVEJzoxC+QGn3tG5gkC9oMOtY5sYJ3Vj
         +OwWyOG5dts+nibnLqLHrBB+y30WUdEnkjgoMU+Ti0ydukyAsPzhuncsdcUt5dT1ljEJ
         uCZmP3yP3D/AmkaDf5bZhYwupChmBReB8hXdXgAanzzMdFzlEYkIQyG2gE7mkidofmnT
         fBNewyvc6pnI6F9cyH/60vbIC9pxOJs6/8qyiHvIif3OnX/6rIfRkJOWw6bQ7W5rZRqi
         dOhv3le7mLo4iuh3wJbbLJIwyieGmvKrYwrK+1Z1sGxz87OYOLK93zuZq8VIfRRJzGBc
         7v+Q==
X-Gm-Message-State: AOJu0YzJu8oJTh/YpOYRyUddsIE5boTAj1IIVLQH9p1vjOt2T6KRql8b
	B2evPEztqiQT66ei2BuUFoqJ5x9bLu2S2g==
X-Google-Smtp-Source: AGHT+IFInz7l3z76r2TT2Qic3LZUATlXudAEgXrjBThcq83S9XATDlQzVwAYHHbP/yQhcteVL0CohA==
X-Received: by 2002:a05:6214:170a:b0:67a:a721:b188 with SMTP id db10-20020a056214170a00b0067aa721b188mr215965qvb.67.1701470349913;
        Fri, 01 Dec 2023 14:39:09 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id b18-20020a0c9b12000000b0065b13180892sm1915411qve.16.2023.12.01.14.39.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:39:07 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/7] test-bap: Add SCC Enable tests
Date: Fri,  1 Dec 2023 17:38:57 -0500
Message-ID: <20231201223900.2498565-4-luiz.dentz@gmail.com>
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

