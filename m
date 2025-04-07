Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAAF21C16B
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Apr 2025 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056097; cv=none; b=mGOEGg8AvTMk4CZO/pCjg+rPowYPlsSXpIYhSNfS/uYsQDAtVPC0fPbdV2FAVhJ6u2IESR/A2bj/aaxDLBKiph+OfngbpYdv7traWqtsSldbpafE+I/a+SXjd8emup9J2Wo2LssdStdiGFcm7Da2O0jZyTKHWvA+YLCizJGyGHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056097; c=relaxed/simple;
	bh=lV9Er+Su+VuJRn8I3P/Z5RcbhKDljCbZ7qikSHJHQD8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UApe7QEBYFrY+AZXijVjLCIbAzuY6ZFYXKLjprcoqVp52JUxwlPPeDuxgglJ3KID57z0l1hhuERCwin2P7ZjAeCqpvAxYG5NoHN45UdlctZwb5nhBKhDmQ6K9wUgVRg/8gdbTZemjwjgxcsqFv0OnPYXE4JyZY+9g4uLyn5BZDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZKoR+14; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZKoR+14"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-523dc190f95so2339065e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Apr 2025 13:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744056093; x=1744660893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oH5zIz3fH+HzePqUrVUnHeTuTck/L6WwKXLj9XMwPLs=;
        b=dZKoR+143krivt61Y1TITdhFA4SLA5ykJnvcwS1ymaZbva9F575Vxn0K/96JjNAmt4
         +8FvlekwlyUxOgg77p7AxWbFBCy95DnfMjDH8MF7lmLxTB2tNkBunVusuA8bi6x9gBX3
         CXQoLgvaWuk98nkK1jdbnb2o50GqcutH3ppghdXpjKwg1vCb170C+6OqkUCZug1SUYDp
         1YSjZHVzlv09qF00H2Zgj7aCDTRvAi9ffPQ/gMrK4Bq6Gpo8+8oiFlr+FIaSDWMbRn1W
         gxxcR3IN10/GZSuB6o5cXh99ytU/+RQABiRAzVC6QT5cEncZ3+gpFrl2dwpYdnMnnn88
         05Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056093; x=1744660893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oH5zIz3fH+HzePqUrVUnHeTuTck/L6WwKXLj9XMwPLs=;
        b=cQ/Cj7RncoSqYIKamfO3ZknLSIt1j4NKZiZsR/SS8AyPY1rcYx/XyLKreuOJBWEzr8
         iP776WPEOz2XnAl5p/Qqyh2g8pIxeHjGmSFBJPm/tEho9GRmdopz6TbgosnD8tsC6QXY
         PhB2kcp2NOLhfvTHbVpjgCbmiavHmtWpsQdp6FvtY3uVbIoNYiHTATKOd+PQ7+DkYYS9
         3B5efiwC/AcLn53Qpch1dQDrj9bEIiuF/jKXnvznnW8YT38juof65DrwG9pdxvH+f7I7
         Uvcn0fxnm+bLjf58DIwl7hb8A8GmWagbvnXtTcWDOpzhMdirMVcVfdMSXngkOJbEYywT
         PZ/Q==
X-Gm-Message-State: AOJu0YyTRjLCX94fFrqPWvLbTLLUlJoA5gRdrUgg3RwcLxs+9KCJ/YWw
	3i1ztUGtU4/Yt2CwcITjaRAZLvHNqoQiI7ozO/Yo+5cxdvjMCKSsJOlweyY4
X-Gm-Gg: ASbGncuAXN8vqAEWzBwLGNP7TcBeIPdDJedXx/Ff9WHiBi8XgUs8E+vt9taNoqQKx8g
	8d0yu/Rm+9IASYcpl4rwEBfnJYPSey76cNhI6Udcckzs4wEP/mIM0W20rzYlw9WwPvLRweV4yM8
	ANzWa7k3aYnox7E7e10eoayb5jrg8NMLZwGFEAGn2wNj3+whQvsPzet5iz6qXuFlajfrGuA3bIg
	5f2SUMVu+YhY6pYDbf8mdo4oqsdi8dz+Hs1ChlLfGcAIiHZPxkpj2HCC8ialwM1ATDyUVxQqo54
	mFsaQ7xJQmnmTyPTfNYHXcFnlxzr40AqVI0euTJItB6EHwcpQ3xxoJl/lSjI3faHdQBDwhUPdu1
	E2Nt5cumRlBV4lg==
X-Google-Smtp-Source: AGHT+IFHfHC3de5HKBPKDXuPvwHUw3rJHNk72kbnIiGpdZuu3UN4J8ejejQAd5hSmeKRVs/LmHRAKw==
X-Received: by 2002:a05:6122:16a6:b0:520:4539:4b4c with SMTP id 71dfb90a1353d-527730d8095mr7413302e0c.9.1744056092696;
        Mon, 07 Apr 2025 13:01:32 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5279b691f07sm69140e0c.41.2025.04.07.13.01.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 13:01:31 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 02/15] test-bap: Introduce USR/SCC tests for LC3
Date: Mon,  7 Apr 2025 16:01:08 -0400
Message-ID: <20250407200124.881534-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407200124.881534-1-luiz.dentz@gmail.com>
References: <20250407200124.881534-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

4.9.1 Unicast Server as Audio Sink Performs Config Codec – LC3

Test Purpose:
Verify that a Unicast Server Audio Sink IUT can perform a Config
Codec operation initiated by a Unicast Client for an ASE in the Idle
state, the Codec Configured state.

Pass Veridict:
The IUT sends a Response_Code of 0x00 (Success) in response to each
Config Codec operation.

4.9.2 Unicast Server as Audio Source Performs Config Codec – LC3

Test Purpose:
Verify that a Unicast Server Audio Source IUT can perform a Config
Codec operation initiated by a Unicast Client for an ASE in the Idle
state, the Codec Configured state.

Pass verdict:
The IUT sends a Response_Code of 0x00 (Success) in response to each
Config Codec operation.

Test Summary
------------
BAP/USR/SCC/BV-001-C [USR SNK Config Codec, LC3 8_1] Passed
BAP/USR/SCC/BV-002-C [USR SNK Config Codec, LC3 8_2] Passed
BAP/USR/SCC/BV-003-C [USR SNK Config Codec, LC3 16_1] Passed
BAP/USR/SCC/BV-004-C [USR SNK Config Codec, LC3 16_2] Passed
BAP/USR/SCC/BV-005-C [USR SNK Config Codec, LC3 24_1] Passed
BAP/USR/SCC/BV-006-C [USR SNK Config Codec, LC3 24_2] Passed
BAP/USR/SCC/BV-007-C [USR SNK Config Codec, LC3 32_1] Passed
BAP/USR/SCC/BV-008-C [USR SNK Config Codec, LC3 32_2] Passed
BAP/USR/SCC/BV-009-C [USR SNK Config Codec, LC3 44.1_1] Passed
BAP/USR/SCC/BV-010-C [USR SNK Config Codec, LC3 44.1_2] Passed
BAP/USR/SCC/BV-011-C [USR SNK Config Codec, LC3 48_1] Passed
BAP/USR/SCC/BV-012-C [USR SNK Config Codec, LC3 48_2] Passed
BAP/USR/SCC/BV-013-C [USR SNK Config Codec, LC3 48_3] Passed
BAP/USR/SCC/BV-014-C [USR SNK Config Codec, LC3 48_4] Passed
BAP/USR/SCC/BV-015-C [USR SNK Config Codec, LC3 48_5] Passed
BAP/USR/SCC/BV-016-C [USR SNK Config Codec, LC3 48_6] Passed
BAP/USR/SCC/BV-017-C [USR SRC Config Codec, LC3 8_1] Passed
BAP/USR/SCC/BV-018-C [USR SRC Config Codec, LC3 8_2] Passed
BAP/USR/SCC/BV-019-C [USR SRC Config Codec, LC3 16_1] Passed
BAP/USR/SCC/BV-020-C [USR SRC Config Codec, LC3 16_2] Passed
BAP/USR/SCC/BV-021-C [USR SRC Config Codec, LC3 24_1] Passed
BAP/USR/SCC/BV-022-C [USR SRC Config Codec, LC3 24_2] Passed
BAP/USR/SCC/BV-023-C [USR SRC Config Codec, LC3 32_1] Passed
BAP/USR/SCC/BV-024-C [USR SRC Config Codec, LC3 32_2] Passed
BAP/USR/SCC/BV-025-C [USR SRC Config Codec, LC3 44.1_1] Passed
BAP/USR/SCC/BV-026-C [USR SRC Config Codec, LC3 44.1_2] Passed
BAP/USR/SCC/BV-027-C [USR SRC Config Codec, LC3 48_1] Passed
BAP/USR/SCC/BV-028-C [USR SRC Config Codec, LC3 48_2] Passed
BAP/USR/SCC/BV-029-C [USR SRC Config Codec, LC3 48_3] Passed
BAP/USR/SCC/BV-030-C [USR SRC Config Codec, LC3 48_4] Passed
BAP/USR/SCC/BV-031-C [USR SRC Config Codec, LC3 48_5] Passed
BAP/USR/SCC/BV-032-C [USR SRC Config Codec, LC3 48_6] Passed
Total: 32, Passed: 32 (100.0%), Failed: 0, Not Run: 0
---
 unit/test-bap.c | 234 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 202 insertions(+), 32 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index cabb9b296ee2..dc199f4871e1 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -90,9 +90,11 @@ static struct iovec lc3_caps = LC3_CAPABILITIES(LC3_FREQ_ANY, LC3_DURATION_ANY,
 								3u, 26, 240);
 
 static struct bt_bap_pac_qos lc3_qos = {
+	.phy = 0x02,
+	.rtn = 0x01,
 	.location = 0x00000003,
 	.supported_context = 0x0fff,
-	.context = 0x0fff
+	.context = 0x0fff,
 };
 
 #define iov_data(args...) ((const struct iovec[]) { args })
@@ -402,12 +404,18 @@ static void gatt_notify_cb(struct gatt_db_attribute *attrib,
 	struct test_data *data = user_data;
 	uint16_t handle = gatt_db_attribute_get_handle(attrib);
 
-	if (!data->server)
+	if (tester_use_debug())
+		tester_debug("handle 0x%04x len %zd", handle, len);
+
+	if (!data->server) {
+		if (tester_use_debug())
+			tester_debug("data->server %p", data->server);
 		return;
+	}
 
 	if (!bt_gatt_server_send_notification(data->server,
 			handle, value, len, false))
-		printf("%s: Failed to send notification\n", __func__);
+		tester_debug("%s: Failed to send notification", __func__);
 }
 
 static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
@@ -475,6 +483,19 @@ static void setup_complete_cb(const void *user_data)
 	tester_setup_complete();
 }
 
+static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
+			struct bt_bap_qos *qos, bt_bap_pac_config_t cb,
+			void *user_data)
+{
+	cb(stream, 0);
+
+	return 0;
+}
+
+static struct bt_bap_pac_ops ucast_pac_ops = {
+	.config = pac_config,
+};
+
 static void test_setup_server(const void *user_data)
 {
 	struct test_data *data = (void *)user_data;
@@ -494,23 +515,19 @@ static void test_setup_server(const void *user_data)
 
 	data->ccc_states = queue_new();
 
-	/* If there is no configuration, add a sink PAC since otherwise bt_bap
-	 * won't even register the required services.
-	 */
-	if (!data->cfg) {
-		data->snk = bt_bap_add_pac(db, "test-bap-snk",
-							BT_BAP_SINK, LC3_ID,
+	data->snk = bt_bap_add_pac(db, "test-bap-snk", BT_BAP_SINK, LC3_ID,
 							data->qos, data->caps,
 							NULL);
-		data->src = bt_bap_add_pac(db, "test-bap-src",
-							BT_BAP_SOURCE, LC3_ID,
+	g_assert(data->snk);
+
+	bt_bap_pac_set_ops(data->snk, &ucast_pac_ops, NULL);
+
+	data->src = bt_bap_add_pac(db, "test-bap-src", BT_BAP_SOURCE, LC3_ID,
 							data->qos, data->caps,
 							NULL);
-		g_assert(data->snk);
-		g_assert(data->src);
-	} else {
-		test_setup_pacs(data);
-	}
+	g_assert(data->src);
+
+	bt_bap_pac_set_ops(data->src, &ucast_pac_ops, NULL);
 
 	att = bt_att_new(io_get_fd(io), false);
 	g_assert(att);
@@ -675,15 +692,6 @@ static void test_client(const void *user_data)
 	bt_bap_attach(data->bap, data->client);
 }
 
-static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
-			struct bt_bap_qos *qos, bt_bap_pac_config_t cb,
-			void *user_data)
-{
-	cb(stream, 0);
-
-	return 0;
-}
-
 static struct bt_bap_pac_ops bcast_pac_ops = {
 	.config = pac_config,
 };
@@ -1154,8 +1162,6 @@ static void test_server(const void *user_data)
 
 	tester_io_set_complete_func(test_complete_cb);
 
-	test_setup_pacs(data);
-
 	data->id = bt_bap_register(bap_attached, NULL, data);
 	g_assert(data->id);
 
@@ -1221,13 +1227,13 @@ static void test_disc(void)
  *     Data: 0101010000
  * ATT: Handle Value Notification (0x1b) len 37
  *   Handle: 0x0016
- *     Data: 01010102010a00204e00409c00204e00409c00_cfg
+ *     Data: 01010002010a00204e00409c00204e00409c00_cfg
  */
 #define SCC_SNK(_cfg...) \
 	IOV_DATA(0x52, 0x22, 0x00, 0x01, 0x01, 0x01, 0x02, 0x02, _cfg), \
 	IOV_DATA(0x1b, 0x22, 0x00, 0x01, 0x01, 0x01, 0x00, 0x00), \
 	IOV_NULL, \
-	IOV_DATA(0x1b, 0x16, 0x00, 0x01, 0x01, 0x01, 0x02, 0x01, 0x0a, 0x00, \
+	IOV_DATA(0x1b, 0x16, 0x00, 0x01, 0x01, 0x00, 0x02, 0x01, 0x0a, 0x00, \
 			0x20, 0x4e, 0x00, 0x40, 0x9c, 0x00, 0x20, 0x4e, 0x00, \
 			0x40, 0x9c, 0x00, _cfg)
 
@@ -1412,13 +1418,13 @@ static struct test_config cfg_snk_48_6 = {
  *     Data: 0101030000
  * ATT: Handle Value Notification (0x1b) len 37
  *   Handle: 0x001c
- *     Data: 03010102010a00204e00409c00204e00409c00_cfg
+ *     Data: 03010002010a00204e00409c00204e00409c00_cfg
  */
 #define SCC_SRC(_cfg...) \
 	IOV_DATA(0x52, 0x22, 0x00, 0x01, 0x01, 0x03, 0x02, 0x02, _cfg), \
 	IOV_DATA(0x1b, 0x22, 0x00, 0x01, 0x01, 0x03, 0x00, 0x00), \
 	IOV_NULL, \
-	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x01, 0x01, 0x02, 0x01, 0x0a, 0x00, \
+	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x01, 0x00, 0x02, 0x01, 0x0a, 0x00, \
 			0x20, 0x4e, 0x00, 0x40, 0x9c, 0x00, 0x20, 0x4e, 0x00, \
 			0x40, 0x9c, 0x00, _cfg)
 
@@ -1600,7 +1606,7 @@ static struct test_config cfg_src_48_6 = {
  * formatted in an LTV structure with the length, type, and value
  * specified in Table 4.10.
  */
-static void test_scc_cc_lc3(void)
+static void test_ucl_scc_cc_lc3(void)
 {
 	define_test("BAP/UCL/SCC/BV-001-C [UCL SRC Config Codec, LC3 8_1]",
 			test_setup, test_client, &cfg_snk_8_1, SCC_SNK_8_1);
@@ -1668,6 +1674,170 @@ static void test_scc_cc_lc3(void)
 			test_setup, test_client, &cfg_src_48_6, SCC_SRC_48_6);
 }
 
+
+/* 4.9 Unicast Server Configuration */
+static void test_usr_scc_cc_lc3(void)
+{
+	/* 4.9.1 Unicast Server as Audio Sink Performs Config Codec – LC3
+	 *
+	 * Test Purpose:
+	 * Verify that a Unicast Server Audio Sink IUT can perform a Config
+	 * Codec operation initiated by a Unicast Client for an ASE in the Idle
+	 * state, the Codec Configured state.
+	 *
+	 * Pass Veridict:
+	 * The IUT sends a Response_Code of 0x00 (Success) in response to each
+	 * Config Codec operation.
+	 *
+	 * BAP/USR/SCC/BV-001-C [USR SNK Config Codec, LC3 8_1]
+	 * BAP/USR/SCC/BV-002-C [USR SNK Config Codec, LC3 8_2]
+	 * BAP/USR/SCC/BV-003-C [USR SNK Config Codec, LC3 16_1]
+	 * BAP/USR/SCC/BV-004-C [USR SNK Config Codec, LC3 16_2]
+	 * BAP/USR/SCC/BV-005-C [USR SNK Config Codec, LC3 24_1]
+	 * BAP/USR/SCC/BV-006-C [USR SNK Config Codec, LC3 24_2]
+	 * BAP/USR/SCC/BV-007-C [USR SNK Config Codec, LC3 32_1]
+	 * BAP/USR/SCC/BV-008-C [USR SNK Config Codec, LC3 32_2]
+	 * BAP/USR/SCC/BV-009-C [USR SNK Config Codec, LC3 44.1_1]
+	 * BAP/USR/SCC/BV-010-C [USR SNK Config Codec, LC3 44.1_2]
+	 * BAP/USR/SCC/BV-011-C [USR SNK Config Codec, LC3 48_1]
+	 * BAP/USR/SCC/BV-012-C [USR SNK Config Codec, LC3 48_2]
+	 * BAP/USR/SCC/BV-013-C [USR SNK Config Codec, LC3 48_3]
+	 * BAP/USR/SCC/BV-014-C [USR SNK Config Codec, LC3 48_4]
+	 * BAP/USR/SCC/BV-015-C [USR SNK Config Codec, LC3 48_5]
+	 * BAP/USR/SCC/BV-016-C [USR SNK Config Codec, LC3 48_6]
+	 */
+	define_test("BAP/USR/SCC/BV-001-C [USR SNK Config Codec, LC3 8_1]",
+			test_setup_server, test_server, &cfg_snk_8_1,
+			SCC_SNK_8_1);
+	define_test("BAP/USR/SCC/BV-002-C [USR SNK Config Codec, LC3 8_2]",
+			test_setup_server, test_server, &cfg_snk_8_2,
+			SCC_SNK_8_2);
+	define_test("BAP/USR/SCC/BV-003-C [USR SNK Config Codec, LC3 16_1]",
+			test_setup_server, test_server, &cfg_snk_16_1,
+			SCC_SNK_16_1);
+	define_test("BAP/USR/SCC/BV-004-C [USR SNK Config Codec, LC3 16_2]",
+			test_setup_server, test_server, &cfg_snk_16_2,
+			SCC_SNK_16_2);
+	define_test("BAP/USR/SCC/BV-005-C [USR SNK Config Codec, LC3 24_1]",
+			test_setup_server, test_server, &cfg_snk_24_1,
+			SCC_SNK_24_1);
+	define_test("BAP/USR/SCC/BV-006-C [USR SNK Config Codec, LC3 24_2]",
+			test_setup_server, test_server, &cfg_snk_24_2,
+			SCC_SNK_24_2);
+	define_test("BAP/USR/SCC/BV-007-C [USR SNK Config Codec, LC3 32_1]",
+			test_setup_server, test_server, &cfg_snk_32_1,
+			SCC_SNK_32_1);
+	define_test("BAP/USR/SCC/BV-008-C [USR SNK Config Codec, LC3 32_2]",
+			test_setup_server, test_server, &cfg_snk_32_2,
+			SCC_SNK_32_2);
+	define_test("BAP/USR/SCC/BV-009-C [USR SNK Config Codec, LC3 44.1_1]",
+			test_setup_server, test_server, &cfg_snk_44_1,
+			SCC_SNK_44_1);
+	define_test("BAP/USR/SCC/BV-010-C [USR SNK Config Codec, LC3 44.1_2]",
+			test_setup_server, test_server, &cfg_snk_44_2,
+			SCC_SNK_44_2);
+	define_test("BAP/USR/SCC/BV-011-C [USR SNK Config Codec, LC3 48_1]",
+			test_setup_server, test_server, &cfg_snk_48_1,
+			SCC_SNK_48_1);
+	define_test("BAP/USR/SCC/BV-012-C [USR SNK Config Codec, LC3 48_2]",
+			test_setup_server, test_server, &cfg_snk_48_2,
+			SCC_SNK_48_2);
+	define_test("BAP/USR/SCC/BV-013-C [USR SNK Config Codec, LC3 48_3]",
+			test_setup_server, test_server, &cfg_snk_48_3,
+			SCC_SNK_48_3);
+	define_test("BAP/USR/SCC/BV-014-C [USR SNK Config Codec, LC3 48_4]",
+			test_setup_server, test_server, &cfg_snk_48_4,
+			SCC_SNK_48_4);
+	define_test("BAP/USR/SCC/BV-015-C [USR SNK Config Codec, LC3 48_5]",
+			test_setup_server, test_server, &cfg_snk_48_5,
+			SCC_SNK_48_5);
+	define_test("BAP/USR/SCC/BV-016-C [USR SNK Config Codec, LC3 48_6]",
+			test_setup_server, test_server, &cfg_snk_48_6,
+			SCC_SNK_48_6);
+	/* 4.9.2 Unicast Server as Audio Source Performs Config Codec – LC3
+	 *
+	 * Test Purpose
+	 * Verify that a Unicast Server Audio Source IUT can perform a Config
+	 * Codec operation initiated by a Unicast Client for an ASE in the Idle
+	 * state, the Codec Configured state.
+	 *
+	 * Pass verdict
+	 * The IUT sends a Response_Code of 0x00 (Success) in response to each
+	 * Config Codec operation.
+	 *
+	 * BAP/USR/SCC/BV-017-C [USR SRC Config Codec, LC3 8_1]
+	 * BAP/USR/SCC/BV-018-C [USR SRC Config Codec, LC3 8_2]
+	 * BAP/USR/SCC/BV-019-C [USR SRC Config Codec, LC3 16_1]
+	 * BAP/USR/SCC/BV-020-C [USR SRC Config Codec, LC3 16_2]
+	 * BAP/USR/SCC/BV-021-C [USR SRC Config Codec, LC3 24_1]
+	 * BAP/USR/SCC/BV-022-C [USR SRC Config Codec, LC3 24_2]
+	 * BAP/USR/SCC/BV-023-C [USR SRC Config Codec, LC3 32_1]
+	 * BAP/USR/SCC/BV-024-C [USR SRC Config Codec, LC3 32_2]
+	 * BAP/USR/SCC/BV-025-C [USR SRC Config Codec, LC3 44.1_1]
+	 * BAP/USR/SCC/BV-026-C [USR SRC Config Codec, LC3 44.1_2]
+	 * BAP/USR/SCC/BV-027-C [USR SRC Config Codec, LC3 48_1]
+	 * BAP/USR/SCC/BV-028-C [USR SRC Config Codec, LC3 48_2]
+	 * BAP/USR/SCC/BV-029-C [USR SRC Config Codec, LC3 48_3]
+	 * BAP/USR/SCC/BV-030-C [USR SRC Config Codec, LC3 48_4]
+	 * BAP/USR/SCC/BV-031-C [USR SRC Config Codec, LC3 48_5]
+	 * BAP/USR/SCC/BV-032-C [USR SRC Config Codec, LC3 48_6]
+	 */
+	define_test("BAP/USR/SCC/BV-017-C [USR SRC Config Codec, LC3 8_1]",
+			test_setup_server, test_server, &cfg_src_8_1,
+			SCC_SRC_8_1);
+	define_test("BAP/USR/SCC/BV-018-C [USR SRC Config Codec, LC3 8_2]",
+			test_setup_server, test_server, &cfg_src_8_2,
+			SCC_SRC_8_2);
+	define_test("BAP/USR/SCC/BV-019-C [USR SRC Config Codec, LC3 16_1]",
+			test_setup_server, test_server, &cfg_src_16_1,
+			SCC_SRC_16_1);
+	define_test("BAP/USR/SCC/BV-020-C [USR SRC Config Codec, LC3 16_2]",
+			test_setup_server, test_server, &cfg_src_16_2,
+			SCC_SRC_16_2);
+	define_test("BAP/USR/SCC/BV-021-C [USR SRC Config Codec, LC3 24_1]",
+			test_setup_server, test_server, &cfg_src_24_1,
+			SCC_SRC_24_1);
+	define_test("BAP/USR/SCC/BV-022-C [USR SRC Config Codec, LC3 24_2]",
+			test_setup_server, test_server, &cfg_src_24_2,
+			SCC_SRC_24_2);
+	define_test("BAP/USR/SCC/BV-023-C [USR SRC Config Codec, LC3 32_1]",
+			test_setup_server, test_server, &cfg_src_32_1,
+			SCC_SRC_32_1);
+	define_test("BAP/USR/SCC/BV-024-C [USR SRC Config Codec, LC3 32_2]",
+			test_setup_server, test_server, &cfg_src_32_2,
+			SCC_SRC_32_2);
+	define_test("BAP/USR/SCC/BV-025-C [USR SRC Config Codec, LC3 44.1_1]",
+			test_setup_server, test_server, &cfg_src_44_1,
+			SCC_SRC_44_1);
+	define_test("BAP/USR/SCC/BV-026-C [USR SRC Config Codec, LC3 44.1_2]",
+			test_setup_server, test_server, &cfg_src_44_2,
+			SCC_SRC_44_2);
+	define_test("BAP/USR/SCC/BV-027-C [USR SRC Config Codec, LC3 48_1]",
+			test_setup_server, test_server, &cfg_src_48_1,
+			SCC_SRC_48_1);
+	define_test("BAP/USR/SCC/BV-028-C [USR SRC Config Codec, LC3 48_2]",
+			test_setup_server, test_server, &cfg_src_48_2,
+			SCC_SRC_48_2);
+	define_test("BAP/USR/SCC/BV-029-C [USR SRC Config Codec, LC3 48_3]",
+			test_setup_server, test_server, &cfg_src_48_3,
+			SCC_SRC_48_3);
+	define_test("BAP/USR/SCC/BV-030-C [USR SRC Config Codec, LC3 48_4]",
+			test_setup_server, test_server, &cfg_src_48_4,
+			SCC_SRC_48_4);
+	define_test("BAP/USR/SCC/BV-031-C [USR SRC Config Codec, LC3 48_5]",
+			test_setup_server, test_server, &cfg_src_48_5,
+			SCC_SRC_48_5);
+	define_test("BAP/USR/SCC/BV-032-C [USR SRC Config Codec, LC3 48_6]",
+			test_setup_server, test_server, &cfg_src_48_6,
+			SCC_SRC_48_6);
+}
+
+static void test_scc_cc_lc3(void)
+{
+	test_ucl_scc_cc_lc3();
+	test_usr_scc_cc_lc3();
+}
+
 static struct test_config cfg_snk_vs = {
 	.cc = IOV_NULL,
 	.qos = QOS_UCAST,
-- 
2.49.0

