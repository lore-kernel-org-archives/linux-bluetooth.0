Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C508FC77B60
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Apr 2023 18:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346521AbjD1Sq6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Apr 2023 14:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346516AbjD1Sq5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Apr 2023 14:46:57 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866762D51
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 11:46:54 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so105202a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 11:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682707613; x=1685299613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PkMxcOuV3hGZ9O7uCLlBgXJ9G5s3hfg1WaWodTfqpfs=;
        b=PlzDU9EYhT38pNcqPxhoto1k5VMZM4CQUKJw5mYNVlULk1wi43q3dbu4cKHFOKjAAj
         53ueYl9R3jDwpLXtcQo5q51Q94YXwHSULtZSHYNzy3oCtuCJw3nL1FNDVMZvgIx4V6a4
         qg0YIMzpG7OikfAyt3D20HqJmVG7gW/YgpBA4d6b5TSfoqCN4MD9l5sHJRVHmu1a/Z7F
         vL8n6LpTpRGXTnkHLIr9R+uRi6BIXovJ7j8U01HkAQ6OyTpuIF/QZGOicQhGWqqe/8Zo
         D5EGw7VCFHoOuaZ9mazY9B59BoT1/YaG8gaGUkMDFk7c3OmQ6eL1kmifi7DiGIYpQ9CH
         SPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682707613; x=1685299613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkMxcOuV3hGZ9O7uCLlBgXJ9G5s3hfg1WaWodTfqpfs=;
        b=R9LpKVOpK5ORH/3qzq6wA9FJBSvXD/3Soqbt8oiHuzYxf7LtcVbAeifTRhmx1IwIGf
         nxbvOpnOm/NF4rz0V0Vo2b3sRMuMY8IKcaJlMpcbgI5FGkhjXdgCGwlwyQ1PXWlQhJGI
         uaMd2p+8ZNlylNUZW0trREpxJLA5ud8AJU+5mOTdG0rQhZ0fE4wDv07cZjfDwDBBXtGL
         Fz+GjqiRDtn/e0S3qNpDT9iugZ1cmPXCB/W9vEsOxDj0BwKThcqKWSfNYSk3J/UUP8EE
         QJvsgyLbJA0LT79KWw+BXIzGER8TzhBeTPkkBSYl889kC/7+eaVKkyqKmj5Cn3Fx6le/
         zaOw==
X-Gm-Message-State: AC+VfDyyMUoMFb2h+0mNYMahqr5+N2dKFpL3de7l0JOQIoa7tZ9rMie6
        8qzKMkHZL4ItgPzg8yM0KrTqXa3KFIA=
X-Google-Smtp-Source: ACHHUZ7S+WXRw+N63u3fr6qcjdhv8KdYEVeykQwQH9rWWobj/qjXEkXzMHpO0BcICRUNbpzhGhkhDQ==
X-Received: by 2002:a17:903:104c:b0:1a6:ba5a:cae0 with SMTP id f12-20020a170903104c00b001a6ba5acae0mr5974272plc.27.1682707612635;
        Fri, 28 Apr 2023 11:46:52 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id bf9-20020a170902b90900b0019f9fd10f62sm13626366plb.70.2023.04.28.11.46.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 11:46:51 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v4 7/9] test-bap: Introduce SCC tests for LC3
Date:   Fri, 28 Apr 2023 11:46:38 -0700
Message-Id: <20230428184640.849066-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428184640.849066-1-luiz.dentz@gmail.com>
References: <20230428184640.849066-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

4.8.1 Unicast Client Initiates a Config Codec Operation – LC3
(Page 39):

  Test Purpose:
  Verify that a Unicast Client IUT can initiate a Config Codec
  operation for an LC3 codec.

  Test Case Configuration:
  BAP/UCL/SCC/BV-001-C [UCL SRC Config Codec, LC3 8_1]
  BAP/UCL/SCC/BV-002-C [UCL SRC Config Codec, LC3 8_2]
  BAP/UCL/SCC/BV-003-C [UCL SRC Config Codec, LC3 16_1]
  BAP/UCL/SCC/BV-004-C [UCL SRC Config Codec, LC3 16_2]
  BAP/UCL/SCC/BV-005-C [UCL SRC Config Codec, LC3 24_1]
  BAP/UCL/SCC/BV-006-C [UCL SRC Config Codec, LC3 24_2]
  BAP/UCL/SCC/BV-007-C [UCL SRC Config Codec, LC3 32_1]
  BAP/UCL/SCC/BV-008-C [UCL SRC Config Codec, LC3 32_2]
  BAP/UCL/SCC/BV-009-C [UCL SRC Config Codec, LC3 44.1_1]
  BAP/UCL/SCC/BV-010-C [UCL SRC Config Codec, LC3 44.1_2]
  BAP/UCL/SCC/BV-011-C [UCL SRC Config Codec, LC3 48_1]
  BAP/UCL/SCC/BV-012-C [UCL SRC Config Codec, LC3 48_2]
  BAP/UCL/SCC/BV-013-C [UCL SRC Config Codec, LC3 48_3]
  BAP/UCL/SCC/BV-014-C [UCL SRC Config Codec, LC3 48_4]
  BAP/UCL/SCC/BV-015-C [UCL SRC Config Codec, LC3 48_5]
  BAP/UCL/SCC/BV-016-C [UCL SRC Config Codec, LC3 48_6]
  BAP/UCL/SCC/BV-017-C [UCL SNK Config Codec, LC3 8_1]
  BAP/UCL/SCC/BV-018-C [UCL SNK Config Codec, LC3 8_2]
  BAP/UCL/SCC/BV-019-C [UCL SNK Config Codec, LC3 16_1]
  BAP/UCL/SCC/BV-020-C [UCL SNK Config Codec, LC3 16_2]
  BAP/UCL/SCC/BV-021-C [UCL SNK Config Codec, LC3 24_1]
  BAP/UCL/SCC/BV-022-C [UCL SNK Config Codec, LC3 24_2]
  BAP/UCL/SCC/BV-023-C [UCL SNK Config Codec, LC3 32_1]
  BAP/UCL/SCC/BV-024-C [UCL SNK Config Codec, LC3 32_2]
  BAP/UCL/SCC/BV-025-C [UCL SNK Config Codec, LC3 44.1_1]
  BAP/UCL/SCC/BV-026-C [UCL SNK Config Codec, LC3 44.1_2]
  BAP/UCL/SCC/BV-027-C [UCL SNK Config Codec, LC3 48_1]
  BAP/UCL/SCC/BV-028-C [UCL SNK Config Codec, LC3 48_2]
  BAP/UCL/SCC/BV-029-C [UCL SNK Config Codec, LC3 48_3]
  BAP/UCL/SCC/BV-030-C [UCL SNK Config Codec, LC3 48_4]
  BAP/UCL/SCC/BV-031-C [UCL SNK Config Codec, LC3 48_5]
  BAP/UCL/SCC/BV-032-C [UCL SNK Config Codec, LC3 48_6]

  Pass verdict:
  The IUT successfully writes to the ASE Control point with the opcode
  set to 0x01 (Config Codec) and correctly formatted parameter values
  from Table 4.9.
  The Codec_ID field is a 5-octet field with octet 0 set to the LC3
  Coding_Format value defined in Bluetooth Assigned Numbers, octets 1–4
  set to 0x0000.

Test Summary
------------
BAP/UCL/SCC/BV-001-C [UCL SRC Config Codec, LC3 8_1] Passed
BAP/UCL/SCC/BV-002-C [UCL SRC Config Codec, LC3 8_2] Passed
BAP/UCL/SCC/BV-003-C [UCL SRC Config Codec, LC3 16_1] Passed
BAP/UCL/SCC/BV-004-C [UCL SRC Config Codec, LC3 16_2] Passed
BAP/UCL/SCC/BV-005-C [UCL SRC Config Codec, LC3 24_1] Passed
BAP/UCL/SCC/BV-006-C [UCL SRC Config Codec, LC3 24_2] Passed
BAP/UCL/SCC/BV-007-C [UCL SRC Config Codec, LC3 32_1] Passed
BAP/UCL/SCC/BV-008-C [UCL SRC Config Codec, LC3 32_2] Passed
BAP/UCL/SCC/BV-009-C [UCL SRC Config Codec, LC3 44.1_1] Passed
BAP/UCL/SCC/BV-010-C [UCL SRC Config Codec, LC3 44.1_2] Passed
BAP/UCL/SCC/BV-011-C [UCL SRC Config Codec, LC3 48_1] Passed
BAP/UCL/SCC/BV-012-C [UCL SRC Config Codec, LC3 48_2] Passed
BAP/UCL/SCC/BV-013-C [UCL SRC Config Codec, LC3 48_3] Passed
BAP/UCL/SCC/BV-014-C [UCL SRC Config Codec, LC3 48_4] Passed
BAP/UCL/SCC/BV-015-C [UCL SRC Config Codec, LC3 48_5] Passed
BAP/UCL/SCC/BV-016-C [UCL SRC Config Codec, LC3 48_6] Passed
BAP/UCL/SCC/BV-017-C [UCL SNK Config Codec, LC3 8_1] Passed
BAP/UCL/SCC/BV-018-C [UCL SNK Config Codec, LC3 8_2] Passed
BAP/UCL/SCC/BV-019-C [UCL SNK Config Codec, LC3 16_1] Passed
BAP/UCL/SCC/BV-020-C [UCL SNK Config Codec, LC3 16_2] Passed
BAP/UCL/SCC/BV-021-C [UCL SNK Config Codec, LC3 24_1] Passed
BAP/UCL/SCC/BV-022-C [UCL SNK Config Codec, LC3 24_2] Passed
BAP/UCL/SCC/BV-023-C [UCL SNK Config Codec, LC3 32_1] Passed
BAP/UCL/SCC/BV-024-C [UCL SNK Config Codec, LC3 32_2] Passed
BAP/UCL/SCC/BV-025-C [UCL SNK Config Codec, LC3 44.1_1] Passed
BAP/UCL/SCC/BV-026-C [UCL SNK Config Codec, LC3 44.1_2] Passed
BAP/UCL/SCC/BV-027-C [UCL SNK Config Codec, LC3 48_1] Passed
BAP/UCL/SCC/BV-028-C [UCL SNK Config Codec, LC3 48_2] Passed
BAP/UCL/SCC/BV-029-C [UCL SNK Config Codec, LC3 48_3] Passed
BAP/UCL/SCC/BV-030-C [UCL SNK Config Codec, LC3 48_4] Passed
BAP/UCL/SCC/BV-031-C [UCL SNK Config Codec, LC3 48_5] Passed
BAP/UCL/SCC/BV-032-C [UCL SNK Config Codec, LC3 48_6] Passed
Total: 32, Passed: 32 (100.0%), Failed: 0, Not Run: 0
---
 unit/test-bap.c | 543 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 536 insertions(+), 7 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index afeefac84091..ab48a15d32b4 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -30,20 +30,45 @@
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-client.h"
 #include "src/shared/bap.h"
+#include "src/shared/lc3.h"
+
+struct test_config {
+	struct bt_bap_pac_qos pqos;
+	struct iovec cc;
+	struct bt_bap_qos qos;
+	bool snk;
+	bool src;
+};
 
 struct test_data {
 	struct bt_gatt_client *client;
 	struct bt_bap *bap;
+	struct bt_bap_pac *snk;
+	struct bt_bap_pac *src;
+	struct iovec *caps;
+	struct test_config *cfg;
+	struct bt_bap_stream *stream;
 	size_t iovcnt;
 	struct iovec *iov;
 };
 
+/*
+ * Frequencies: 8Khz 11Khz 16Khz 22Khz 24Khz 32Khz 44.1Khz 48Khz
+ * Duration: 7.5 ms 10 ms
+ * Channel count: 3
+ * Frame length: 30-240
+ */
+static struct iovec lc3_caps = LC3_CAPABILITIES(LC3_FREQ_ANY, LC3_DURATION_ANY,
+								3u, 30, 240);
+
 #define iov_data(args...) ((const struct iovec[]) { args })
 
-#define define_test(name, function, args...)			\
+#define define_test(name, function, _cfg, args...)		\
 	do {							\
 		const struct iovec iov[] = { args };		\
 		static struct test_data data;			\
+		data.caps = &lc3_caps;				\
+		data.cfg = _cfg;				\
 		data.iovcnt = ARRAY_SIZE(iov_data(args));	\
 		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov_data(args))); \
 		tester_add(name, &data, test_setup, function,	\
@@ -307,6 +332,38 @@ static void test_complete_cb(const void *user_data)
 	tester_test_passed();
 }
 
+static void bap_config(struct bt_bap_stream *stream,
+					uint8_t code, uint8_t reason,
+					void *user_data)
+{
+	if (code)
+		tester_test_failed();
+}
+
+static bool pac_found(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
+							void *user_data)
+{
+	struct test_data *data = user_data;
+	unsigned int config_id;
+
+	data->stream = bt_bap_stream_new(data->bap, lpac, rpac,
+						&data->cfg->qos,
+						&data->cfg->cc);
+	g_assert(data->stream);
+
+	config_id = bt_bap_stream_config(data->stream, &data->cfg->qos,
+					&data->cfg->cc, bap_config, data);
+	g_assert(config_id);
+
+	return true;
+}
+
+static void bap_ready(struct bt_bap *bap, void *user_data)
+{
+	bt_bap_foreach_pac(bap, BT_BAP_SINK, pac_found, user_data);
+	bt_bap_foreach_pac(bap, BT_BAP_SOURCE, pac_found, user_data);
+}
+
 static void test_client(const void *user_data)
 {
 	struct test_data *data = (void *)user_data;
@@ -321,11 +378,29 @@ static void test_client(const void *user_data)
 	db = gatt_db_new();
 	g_assert(db);
 
+	if (data->cfg) {
+		if (data->cfg->src) {
+			data->snk = bt_bap_add_pac(db, "test-bap-snk",
+							BT_BAP_SINK, LC3_ID,
+							NULL, data->caps, NULL);
+			g_assert(data->snk);
+		}
+
+		if (data->cfg->snk) {
+			data->src = bt_bap_add_pac(db, "test-bap-src",
+							BT_BAP_SOURCE, LC3_ID,
+							NULL, data->caps, NULL);
+			g_assert(data->src);
+		}
+	}
+
 	data->bap = bt_bap_new(db, bt_gatt_client_get_db(data->client));
 	g_assert(data->bap);
 
 	bt_bap_set_debug(data->bap, print_debug, "bt_bap:", NULL);
 
+	bt_bap_ready_register(data->bap, bap_ready, data, NULL);
+
 	bt_bap_attach(data->bap, data->client);
 }
 
@@ -531,22 +606,22 @@ static void test_disc(void)
 	 * The IUT reads the values of the characteristics specified in the PAC
 	 * Characteristic and Location Characteristic columns.
 	 */
-	define_test("BAP/UCL/DISC/BV-01-C", test_client, DISC_SINK_PAC);
-	define_test("BAP/UCL/DISC/BV-02-C", test_client, DISC_SOURCE_PAC);
+	define_test("BAP/UCL/DISC/BV-01-C", test_client, NULL, DISC_SINK_PAC);
+	define_test("BAP/UCL/DISC/BV-02-C", test_client, NULL, DISC_SOURCE_PAC);
 
 	/* BAP/UCL/DISC/BV-06-C [Discover Available Audio Contexts]
 	 *
 	 * The IUT successfully reads the value of the Available Audio Contexts
 	 * characteristic on the LowerTester.
 	 */
-	define_test("BAP/UCL/DISC/BV-06-C", test_client, DISC_CTX);
+	define_test("BAP/UCL/DISC/BV-06-C", test_client, NULL, DISC_CTX);
 
 	/* BAP/UCL/DISC/BV-05-C [Discover Supported Audio Contexts]
 	 *
 	 * The IUT successfully reads the value of the Supported Audio Contexts
 	 * characteristic on the Lower Tester.
 	 */
-	define_test("BAP/UCL/DISC/BV-05-C", test_client, DISC_SUP_CTX);
+	define_test("BAP/UCL/DISC/BV-05-C", test_client, NULL, DISC_SUP_CTX);
 
 	/* BAP/UCL/DISC/BV-03-C [Discover Sink ASE_ID]
 	 * BAP/UCL/DISC/BV-04-C [Discover Source ASE_ID]
@@ -554,8 +629,461 @@ static void test_disc(void)
 	 * The IUT successfully reads the ASE_ID values of each discovered ASE
 	 * characteristic on the LowerTester.
 	 */
-	define_test("BAP/UCL/DISC/BV-03-C", test_client, DISC_SINK_ASE);
-	define_test("BAP/UCL/DISC/BV-04-C", test_client, DISC_SOURCE_ASE);
+	define_test("BAP/UCL/DISC/BV-03-C", test_client, NULL, DISC_SINK_ASE);
+	define_test("BAP/UCL/DISC/BV-04-C", test_client, NULL, DISC_SOURCE_ASE);
+}
+
+/* ATT: Write Command (0x52) len 23
+ *  Handle: 0x0022
+ *    Data: 010101020206000000000_cfg
+ * ATT: Handle Value Notification (0x1b) len 7
+ *   Handle: 0x0022
+ *     Data: 0101010000
+ * ATT: Handle Value Notification (0x1b) len 37
+ *   Handle: 0x0016
+ *     Data: 01010102010a00204e00409c00204e00409c000600000000_cfg
+ */
+#define SCC_SNK(_cfg...) \
+	DISC_SOURCE_ASE, \
+	IOV_DATA(0x52, 0x22, 0x00, 0x01, 0x01, 0x01, 0x02, 0x02, 0x06, 0x00, \
+			0x00, 0x00, 0x00, _cfg), \
+	IOV_DATA(0x1b, 0x22, 0x00, 0x01, 0x01, 0x01, 0x00, 0x00), \
+	IOV_NULL, \
+	IOV_DATA(0x1b, 0x16, 0x00, 0x01, 0x01, 0x01, 0x02, 0x01, 0x0a, 0x00, \
+			0x20, 0x4e, 0x00, 0x40, 0x9c, 0x00, 0x20, 0x4e, 0x00, \
+			0x40, 0x9c, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, _cfg)
+
+#define QOS_BALANCED_2M \
+	{ \
+		.target_latency = BT_BAP_CONFIG_LATENCY_BALANCED, \
+		.phy = BT_BAP_CONFIG_PHY_2M, \
+	}
+
+static struct test_config cfg_snk_8_1 = {
+	.cc = LC3_CONFIG_8_1,
+	.qos = QOS_BALANCED_2M,
+	.snk = true,
+};
+
+#define SCC_SNK_8_1 \
+	SCC_SNK(0x0a, 0x02, 0x01, 0x01, 0x02, 0x02, 0x00, 0x03, 0x04, 0x1a, \
+			0x00)
+
+static struct test_config cfg_snk_8_2 = {
+	.cc = LC3_CONFIG_8_2,
+	.qos = QOS_BALANCED_2M,
+	.snk = true,
+};
+
+#define SCC_SNK_8_2 \
+	SCC_SNK(0x0a, 0x02, 0x01, 0x01, 0x02, 0x02, 0x01, 0x03, 0x04, 0x1e, \
+			0x00)
+
+static struct test_config cfg_snk_16_1 = {
+	.cc = LC3_CONFIG_16_1,
+	.qos = QOS_BALANCED_2M,
+	.snk = true,
+};
+
+#define SCC_SNK_16_1 \
+	SCC_SNK(0x0a, 0x02, 0x01, 0x03, 0x02, 0x02, 0x00, 0x03, 0x04, 0x1e, \
+			0x00)
+
+static struct test_config cfg_snk_16_2 = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = QOS_BALANCED_2M,
+	.snk = true,
+};
+
+#define SCC_SNK_16_2 \
+	SCC_SNK(0x0a, 0x02, 0x01, 0x03, 0x02, 0x02, 0x01, 0x03, 0x04, 0x28, \
+			0x00)
+
+static struct test_config cfg_snk_24_1 = {
+	.cc = LC3_CONFIG_24_1,
+	.qos = QOS_BALANCED_2M,
+	.snk = true,
+};
+
+#define SCC_SNK_24_1 \
+	SCC_SNK(0x0a, 0x02, 0x01, 0x05, 0x02, 0x02, 0x00, 0x03, 0x04, 0x2d, \
+			0x00)
+
+static struct test_config cfg_snk_24_2 = {
+	.cc = LC3_CONFIG_24_2,
+	.qos = QOS_BALANCED_2M,
+	.snk = true,
+};
+
+#define SCC_SNK_24_2 \
+	SCC_SNK(0x0a, 0x02, 0x01, 0x05, 0x02, 0x02, 0x01, 0x03, 0x04, 0x3c, \
+			0x00)
+
+static struct test_config cfg_snk_32_1 = {
+	.cc = LC3_CONFIG_32_1,
+	.qos = QOS_BALANCED_2M,
+	.snk = true,
+};
+
+#define SCC_SNK_32_1 \
+	SCC_SNK(0x0a, 0x02, 0x01, 0x06, 0x02, 0x02, 0x00, 0x03, 0x04, 0x3c, \
+			0x00)
+
+static struct test_config cfg_snk_32_2 = {
+	.cc = LC3_CONFIG_32_2,
+	.qos = QOS_BALANCED_2M,
+	.snk = true,
+};
+
+#define SCC_SNK_32_2 \
+	SCC_SNK(0x0a, 0x02, 0x01, 0x06, 0x02, 0x02, 0x01, 0x03, 0x04, 0x50, \
+			0x00)
+
+static struct test_config cfg_snk_44_1 = {
+	.cc = LC3_CONFIG_44_1,
+	.qos = QOS_BALANCED_2M,
+	.snk = true,
+};
+
+#define SCC_SNK_44_1 \
+	SCC_SNK(0x0a, 0x02, 0x01, 0x07, 0x02, 0x02, 0x00, 0x03, 0x04, 0x62, \
+			0x00)
+
+static struct test_config cfg_snk_44_2 = {
+	.cc = LC3_CONFIG_44_2,
+	.qos = QOS_BALANCED_2M,
+	.snk = true,
+};
+
+#define SCC_SNK_44_2 \
+	SCC_SNK(0x0a, 0x02, 0x01, 0x07, 0x02, 0x02, 0x01, 0x03, 0x04, 0x82, \
+			0x00)
+
+static struct test_config cfg_snk_48_1 = {
+	.cc = LC3_CONFIG_48_1,
+	.qos = QOS_BALANCED_2M,
+	.snk = true,
+};
+
+#define SCC_SNK_48_1 \
+	SCC_SNK(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x00, 0x03, 0x04, 0x4b, \
+			0x00)
+
+static struct test_config cfg_snk_48_2 = {
+	.cc = LC3_CONFIG_48_2,
+	.qos = QOS_BALANCED_2M,
+	.snk = true,
+};
+
+#define SCC_SNK_48_2 \
+	SCC_SNK(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x01, 0x03, 0x04, 0x64, \
+			0x00)
+
+static struct test_config cfg_snk_48_3 = {
+	.cc = LC3_CONFIG_48_3,
+	.qos = QOS_BALANCED_2M,
+	.snk = true,
+};
+
+#define SCC_SNK_48_3 \
+	SCC_SNK(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x00, 0x03, 0x04, 0x5a, \
+			0x00)
+
+static struct test_config cfg_snk_48_4 = {
+	.cc = LC3_CONFIG_48_4,
+	.qos = QOS_BALANCED_2M,
+	.snk = true,
+};
+
+#define SCC_SNK_48_4 \
+	SCC_SNK(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x01, 0x03, 0x04, 0x78, \
+			0x00)
+
+static struct test_config cfg_snk_48_5 = {
+	.cc = LC3_CONFIG_48_5,
+	.qos = QOS_BALANCED_2M,
+	.snk = true,
+};
+
+#define SCC_SNK_48_5 \
+	SCC_SNK(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x00, 0x03, 0x04, 0x75, \
+			0x00)
+
+static struct test_config cfg_snk_48_6 = {
+	.cc = LC3_CONFIG_48_6,
+	.qos = QOS_BALANCED_2M,
+	.snk = true,
+};
+
+#define SCC_SNK_48_6 \
+	SCC_SNK(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x01, 0x03, 0x04, 0x9b, \
+			0x00)
+
+/* ATT: Write Command (0x52) len 23
+ *  Handle: 0x0022
+ *    Data: 010103020206000000000_cfg
+ * ATT: Handle Value Notification (0x1b) len 7
+ *   Handle: 0x0022
+ *     Data: 0101030000
+ * ATT: Handle Value Notification (0x1b) len 37
+ *   Handle: 0x001c
+ *     Data: 03010102010a00204e00409c00204e00409c000600000000_cfg
+ */
+#define SCC_SRC(_cfg...) \
+	DISC_SOURCE_ASE, \
+	IOV_DATA(0x52, 0x22, 0x00, 0x01, 0x01, 0x03, 0x02, 0x02, 0x06, 0x00, \
+			0x00, 0x00, 0x00, _cfg), \
+	IOV_DATA(0x1b, 0x22, 0x00, 0x01, 0x01, 0x03, 0x00, 0x00), \
+	IOV_NULL, \
+	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x01, 0x01, 0x02, 0x01, 0x0a, 0x00, \
+			0x20, 0x4e, 0x00, 0x40, 0x9c, 0x00, 0x20, 0x4e, 0x00, \
+			0x40, 0x9c, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, _cfg)
+
+static struct test_config cfg_src_8_1 = {
+	.cc = LC3_CONFIG_8_1,
+	.qos = QOS_BALANCED_2M,
+	.src = true,
+};
+
+#define SCC_SRC_8_1 \
+	SCC_SRC(0x0a, 0x02, 0x01, 0x01, 0x02, 0x02, 0x00, 0x03, 0x04, 0x1a, \
+			0x00)
+
+static struct test_config cfg_src_8_2 = {
+	.cc = LC3_CONFIG_8_2,
+	.qos = QOS_BALANCED_2M,
+	.src = true,
+};
+
+#define SCC_SRC_8_2 \
+	SCC_SRC(0x0a, 0x02, 0x01, 0x01, 0x02, 0x02, 0x01, 0x03, 0x04, 0x1e, \
+			0x00)
+
+static struct test_config cfg_src_16_1 = {
+	.cc = LC3_CONFIG_16_1,
+	.qos = QOS_BALANCED_2M,
+	.src = true,
+};
+
+#define SCC_SRC_16_1 \
+	SCC_SRC(0x0a, 0x02, 0x01, 0x03, 0x02, 0x02, 0x00, 0x03, 0x04, 0x1e, \
+			0x00)
+
+static struct test_config cfg_src_16_2 = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = QOS_BALANCED_2M,
+	.src = true,
+};
+
+#define SCC_SRC_16_2 \
+	SCC_SRC(0x0a, 0x02, 0x01, 0x03, 0x02, 0x02, 0x01, 0x03, 0x04, 0x28, \
+			0x00)
+
+static struct test_config cfg_src_24_1 = {
+	.cc = LC3_CONFIG_24_1,
+	.qos = QOS_BALANCED_2M,
+	.src = true,
+};
+
+#define SCC_SRC_24_1 \
+	SCC_SRC(0x0a, 0x02, 0x01, 0x05, 0x02, 0x02, 0x00, 0x03, 0x04, 0x2d, \
+			0x00)
+
+static struct test_config cfg_src_24_2 = {
+	.cc = LC3_CONFIG_24_2,
+	.qos = QOS_BALANCED_2M,
+	.src = true,
+};
+
+#define SCC_SRC_24_2 \
+	SCC_SRC(0x0a, 0x02, 0x01, 0x05, 0x02, 0x02, 0x01, 0x03, 0x04, 0x3c, \
+			0x00)
+
+static struct test_config cfg_src_32_1 = {
+	.cc = LC3_CONFIG_32_1,
+	.qos = QOS_BALANCED_2M,
+	.src = true,
+};
+
+#define SCC_SRC_32_1 \
+	SCC_SRC(0x0a, 0x02, 0x01, 0x06, 0x02, 0x02, 0x00, 0x03, 0x04, 0x3c, \
+			0x00)
+
+static struct test_config cfg_src_32_2 = {
+	.cc = LC3_CONFIG_32_2,
+	.qos = QOS_BALANCED_2M,
+	.src = true,
+};
+
+#define SCC_SRC_32_2 \
+	SCC_SRC(0x0a, 0x02, 0x01, 0x06, 0x02, 0x02, 0x01, 0x03, 0x04, 0x50, \
+			0x00)
+
+static struct test_config cfg_src_44_1 = {
+	.cc = LC3_CONFIG_44_1,
+	.qos = QOS_BALANCED_2M,
+	.src = true,
+};
+
+#define SCC_SRC_44_1 \
+	SCC_SRC(0x0a, 0x02, 0x01, 0x07, 0x02, 0x02, 0x00, 0x03, 0x04, 0x62, \
+			0x00)
+
+static struct test_config cfg_src_44_2 = {
+	.cc = LC3_CONFIG_44_2,
+	.qos = QOS_BALANCED_2M,
+	.src = true,
+};
+
+#define SCC_SRC_44_2 \
+	SCC_SRC(0x0a, 0x02, 0x01, 0x07, 0x02, 0x02, 0x01, 0x03, 0x04, 0x82, \
+			0x00)
+
+static struct test_config cfg_src_48_1 = {
+	.cc = LC3_CONFIG_48_1,
+	.qos = QOS_BALANCED_2M,
+	.src = true,
+};
+
+#define SCC_SRC_48_1 \
+	SCC_SRC(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x00, 0x03, 0x04, 0x4b, \
+			0x00)
+
+static struct test_config cfg_src_48_2 = {
+	.cc = LC3_CONFIG_48_2,
+	.qos = QOS_BALANCED_2M,
+	.src = true,
+};
+
+#define SCC_SRC_48_2 \
+	SCC_SRC(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x01, 0x03, 0x04, 0x64, \
+			0x00)
+
+static struct test_config cfg_src_48_3 = {
+	.cc = LC3_CONFIG_48_3,
+	.qos = QOS_BALANCED_2M,
+	.src = true,
+};
+
+#define SCC_SRC_48_3 \
+	SCC_SRC(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x00, 0x03, 0x04, 0x5a, \
+			0x00)
+
+static struct test_config cfg_src_48_4 = {
+	.cc = LC3_CONFIG_48_4,
+	.qos = QOS_BALANCED_2M,
+	.src = true,
+};
+
+#define SCC_SRC_48_4 \
+	SCC_SRC(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x01, 0x03, 0x04, 0x78, \
+			0x00)
+
+static struct test_config cfg_src_48_5 = {
+	.cc = LC3_CONFIG_48_5,
+	.qos = QOS_BALANCED_2M,
+	.src = true,
+};
+
+#define SCC_SRC_48_5 \
+	SCC_SRC(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x00, 0x03, 0x04, 0x75, \
+			0x00)
+
+static struct test_config cfg_src_48_6 = {
+	.cc = LC3_CONFIG_48_6,
+	.qos = QOS_BALANCED_2M,
+	.src = true,
+};
+
+#define SCC_SRC_48_6 \
+	SCC_SRC(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x01, 0x03, 0x04, \
+			0x9b, 0x00)
+
+/* Test Purpose:
+ * Verify that a Unicast Client IUT can initiate a Config Codec
+ * operation for an LC3 codec.
+ *
+ * Pass verdict:
+ * The IUT successfully writes to the ASE Control point with the opcode
+ * set to 0x01 (Config Codec) and correctly formatted parameter values
+ * from Table 4.9. The Codec_ID field is a 5-octet field with octet 0
+ * set to the LC3 Coding_Format value defined in Bluetooth Assigned
+ * Numbers, octets 1–4 set to 0x0000. Each parameter (if present)
+ * included in the data sent in Codec_Specific_Configuration is
+ * formatted in an LTV structure with the length, type, and value
+ * specified in Table 4.10.
+ */
+static void test_scc_cc_lc3(void)
+{
+	define_test("BAP/UCL/SCC/BV-001-C [UCL SRC Config Codec, LC3 8_1]",
+			test_client, &cfg_snk_8_1, SCC_SNK_8_1);
+	define_test("BAP/UCL/SCC/BV-002-C [UCL SRC Config Codec, LC3 8_2]",
+			test_client, &cfg_snk_8_2, SCC_SNK_8_2);
+	define_test("BAP/UCL/SCC/BV-003-C [UCL SRC Config Codec, LC3 16_1]",
+			test_client, &cfg_snk_16_1, SCC_SNK_16_1);
+	define_test("BAP/UCL/SCC/BV-004-C [UCL SRC Config Codec, LC3 16_2]",
+			test_client, &cfg_snk_16_2, SCC_SNK_16_2);
+	define_test("BAP/UCL/SCC/BV-005-C [UCL SRC Config Codec, LC3 24_1]",
+			test_client, &cfg_snk_24_1, SCC_SNK_24_1);
+	define_test("BAP/UCL/SCC/BV-006-C [UCL SRC Config Codec, LC3 24_2]",
+			test_client, &cfg_snk_24_2, SCC_SNK_24_2);
+	define_test("BAP/UCL/SCC/BV-007-C [UCL SRC Config Codec, LC3 32_1]",
+			test_client, &cfg_snk_32_1, SCC_SNK_32_1);
+	define_test("BAP/UCL/SCC/BV-008-C [UCL SRC Config Codec, LC3 32_2]",
+			test_client, &cfg_snk_32_2, SCC_SNK_32_2);
+	define_test("BAP/UCL/SCC/BV-009-C [UCL SRC Config Codec, LC3 44.1_1]",
+			test_client, &cfg_snk_44_1, SCC_SNK_44_1);
+	define_test("BAP/UCL/SCC/BV-010-C [UCL SRC Config Codec, LC3 44.1_2]",
+			test_client, &cfg_snk_44_2, SCC_SNK_44_2);
+	define_test("BAP/UCL/SCC/BV-011-C [UCL SRC Config Codec, LC3 48_1]",
+			test_client, &cfg_snk_48_1, SCC_SNK_48_1);
+	define_test("BAP/UCL/SCC/BV-012-C [UCL SRC Config Codec, LC3 48_2]",
+			test_client, &cfg_snk_48_2, SCC_SNK_48_2);
+	define_test("BAP/UCL/SCC/BV-013-C [UCL SRC Config Codec, LC3 48_3]",
+			test_client, &cfg_snk_48_3, SCC_SNK_48_3);
+	define_test("BAP/UCL/SCC/BV-014-C [UCL SRC Config Codec, LC3 48_4]",
+			test_client, &cfg_snk_48_4, SCC_SNK_48_4);
+	define_test("BAP/UCL/SCC/BV-015-C [UCL SRC Config Codec, LC3 48_5]",
+			test_client, &cfg_snk_48_5, SCC_SNK_48_5);
+	define_test("BAP/UCL/SCC/BV-016-C [UCL SRC Config Codec, LC3 48_6]",
+			test_client, &cfg_snk_48_6, SCC_SNK_48_6);
+	define_test("BAP/UCL/SCC/BV-017-C [UCL SNK Config Codec, LC3 8_1]",
+			test_client, &cfg_src_8_1, SCC_SRC_8_1);
+	define_test("BAP/UCL/SCC/BV-018-C [UCL SNK Config Codec, LC3 8_2]",
+			test_client, &cfg_src_8_2, SCC_SRC_8_2);
+	define_test("BAP/UCL/SCC/BV-019-C [UCL SNK Config Codec, LC3 16_1]",
+			test_client, &cfg_src_16_1, SCC_SRC_16_1);
+	define_test("BAP/UCL/SCC/BV-020-C [UCL SNK Config Codec, LC3 16_2]",
+			test_client, &cfg_src_16_2, SCC_SRC_16_2);
+	define_test("BAP/UCL/SCC/BV-021-C [UCL SNK Config Codec, LC3 24_1]",
+			test_client, &cfg_src_24_1, SCC_SRC_24_1);
+	define_test("BAP/UCL/SCC/BV-022-C [UCL SNK Config Codec, LC3 24_2]",
+			test_client, &cfg_src_24_2, SCC_SRC_24_2);
+	define_test("BAP/UCL/SCC/BV-023-C [UCL SNK Config Codec, LC3 32_1]",
+			test_client, &cfg_src_32_1, SCC_SRC_32_1);
+	define_test("BAP/UCL/SCC/BV-024-C [UCL SNK Config Codec, LC3 32_2]",
+			test_client, &cfg_src_32_2, SCC_SRC_32_2);
+	define_test("BAP/UCL/SCC/BV-025-C [UCL SNK Config Codec, LC3 44.1_1]",
+			test_client, &cfg_src_44_1, SCC_SRC_44_1);
+	define_test("BAP/UCL/SCC/BV-026-C [UCL SNK Config Codec, LC3 44.1_2]",
+			test_client, &cfg_src_44_2, SCC_SRC_44_2);
+	define_test("BAP/UCL/SCC/BV-027-C [UCL SNK Config Codec, LC3 48_1]",
+			test_client, &cfg_src_48_1, SCC_SRC_48_1);
+	define_test("BAP/UCL/SCC/BV-028-C [UCL SNK Config Codec, LC3 48_2]",
+			test_client, &cfg_src_48_2, SCC_SRC_48_2);
+	define_test("BAP/UCL/SCC/BV-029-C [UCL SNK Config Codec, LC3 48_3]",
+			test_client, &cfg_src_48_3, SCC_SRC_48_3);
+	define_test("BAP/UCL/SCC/BV-030-C [UCL SNK Config Codec, LC3 48_4]",
+			test_client, &cfg_src_48_4, SCC_SRC_48_4);
+	define_test("BAP/UCL/SCC/BV-031-C [UCL SNK Config Codec, LC3 48_5]",
+			test_client, &cfg_src_48_5, SCC_SRC_48_5);
+	define_test("BAP/UCL/SCC/BV-032-C [UCL SNK Config Codec, LC3 48_6]",
+			test_client, &cfg_src_48_6, SCC_SRC_48_6);
+}
+
+static void test_scc(void)
+{
+	test_scc_cc_lc3();
 }
 
 int main(int argc, char *argv[])
@@ -563,6 +1091,7 @@ int main(int argc, char *argv[])
 	tester_init(&argc, &argv);
 
 	test_disc();
+	test_scc();
 
 	return tester_run();
 }
-- 
2.40.0

