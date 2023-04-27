Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60944C77B73
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Apr 2023 19:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245024AbjD0Tdh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Apr 2023 15:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245453AbjD0TdJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Apr 2023 15:33:09 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489B510DA
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 12:33:06 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-32f23e2249bso12721705ab.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 12:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682623985; x=1685215985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W63wz9PM6AvCAMQzs8mg0htB9fJPZP4GWCCPe/Uebys=;
        b=PxCIgSc47qMIJveM15ljaRDCsjPz3AlYJFuP2YvSEuOB9YU4powz0Upe6SaxZop82N
         9ErHtErS4Ko0voLKmXQniWtjPJC5REPpTR+GjifLhEBjBbrktCakmTQyMBMqyOYHigpj
         c0uedqzWBakLElh3ZsiAYDYlZ9JLIwTFpSq+YU1+yo2GFGDeqJZ/NHiSm0eyckfkZBPs
         cKEXJQD7IAdpsHfJBVGC+5J2fD/JTWLJoz5VOXUOLukfI13q+vMH4jWrUjTjCVM5gDnH
         ar3ipsnIm+682tFaifvEvWWTbdJevsD/J4EhTl5waIxK9H8yv8b48xe/ry2fNjinbNHc
         vyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682623985; x=1685215985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W63wz9PM6AvCAMQzs8mg0htB9fJPZP4GWCCPe/Uebys=;
        b=aoeUU8m8yTLN7v47FvpNWted3KtIKsdjCLuUEqeLnwGPtRx+qwvTLIlIRgj84Z1yhv
         hhU5rLHS08svT0lsqWlK58jT3wMVyIXD7XKkAL6zc4v8gAwHn8+OQkB5x7LVIvtjFKiJ
         builpu8APkOmIXeiBOOjACPioZRxnn1KFb38Y9KSnmGnO8SHQrBmaGWwuKYckHv08JWz
         Z628qhJ3wsc/JnunSpyO/G1ARuCfIWBw0iXsszixdHv3gnx1eI73i4OVBv88g3/iM3Rq
         kBMpCbYf0I/NVURU0+b2YayU8MK/CphZoNx7IzOhyCFMjvfosVnGcJ1UGgtCiyPLryJF
         ZE+A==
X-Gm-Message-State: AC+VfDxp9ikYyhfrwhUlq/LyP+w9QDwH9qoOu0R2mKU+JaoqJkzfnVdy
        N2uaY6RAFPLCxhMBvT5DAEFmGxkEcUQ=
X-Google-Smtp-Source: ACHHUZ44E+DnNjJRXx3XYiJnY6gzmwKTdEXrI0dPifbw3zLBqEJHy7W5W2OeJrEE9gQZp33LvTKEMw==
X-Received: by 2002:a05:6e02:18ce:b0:329:4142:e9ff with SMTP id s14-20020a056e0218ce00b003294142e9ffmr4904778ilu.10.1682623984285;
        Thu, 27 Apr 2023 12:33:04 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id n12-20020a056638264c00b00411baa5ec5asm3349898jat.154.2023.04.27.12.33.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 12:33:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 9/9] test-bap: Add SCC tests for Vendor-Specific codec
Date:   Thu, 27 Apr 2023 12:32:45 -0700
Message-Id: <20230427193245.323502-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427193245.323502-1-luiz.dentz@gmail.com>
References: <20230427193245.323502-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

4.8.2 Unicast Client Initiates a Config Codec Operation –
Vendor-Specific (page 42):

  Test Purpose:
  Verify that a Unicast Client IUT can initiate a Config Codec
  operation for a vendor-specific codec.

  Test Case Configuration:
  BAP/UCL/SCC/BV-033-C [UCL SRC Config Codec, VS]
  BAP/UCL/SCC/BV-034-C [UCL SNK Config Codec, VS]

  Pass verdict:
  The IUT successfully writes to the ASE Control Point characteristic
  with the opcode set to 0x01 (Config Codec) and the specified
  parameters. The Codec_ID parameter is formatted with octet 0 set to
  0xFF, octets 1–2 set to TSPX_VS_Company_ID, and octets 3–4 set to
  TSPX_VS_Codec_ID.

BAP/UCL/SCC/BV-033-C                                 Passed
BAP/UCL/SCC/BV-034-C                                 Passed
---
 unit/test-bap.c | 334 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 216 insertions(+), 118 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 269dcf6520c0..241dffbd1c09 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -38,10 +38,12 @@ struct test_config {
 	struct bt_bap_qos qos;
 	bool snk;
 	bool src;
+	bool vs;
 };
 
 struct test_data {
 	struct bt_gatt_client *client;
+	struct gatt_db *db;
 	struct bt_bap *bap;
 	struct bt_bap_pac *snk;
 	struct bt_bap_pac *src;
@@ -364,37 +366,56 @@ static void bap_ready(struct bt_bap *bap, void *user_data)
 	bt_bap_foreach_pac(bap, BT_BAP_SOURCE, pac_found, user_data);
 }
 
+static void test_client_config(struct test_data *data)
+{
+	if (!data->cfg)
+		return;
+
+	if (data->cfg->src) {
+		if (data->cfg->vs)
+			data->snk = bt_bap_add_vendor_pac(data->db,
+							"test-bap-snk",
+							BT_BAP_SINK, 0x0ff,
+							0x0001, 0x0001,
+							NULL, data->caps, NULL);
+		else
+			data->snk = bt_bap_add_pac(data->db, "test-bap-snk",
+							BT_BAP_SINK, LC3_ID,
+							NULL, data->caps, NULL);
+		g_assert(data->snk);
+	}
+
+	if (data->cfg->snk) {
+		if (data->cfg->vs)
+			data->src = bt_bap_add_vendor_pac(data->db,
+							"test-bap-src",
+							BT_BAP_SOURCE, 0x0ff,
+							0x0001, 0x0001,
+							NULL, data->caps, NULL);
+		else
+			data->src = bt_bap_add_pac(data->db, "test-bap-src",
+							BT_BAP_SOURCE, LC3_ID,
+							NULL, data->caps, NULL);
+		g_assert(data->src);
+	}
+}
+
 static void test_client(const void *user_data)
 {
 	struct test_data *data = (void *)user_data;
 	struct io *io;
-	struct gatt_db *db;
 
 	io = tester_setup_io(data->iov, data->iovcnt);
 	g_assert(io);
 
 	tester_io_set_complete_func(test_complete_cb);
 
-	db = gatt_db_new();
-	g_assert(db);
+	data->db = gatt_db_new();
+	g_assert(data->db);
 
-	if (data->cfg) {
-		if (data->cfg->src) {
-			data->snk = bt_bap_add_pac(db, "test-bap-snk",
-							BT_BAP_SINK, LC3_ID,
-							NULL, data->caps, NULL);
-			g_assert(data->snk);
-		}
+	test_client_config(data);
 
-		if (data->cfg->snk) {
-			data->src = bt_bap_add_pac(db, "test-bap-src",
-							BT_BAP_SOURCE, LC3_ID,
-							NULL, data->caps, NULL);
-			g_assert(data->src);
-		}
-	}
-
-	data->bap = bt_bap_new(db, bt_gatt_client_get_db(data->client));
+	data->bap = bt_bap_new(data->db, bt_gatt_client_get_db(data->client));
 	g_assert(data->bap);
 
 	bt_bap_set_debug(data->bap, print_debug, "bt_bap:", NULL);
@@ -412,6 +433,10 @@ static void test_teardown(const void *user_data)
 	bt_gatt_client_unref(data->client);
 	util_iov_free(data->iov, data->iovcnt);
 
+	bt_bap_remove_pac(data->snk);
+	bt_bap_remove_pac(data->src);
+	gatt_db_unref(data->db);
+
 	tester_teardown_complete();
 }
 
@@ -452,14 +477,17 @@ static void test_teardown(const void *user_data)
  *       Front Left (0x00000001)
  *       Front Right (0x00000002)
  */
-#define DISC_SINK_PAC \
+#define DISC_SNK_PAC(_caps...) \
 	IOV_DATA(0x0a, 0x03, 0x00), \
-	IOV_DATA(0x0b, 0x01, 0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
-		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
-		0x1e, 0x00, 0xf0, 0x00, 0x00), \
+	IOV_DATA(0x0b, 0x01, _caps), \
 	IOV_DATA(0x0a, 0x06, 0x00), \
 	IOV_DATA(0x0b, 0x03, 0x00, 0x00, 0x00)
 
+#define DISC_SNK_LC3 \
+	DISC_SNK_PAC(0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
+		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
+		0x1e, 0x00, 0xf0, 0x00, 0x00)
+
 /* ATT: Read Request (0x0a) len 2
  *   Handle: 0x0009 Type: Source PAC (0x2bcb)
  * ATT: Read Response (0x0b) len 24
@@ -497,37 +525,50 @@ static void test_teardown(const void *user_data)
  *       Front Left (0x00000001)
  *       Front Right (0x00000002)
  */
-#define DISC_SOURCE_PAC \
-	DISC_SINK_PAC, \
+#define DISC_SRC_PAC(_caps...) \
+	DISC_SNK_PAC(_caps), \
 	IOV_DATA(0x0a, 0x09, 0x00), \
-	IOV_DATA(0x0b, 0x01, 0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
-		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
-		0x1e, 0x00, 0xf0, 0x00, 0x00), \
+	IOV_DATA(0x0b, 0x01, _caps), \
 	IOV_DATA(0x0a, 0x0c, 0x00), \
 	IOV_DATA(0x0b, 0x03, 0x00, 0x00, 0x00)
 
+#define DISC_SRC_LC3 \
+	DISC_SRC_PAC(0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
+		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
+		0x1e, 0x00, 0xf0, 0x00, 0x00)
+
 /* ATT: Read Request (0x0a) len 2
  *   Handle: 0x000f Type: Available Audio Contexts (0x2bcd)
  * ATT: Read Response (0x0b) len 4
  *   Value: ff0f0e00
  *   Handle: 0x000f Type: Available Audio Contexts (0x2bcd)
  */
-#define DISC_CTX \
-	DISC_SOURCE_PAC, \
+#define DISC_CTX(_caps...) \
+	DISC_SRC_PAC(_caps), \
 	IOV_DATA(0x0a, 0x0f, 0x00), \
 	IOV_DATA(0x0b, 0xff, 0x0f, 0x0e, 0x00)
 
+#define DISC_CTX_LC3 \
+	DISC_CTX(0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
+		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
+		0x1e, 0x00, 0xf0, 0x00, 0x00)
+
 /* ATT: Read Request (0x0a) len 2
  *   Handle: 0x0012 Type: Supported Audio Contexts (0x2bce)
  * ATT: Read Response (0x0b) len 4
  *   Value: ff0f0e00
  *   Handle: 0x0012 Type: Supported Audio Contexts (0x2bce)
  */
-#define DISC_SUP_CTX \
-	DISC_CTX, \
+#define DISC_SUP_CTX(_caps...) \
+	DISC_CTX(_caps), \
 	IOV_DATA(0x0a, 0x12, 0x00), \
 	IOV_DATA(0x0b, 0xff, 0x0f, 0x0e, 0x00)
 
+#define DISC_SUP_CTX_LC3 \
+	DISC_SUP_CTX(0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
+		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
+		0x1e, 0x00, 0xf0, 0x00, 0x00)
+
 /* ATT: Read Request (0x0a) len 2
  *   Handle: 0x0016 Type: Sink ASE (0x2bc4)
  * ATT: Read Response (0x0b) len 4
@@ -549,8 +590,8 @@ static void test_teardown(const void *user_data)
  *       Notification (0x01)
  * ATT: Write Response (0x13) len 0
  */
-#define DISC_SINK_ASE \
-	DISC_SUP_CTX, \
+#define DISC_SNK_ASE(_caps...) \
+	DISC_SUP_CTX(_caps), \
 	IOV_DATA(0x0a, 0x16, 0x00), \
 	IOV_DATA(0x0b, 0x01, 0x00), \
 	IOV_DATA(0x12, 0x17, 0x00, 0x01, 0x00), \
@@ -560,6 +601,11 @@ static void test_teardown(const void *user_data)
 	IOV_DATA(0x12, 0x1a, 0x00, 0x01, 0x00), \
 	IOV_DATA(0x13)
 
+#define DISC_SNK_ASE_LC3 \
+	DISC_SNK_ASE(0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
+		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
+		0x1e, 0x00, 0xf0, 0x00, 0x00)
+
 /* ATT: Read Request (0x0a) len 2
  *   Handle: 0x001c Type: Source ASE (0x2bc5)
  * ATT: Read Response (0x0b) len 4
@@ -586,8 +632,8 @@ static void test_teardown(const void *user_data)
  *       Notification (0x01)
  * ATT: Write Response (0x13) len 0
  */
-#define DISC_SOURCE_ASE \
-	DISC_SINK_ASE, \
+#define DISC_SRC_ASE(_cfg...) \
+	DISC_SNK_ASE(_cfg), \
 	IOV_DATA(0x0a, 0x1c, 0x00), \
 	IOV_DATA(0x0b, 0x03, 0x00), \
 	IOV_DATA(0x12, 0x1d, 0x00, 0x01, 0x00), \
@@ -599,6 +645,11 @@ static void test_teardown(const void *user_data)
 	IOV_DATA(0x12, 0x23, 0x00, 0x01, 0x00), \
 	IOV_DATA(0x13)
 
+#define DISC_SRC_ASE_LC3 \
+	DISC_SRC_ASE(0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
+		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
+		0x1e, 0x00, 0xf0, 0x00, 0x00)
+
 static void test_disc(void)
 {
 	/* The IUT discovers the characteristics specified in the PAC
@@ -606,22 +657,23 @@ static void test_disc(void)
 	 * The IUT reads the values of the characteristics specified in the PAC
 	 * Characteristic and Location Characteristic columns.
 	 */
-	define_test("BAP/UCL/DISC/BV-01-C", test_client, NULL, DISC_SINK_PAC);
-	define_test("BAP/UCL/DISC/BV-02-C", test_client, NULL, DISC_SOURCE_PAC);
+	define_test("BAP/UCL/DISC/BV-01-C", test_client, NULL, DISC_SNK_LC3);
+	define_test("BAP/UCL/DISC/BV-02-C", test_client, NULL, DISC_SRC_LC3);
 
 	/* BAP/UCL/DISC/BV-06-C [Discover Available Audio Contexts]
 	 *
 	 * The IUT successfully reads the value of the Available Audio Contexts
 	 * characteristic on the LowerTester.
 	 */
-	define_test("BAP/UCL/DISC/BV-06-C", test_client, NULL, DISC_CTX);
+	define_test("BAP/UCL/DISC/BV-06-C", test_client, NULL, DISC_CTX_LC3);
 
 	/* BAP/UCL/DISC/BV-05-C [Discover Supported Audio Contexts]
 	 *
 	 * The IUT successfully reads the value of the Supported Audio Contexts
 	 * characteristic on the Lower Tester.
 	 */
-	define_test("BAP/UCL/DISC/BV-05-C", test_client, NULL, DISC_SUP_CTX);
+	define_test("BAP/UCL/DISC/BV-05-C", test_client, NULL,
+						DISC_SUP_CTX_LC3);
 
 	/* BAP/UCL/DISC/BV-03-C [Discover Sink ASE_ID]
 	 * BAP/UCL/DISC/BV-04-C [Discover Source ASE_ID]
@@ -629,29 +681,33 @@ static void test_disc(void)
 	 * The IUT successfully reads the ASE_ID values of each discovered ASE
 	 * characteristic on the LowerTester.
 	 */
-	define_test("BAP/UCL/DISC/BV-03-C", test_client, NULL, DISC_SINK_ASE);
-	define_test("BAP/UCL/DISC/BV-04-C", test_client, NULL, DISC_SOURCE_ASE);
+	define_test("BAP/UCL/DISC/BV-03-C", test_client, NULL,
+						DISC_SNK_ASE_LC3);
+	define_test("BAP/UCL/DISC/BV-04-C", test_client, NULL,
+						DISC_SRC_ASE_LC3);
 }
 
 /* ATT: Write Command (0x52) len 23
  *  Handle: 0x0022
- *    Data: 010101020206000000000_cfg
+ *    Data: 0101010202_cfg
  * ATT: Handle Value Notification (0x1b) len 7
  *   Handle: 0x0022
  *     Data: 0101010000
  * ATT: Handle Value Notification (0x1b) len 37
  *   Handle: 0x0016
- *     Data: 01010102010a00204e00409c00204e00409c000600000000_cfg
+ *     Data: 01010102010a00204e00409c00204e00409c00_cfg
  */
 #define SCC_SNK(_cfg...) \
-	DISC_SOURCE_ASE, \
-	IOV_DATA(0x52, 0x22, 0x00, 0x01, 0x01, 0x01, 0x02, 0x02, 0x06, 0x00, \
-			0x00, 0x00, 0x00, _cfg), \
+	IOV_DATA(0x52, 0x22, 0x00, 0x01, 0x01, 0x01, 0x02, 0x02, _cfg), \
 	IOV_DATA(0x1b, 0x22, 0x00, 0x01, 0x01, 0x01, 0x00, 0x00), \
 	IOV_NULL, \
 	IOV_DATA(0x1b, 0x16, 0x00, 0x01, 0x01, 0x01, 0x02, 0x01, 0x0a, 0x00, \
 			0x20, 0x4e, 0x00, 0x40, 0x9c, 0x00, 0x20, 0x4e, 0x00, \
-			0x40, 0x9c, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, _cfg)
+			0x40, 0x9c, 0x00, _cfg)
+
+#define SCC_SNK_LC3(_cc...) \
+	DISC_SRC_ASE_LC3, \
+	SCC_SNK(0x06, 0x00, 0x00, 0x00, 0x00, _cc)
 
 #define QOS_BALANCED_2M \
 	{ \
@@ -666,8 +722,8 @@ static struct test_config cfg_snk_8_1 = {
 };
 
 #define SCC_SNK_8_1 \
-	SCC_SNK(0x0a, 0x02, 0x01, 0x01, 0x02, 0x02, 0x00, 0x03, 0x04, 0x1a, \
-			0x00)
+	SCC_SNK_LC3(0x0a, 0x02, 0x01, 0x01, 0x02, 0x02, 0x00, 0x03, 0x04, \
+			0x1a, 0x00)
 
 static struct test_config cfg_snk_8_2 = {
 	.cc = LC3_CONFIG_8_2,
@@ -676,8 +732,8 @@ static struct test_config cfg_snk_8_2 = {
 };
 
 #define SCC_SNK_8_2 \
-	SCC_SNK(0x0a, 0x02, 0x01, 0x01, 0x02, 0x02, 0x01, 0x03, 0x04, 0x1e, \
-			0x00)
+	SCC_SNK_LC3(0x0a, 0x02, 0x01, 0x01, 0x02, 0x02, 0x01, 0x03, 0x04, \
+			0x1e, 0x00)
 
 static struct test_config cfg_snk_16_1 = {
 	.cc = LC3_CONFIG_16_1,
@@ -686,8 +742,8 @@ static struct test_config cfg_snk_16_1 = {
 };
 
 #define SCC_SNK_16_1 \
-	SCC_SNK(0x0a, 0x02, 0x01, 0x03, 0x02, 0x02, 0x00, 0x03, 0x04, 0x1e, \
-			0x00)
+	SCC_SNK_LC3(0x0a, 0x02, 0x01, 0x03, 0x02, 0x02, 0x00, 0x03, 0x04, \
+			0x1e, 0x00)
 
 static struct test_config cfg_snk_16_2 = {
 	.cc = LC3_CONFIG_16_2,
@@ -696,8 +752,8 @@ static struct test_config cfg_snk_16_2 = {
 };
 
 #define SCC_SNK_16_2 \
-	SCC_SNK(0x0a, 0x02, 0x01, 0x03, 0x02, 0x02, 0x01, 0x03, 0x04, 0x28, \
-			0x00)
+	SCC_SNK_LC3(0x0a, 0x02, 0x01, 0x03, 0x02, 0x02, 0x01, 0x03, 0x04, \
+			0x28, 0x00)
 
 static struct test_config cfg_snk_24_1 = {
 	.cc = LC3_CONFIG_24_1,
@@ -706,8 +762,8 @@ static struct test_config cfg_snk_24_1 = {
 };
 
 #define SCC_SNK_24_1 \
-	SCC_SNK(0x0a, 0x02, 0x01, 0x05, 0x02, 0x02, 0x00, 0x03, 0x04, 0x2d, \
-			0x00)
+	SCC_SNK_LC3(0x0a, 0x02, 0x01, 0x05, 0x02, 0x02, 0x00, 0x03, 0x04, \
+			0x2d, 0x00)
 
 static struct test_config cfg_snk_24_2 = {
 	.cc = LC3_CONFIG_24_2,
@@ -716,8 +772,8 @@ static struct test_config cfg_snk_24_2 = {
 };
 
 #define SCC_SNK_24_2 \
-	SCC_SNK(0x0a, 0x02, 0x01, 0x05, 0x02, 0x02, 0x01, 0x03, 0x04, 0x3c, \
-			0x00)
+	SCC_SNK_LC3(0x0a, 0x02, 0x01, 0x05, 0x02, 0x02, 0x01, 0x03, 0x04, \
+			0x3c, 0x00)
 
 static struct test_config cfg_snk_32_1 = {
 	.cc = LC3_CONFIG_32_1,
@@ -726,8 +782,8 @@ static struct test_config cfg_snk_32_1 = {
 };
 
 #define SCC_SNK_32_1 \
-	SCC_SNK(0x0a, 0x02, 0x01, 0x06, 0x02, 0x02, 0x00, 0x03, 0x04, 0x3c, \
-			0x00)
+	SCC_SNK_LC3(0x0a, 0x02, 0x01, 0x06, 0x02, 0x02, 0x00, 0x03, 0x04, \
+			0x3c, 0x00)
 
 static struct test_config cfg_snk_32_2 = {
 	.cc = LC3_CONFIG_32_2,
@@ -736,8 +792,8 @@ static struct test_config cfg_snk_32_2 = {
 };
 
 #define SCC_SNK_32_2 \
-	SCC_SNK(0x0a, 0x02, 0x01, 0x06, 0x02, 0x02, 0x01, 0x03, 0x04, 0x50, \
-			0x00)
+	SCC_SNK_LC3(0x0a, 0x02, 0x01, 0x06, 0x02, 0x02, 0x01, 0x03, 0x04, \
+			0x50, 0x00)
 
 static struct test_config cfg_snk_44_1 = {
 	.cc = LC3_CONFIG_44_1,
@@ -746,8 +802,8 @@ static struct test_config cfg_snk_44_1 = {
 };
 
 #define SCC_SNK_44_1 \
-	SCC_SNK(0x0a, 0x02, 0x01, 0x07, 0x02, 0x02, 0x00, 0x03, 0x04, 0x62, \
-			0x00)
+	SCC_SNK_LC3(0x0a, 0x02, 0x01, 0x07, 0x02, 0x02, 0x00, 0x03, 0x04, \
+			0x62, 0x00)
 
 static struct test_config cfg_snk_44_2 = {
 	.cc = LC3_CONFIG_44_2,
@@ -756,8 +812,8 @@ static struct test_config cfg_snk_44_2 = {
 };
 
 #define SCC_SNK_44_2 \
-	SCC_SNK(0x0a, 0x02, 0x01, 0x07, 0x02, 0x02, 0x01, 0x03, 0x04, 0x82, \
-			0x00)
+	SCC_SNK_LC3(0x0a, 0x02, 0x01, 0x07, 0x02, 0x02, 0x01, 0x03, 0x04, \
+			0x82, 0x00)
 
 static struct test_config cfg_snk_48_1 = {
 	.cc = LC3_CONFIG_48_1,
@@ -766,8 +822,8 @@ static struct test_config cfg_snk_48_1 = {
 };
 
 #define SCC_SNK_48_1 \
-	SCC_SNK(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x00, 0x03, 0x04, 0x4b, \
-			0x00)
+	SCC_SNK_LC3(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x00, 0x03, 0x04, \
+			0x4b, 0x00)
 
 static struct test_config cfg_snk_48_2 = {
 	.cc = LC3_CONFIG_48_2,
@@ -776,8 +832,8 @@ static struct test_config cfg_snk_48_2 = {
 };
 
 #define SCC_SNK_48_2 \
-	SCC_SNK(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x01, 0x03, 0x04, 0x64, \
-			0x00)
+	SCC_SNK_LC3(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x01, 0x03, 0x04, \
+			0x64, 0x00)
 
 static struct test_config cfg_snk_48_3 = {
 	.cc = LC3_CONFIG_48_3,
@@ -786,8 +842,8 @@ static struct test_config cfg_snk_48_3 = {
 };
 
 #define SCC_SNK_48_3 \
-	SCC_SNK(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x00, 0x03, 0x04, 0x5a, \
-			0x00)
+	SCC_SNK_LC3(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x00, 0x03, 0x04, \
+			0x5a, 0x00)
 
 static struct test_config cfg_snk_48_4 = {
 	.cc = LC3_CONFIG_48_4,
@@ -796,8 +852,8 @@ static struct test_config cfg_snk_48_4 = {
 };
 
 #define SCC_SNK_48_4 \
-	SCC_SNK(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x01, 0x03, 0x04, 0x78, \
-			0x00)
+	SCC_SNK_LC3(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x01, 0x03, 0x04, \
+			0x78, 0x00)
 
 static struct test_config cfg_snk_48_5 = {
 	.cc = LC3_CONFIG_48_5,
@@ -806,8 +862,8 @@ static struct test_config cfg_snk_48_5 = {
 };
 
 #define SCC_SNK_48_5 \
-	SCC_SNK(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x00, 0x03, 0x04, 0x75, \
-			0x00)
+	SCC_SNK_LC3(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x00, 0x03, 0x04, \
+			0x75, 0x00)
 
 static struct test_config cfg_snk_48_6 = {
 	.cc = LC3_CONFIG_48_6,
@@ -816,28 +872,30 @@ static struct test_config cfg_snk_48_6 = {
 };
 
 #define SCC_SNK_48_6 \
-	SCC_SNK(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x01, 0x03, 0x04, 0x9b, \
-			0x00)
+	SCC_SNK_LC3(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x01, 0x03, 0x04, \
+			0x9b, 0x00)
 
 /* ATT: Write Command (0x52) len 23
  *  Handle: 0x0022
- *    Data: 010103020206000000000_cfg
+ *    Data: 0101030202_cfg
  * ATT: Handle Value Notification (0x1b) len 7
  *   Handle: 0x0022
  *     Data: 0101030000
  * ATT: Handle Value Notification (0x1b) len 37
  *   Handle: 0x001c
- *     Data: 03010102010a00204e00409c00204e00409c000600000000_cfg
+ *     Data: 03010102010a00204e00409c00204e00409c00_cfg
  */
 #define SCC_SRC(_cfg...) \
-	DISC_SOURCE_ASE, \
-	IOV_DATA(0x52, 0x22, 0x00, 0x01, 0x01, 0x03, 0x02, 0x02, 0x06, 0x00, \
-			0x00, 0x00, 0x00, _cfg), \
+	IOV_DATA(0x52, 0x22, 0x00, 0x01, 0x01, 0x03, 0x02, 0x02, _cfg), \
 	IOV_DATA(0x1b, 0x22, 0x00, 0x01, 0x01, 0x03, 0x00, 0x00), \
 	IOV_NULL, \
 	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x01, 0x01, 0x02, 0x01, 0x0a, 0x00, \
 			0x20, 0x4e, 0x00, 0x40, 0x9c, 0x00, 0x20, 0x4e, 0x00, \
-			0x40, 0x9c, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, _cfg)
+			0x40, 0x9c, 0x00, _cfg)
+
+#define SCC_SRC_LC3(_cc...) \
+	DISC_SRC_ASE_LC3, \
+	SCC_SRC(0x06, 0x00, 0x00, 0x00, 0x00, _cc)
 
 static struct test_config cfg_src_8_1 = {
 	.cc = LC3_CONFIG_8_1,
@@ -846,8 +904,8 @@ static struct test_config cfg_src_8_1 = {
 };
 
 #define SCC_SRC_8_1 \
-	SCC_SRC(0x0a, 0x02, 0x01, 0x01, 0x02, 0x02, 0x00, 0x03, 0x04, 0x1a, \
-			0x00)
+	SCC_SRC_LC3(0x0a, 0x02, 0x01, 0x01, 0x02, 0x02, 0x00, 0x03, 0x04, \
+			    0x1a, 0x00)
 
 static struct test_config cfg_src_8_2 = {
 	.cc = LC3_CONFIG_8_2,
@@ -856,8 +914,8 @@ static struct test_config cfg_src_8_2 = {
 };
 
 #define SCC_SRC_8_2 \
-	SCC_SRC(0x0a, 0x02, 0x01, 0x01, 0x02, 0x02, 0x01, 0x03, 0x04, 0x1e, \
-			0x00)
+	SCC_SRC_LC3(0x0a, 0x02, 0x01, 0x01, 0x02, 0x02, 0x01, 0x03, 0x04, \
+			0x1e, 0x00)
 
 static struct test_config cfg_src_16_1 = {
 	.cc = LC3_CONFIG_16_1,
@@ -866,8 +924,8 @@ static struct test_config cfg_src_16_1 = {
 };
 
 #define SCC_SRC_16_1 \
-	SCC_SRC(0x0a, 0x02, 0x01, 0x03, 0x02, 0x02, 0x00, 0x03, 0x04, 0x1e, \
-			0x00)
+	SCC_SRC_LC3(0x0a, 0x02, 0x01, 0x03, 0x02, 0x02, 0x00, 0x03, 0x04, \
+			0x1e, 0x00)
 
 static struct test_config cfg_src_16_2 = {
 	.cc = LC3_CONFIG_16_2,
@@ -876,8 +934,8 @@ static struct test_config cfg_src_16_2 = {
 };
 
 #define SCC_SRC_16_2 \
-	SCC_SRC(0x0a, 0x02, 0x01, 0x03, 0x02, 0x02, 0x01, 0x03, 0x04, 0x28, \
-			0x00)
+	SCC_SRC_LC3(0x0a, 0x02, 0x01, 0x03, 0x02, 0x02, 0x01, 0x03, 0x04, \
+			0x28, 0x00)
 
 static struct test_config cfg_src_24_1 = {
 	.cc = LC3_CONFIG_24_1,
@@ -886,8 +944,8 @@ static struct test_config cfg_src_24_1 = {
 };
 
 #define SCC_SRC_24_1 \
-	SCC_SRC(0x0a, 0x02, 0x01, 0x05, 0x02, 0x02, 0x00, 0x03, 0x04, 0x2d, \
-			0x00)
+	SCC_SRC_LC3(0x0a, 0x02, 0x01, 0x05, 0x02, 0x02, 0x00, 0x03, 0x04, \
+			0x2d, 0x00)
 
 static struct test_config cfg_src_24_2 = {
 	.cc = LC3_CONFIG_24_2,
@@ -896,8 +954,8 @@ static struct test_config cfg_src_24_2 = {
 };
 
 #define SCC_SRC_24_2 \
-	SCC_SRC(0x0a, 0x02, 0x01, 0x05, 0x02, 0x02, 0x01, 0x03, 0x04, 0x3c, \
-			0x00)
+	SCC_SRC_LC3(0x0a, 0x02, 0x01, 0x05, 0x02, 0x02, 0x01, 0x03, 0x04, \
+			0x3c, 0x00)
 
 static struct test_config cfg_src_32_1 = {
 	.cc = LC3_CONFIG_32_1,
@@ -906,8 +964,8 @@ static struct test_config cfg_src_32_1 = {
 };
 
 #define SCC_SRC_32_1 \
-	SCC_SRC(0x0a, 0x02, 0x01, 0x06, 0x02, 0x02, 0x00, 0x03, 0x04, 0x3c, \
-			0x00)
+	SCC_SRC_LC3(0x0a, 0x02, 0x01, 0x06, 0x02, 0x02, 0x00, 0x03, 0x04, \
+			0x3c, 0x00)
 
 static struct test_config cfg_src_32_2 = {
 	.cc = LC3_CONFIG_32_2,
@@ -916,8 +974,8 @@ static struct test_config cfg_src_32_2 = {
 };
 
 #define SCC_SRC_32_2 \
-	SCC_SRC(0x0a, 0x02, 0x01, 0x06, 0x02, 0x02, 0x01, 0x03, 0x04, 0x50, \
-			0x00)
+	SCC_SRC_LC3(0x0a, 0x02, 0x01, 0x06, 0x02, 0x02, 0x01, 0x03, 0x04, \
+			0x50, 0x00)
 
 static struct test_config cfg_src_44_1 = {
 	.cc = LC3_CONFIG_44_1,
@@ -926,8 +984,8 @@ static struct test_config cfg_src_44_1 = {
 };
 
 #define SCC_SRC_44_1 \
-	SCC_SRC(0x0a, 0x02, 0x01, 0x07, 0x02, 0x02, 0x00, 0x03, 0x04, 0x62, \
-			0x00)
+	SCC_SRC_LC3(0x0a, 0x02, 0x01, 0x07, 0x02, 0x02, 0x00, 0x03, 0x04, \
+			0x62, 0x00)
 
 static struct test_config cfg_src_44_2 = {
 	.cc = LC3_CONFIG_44_2,
@@ -936,8 +994,8 @@ static struct test_config cfg_src_44_2 = {
 };
 
 #define SCC_SRC_44_2 \
-	SCC_SRC(0x0a, 0x02, 0x01, 0x07, 0x02, 0x02, 0x01, 0x03, 0x04, 0x82, \
-			0x00)
+	SCC_SRC_LC3(0x0a, 0x02, 0x01, 0x07, 0x02, 0x02, 0x01, 0x03, 0x04, \
+			0x82, 0x00)
 
 static struct test_config cfg_src_48_1 = {
 	.cc = LC3_CONFIG_48_1,
@@ -946,8 +1004,8 @@ static struct test_config cfg_src_48_1 = {
 };
 
 #define SCC_SRC_48_1 \
-	SCC_SRC(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x00, 0x03, 0x04, 0x4b, \
-			0x00)
+	SCC_SRC_LC3(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x00, 0x03, 0x04, \
+			0x4b, 0x00)
 
 static struct test_config cfg_src_48_2 = {
 	.cc = LC3_CONFIG_48_2,
@@ -956,8 +1014,8 @@ static struct test_config cfg_src_48_2 = {
 };
 
 #define SCC_SRC_48_2 \
-	SCC_SRC(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x01, 0x03, 0x04, 0x64, \
-			0x00)
+	SCC_SRC_LC3(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x01, 0x03, 0x04, \
+			0x64, 0x00)
 
 static struct test_config cfg_src_48_3 = {
 	.cc = LC3_CONFIG_48_3,
@@ -966,8 +1024,8 @@ static struct test_config cfg_src_48_3 = {
 };
 
 #define SCC_SRC_48_3 \
-	SCC_SRC(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x00, 0x03, 0x04, 0x5a, \
-			0x00)
+	SCC_SRC_LC3(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x00, 0x03, 0x04, \
+			0x5a, 0x00)
 
 static struct test_config cfg_src_48_4 = {
 	.cc = LC3_CONFIG_48_4,
@@ -976,8 +1034,8 @@ static struct test_config cfg_src_48_4 = {
 };
 
 #define SCC_SRC_48_4 \
-	SCC_SRC(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x01, 0x03, 0x04, 0x78, \
-			0x00)
+	SCC_SRC_LC3(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x01, 0x03, 0x04, \
+			0x78, 0x00)
 
 static struct test_config cfg_src_48_5 = {
 	.cc = LC3_CONFIG_48_5,
@@ -986,8 +1044,8 @@ static struct test_config cfg_src_48_5 = {
 };
 
 #define SCC_SRC_48_5 \
-	SCC_SRC(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x00, 0x03, 0x04, 0x75, \
-			0x00)
+	SCC_SRC_LC3(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x00, 0x03, 0x04, \
+			0x75, 0x00)
 
 static struct test_config cfg_src_48_6 = {
 	.cc = LC3_CONFIG_48_6,
@@ -996,8 +1054,33 @@ static struct test_config cfg_src_48_6 = {
 };
 
 #define SCC_SRC_48_6 \
-	SCC_SRC(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x01, 0x03, 0x04, 0x9b, \
-			0x00)
+	SCC_SRC_LC3(0x0a, 0x02, 0x01, 0x08, 0x02, 0x02, 0x01, 0x03, 0x04, \
+			0x9b, 0x00)
+
+static struct test_config cfg_snk_vs = {
+	.cc = IOV_NULL,
+	.qos = QOS_BALANCED_2M,
+	.snk = true,
+	.vs = true,
+};
+
+#define DISC_SRC_ASE_VS \
+	DISC_SRC_ASE(0xff, 0x01, 0x00, 0x01, 0x00, 0x00, 0x00)
+
+#define SCC_SNK_VS \
+	DISC_SRC_ASE_VS,  \
+	SCC_SNK(0xff, 0x01, 0x00, 0x01, 0x00, 0x00)
+
+static struct test_config cfg_src_vs = {
+	.cc = IOV_NULL,
+	.qos = QOS_BALANCED_2M,
+	.src = true,
+	.vs = true,
+};
+
+#define SCC_SRC_VS \
+	DISC_SRC_ASE_VS,  \
+	SCC_SRC(0xff, 0x01, 0x00, 0x01, 0x00, 0x00)
 
 static void test_scc(void)
 {
@@ -1079,6 +1162,21 @@ static void test_scc(void)
 							SCC_SRC_48_5);
 	define_test("BAP/UCL/SCC/BV-032-C", test_client, &cfg_src_48_6,
 							SCC_SRC_48_6);
+	/* Test Purpose:
+	 * Verify that a Unicast Client IUT can initiate a Config Codec
+	 * operation for a vendor-specific codec.
+	 *
+	 * Pass verdict:
+	 * The IUT successfully writes to the ASE Control Point characteristic
+	 * with the opcode set to 0x01 (Config Codec) and the specified
+	 * parameters. The Codec_ID parameter is formatted with octet 0 set to
+	 * 0xFF, octets 1–2 set to TSPX_VS_Company_ID, and octets 3–4 set to
+	 * TSPX_VS_Codec_ID.
+	 */
+	define_test("BAP/UCL/SCC/BV-033-C", test_client, &cfg_snk_vs,
+							SCC_SNK_VS);
+	define_test("BAP/UCL/SCC/BV-034-C", test_client, &cfg_src_vs,
+							SCC_SRC_VS);
 }
 
 int main(int argc, char *argv[])
-- 
2.40.0

