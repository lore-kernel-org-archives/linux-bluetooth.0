Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917011;
	b=TZ9CCCxSi/8MxkWlBXs0uCzFKq+Od9AfGGQD/mDTLMsU142A2uEk15IHE7BJ9QN05n95
	 0hztO8T3X1kFgCtHVV+g/26HLFrgBpvb1j2aw7MZkIndpUD4eT670sz9Rgf7Cr45v/Ujk
	 5FF6pe4j65SjWd84qSS/cmGvCDOWShy1I/Qy68ek6w7mOx4L/0KIXJuaHgFtzA1GBAKjw
	 puEx5Rr9Q2jvccJqRaATp/fwV63VrR+aBkxWia2IXBXfUTsrwHTeBO9fm4t5k1BTz6rGF
	 UpRs7IjVpEo2yo4Nzv/wbzeGERreuM48ZJz5Srr9ZNZNzFGB15hzyXKOvacwS8s2vkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917011;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xtm5G2OySd+W6hjtxk6P1GMJ+q8T3bDBCNGgCb/1hIc=;
	b=rvB1O5Yrxib8JEcZy6jO51qUDjIMq9Muw+IpqcqtWrmdxFWFYYJpJy9FP8h//BGGbNkl
	 60iXS5yDFSus/qvYXt615s3AMBJAg+C6cuh+RVZL9tjLrimdKfvUmyJVi5ysCT5KMlQdo
	 /8D3+ChZ3aO+vUpBCOzY6rpLqBcO0hW6E0/UMk/Q/Anlf8hvijJjpMGmP8OQ6k4fVIvP5
	 yYD35jmB1jlIVQUJaEpO3TpuQkV/JZK3UMvJTj5oalRQ44WPIYHda6gQKCSvdTxFtBQde
	 4opj9z3D2C3nOprXx+UCZWzKHYibL5GjHM5zFaO0nm6enqwtdPvR5sfbYHEozgCAQYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j62QzSJG;
	arc=none smtp.remote-ip=209.85.222.46
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97610606A32D
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 22:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97610606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j62QzSJG
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-99911ead46dso1105175241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 14:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793917009; x=1794521809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xtm5G2OySd+W6hjtxk6P1GMJ+q8T3bDBCNGgCb/1hIc=;
        b=j62QzSJG6DaTKSXY3YMBwF3U5UlLNHKcAnDMCgD+nNOF16LxG0Fk5zzQUCyybdYmpH
         KbdpdvSGxbYjzyDgG2OkcZzktAV73INqHGe26XYH9TIHNtPtGz6ehqPuid5kefEB/GuA
         yoCv2Dm82hWIHungOpnZQm9ENsWVXBBOF19OpJ5Q6DPAnOCJ8kZbAnIVxK1832aHoWBJ
         ui2DYm0UokxxBf5dCml9PQ5byRLqL1KB1hUGIz8S6Zj2j3IM6nBc7lD4dE0gDbqXf45i
         dMRBv0+S2oetqcXXQKQaAusd7wOWZ1BFmUPZvbT1IOsTgz3myWVo8dKp2k4jUeoQF1zD
         4ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793917009; x=1794521809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xtm5G2OySd+W6hjtxk6P1GMJ+q8T3bDBCNGgCb/1hIc=;
        b=MhLBA/1qrNwIlOx1SC7fYn33foizsU1Q8F3KC5yLO5odeZWNRpT7YKjSvrkP8stDro
         Nia2pUZOHiN5UkYeYLbWNZEaWQ9T+1hBp+3yLFmc2b8+dsKVznZ1PQwTTyfh+CwPcMao
         SP9V0r7kI4oG8EhhGtYinTCVu0L+F2UgykZaqf3+1Z3BMSgZ6uamfCdoHOX8iOWOvs8D
         Tm1nG+ioj3jULKwqoegBIMMkDDpB9/RaeA8mc2Isn12KlzVrviUwrsWKALz482pevca/
         d3D7J1mTDw5dcCvZquK+K76Zo0KEvy4fjasYlV9jrTni2fKNGkM8tGoZaB1SY4OgGLfU
         pQSA==
X-Gm-Message-State: APuU4Z/gSi9tRzCe2o8U2yhjNiOH3ZbtOfvnpvkbG0LZckUOA73Csjfb
	7EwPoOZ4WU9TpPVS2I/sBeIBlHQE2A2HIi+5i53KnCBJfUasZhkMJoyjejfl0w==
X-Gm-Gg: AYBFou2stMtjIvZ8mvcTsxTvwnSX+2yPJ/WZhTXvEWZrnsyBRvnTIqve/l5EqmZgAJj
	F3Z8K7XaC+QvfQQB/Tw2DSksU/82JGgXUOgOR0h8l7HPFWwI1EcaA78JrnoQMt0pBhC09Q6X3rE
	tX++5sGH2t0yd57V7807tibUyEu+vcsISB4UXSYC0zHNe0UnrBAj9/qc87QmU9wtlb6GPx4N03l
	SP11oPC14W6BxUlAIQvo/0ZZwQAZf6WjFZirx8R1fdQVmWbMxnHfPI1foM/rPdF1vipNd1vOxlb
	o05ADeciCjm3bTmmv4KUz+zgYcZR5jwhmK9GeaWWBoedMcPWwY5RQzJXGLZM7yDZZJhMPKZlKzq
	olkD8g9GajE97NCfmxL6Dgm1cjgm6pByTbRNgxbg40VnW4aNAb9Dd4mFaqPm/2KcChB9UKmcoUB
	fRQj1md3CuXPsk2V7Y3/BZ+Xtq086OJeSahlWKwn/RKua+BBuBphyBDMwvIEC8eT1lipvdenTF2
	oCoYd1jx5KvP5Usa+ZTgxuHDUGUMA9zFv5UBfme5AAtVjlmJOmd5fi1DxulbdczpnNK6OHzpfj7
	tw59h0eJ5z3bPBKOlxovezmsTKCL12spaRhKyphb/qcoB7ei/oj1en63Z1YOssKPscYjNR31MpV
	tj1HSJRs0BdH8EhJ4z8BoBB5+eqZRYL7xj1ThmgO1Yc0KAD5ex0kXDETyD1lMu9WiF+b3aIrMe9
	zr8d0=
X-Received: by 2002:a05:6102:4414:b0:7d2:7827:c03 with SMTP id ada2fe7eead31-7d2a160257dmr813800137.25.1793917009469;
        Thu, 05 Nov 2026 14:16:49 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d29d1ea0efsm1355419137.6.2026.11.05.14.16.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:16:49 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 8/8] unit/test-gatt: Add Read Multiple Variable Length tests
Date: Thu,  5 Nov 2026 17:16:38 -0500
Message-ID: <20261105221638.2332398-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105221638.2332398-1-luiz.dentz@gmail.com>
References: <20261105221638.2332398-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add client tests, using EATT client features, for regular and truncated
responses and a server test for the response.

Assisted-by: OpenCode:claude-opus-5.5
---
 unit/test-gatt.c | 120 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 116 insertions(+), 4 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index d032e7598f9b..2d654299852d 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -119,6 +119,29 @@ struct context {
 		MTU_EXCHANGE_CLIENT_PDUS,				\
 		READ_SERVER_FEAT_PDUS
 
+#define EATT_CLIENT_INIT_PDUS						\
+		MTU_EXCHANGE_CLIENT_PDUS,				\
+		raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x3a, 0x2b),	\
+		raw_pdu(0x09, 0x03, 0x03, 0x00, 0x01),			\
+		raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),	\
+		raw_pdu(0x11, 0x06, 0x01, 0x00, 0x05, 0x00, 0x01, 0x18),\
+		raw_pdu(0x08, 0x04, 0x00, 0xff, 0xff, 0x3a, 0x2b),	\
+		raw_pdu(0x01, 0x08, 0x04, 0x00, 0x0a),			\
+		raw_pdu(0x10, 0x06, 0x00, 0xff, 0xff, 0x00, 0x28),	\
+		raw_pdu(0x01, 0x10, 0x06, 0x00, 0x0a),			\
+		raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x01, 0x28),	\
+		raw_pdu(0x01, 0x10, 0x01, 0x00, 0x0a),			\
+		raw_pdu(0x08, 0x01, 0x00, 0x05, 0x00, 0x02, 0x28),	\
+		raw_pdu(0x01, 0x08, 0x01, 0x00, 0x0a),			\
+		raw_pdu(0x08, 0x01, 0x00, 0x05, 0x00, 0x03, 0x28),	\
+		raw_pdu(0x09, 0x07, 0x02, 0x00, 0x02, 0x03, 0x00, 0x3a,	\
+				0x2b, 0x04, 0x00, 0x0a, 0x05, 0x00, 0x29,\
+				0x2b),					\
+		raw_pdu(0x08, 0x05, 0x00, 0x05, 0x00, 0x03, 0x28),	\
+		raw_pdu(0x01, 0x08, 0x05, 0x00, 0x0a),			\
+		raw_pdu(0x12, 0x05, 0x00, 0x07),			\
+		raw_pdu(0x13)
+
 #define SERVICE_DATA_1_PDUS						\
 		CLIENT_INIT_PDUS,					\
 		raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),	\
@@ -328,6 +351,7 @@ struct test_step {
 	uint8_t expected_att_ecode;
 	const uint8_t *value;
 	uint16_t length;
+	uint8_t features;
 };
 
 static void destroy_context(struct context *context)
@@ -624,7 +648,7 @@ static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
 
 	g_assert(success);
 
-	if (!context->data->source_db) {
+	if (!context->data->source_db && !context->data->step) {
 		context_quit(context);
 		return;
 	}
@@ -632,8 +656,10 @@ static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
 	g_assert(context->client);
 	g_assert(context->client_db);
 
-	gatt_db_foreach_service(context->client_db, NULL, match_services,
-						context->data->source_db);
+	if (context->data->source_db)
+		gatt_db_foreach_service(context->client_db, NULL,
+					match_services,
+					context->data->source_db);
 
 	if (context->data->step) {
 		const struct test_step *step = context->data->step;
@@ -653,6 +679,7 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
 {
 	struct context *context = g_new0(struct context, 1);
 	const struct test_data *test_data = data;
+	const struct test_step *step;
 	GIOChannel *channel;
 	int err, sv[2];
 
@@ -680,11 +707,14 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
 						"bt_gatt_server:", NULL);
 		break;
 	case CLIENT:
+		step = test_data->step;
+
 		context->client_db = gatt_db_new();
 		g_assert(context->client_db);
 
 		context->client = bt_gatt_client_new(context->client_db,
-							context->att, mtu, 0);
+						context->att, mtu,
+						step ? step->features : 0);
 		g_assert(context->client);
 
 		bt_gatt_client_set_debug(context->client, print_debug,
@@ -2149,6 +2179,67 @@ static const struct test_step test_multiple_read_6 = {
 	.expected_att_ecode = 0x0c
 };
 
+static void multiple_read_vl_cb(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t length,
+					void *user_data)
+{
+	struct context *context = user_data;
+	const struct test_step *step = context->data->step;
+	static uint16_t offset;
+
+	g_assert(success);
+	g_assert_cmpint(offset + 2 + length, <=, step->length);
+	g_assert_cmpint(get_le16(step->value + offset), ==, length);
+	g_assert(memcmp(value, step->value + offset + 2, length) == 0);
+
+	offset += 2 + length;
+	if (offset == step->length) {
+		offset = 0;
+		context_quit(context);
+	}
+}
+
+static void test_multiple_read_vl(struct context *context)
+{
+	const struct test_step *step = context->data->step;
+	uint16_t handles[2];
+
+	handles[0] = step->handle;
+	handles[1] = step->end_handle;
+
+	g_assert(bt_gatt_client_read_multiple(context->client, handles, 2,
+						multiple_read_vl_cb, context,
+						NULL));
+}
+
+static const uint8_t read_mult_vl_data_1[] = {
+	0x02, 0x00, 0x01, 0x02,
+	0x03, 0x00, 0x03, 0x04, 0x05
+};
+
+static const struct test_step test_multiple_read_vl_1 = {
+	.handle = 0x0003,
+	.end_handle = 0x0005,
+	.func = test_multiple_read_vl,
+	.value = read_mult_vl_data_1,
+	.length = sizeof(read_mult_vl_data_1),
+	.features = BT_GATT_CHRC_CLI_FEAT_EATT,
+};
+
+static const uint8_t read_mult_vl_data_2[] = {
+	0x02, 0x00, 0x01, 0x02,
+	0x01, 0x00, 0x03
+};
+
+static const struct test_step test_multiple_read_vl_2 = {
+	.handle = 0x0003,
+	.end_handle = 0x0005,
+	.func = test_multiple_read_vl,
+	.value = read_mult_vl_data_2,
+	.length = sizeof(read_mult_vl_data_2),
+	.features = BT_GATT_CHRC_CLI_FEAT_EATT,
+};
+
 static void read_by_type_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data)
@@ -3378,6 +3469,20 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
 			raw_pdu(0x0f, 0x01, 0x02, 0x03));
 
+	define_test_client("/robustness/read-multiple-vl", test_client,
+			NULL, &test_multiple_read_vl_1,
+			EATT_CLIENT_INIT_PDUS,
+			raw_pdu(0x20, 0x03, 0x00, 0x05, 0x00),
+			raw_pdu(0x21, 0x02, 0x00, 0x01, 0x02, 0x03, 0x00,
+					0x03, 0x04, 0x05));
+
+	define_test_client("/robustness/read-multiple-vl-truncated",
+			test_client, NULL, &test_multiple_read_vl_2,
+			EATT_CLIENT_INIT_PDUS,
+			raw_pdu(0x20, 0x03, 0x00, 0x05, 0x00),
+			raw_pdu(0x21, 0x02, 0x00, 0x01, 0x02, 0x03, 0x00,
+					0x03));
+
 	define_test_client("/TP/GAR/CL/BI-22-C", test_client, service_db_1,
 			&test_multiple_read_6,
 			SERVICE_DATA_1_PDUS,
@@ -3390,6 +3495,13 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0e, 0x15, 0xF0, 0x03, 0x00),
 			raw_pdu(0x0f, 0x09, 'B', 'l', 'u', 'e', 'Z'));
 
+	define_test_server("/robustness/read-multiple-vl/server",
+			test_server, ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x20, 0x15, 0xF0, 0x03, 0x00),
+			raw_pdu(0x21, 0x01, 0x00, 0x09, 0x05, 0x00, 'B', 'l',
+					'u', 'e', 'Z'));
+
 	define_test_server("/TP/GAR/SR/BV-05-C/large-1", test_server,
 			ts_large_db_1, NULL,
 			raw_pdu(0x03, 0x00, 0x02),
-- 
2.56.0

