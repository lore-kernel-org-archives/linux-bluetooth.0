Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990039;
	b=zAYqFsZfy67Kujw7ptH00ItZNXXY05pHAuyxkJhZZo7o5jbBQx4EUHhPS/qprZtmg7L1
	 iNMxXpE2IYSKaxS1FCIgtKBlFyRtLEzKALKg/tvwNsjqHmEks0FoAFwrXM3o32FeqewR1
	 oWHz5i9rvxYzU9M/ly1MSh73sgSJVqPFR4L1J0YvXExxkiTY0vNyud6J2DUHqAuyZEaaf
	 I7CimFU5JNNNbgMawyPZrt9sZZM4zmd82GJE08Gj/IhPTRLyMOoEhubsKeTwXvVnRfgXG
	 at6FDZH+UXNC6d7NYZ47TRSHA7Fnrqp5eNZwEk8AyNdDquL7kP90CVE9brPLvSn+lhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nf/Ia+hXcEpL9AVu5ferYzhx7jfifOL9cf/849TF+ZA=;
	b=AsDExhtUQ1XkCKjJMRMxI9IGZbSdarBqt1mBbYO9hZ+F6PR6ogp7f3BbdwALKYmOmF8Q
	 MjKMGUIOluw8BinS5+IhewqvSJtFSlqrDcJDH8JT+03wNLUHdfrF+ujuEV1BGVcNscVrK
	 hW6nYnWGxIKtoY3bmAIJgF+asm6wywex9YEWC286Q1cBkDvrzMfJHcU8FUH3FnOsOTtiJ
	 kxDpn1CEuypXUcQK+xzJiEFgAHuurWnC6b9nVIWOq5CTjqYS4+8SHnoCbYtmATLI/Qn8x
	 7V1Jl/BOVgNlga77MLKTbjbJqJwQ6f9CAG9b/Ni02g83estzeykdPKyiY5EkqP53zWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aSC+02i1;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893D1606A329
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 18:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 893D1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aSC+02i1
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eab93a9862so272764e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 10:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990038; x=1794594838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nf/Ia+hXcEpL9AVu5ferYzhx7jfifOL9cf/849TF+ZA=;
        b=aSC+02i1Mz0Y1kHRoCcky65vHgrmUpunUu68hJ/p8JxSry75nz5QOWLP0OM8wJICup
         Z2wjZss6WTYKGXJgRn78rkOv+FbcgNtbjNKOiY0pv3wnT+tyoyqyyUpLKkptMC+QoJDK
         R7GxA6th7WVTOtOTIgw7xM5oxAwMVdQcCSRdPUOvfEasO/l+ZR57UmokZYgQW25y+Yhw
         xJIzHJMWJWVdS/foPjv1CeaZfkJqlGX5X2CgibBxB1wDVjKG01bWVe+Z8icZ0sX5HLvq
         4lcW0oKg9ANJpfZihh2X8I/EOEvWVhvW9X+96qQSv3YugJ5TdwFl9nQw64Th95kh+RJG
         iY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990038; x=1794594838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nf/Ia+hXcEpL9AVu5ferYzhx7jfifOL9cf/849TF+ZA=;
        b=dty+K6chyfZgBwjTzhijFv0dvK7cN7dcGCFJFqOYkXc/IXUo1w21ZxZ6D3PoGYmtyJ
         IV1yyzlaEvruUUptW6VxgtvouL2ydPTk43NVHC/WUN2Jn2A/JB6cUkAX0CZvan9bz4xx
         r5AffMT4Z1UGaKli3W44MayZ1uLzjzBMAHUOzMZ6tH4qy6SgrYXyUde09ibjtTNz4AAG
         sUJKZkJs1+G/01jUo92xJbkRqEVX05DqaWwcls5R0gllMVBftrgk7/HGmGgqUhRLoNjc
         uTBTXquLO5uB/iIvkBD5ACyQkEBK0gRoqdwFllasljMIZWKlGpeN+5XGYGG3Bi+APMKg
         Oxxw==
X-Gm-Message-State: APuU4Z8YMU2k+8yR+q1V/R67IH2NNc1ZHHgwE2glZvNI6IplD5FEmSaR
	JbCNjdRcSjHXsznKfvFCUeMGUGR31Y7qOpgvLuZPlimFAkRLmRpmS5dAsNQ6Hg==
X-Gm-Gg: AYBFou25Tv8tKOyTHDkftibhjxZ7UbIBa7nFl3+NXCGV3MkILTOyaIYmt7ZM3lT9+uk
	Srm5QkhZQrV9ChMirlbFoF1eSD8A8ydaV7xKYVvK/eWyLjLFyIL/LNZARFEjFXqbLlSlHmcc9Vi
	QZITkoSKWGbP/ku83r2f6gWCZid9kFQdvXoVvv+jOgkV9jW4zM6k2du5JEo9Phy4fIDdoWL6rFl
	JPTJ+PXd2w6QEAksraBYozHwG8R/rvhlA/W9EMx6D2lmYaPptcuPS3pqEVsw3d7m19jpCMJG73W
	xyTaWA5lhoy4wVR+MkqIY4bi61Oo6IuUXuRdHCt5Ag/gKJ51rwaw/yC+rGnqPm4WdbP59eXtbY2
	A1fuuDd5oN/Oxb0k6YjGRygSq/Pffv4WhAcZDR1LUB8RXtMfwCT4jxvblMpzar4KTh2mGBfD4gT
	glxqDIBjVaJwGQm4B7UurGvWe6Q6Y9VzPS+DYqizpXOpas6wLQbEKXHqHz0EcLBIfSTIddafLp0
	zf3RkkpE6u5gZuPm+8hVGlKC3SWRPLW2rEG0uD1ZuFrFG203+t3pXhuJCOy9ylMeKZioCUK4+Jp
	SjCkzGF5EpxNrujVTsjyceZBPmmcNNldBsopFrg5eK5ltyRjJs2yLGEaFkYhzHnd+zQy+J0tpl6
	A/qU/zqHyEO80cOZiLSp+qG2g5VZpg7mgskf6lonFePYVnPdLWHkzsKmUvpW9FE1OoffzzdS/xj
	zgilU=
X-Received: by 2002:a05:6122:1d14:b0:5ea:c9ab:bd86 with SMTP id 71dfb90a1353d-5ecc4468dd8mr1505050e0c.21.1793990038379;
        Fri, 06 Nov 2026 10:33:58 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64a6774sm1910173e0c.3.2026.11.06.10.33.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:33:57 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 8/8] unit/test-gatt: Add Read Multiple Variable Length tests
Date: Fri,  6 Nov 2026 13:33:50 -0500
Message-ID: <20261106183350.3155282-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106183350.3155282-1-luiz.dentz@gmail.com>
References: <20261106183350.3155282-1-luiz.dentz@gmail.com>
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
responses and for cancelling the request from the callback, and a
server test for the response.

Assisted-by: OpenCode:claude-opus-5.5
---
 unit/test-gatt.c | 169 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 165 insertions(+), 4 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index d032e7598f9b..267bcc61802e 100644
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
@@ -2149,6 +2179,109 @@ static const struct test_step test_multiple_read_6 = {
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
+static unsigned int multiple_read_vl_id;
+
+static void multiple_read_vl_cancel_cb(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t length,
+					void *user_data)
+{
+	struct context *context = user_data;
+	const struct test_step *step = context->data->step;
+
+	g_assert(success);
+	g_assert_cmpint(get_le16(step->value), ==, length);
+	g_assert(memcmp(value, step->value + 2, length) == 0);
+
+	g_assert(bt_gatt_client_cancel(context->client, multiple_read_vl_id));
+	multiple_read_vl_id = 0;
+
+	context_quit(context);
+}
+
+static void test_multiple_read_vl_cancel(struct context *context)
+{
+	const struct test_step *step = context->data->step;
+	uint16_t handles[2];
+
+	handles[0] = step->handle;
+	handles[1] = step->end_handle;
+
+	multiple_read_vl_id = bt_gatt_client_read_multiple(context->client,
+					handles, 2, multiple_read_vl_cancel_cb,
+					context, NULL);
+	g_assert(multiple_read_vl_id);
+}
+
+static const struct test_step test_multiple_read_vl_3 = {
+	.handle = 0x0003,
+	.end_handle = 0x0005,
+	.func = test_multiple_read_vl_cancel,
+	.value = read_mult_vl_data_1,
+	.length = sizeof(read_mult_vl_data_1),
+	.features = BT_GATT_CHRC_CLI_FEAT_EATT,
+};
+
 static void read_by_type_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data)
@@ -3378,6 +3511,27 @@ int main(int argc, char *argv[])
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
+	define_test_client("/robustness/read-multiple-vl-cancel",
+			test_client, NULL, &test_multiple_read_vl_3,
+			EATT_CLIENT_INIT_PDUS,
+			raw_pdu(0x20, 0x03, 0x00, 0x05, 0x00),
+			raw_pdu(0x21, 0x02, 0x00, 0x01, 0x02, 0x03, 0x00,
+					0x03, 0x04, 0x05));
+
 	define_test_client("/TP/GAR/CL/BI-22-C", test_client, service_db_1,
 			&test_multiple_read_6,
 			SERVICE_DATA_1_PDUS,
@@ -3390,6 +3544,13 @@ int main(int argc, char *argv[])
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

