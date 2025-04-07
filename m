Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2191EE032
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Apr 2025 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056095; cv=none; b=JvhrbnwG8WmtDBQzHmzzaqcJZsLHSL8O7OujpNWjRPcu0P6anM8qo6yCBaMpgROZraeH5KwnV07lTPA2Vn0B2IFvN3JIK1pwpHx7OAbhDu30oepBIs5fK4PT5nqb9b7Z+RR0rbOj5Y+69TXdkMlQPHe5Jha88KDMxFjF9Xrti5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056095; c=relaxed/simple;
	bh=+ZvmQNa5yIl86i4EQl9vxmXMU/IuzIO5hvKbXs7M2Bc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/PSFOezaij9nBEHKPUsIgN9GzvqlECpbwy5ndRWDWbRxK0G+DH+Mkhi2Q+WvV+NuBrx8LKp6xefP/Y/x5yxzs/p/ddvITNwnWYMHuo+iKwYJZs0p7+QC9UbNo0nfwdjSY9+zF8sultPMZZJ3am8aDoRw+qU4JZGZ9dIfw7vZig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ali07jx6; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ali07jx6"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-51eb18130f9so2559368e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Apr 2025 13:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744056090; x=1744660890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xd6U/z0kBI9dOurDIgmF95BXv3OdYTfiJ7bE4h6+gGM=;
        b=ali07jx6D5xTv8+soICMp9vZOsGcYXj6XE6zO3syl3rIz/hl//eoyavQlaDQx37Gbw
         SEXXViTQcdDOpEFZzsqyiv/v2BYu0il85SHNTvKoC1HupFf3csNEo0HZaznOPsMC4l5v
         QtQ55FQJUz9wEEuUNSX+SNPgsiu3cqUxdLMyJqI0jRat7YFdGtvZ1O4VGdTDEpKWXUW7
         AW3lMNJF6dQwtsVLLx6GkCu9WKEsKJkz8pKc61yB/XuroZVn+NN/WrO3qxoFVqBSmQ/i
         3RhNefFZ6vmJj2YaT+QaQDNjOnZVy97k5LuqBEsDHtlrNmf9qCIMUPh6IiUqyrMqWD2F
         L6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056090; x=1744660890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xd6U/z0kBI9dOurDIgmF95BXv3OdYTfiJ7bE4h6+gGM=;
        b=oVoPX/9zTYoWtoAVcDu3YFUl27B34OxyKIIoxF1Ja2OyD69hy0gEOkzTX1fJ8X5Wmx
         n5QgxmbI2JCJ0E6vry+VqNeK2cRX4oqtj+45CpD6Vsdy7KHdeWd8If06ffZle4CY6YGr
         T777MfMG46zyvQLX3W1VO4HjcKEy0B5TL1TdmaQxtbjDq8YP5OBXQ9wF6Oze34cLiXiJ
         8vVrJ+L3Q2HelP7vuUWLXPixN4IAXJNPgFOcnWNPqAzytWI2mDFEVWWo6aF6GXXq2oDd
         XCbUIq8FC/TJdP/WXGtDdVjfYmf9Af24teOmHv2g0Vh7YajfcruuEA2nd3Vqpk3lozBG
         qUVw==
X-Gm-Message-State: AOJu0Yz+I3MT7uVo/BhfEXSCSbTk4FXRDHMU3NoMqyKlLE4hcZf2vZ4c
	KRFRkb/hhlIsFZReCQ/GurPJow5ptJRmlvHVtQfWReuDMfJQM00L/lMbsL1x
X-Gm-Gg: ASbGnctFcKC3oDXxeeqdP92byMzlWCK8VOPG9AuzxOtDr1cNBVzXmvFtWmiKCUn6Ej3
	ulkPoldnYE0QkLAeKs+IBTcUIZV20wUPUQRb2NQmRNN5bxeHu/VoiTv3ejxkdUwoXxyW9j5GVDK
	M+4hGLiNJALWOsJaCemuUWlWMQbbtGWfLDy6F5wUWA3k4GHu69crBxlPqXf/GXp8l+tbsZLTZ0q
	7WXK24a+8gnhu6y7fNsBi2sF8pYDiQizGlr0HgbNKGyP/WZj4qFB83LosGsjxUUix9uV3v2bnRl
	UFCfWW8gagWSAz99q19zRhlC03UkKSo1s7E3h2gUNE5r42jXVt88ip+n1GbzSesG4Fl82xw4Hsu
	U8FxQ7EQWnRkZHg==
X-Google-Smtp-Source: AGHT+IESlhGlIEzvlB25MqCPaihOrGZi8cU6biX11VwXsUqt7giPE42pSsxuqF8BpLBZ1e4Z5OvmyA==
X-Received: by 2002:a05:6122:a09:b0:520:42d3:91c1 with SMTP id 71dfb90a1353d-527645a5e5dmr10168368e0c.10.1744056090325;
        Mon, 07 Apr 2025 13:01:30 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5279b691f07sm69140e0c.41.2025.04.07.13.01.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 13:01:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 01/15] test-bap: Introduce DISC tests for LC3
Date: Mon,  7 Apr 2025 16:01:07 -0400
Message-ID: <20250407200124.881534-2-luiz.dentz@gmail.com>
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

4.7.2 Unicast Server – Audio Capability Exposure (Page 32):

Test Purpose
Verify that a Unicast Server IUT can allow audio capability discovery
with an Audio Sink reading the values of the Sink PAC characteristic
and the Sink Audio Locations characteristic on the IUT, or with an
Audio Source reading the values of the Source PAC characteristic and
the Source Audio Locations characteristic on the IUT.

Test Summary
------------
BAP/USR/DISC/BV-01-C                                 Passed
BAP/USR/DISC/BV-02-C                                 Passed
BAP/USR/DISC/BV-06-C                                 Passed
BAP/USR/DISC/BV-07-C                                 Passed
BAP/USR/DISC/BV-03-C                                 Passed
BAP/USR/DISC/BV-04-C                                 Passed
BAP/USR/DISC/BV-05-C                                 Passed
Total: 7, Passed: 7 (100.0%), Failed: 0, Not Run: 0
---
 src/shared/lc3.h |   2 +-
 unit/test-bap.c  | 347 ++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 299 insertions(+), 50 deletions(-)

diff --git a/src/shared/lc3.h b/src/shared/lc3.h
index e7a9277ec349..a6f65eedecc5 100644
--- a/src/shared/lc3.h
+++ b/src/shared/lc3.h
@@ -48,7 +48,7 @@
 #define LC3_FRAME_COUNT		(LC3_TYPE_BASE + 4)
 
 #define LC3_CAPABILITIES(_freq, _duration, _chan_count, _len_min, _len_max) \
-	UTIL_IOV_INIT(0x02, LC3_FREQ, _freq, _freq >> 8, \
+	UTIL_IOV_INIT(0x03, LC3_FREQ, _freq, _freq >> 8, \
 			0x02, LC3_DURATION, _duration, \
 			0x02, LC3_CHAN_COUNT, _chan_count, \
 			0x05, LC3_FRAME_LEN, _len_min, _len_min >> 8, \
diff --git a/unit/test-bap.c b/unit/test-bap.c
index 0c190d7fe15a..cabb9b296ee2 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -30,6 +30,7 @@
 #include "src/shared/att.h"
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-client.h"
+#include "src/shared/gatt-server.h"
 #include "src/shared/bap.h"
 #include "src/shared/lc3.h"
 
@@ -48,12 +49,16 @@ struct test_config {
 
 struct test_data {
 	struct bt_gatt_client *client;
+	struct bt_gatt_server *server;
 	struct gatt_db *db;
+	struct queue *ccc_states;
 	struct bt_bap *bap;
+	unsigned int id;
 	struct bt_bap_pac *snk;
 	struct bt_bap_pac *src;
 	struct bt_bap_pac *bsrc;
 	struct bt_bap_pac *bsnk;
+	struct bt_bap_pac_qos *qos;
 	struct iovec *base;
 	struct iovec *caps;
 	struct test_config *cfg;
@@ -62,6 +67,19 @@ struct test_data {
 	struct iovec *iov;
 };
 
+struct notify {
+	uint16_t handle, ccc_handle;
+	uint8_t *value;
+	uint16_t len;
+	bt_gatt_server_conf_func_t conf;
+	void *user_data;
+};
+
+struct ccc_state {
+	uint16_t handle;
+	uint16_t value;
+};
+
 /*
  * Frequencies: 8Khz 11Khz 16Khz 22Khz 24Khz 32Khz 44.1Khz 48Khz
  * Duration: 7.5 ms 10 ms
@@ -71,6 +89,12 @@ struct test_data {
 static struct iovec lc3_caps = LC3_CAPABILITIES(LC3_FREQ_ANY, LC3_DURATION_ANY,
 								3u, 26, 240);
 
+static struct bt_bap_pac_qos lc3_qos = {
+	.location = 0x00000003,
+	.supported_context = 0x0fff,
+	.context = 0x0fff
+};
+
 #define iov_data(args...) ((const struct iovec[]) { args })
 
 #define define_test(name, setup, function, _cfg, args...)		\
@@ -78,6 +102,7 @@ static struct iovec lc3_caps = LC3_CAPABILITIES(LC3_FREQ_ANY, LC3_DURATION_ANY,
 		const struct iovec iov[] = { args };		\
 		static struct test_data data;			\
 		data.caps = &lc3_caps;				\
+		data.qos = &lc3_qos;				\
 		data.cfg = _cfg;				\
 		data.iovcnt = ARRAY_SIZE(iov_data(args));	\
 		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov_data(args))); \
@@ -284,7 +309,7 @@ static const struct iovec setup_data[] = {
 	 *   Handle: 0x0022
 	 *   Error: Attribute Not Found (0x0a)
 	 */
-	IOV_DATA(0x01, 0x08, 0x23, 0x00, 0x0a),
+	IOV_DATA(0x01, 0x08, 0x22, 0x00, 0x0a),
 	/* ACL Data TX: Handle 42 flags 0x00 dlen 11
 	 *   ATT: Read By Type Request (0x08) len 6
 	 *   Handle range: 0x0001-0xffff
@@ -338,6 +363,172 @@ static void test_setup(const void *user_data)
 	gatt_db_unref(db);
 }
 
+static bool ccc_state_match(const void *a, const void *b)
+{
+	const struct ccc_state *ccc = a;
+	uint16_t handle = PTR_TO_UINT(b);
+
+	return ccc->handle == handle;
+}
+
+static struct ccc_state *find_ccc_state(struct test_data *data,
+				uint16_t handle)
+{
+	return queue_find(data->ccc_states, ccc_state_match,
+				UINT_TO_PTR(handle));
+}
+
+static struct ccc_state *get_ccc_state(struct test_data *data,
+					uint16_t handle)
+{
+	struct ccc_state *ccc;
+
+	ccc = find_ccc_state(data, handle);
+	if (ccc)
+		return ccc;
+
+	ccc = new0(struct ccc_state, 1);
+	ccc->handle = handle;
+	queue_push_tail(data->ccc_states, ccc);
+
+	return ccc;
+}
+
+static void gatt_notify_cb(struct gatt_db_attribute *attrib,
+					struct gatt_db_attribute *ccc,
+					const uint8_t *value, size_t len,
+					struct bt_att *att, void *user_data)
+{
+	struct test_data *data = user_data;
+	uint16_t handle = gatt_db_attribute_get_handle(attrib);
+
+	if (!data->server)
+		return;
+
+	if (!bt_gatt_server_send_notification(data->server,
+			handle, value, len, false))
+		printf("%s: Failed to send notification\n", __func__);
+}
+
+static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offest,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct test_data *data = user_data;
+	struct ccc_state *ccc;
+	uint16_t handle;
+	uint8_t ecode = 0;
+	uint16_t value = 0;
+
+	handle = gatt_db_attribute_get_handle(attrib);
+
+	ccc = get_ccc_state(data, handle);
+	if (!ccc) {
+		ecode = BT_ATT_ERROR_UNLIKELY;
+		goto done;
+	}
+
+	value = cpu_to_le16(ccc->value);
+
+done:
+	gatt_db_attribute_read_result(attrib, id, ecode, (void *)&value,
+							sizeof(value));
+}
+
+static void test_setup_pacs(struct test_data *data)
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
+static void setup_complete_cb(const void *user_data)
+{
+	tester_setup_complete();
+}
+
+static void test_setup_server(const void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+	struct bt_att *att;
+	struct gatt_db *db;
+	struct io *io;
+
+	io = tester_setup_io(setup_data, ARRAY_SIZE(setup_data));
+	g_assert(io);
+
+	tester_io_set_complete_func(setup_complete_cb);
+
+	db = gatt_db_new();
+	g_assert(db);
+
+	gatt_db_ccc_register(db, gatt_ccc_read_cb, NULL, gatt_notify_cb, data);
+
+	data->ccc_states = queue_new();
+
+	/* If there is no configuration, add a sink PAC since otherwise bt_bap
+	 * won't even register the required services.
+	 */
+	if (!data->cfg) {
+		data->snk = bt_bap_add_pac(db, "test-bap-snk",
+							BT_BAP_SINK, LC3_ID,
+							data->qos, data->caps,
+							NULL);
+		data->src = bt_bap_add_pac(db, "test-bap-src",
+							BT_BAP_SOURCE, LC3_ID,
+							data->qos, data->caps,
+							NULL);
+		g_assert(data->snk);
+		g_assert(data->src);
+	} else {
+		test_setup_pacs(data);
+	}
+
+	att = bt_att_new(io_get_fd(io), false);
+	g_assert(att);
+
+	bt_att_set_debug(att, BT_ATT_DEBUG, print_debug, "bt_att:", NULL);
+
+	data->server = bt_gatt_server_new(db, att, 64, 0);
+	g_assert(data->server);
+
+	bt_gatt_server_set_debug(data->server, print_debug, "bt_gatt_server:",
+						NULL);
+
+	tester_io_send();
+
+	bt_att_unref(att);
+	gatt_db_unref(db);
+}
+
 static void test_complete_cb(const void *user_data)
 {
 	tester_test_passed();
@@ -455,40 +646,6 @@ static void bap_ready(struct bt_bap *bap, void *user_data)
 	bt_bap_foreach_pac(bap, BT_BAP_SOURCE, pac_found, user_data);
 }
 
-static void test_client_config(struct test_data *data)
-{
-	if (!data->cfg)
-		return;
-
-	if (data->cfg->src) {
-		if (data->cfg->vs)
-			data->snk = bt_bap_add_vendor_pac(data->db,
-							"test-bap-snk",
-							BT_BAP_SINK, 0x0ff,
-							0x0001, 0x0001,
-							NULL, data->caps, NULL);
-		else
-			data->snk = bt_bap_add_pac(data->db, "test-bap-snk",
-							BT_BAP_SINK, LC3_ID,
-							NULL, data->caps, NULL);
-		g_assert(data->snk);
-	}
-
-	if (data->cfg->snk) {
-		if (data->cfg->vs)
-			data->src = bt_bap_add_vendor_pac(data->db,
-							"test-bap-src",
-							BT_BAP_SOURCE, 0x0ff,
-							0x0001, 0x0001,
-							NULL, data->caps, NULL);
-		else
-			data->src = bt_bap_add_pac(data->db, "test-bap-src",
-							BT_BAP_SOURCE, LC3_ID,
-							NULL, data->caps, NULL);
-		g_assert(data->src);
-	}
-}
-
 static void test_client(const void *user_data)
 {
 	struct test_data *data = (void *)user_data;
@@ -502,7 +659,7 @@ static void test_client(const void *user_data)
 	data->db = gatt_db_new();
 	g_assert(data->db);
 
-	test_client_config(data);
+	test_setup_pacs(data);
 
 	data->bap = bt_bap_new(data->db, bt_gatt_client_get_db(data->client));
 	g_assert(data->bap);
@@ -697,6 +854,7 @@ static void test_teardown(const void *user_data)
 {
 	struct test_data *data = (void *)user_data;
 
+	bt_bap_unregister(data->id);
 	bt_bap_unref(data->bap);
 	bt_gatt_client_unref(data->client);
 	util_iov_free(data->iov, data->iovcnt);
@@ -708,6 +866,8 @@ static void test_teardown(const void *user_data)
 	bt_bap_remove_pac(data->bsrc);
 	bt_bap_remove_pac(data->bsnk);
 	gatt_db_unref(data->db);
+	bt_gatt_server_unref(data->server);
+	data->server = NULL;
 
 	queue_destroy(data->streams, NULL);
 
@@ -741,7 +901,7 @@ static void test_teardown(const void *user_data)
  *           1 channel (0x01)
  *           2 channels (0x02)
  *       Codec Specific Capabilities #3: len 0x05 type 0x04
- *         Frame Length: 30 (0x001e) - 240 (0x00f0)
+ *         Frame Length: 26 (0x001a) - 240 (0x00f0)
  * ATT: Read Request (0x0a) len 2
  *   Handle: 0x0006 Type: Sink Audio Location (0x2bca)
  * ATT: Read Response (0x0b) len 4
@@ -760,7 +920,7 @@ static void test_teardown(const void *user_data)
 #define DISC_SNK_LC3 \
 	DISC_SNK_PAC(0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
 		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
-		0x1e, 0x00, 0xf0, 0x00, 0x00)
+		0x1a, 0x00, 0xf0, 0x00, 0x00)
 
 /* ATT: Read Request (0x0a) len 2
  *   Handle: 0x0009 Type: Source PAC (0x2bcb)
@@ -789,7 +949,7 @@ static void test_teardown(const void *user_data)
  *           1 channel (0x01)
  *           2 channels (0x02)
  *       Codec Specific Capabilities #3: len 0x05 type 0x04
- *         Frame Length: 30 (0x001e) - 240 (0x00f0)
+ *         Frame Length: 26 (0x001e) - 240 (0x00f0)
  * ATT: Read Request (0x0a) len 2
  *   Handle: 0x000c Type: Source Audio Location (0x2bcc)
  * ATT: Read Response (0x0b) len 4
@@ -809,39 +969,39 @@ static void test_teardown(const void *user_data)
 #define DISC_SRC_LC3 \
 	DISC_SRC_PAC(0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
 		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
-		0x1e, 0x00, 0xf0, 0x00, 0x00)
+		0x1a, 0x00, 0xf0, 0x00, 0x00)
 
 /* ATT: Read Request (0x0a) len 2
  *   Handle: 0x000f Type: Available Audio Contexts (0x2bcd)
  * ATT: Read Response (0x0b) len 4
- *   Value: ff0f0e00
+ *   Value: ff0fff0f
  *   Handle: 0x000f Type: Available Audio Contexts (0x2bcd)
  */
 #define DISC_CTX(_caps...) \
 	DISC_SRC_PAC(_caps), \
 	IOV_DATA(0x0a, 0x0f, 0x00), \
-	IOV_DATA(0x0b, 0xff, 0x0f, 0x0e, 0x00)
+	IOV_DATA(0x0b, 0xff, 0x0f, 0xff, 0x0f)
 
 #define DISC_CTX_LC3 \
 	DISC_CTX(0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
 		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
-		0x1e, 0x00, 0xf0, 0x00, 0x00)
+		0x1a, 0x00, 0xf0, 0x00, 0x00)
 
 /* ATT: Read Request (0x0a) len 2
  *   Handle: 0x0012 Type: Supported Audio Contexts (0x2bce)
  * ATT: Read Response (0x0b) len 4
- *   Value: ff0f0e00
+ *   Value: ff0fff0f
  *   Handle: 0x0012 Type: Supported Audio Contexts (0x2bce)
  */
 #define DISC_SUP_CTX(_caps...) \
 	DISC_CTX(_caps), \
 	IOV_DATA(0x0a, 0x12, 0x00), \
-	IOV_DATA(0x0b, 0xff, 0x0f, 0x0e, 0x00)
+	IOV_DATA(0x0b, 0xff, 0x0f, 0xff, 0x0f)
 
 #define DISC_SUP_CTX_LC3 \
 	DISC_SUP_CTX(0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
 		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
-		0x1e, 0x00, 0xf0, 0x00, 0x00)
+		0x1a, 0x00, 0xf0, 0x00, 0x00)
 
 /* ATT: Read Request (0x0a) len 2
  *   Handle: 0x0016 Type: Sink ASE (0x2bc4)
@@ -878,7 +1038,7 @@ static void test_teardown(const void *user_data)
 #define DISC_SNK_ASE_LC3 \
 	DISC_SNK_ASE(0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
 		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
-		0x1e, 0x00, 0xf0, 0x00, 0x00)
+		0x1a, 0x00, 0xf0, 0x00, 0x00)
 
 /* ATT: Read Request (0x0a) len 2
  *   Handle: 0x001c Type: Source ASE (0x2bc5)
@@ -922,9 +1082,13 @@ static void test_teardown(const void *user_data)
 #define DISC_SRC_ASE_LC3 \
 	DISC_SRC_ASE(0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
 		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
-		0x1e, 0x00, 0xf0, 0x00, 0x00)
+		0x1a, 0x00, 0xf0, 0x00, 0x00)
 
-static void test_disc(void)
+#define DISC_ASE_LC3 \
+	DISC_SNK_ASE_LC3, \
+	DISC_SRC_ASE_LC3
+
+static void test_ucl_disc(void)
 {
 	/* The IUT discovers the characteristics specified in the PAC
 	 * Characteristic and Location Characteristic columns in Table 4.4.
@@ -964,6 +1128,91 @@ static void test_disc(void)
 						DISC_SRC_ASE_LC3);
 }
 
+static void bap_attached(struct bt_bap *bap, void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+
+	if (tester_use_debug())
+		tester_debug("bap %p session attached", bap);
+
+	data->bap = bap;
+
+	bt_bap_set_debug(data->bap, print_debug, "bt_bap:", NULL);
+
+	if (data->cfg && data->cfg->state_func)
+		bt_bap_state_register(data->bap, data->cfg->state_func, NULL,
+						data, NULL);
+}
+
+static void test_server(const void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+	struct io *io;
+
+	io = tester_setup_io(data->iov, data->iovcnt);
+	g_assert(io);
+
+	tester_io_set_complete_func(test_complete_cb);
+
+	test_setup_pacs(data);
+
+	data->id = bt_bap_register(bap_attached, NULL, data);
+	g_assert(data->id);
+
+	tester_io_send();
+}
+
+static void test_usr_disc(void)
+{
+	/* BAP/USR/DISC/BV-01-C [Expose Audio Sink Capabilities]
+	 * BAP/USR/DISC/BV-02-C [Expose Audio Source Capabilities]
+	 *
+	 * The specified PAC Characteristic and the Location Characteristic,
+	 * if supported, are read on the IUT.
+	 */
+	define_test("BAP/USR/DISC/BV-01-C", test_setup_server, test_server,
+						NULL, DISC_SNK_LC3);
+	define_test("BAP/USR/DISC/BV-02-C", test_setup_server, test_server,
+						NULL, DISC_SRC_LC3);
+
+	/* BAP/UCL/DISC/BV-06-C [Discover Available Audio Contexts]
+	 *
+	 * The IUT successfully reads the value of the Available Audio Contexts
+	 * characteristic on the Lower Tester.
+	 */
+	define_test("BAP/USR/DISC/BV-06-C", test_setup_server, test_server,
+						NULL, DISC_CTX_LC3);
+
+	/* BAP/USR/DISC/BV-07-C [Expose Supported Audio Contexts]
+	 *
+	 * The IUT successfully returns the value of its Supported Audio
+	 * Contexts characteristic when read by the Lower Tester.
+	 */
+	define_test("BAP/USR/DISC/BV-07-C", test_setup_server, test_server,
+						NULL, DISC_SUP_CTX_LC3);
+
+	/* BAP/USR/DISC/BV-03-C [Expose Sink ASE_ID]
+	 * BAP/USR/DISC/BV-04-C [Expose Source ASE_ID]
+	 * BAP/USR/DISC/BV-05-C [Expose Sink and Source ASE_ID]
+	 *
+	 * The IUT successfully returns the values of each ASE characteristic
+	 * read by the Lower Tester. The value of the ASE_ID field is unique
+	 * for each ASE characteristic.
+	 */
+	define_test("BAP/USR/DISC/BV-03-C", test_setup_server, test_server,
+						NULL, DISC_SNK_ASE_LC3);
+	define_test("BAP/USR/DISC/BV-04-C", test_setup_server, test_server,
+						NULL, DISC_SRC_ASE_LC3);
+	define_test("BAP/USR/DISC/BV-05-C", test_setup_server, test_server,
+						NULL, DISC_ASE_LC3);
+}
+
+static void test_disc(void)
+{
+	test_ucl_disc();
+	test_usr_disc();
+}
+
 /* ATT: Write Command (0x52) len 23
  *  Handle: 0x0022
  *    Data: 0101010202_cfg
-- 
2.49.0

