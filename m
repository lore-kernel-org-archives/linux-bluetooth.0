Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A1F3612E2
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jun 2026 19:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781983363; cv=none; b=oSOC78b/19g2Km148OsElvv1hP9DrgutuX9E5sEkbvesnRRmJKTWULOhw0Th+U4gQyJ00bgobq4vrrziwInhpfoeo7zC7qripshWoSrDMOL4hl1UKF3Au751kX6I6EsheJocdo4WkHBxcVG+2d5XxeQiQcnyE2ctFDmXtZaQ1r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781983363; c=relaxed/simple;
	bh=kVR9Pr3htNiU+yBXa+s6Ln/AMvvYEe2Y+7Fu59AsWT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxXZMqnmbG+rasBlSa7aIWNhBzT1cRQ7MBFO00yJhjQWUtxhM6Gb+W/xo6tpijwik5ajebV3B+Rg0kCL5RPGfjb+PYVsHunyLw1sq2iTWTx2iWNNmZBfNwSG0oOWW8Jlu7gWQEAUZEK3DWldNv9xZpw87yxeK2rTkGPlJdbmS5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5tnOeyp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5tnOeyp"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b9318997so21408485e9.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jun 2026 12:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781983359; x=1782588159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLK4Z8nFIPgpcT17L/sxhf6gG5IC9DehlG+o56LxVlA=;
        b=k5tnOeypyoMkEWVCGb8cmeMUPRDJe+A1Ns3KnRRYM1a/FoX+BqNvw9XR5r2qnZLNEu
         WZQ/VQE7L3TIEjI6OtOKep2dv8yvSuaEr7tpsSastCKLBOYwEexUFOhIPxrANGT8AfEL
         u2ZAc3BLNyXJHDA00RnmcNQZX9A97AzmNY7sbFLq67m8oCvKwJal7utkSbcNgeSc1NIt
         Lj6dgLp675QpFE/CpUirQTE/4ClcCq383DdXGL3U+LzxGjSXMATdEU5BLcZA1U+jIaXF
         kD+VW0OogxPDZ/auwhOskuECLviYpjvs+uKKU+hRCNkJoxYc7s6atDpMl1WDuiT2y2qd
         8mXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781983359; x=1782588159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kLK4Z8nFIPgpcT17L/sxhf6gG5IC9DehlG+o56LxVlA=;
        b=RoiZwca+qikrnEfo5WF94mbLj+y4RGnt4DBG1cD2hOXrjD6gz2U/nU5gurHthwVk1V
         1WqSI/eKaf4gdaB75PnzrwYm7eDk0+ILloUNlYHMXi27+uFEW5wjNauRnWQwE+gNTLfn
         uj2lfDvHMoOdnMXufi1wy5qMQwZtaJtSYuEQRfdx53IrNhbjJOPwLAMsuVAD3+EAVSIh
         Co+BMoMb2TWKRiVbbc+8eJDOQIeev+EUe1o1gCrY1sx0cIOhfrLogO5mAvyjzfX2rjrI
         ob6uRcCVuYEnqlKOfXLpTxxNiLTOcjyOI8iq6qsOF6hn07zsUJQLjs9c32E9WUdR80es
         VzRw==
X-Gm-Message-State: AOJu0YwwnmcshqaymaH6F6aFW4X/ZBccXHbu2j33wHarf1BsNzrgAt8i
	NFxH4efVNzPVTHwPddvuCL+rocS9FQ9dplEOMEF1vUWNkDwCspkrMBtbkeT4Ww==
X-Gm-Gg: AfdE7cmjP6sJ2xaqxirAzKdswL/nETWUb0GQolvBFulWCmYT9alEb6IjyHSWbBeEIXq
	QqgDo+eySNmhqEJocP/pQbTB11VW15XoYV2f1eKWmewI5MHycngE8r1lRmZ4FaKFNxgOr581w6A
	1gJibKS8i9ab7c5udKPQqatRIeEC4anzrCqZK8jEE2D1WdyfajU0VpoDCl+TK0Urmr4x5JrUeFo
	NCsWMTlr+M7RKrBnKUEe/v8eWjc7EWJkGhn6O1U4Esy6PFCvyWhY3n/US6pXjPC4f8TcBqF4dMR
	QDJ1cgkelWioz7NrP3Fn98bdRe8CJ0boXO6hxguZw8CzizUr9uYz0knJoBZRgQlQ4jTe2OGCe1G
	8XRMJ7e2VcSjSVuJksNDytBf0YTZGueX944Tlg2RqW/L1qPp/oATEJ3CoL0IpCHa/4Kx4WsM/uB
	XY6s5sWdKlmA+nkQh9hQA4mQCw07+dAniCHMD7lFuFfwojT58ynA9tosDmHpfXZmSzRU1B/Qik3
	/qfHbJP/8fONrZmPA==
X-Received: by 2002:a05:600c:828a:b0:490:b58a:e6ff with SMTP id 5b1f17b1804b1-4923f56c180mr147078025e9.22.1781983358274;
        Sat, 20 Jun 2026 12:22:38 -0700 (PDT)
Received: from morpheus01.lan (93-38-64-42.ip69.fastwebnet.it. [93.38.64.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492492338dasm81751085e9.1.2026.06.20.12.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 12:22:37 -0700 (PDT)
From: Geraldo Netto <geraldonetto@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Geraldo Netto <geraldonetto@gmail.com>
Subject: [PATCH BlueZ 2/2] unit: split btsnoop pklg tests
Date: Sat, 20 Jun 2026 21:22:28 +0200
Message-ID: <20260620192228.2692610-2-geraldonetto@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260620192228.2692610-1-geraldonetto@gmail.com>
References: <20260620192228.2692610-1-geraldonetto@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 Makefile.am              |   3 +-
 unit/test-btsnoop-pklg.c | 266 ++++++++++++++++++++++
 unit/test-btsnoop.c      | 462 +++++++++------------------------------
 3 files changed, 374 insertions(+), 357 deletions(-)
 create mode 100644 unit/test-btsnoop-pklg.c

diff --git a/Makefile.am b/Makefile.am
index 4887934a9..db63f3b07 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -589,7 +589,8 @@ unit_test_textfile_LDADD = src/libshared-glib.la $(GLIB_LIBS)
 
 unit_tests += unit/test-btsnoop
 
-unit_test_btsnoop_SOURCES = unit/test-btsnoop.c \
+unit_test_btsnoop_SOURCES = unit/test-btsnoop.c unit/test-btsnoop.h \
+				unit/test-btsnoop-pklg.c \
 				src/shared/btsnoop.h src/shared/btsnoop.c
 unit_test_btsnoop_LDADD = src/libshared-glib.la $(GLIB_LIBS)
 
diff --git a/unit/test-btsnoop-pklg.c b/unit/test-btsnoop-pklg.c
new file mode 100644
index 000000000..ff3c24354
--- /dev/null
+++ b/unit/test-btsnoop-pklg.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <endian.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <glib.h>
+
+#include "src/shared/att-types.h"
+#include "src/shared/btsnoop.h"
+#include "unit/test-btsnoop.h"
+
+#define PKLG_PAYLOAD_OFFSET 9
+
+struct test_pklg_pkt {
+	uint32_t len;
+	uint64_t ts;
+	uint8_t type;
+} __packed;
+
+struct read_result {
+	uint8_t data[BTSNOOP_MAX_PACKET_SIZE];
+	uint16_t size;
+	uint16_t index;
+	uint16_t opcode;
+	struct timeval tv;
+};
+
+static void read_result_init(struct read_result *result)
+{
+	memset(result->data, 0xa5, sizeof(result->data));
+	result->size = 0;
+	result->index = 0xffff;
+	result->opcode = 0xffff;
+	memset(&result->tv, 0, sizeof(result->tv));
+}
+
+static void append_bytes(GByteArray *array, const void *data, size_t size)
+{
+	if (size)
+		g_byte_array_append(array, data, size);
+}
+
+static void append_pklg_packet(GByteArray *array, bool little_endian,
+				uint32_t payload_len, uint64_t ts,
+				uint8_t type, const void *data, size_t data_len)
+{
+	struct test_pklg_pkt pkt;
+	uint32_t len = PKLG_PAYLOAD_OFFSET + payload_len;
+
+	pkt.len = little_endian ? htole32(len) : htobe32(len);
+	pkt.ts = little_endian ? htole64(ts) : htobe64(ts);
+	pkt.type = type;
+
+	append_bytes(array, &pkt, sizeof(pkt));
+	append_bytes(array, data, data_len);
+}
+
+static char *write_tmp_trace(const void *data, size_t size)
+{
+	char *path = NULL;
+	ssize_t written;
+	int fd;
+
+	fd = g_file_open_tmp("bluez-btsnoop-XXXXXX", &path, NULL);
+	g_assert(fd >= 0);
+	written = write(fd, data, size);
+	g_assert_cmpint(written, ==, (ssize_t) size);
+	g_assert_cmpint(close(fd), ==, 0);
+
+	return path;
+}
+
+static bool read_tmp_trace(const void *trace, size_t trace_len,
+				uint16_t data_size, struct read_result *result)
+{
+	struct btsnoop *btsnoop;
+	char *path;
+	bool ok;
+
+	read_result_init(result);
+	path = write_tmp_trace(trace, trace_len);
+	btsnoop = btsnoop_open(path, BTSNOOP_FLAG_PKLG_SUPPORT);
+	unlink(path);
+	g_free(path);
+
+	if (!btsnoop)
+		return false;
+
+	ok = btsnoop_read_hci(btsnoop, &result->tv, &result->index,
+				&result->opcode, result->data, data_size,
+				&result->size);
+	btsnoop_unref(btsnoop);
+
+	return ok;
+}
+
+static void test_pklg_big_endian_valid(void)
+{
+	GByteArray *trace = g_byte_array_new();
+	const uint8_t payload[] = { 0x0e, 0x01, 0x00 };
+	struct read_result result;
+
+	append_pklg_packet(trace, false, sizeof(payload),
+			((uint64_t) 123 << 32) | 456, 0x01, payload,
+			sizeof(payload));
+
+	g_assert_true(read_tmp_trace(trace->data, trace->len, sizeof(payload),
+								&result));
+	g_assert_cmpint(result.index, ==, 0);
+	g_assert_cmpint(result.opcode, ==, BTSNOOP_OPCODE_EVENT_PKT);
+	g_assert_cmpint(result.size, ==, sizeof(payload));
+	g_assert_cmpint(memcmp(result.data, payload, sizeof(payload)), ==, 0);
+	g_assert_cmpint(result.tv.tv_sec, ==, 123);
+	g_assert_cmpint(result.tv.tv_usec, ==, 456);
+
+	g_byte_array_unref(trace);
+}
+
+static void test_pklg_little_endian_valid(void)
+{
+	GByteArray *trace = g_byte_array_new();
+	const uint8_t payload[] = { 0x01, 0x02, 0x03 };
+	struct read_result result;
+
+	append_pklg_packet(trace, true, sizeof(payload),
+			((uint64_t) 456 << 32) | 123, 0x00, payload,
+			sizeof(payload));
+
+	g_assert_true(read_tmp_trace(trace->data, trace->len, sizeof(payload),
+								&result));
+	g_assert_cmpint(result.index, ==, 0);
+	g_assert_cmpint(result.opcode, ==, BTSNOOP_OPCODE_COMMAND_PKT);
+	g_assert_cmpint(result.size, ==, sizeof(payload));
+	g_assert_cmpint(result.data[0], ==, payload[0]);
+	g_assert_cmpint(result.tv.tv_sec, ==, 123);
+	g_assert_cmpint(result.tv.tv_usec, ==, 456);
+
+	g_byte_array_unref(trace);
+}
+
+static void test_pklg_rejects_short_length(void)
+{
+	GByteArray *trace = g_byte_array_new();
+	struct test_pklg_pkt pkt;
+	const uint8_t padding[] = { 0x00, 0x00, 0x00 };
+	struct read_result result;
+
+	pkt.len = htobe32(PKLG_PAYLOAD_OFFSET - 1);
+	pkt.ts = 0;
+	pkt.type = 0x01;
+
+	append_bytes(trace, &pkt, sizeof(pkt));
+	append_bytes(trace, padding, sizeof(padding));
+
+	g_assert_false(read_tmp_trace(trace->data, trace->len, 0, &result));
+
+	g_byte_array_unref(trace);
+}
+
+static void test_pklg_rejects_small_capacity(void)
+{
+	GByteArray *trace = g_byte_array_new();
+	const uint8_t payload[] = { 0x01, 0x02, 0x03 };
+	struct read_result result;
+
+	append_pklg_packet(trace, false, sizeof(payload), 0, 0x01, payload,
+							sizeof(payload));
+
+	g_assert_false(read_tmp_trace(trace->data, trace->len, 2, &result));
+	g_assert_cmpint(result.data[0], ==, 0xa5);
+	g_assert_cmpint(result.data[1], ==, 0xa5);
+	g_assert_cmpint(result.data[2], ==, 0xa5);
+	g_assert_cmpint(result.data[3], ==, 0xa5);
+
+	g_byte_array_unref(trace);
+}
+
+static void test_pklg_rejects_short_payload(void)
+{
+	GByteArray *trace = g_byte_array_new();
+	const uint8_t payload[] = { 0x01, 0x02, 0x03 };
+	struct read_result result;
+
+	append_pklg_packet(trace, false, 4, 0, 0x01, payload,
+							sizeof(payload));
+
+	g_assert_false(read_tmp_trace(trace->data, trace->len, 4, &result));
+
+	g_byte_array_unref(trace);
+}
+
+static void test_pklg_type_map(void)
+{
+	static const struct {
+		uint8_t type;
+		uint16_t index;
+		uint16_t opcode;
+	} cases[] = {
+		{ 0x02, 0x0000, BTSNOOP_OPCODE_ACL_TX_PKT },
+		{ 0x03, 0x0000, BTSNOOP_OPCODE_ACL_RX_PKT },
+		{ 0x08, 0x0000, BTSNOOP_OPCODE_SCO_TX_PKT },
+		{ 0x09, 0x0000, BTSNOOP_OPCODE_SCO_RX_PKT },
+		{ 0x12, 0x0000, BTSNOOP_OPCODE_ISO_TX_PKT },
+		{ 0x13, 0x0000, BTSNOOP_OPCODE_ISO_RX_PKT },
+		{ 0x0b, 0x0000, BTSNOOP_OPCODE_VENDOR_DIAG },
+		{ 0xfc, 0xffff, BTSNOOP_OPCODE_SYSTEM_NOTE },
+		{ 0xaa, 0xffff, 0xffff },
+	};
+	const uint8_t payload[] = { 0x00, 0x01, 0x02 };
+	unsigned int i;
+
+	for (i = 0; i < G_N_ELEMENTS(cases); i++) {
+		GByteArray *trace = g_byte_array_new();
+		struct read_result result;
+
+		append_pklg_packet(trace, false, sizeof(payload), 0,
+						cases[i].type, payload,
+						sizeof(payload));
+
+		g_assert_true(read_tmp_trace(trace->data, trace->len,
+						sizeof(payload), &result));
+		g_assert_cmpint(result.index, ==, cases[i].index);
+		g_assert_cmpint(result.opcode, ==, cases[i].opcode);
+		g_byte_array_unref(trace);
+	}
+}
+
+static void test_pklg_truncation_fuzz(void)
+{
+	GByteArray *trace = g_byte_array_new();
+	const uint8_t payload[] = { 0x01, 0x02, 0x03 };
+	size_t len;
+
+	append_pklg_packet(trace, false, sizeof(payload), 0, 0x01, payload,
+							sizeof(payload));
+
+	for (len = 0; len < trace->len; len++) {
+		struct read_result result;
+
+		g_assert_false(read_tmp_trace(trace->data, len, sizeof(payload),
+								&result));
+	}
+
+	g_byte_array_unref(trace);
+}
+
+void add_pklg_tests(void)
+{
+	g_test_add_func("/pklg/big-endian/valid", test_pklg_big_endian_valid);
+	g_test_add_func("/pklg/little-endian/valid",
+			test_pklg_little_endian_valid);
+	g_test_add_func("/pklg/length/short", test_pklg_rejects_short_length);
+	g_test_add_func("/pklg/capacity/reject",
+			test_pklg_rejects_small_capacity);
+	g_test_add_func("/pklg/payload/short", test_pklg_rejects_short_payload);
+	g_test_add_func("/pklg/type-map", test_pklg_type_map);
+	g_test_add_func("/pklg/fuzz/truncation", test_pklg_truncation_fuzz);
+}
diff --git a/unit/test-btsnoop.c b/unit/test-btsnoop.c
index 710209097..fa7587d1a 100644
--- a/unit/test-btsnoop.c
+++ b/unit/test-btsnoop.c
@@ -18,7 +18,6 @@
 #include "unit/test-btsnoop.h"
 
 #define BTSNOOP_EPOCH_OFFSET 0x00E03AB44A676000ull
-#define PKLG_PAYLOAD_OFFSET 9
 
 struct test_btsnoop_hdr {
 	uint8_t id[8];
@@ -34,22 +33,31 @@ struct test_btsnoop_pkt {
 	uint64_t ts;
 } __packed;
 
-struct test_pklg_pkt {
-	uint32_t len;
-	uint64_t ts;
-	uint8_t type;
-} __packed;
+struct read_result {
+	uint8_t data[BTSNOOP_MAX_PACKET_SIZE];
+	uint16_t size;
+	uint16_t index;
+	uint16_t opcode;
+	struct timeval tv;
+};
 
 static const uint8_t btsnoop_id[] = {
 	0x62, 0x74, 0x73, 0x6e, 0x6f, 0x6f, 0x70, 0x00
 };
 
-static void append_bytes(GByteArray *array, const void *data, size_t size)
+static void read_result_init(struct read_result *result)
 {
-	if (!size)
-		return;
+	memset(result->data, 0xa5, sizeof(result->data));
+	result->size = 0;
+	result->index = 0xffff;
+	result->opcode = 0xffff;
+	memset(&result->tv, 0, sizeof(result->tv));
+}
 
-	g_byte_array_append(array, data, size);
+static void append_bytes(GByteArray *array, const void *data, size_t size)
+{
+	if (size)
+		g_byte_array_append(array, data, size);
 }
 
 static void append_btsnoop_header(GByteArray *array, uint32_t format)
@@ -79,21 +87,6 @@ static void append_btsnoop_packet(GByteArray *array, uint32_t len,
 	append_bytes(array, data, data_len);
 }
 
-static void append_pklg_packet(GByteArray *array, bool little_endian,
-				uint32_t payload_len, uint64_t ts,
-				uint8_t type, const void *data, size_t data_len)
-{
-	struct test_pklg_pkt pkt;
-	uint32_t len = PKLG_PAYLOAD_OFFSET + payload_len;
-
-	pkt.len = little_endian ? htole32(len) : htobe32(len);
-	pkt.ts = little_endian ? htole64(ts) : htobe64(ts);
-	pkt.type = type;
-
-	append_bytes(array, &pkt, sizeof(pkt));
-	append_bytes(array, data, data_len);
-}
-
 static char *write_tmp_trace(const void *data, size_t size)
 {
 	char *path = NULL;
@@ -127,9 +120,8 @@ static void unlink_rotated(const char *path, unsigned int count)
 	unsigned int i;
 
 	for (i = 0; i <= count; i++) {
-		char *name;
+		char *name = g_strdup_printf("%s.%u", path, i);
 
-		name = g_strdup_printf("%s.%u", path, i);
 		unlink(name);
 		g_free(name);
 	}
@@ -137,14 +129,13 @@ static void unlink_rotated(const char *path, unsigned int count)
 
 static bool read_tmp_trace(const void *trace, size_t trace_len,
 				unsigned long flags, uint16_t data_size,
-				uint8_t *data, uint16_t *size,
-				uint16_t *index, uint16_t *opcode,
-				struct timeval *tv)
+				struct read_result *result)
 {
 	struct btsnoop *btsnoop;
 	char *path;
-	bool result;
+	bool ok;
 
+	read_result_init(result);
 	path = write_tmp_trace(trace, trace_len);
 	btsnoop = btsnoop_open(path, flags);
 	unlink(path);
@@ -153,54 +144,51 @@ static bool read_tmp_trace(const void *trace, size_t trace_len,
 	if (!btsnoop)
 		return false;
 
-	result = btsnoop_read_hci(btsnoop, tv, index, opcode, data,
-							data_size, size);
+	ok = btsnoop_read_hci(btsnoop, &result->tv, &result->index,
+				&result->opcode, result->data, data_size,
+				&result->size);
 	btsnoop_unref(btsnoop);
 
-	return result;
+	return ok;
 }
 
 static bool read_trace_file(const char *path, unsigned long flags,
-				uint8_t *data, uint16_t data_size,
-				uint16_t *size, uint16_t *index,
-				uint16_t *opcode, struct timeval *tv)
+				uint16_t data_size, struct read_result *result)
 {
 	struct btsnoop *btsnoop;
-	bool result;
+	bool ok;
 
+	read_result_init(result);
 	btsnoop = btsnoop_open(path, flags);
 	g_assert_nonnull(btsnoop);
 
-	result = btsnoop_read_hci(btsnoop, tv, index, opcode, data,
-							data_size, size);
+	ok = btsnoop_read_hci(btsnoop, &result->tv, &result->index,
+				&result->opcode, result->data, data_size,
+				&result->size);
 	btsnoop_unref(btsnoop);
 
-	return result;
+	return ok;
 }
 
 static void test_btsnoop_hci_valid(void)
 {
 	GByteArray *trace = g_byte_array_new();
 	const uint8_t payload[] = { 0x01, 0x02, 0x03 };
-	uint8_t data[sizeof(payload)];
-	struct timeval tv;
-	uint16_t size = 0;
-	uint16_t index = 0xffff;
-	uint16_t opcode = 0xffff;
+	struct read_result result;
 
 	append_btsnoop_header(trace, BTSNOOP_FORMAT_HCI);
 	append_btsnoop_packet(trace, sizeof(payload), 0x02,
 			BTSNOOP_EPOCH_OFFSET + 1234567, payload,
 			sizeof(payload));
 
-	g_assert_true(read_tmp_trace(trace->data, trace->len, 0, sizeof(data),
-					data, &size, &index, &opcode, &tv));
-	g_assert_cmpint(index, ==, 0);
-	g_assert_cmpint(opcode, ==, BTSNOOP_OPCODE_COMMAND_PKT);
-	g_assert_cmpint(size, ==, sizeof(payload));
-	g_assert_cmpint(memcmp(data, payload, sizeof(payload)), ==, 0);
-	g_assert_cmpint(tv.tv_sec, ==, 946684801);
-	g_assert_cmpint(tv.tv_usec, ==, 234567);
+	g_assert_true(read_tmp_trace(trace->data, trace->len, 0,
+						sizeof(payload), &result));
+	g_assert_cmpint(result.index, ==, 0);
+	g_assert_cmpint(result.opcode, ==, BTSNOOP_OPCODE_COMMAND_PKT);
+	g_assert_cmpint(result.size, ==, sizeof(payload));
+	g_assert_cmpint(memcmp(result.data, payload, sizeof(payload)), ==, 0);
+	g_assert_cmpint(result.tv.tv_sec, ==, 946684801);
+	g_assert_cmpint(result.tv.tv_usec, ==, 234567);
 
 	g_byte_array_unref(trace);
 }
@@ -247,12 +235,9 @@ static void test_btsnoop_write_hci_roundtrip(void)
 {
 	const uint8_t command[] = { 0x01, 0x02, 0x03 };
 	const uint8_t event[] = { 0x04, 0x05 };
-	uint8_t data[sizeof(command)];
 	struct btsnoop *btsnoop;
+	struct read_result result;
 	struct timeval tv = { .tv_sec = 946684802, .tv_usec = 345678 };
-	uint16_t size = 0;
-	uint16_t index = 0;
-	uint16_t opcode = 0;
 	char *path = new_tmp_path();
 
 	btsnoop = btsnoop_create(path, 0, 0, BTSNOOP_FORMAT_HCI);
@@ -272,24 +257,30 @@ static void test_btsnoop_write_hci_roundtrip(void)
 					command, sizeof(command)));
 	btsnoop_unref(btsnoop);
 
-	g_assert_true(read_trace_file(path, 0, data, sizeof(data), &size,
-						&index, &opcode, &tv));
-	g_assert_cmpint(index, ==, 0);
-	g_assert_cmpint(opcode, ==, BTSNOOP_OPCODE_COMMAND_PKT);
-	g_assert_cmpint(size, ==, sizeof(command));
-	g_assert_cmpint(memcmp(data, command, sizeof(command)), ==, 0);
+	g_assert_true(read_trace_file(path, 0, sizeof(command), &result));
+	g_assert_cmpint(result.index, ==, 0);
+	g_assert_cmpint(result.opcode, ==, BTSNOOP_OPCODE_COMMAND_PKT);
+	g_assert_cmpint(result.size, ==, sizeof(command));
+	g_assert_cmpint(memcmp(result.data, command, sizeof(command)), ==, 0);
 
 	btsnoop = btsnoop_open(path, 0);
 	g_assert_nonnull(btsnoop);
-	g_assert_true(btsnoop_read_hci(btsnoop, &tv, &index, &opcode, data,
-							sizeof(data), &size));
-	g_assert_true(btsnoop_read_hci(btsnoop, &tv, &index, &opcode, data,
-							sizeof(data), &size));
-	g_assert_cmpint(opcode, ==, BTSNOOP_OPCODE_EVENT_PKT);
-	g_assert_cmpint(size, ==, sizeof(event));
-	g_assert_cmpint(memcmp(data, event, sizeof(event)), ==, 0);
-	g_assert_false(btsnoop_read_hci(btsnoop, &tv, &index, &opcode, data,
-							sizeof(data), &size));
+	read_result_init(&result);
+	g_assert_true(btsnoop_read_hci(btsnoop, &result.tv,
+				&result.index, &result.opcode,
+				result.data, sizeof(result.data),
+				&result.size));
+	g_assert_true(btsnoop_read_hci(btsnoop, &result.tv,
+				&result.index, &result.opcode,
+				result.data, sizeof(result.data),
+				&result.size));
+	g_assert_cmpint(result.opcode, ==, BTSNOOP_OPCODE_EVENT_PKT);
+	g_assert_cmpint(result.size, ==, sizeof(event));
+	g_assert_cmpint(memcmp(result.data, event, sizeof(event)), ==, 0);
+	g_assert_false(btsnoop_read_hci(btsnoop, &result.tv,
+				&result.index, &result.opcode,
+				result.data, sizeof(result.data),
+				&result.size));
 	btsnoop_unref(btsnoop);
 
 	unlink(path);
@@ -299,12 +290,9 @@ static void test_btsnoop_write_hci_roundtrip(void)
 static void test_btsnoop_write_monitor_roundtrip(void)
 {
 	const uint8_t payload[] = { 0xaa, 0xbb };
-	uint8_t data[sizeof(payload)];
 	struct btsnoop *btsnoop;
+	struct read_result result;
 	struct timeval tv = { .tv_sec = 946684800, .tv_usec = 0 };
-	uint16_t size = 0;
-	uint16_t index = 0;
-	uint16_t opcode = 0;
 	char *path = new_tmp_path();
 
 	btsnoop = btsnoop_create(path, 0, 0, BTSNOOP_FORMAT_MONITOR);
@@ -313,12 +301,11 @@ static void test_btsnoop_write_monitor_roundtrip(void)
 						payload, sizeof(payload)));
 	btsnoop_unref(btsnoop);
 
-	g_assert_true(read_trace_file(path, 0, data, sizeof(data), &size,
-						&index, &opcode, &tv));
-	g_assert_cmpint(index, ==, 7);
-	g_assert_cmpint(opcode, ==, 0x1234);
-	g_assert_cmpint(size, ==, sizeof(payload));
-	g_assert_cmpint(memcmp(data, payload, sizeof(payload)), ==, 0);
+	g_assert_true(read_trace_file(path, 0, sizeof(payload), &result));
+	g_assert_cmpint(result.index, ==, 7);
+	g_assert_cmpint(result.opcode, ==, 0x1234);
+	g_assert_cmpint(result.size, ==, sizeof(payload));
+	g_assert_cmpint(memcmp(result.data, payload, sizeof(payload)), ==, 0);
 
 	unlink(path);
 	g_free(path);
@@ -355,22 +342,18 @@ static void test_btsnoop_monitor_valid(void)
 {
 	GByteArray *trace = g_byte_array_new();
 	const uint8_t payload[] = { 0xaa, 0xbb };
-	uint8_t data[sizeof(payload)];
-	struct timeval tv;
-	uint16_t size = 0;
-	uint16_t index = 0xffff;
-	uint16_t opcode = 0xffff;
+	struct read_result result;
 
 	append_btsnoop_header(trace, BTSNOOP_FORMAT_MONITOR);
 	append_btsnoop_packet(trace, sizeof(payload), 0x00051234,
 			BTSNOOP_EPOCH_OFFSET, payload, sizeof(payload));
 
-	g_assert_true(read_tmp_trace(trace->data, trace->len, 0, sizeof(data),
-					data, &size, &index, &opcode, &tv));
-	g_assert_cmpint(index, ==, 5);
-	g_assert_cmpint(opcode, ==, 0x1234);
-	g_assert_cmpint(size, ==, sizeof(payload));
-	g_assert_cmpint(memcmp(data, payload, sizeof(payload)), ==, 0);
+	g_assert_true(read_tmp_trace(trace->data, trace->len, 0,
+						sizeof(payload), &result));
+	g_assert_cmpint(result.index, ==, 5);
+	g_assert_cmpint(result.opcode, ==, 0x1234);
+	g_assert_cmpint(result.size, ==, sizeof(payload));
+	g_assert_cmpint(memcmp(result.data, payload, sizeof(payload)), ==, 0);
 
 	g_byte_array_unref(trace);
 }
@@ -379,22 +362,18 @@ static void test_btsnoop_uart_valid(void)
 {
 	GByteArray *trace = g_byte_array_new();
 	const uint8_t payload[] = { 0x04, 0x0e, 0x01, 0x00 };
-	uint8_t data[sizeof(payload) - 1];
-	struct timeval tv;
-	uint16_t size = 0;
-	uint16_t index = 0xffff;
-	uint16_t opcode = 0xffff;
+	struct read_result result;
 
 	append_btsnoop_header(trace, BTSNOOP_FORMAT_UART);
 	append_btsnoop_packet(trace, sizeof(payload), 0,
 			BTSNOOP_EPOCH_OFFSET, payload, sizeof(payload));
 
-	g_assert_true(read_tmp_trace(trace->data, trace->len, 0, sizeof(data),
-					data, &size, &index, &opcode, &tv));
-	g_assert_cmpint(index, ==, 0);
-	g_assert_cmpint(opcode, ==, BTSNOOP_OPCODE_EVENT_PKT);
-	g_assert_cmpint(size, ==, sizeof(payload) - 1);
-	g_assert_cmpint(memcmp(data, payload + 1, sizeof(data)), ==, 0);
+	g_assert_true(read_tmp_trace(trace->data, trace->len, 0,
+						sizeof(payload) - 1, &result));
+	g_assert_cmpint(result.index, ==, 0);
+	g_assert_cmpint(result.opcode, ==, BTSNOOP_OPCODE_EVENT_PKT);
+	g_assert_cmpint(result.size, ==, sizeof(payload) - 1);
+	g_assert_cmpint(memcmp(result.data, payload + 1, result.size), ==, 0);
 
 	g_byte_array_unref(trace);
 }
@@ -420,20 +399,15 @@ static void test_btsnoop_uart_opcode_map(void)
 	for (i = 0; i < G_N_ELEMENTS(cases); i++) {
 		GByteArray *trace = g_byte_array_new();
 		const uint8_t payload[] = { cases[i].type, 0x00 };
-		uint8_t data[1];
-		struct timeval tv;
-		uint16_t size = 0;
-		uint16_t index = 0;
-		uint16_t opcode = 0;
+		struct read_result result;
 
 		append_btsnoop_header(trace, BTSNOOP_FORMAT_UART);
 		append_btsnoop_packet(trace, sizeof(payload), cases[i].flags,
 				BTSNOOP_EPOCH_OFFSET, payload, sizeof(payload));
 
-		g_assert_true(read_tmp_trace(trace->data, trace->len, 0,
-						sizeof(data), data, &size,
-						&index, &opcode, &tv));
-		g_assert_cmpint(opcode, ==, cases[i].opcode);
+		g_assert_true(read_tmp_trace(trace->data, trace->len, 0, 1,
+								&result));
+		g_assert_cmpint(result.opcode, ==, cases[i].opcode);
 		g_byte_array_unref(trace);
 	}
 }
@@ -442,22 +416,17 @@ static void test_btsnoop_rejects_small_capacity(void)
 {
 	GByteArray *trace = g_byte_array_new();
 	const uint8_t payload[] = { 0x01, 0x02, 0x03 };
-	uint8_t data[4] = { 0xa5, 0xa5, 0xa5, 0xa5 };
-	struct timeval tv;
-	uint16_t size = 0;
-	uint16_t index = 0;
-	uint16_t opcode = 0;
+	struct read_result result;
 
 	append_btsnoop_header(trace, BTSNOOP_FORMAT_HCI);
 	append_btsnoop_packet(trace, sizeof(payload), 0x02,
 			BTSNOOP_EPOCH_OFFSET, payload, sizeof(payload));
 
-	g_assert_false(read_tmp_trace(trace->data, trace->len, 0, 2, data,
-						&size, &index, &opcode, &tv));
-	g_assert_cmpint(data[0], ==, 0xa5);
-	g_assert_cmpint(data[1], ==, 0xa5);
-	g_assert_cmpint(data[2], ==, 0xa5);
-	g_assert_cmpint(data[3], ==, 0xa5);
+	g_assert_false(read_tmp_trace(trace->data, trace->len, 0, 2, &result));
+	g_assert_cmpint(result.data[0], ==, 0xa5);
+	g_assert_cmpint(result.data[1], ==, 0xa5);
+	g_assert_cmpint(result.data[2], ==, 0xa5);
+	g_assert_cmpint(result.data[3], ==, 0xa5);
 
 	g_byte_array_unref(trace);
 }
@@ -465,17 +434,13 @@ static void test_btsnoop_rejects_small_capacity(void)
 static void test_btsnoop_rejects_timestamp_underflow(void)
 {
 	GByteArray *trace = g_byte_array_new();
-	struct timeval tv;
-	uint16_t size = 0;
-	uint16_t index = 0;
-	uint16_t opcode = 0;
+	struct read_result result;
 
 	append_btsnoop_header(trace, BTSNOOP_FORMAT_HCI);
 	append_btsnoop_packet(trace, 0, 0x02, BTSNOOP_EPOCH_OFFSET - 1,
 								NULL, 0);
 
-	g_assert_false(read_tmp_trace(trace->data, trace->len, 0, 0, NULL,
-						&size, &index, &opcode, &tv));
+	g_assert_false(read_tmp_trace(trace->data, trace->len, 0, 0, &result));
 
 	g_byte_array_unref(trace);
 }
@@ -483,16 +448,12 @@ static void test_btsnoop_rejects_timestamp_underflow(void)
 static void test_btsnoop_rejects_uart_zero_length(void)
 {
 	GByteArray *trace = g_byte_array_new();
-	struct timeval tv;
-	uint16_t size = 0;
-	uint16_t index = 0;
-	uint16_t opcode = 0;
+	struct read_result result;
 
 	append_btsnoop_header(trace, BTSNOOP_FORMAT_UART);
 	append_btsnoop_packet(trace, 0, 0, BTSNOOP_EPOCH_OFFSET, NULL, 0);
 
-	g_assert_false(read_tmp_trace(trace->data, trace->len, 0, 0, NULL,
-						&size, &index, &opcode, &tv));
+	g_assert_false(read_tmp_trace(trace->data, trace->len, 0, 0, &result));
 
 	g_byte_array_unref(trace);
 }
@@ -500,16 +461,12 @@ static void test_btsnoop_rejects_uart_zero_length(void)
 static void test_btsnoop_rejects_uart_short_type(void)
 {
 	GByteArray *trace = g_byte_array_new();
-	struct timeval tv;
-	uint16_t size = 0;
-	uint16_t index = 0;
-	uint16_t opcode = 0;
+	struct read_result result;
 
 	append_btsnoop_header(trace, BTSNOOP_FORMAT_UART);
 	append_btsnoop_packet(trace, 1, 0, BTSNOOP_EPOCH_OFFSET, NULL, 0);
 
-	g_assert_false(read_tmp_trace(trace->data, trace->len, 0, 0, NULL,
-						&size, &index, &opcode, &tv));
+	g_assert_false(read_tmp_trace(trace->data, trace->len, 0, 0, &result));
 
 	g_byte_array_unref(trace);
 }
@@ -518,187 +475,17 @@ static void test_btsnoop_rejects_short_payload(void)
 {
 	GByteArray *trace = g_byte_array_new();
 	const uint8_t payload[] = { 0x01, 0x02 };
-	uint8_t data[3];
-	struct timeval tv;
-	uint16_t size = 0;
-	uint16_t index = 0;
-	uint16_t opcode = 0;
+	struct read_result result;
 
 	append_btsnoop_header(trace, BTSNOOP_FORMAT_HCI);
 	append_btsnoop_packet(trace, 3, 0x02, BTSNOOP_EPOCH_OFFSET,
 					payload, sizeof(payload));
 
-	g_assert_false(read_tmp_trace(trace->data, trace->len, 0,
-					sizeof(data), data, &size,
-					&index, &opcode, &tv));
-
-	g_byte_array_unref(trace);
-}
-
-static void test_pklg_big_endian_valid(void)
-{
-	GByteArray *trace = g_byte_array_new();
-	const uint8_t payload[] = { 0x0e, 0x01, 0x00 };
-	uint8_t data[sizeof(payload)];
-	struct timeval tv;
-	uint16_t size = 0;
-	uint16_t index = 0xffff;
-	uint16_t opcode = 0xffff;
-
-	append_pklg_packet(trace, false, sizeof(payload),
-			((uint64_t) 123 << 32) | 456, 0x01, payload,
-			sizeof(payload));
-
-	g_assert_true(read_tmp_trace(trace->data, trace->len,
-					BTSNOOP_FLAG_PKLG_SUPPORT, sizeof(data),
-					data, &size, &index, &opcode, &tv));
-	g_assert_cmpint(index, ==, 0);
-	g_assert_cmpint(opcode, ==, BTSNOOP_OPCODE_EVENT_PKT);
-	g_assert_cmpint(size, ==, sizeof(payload));
-	g_assert_cmpint(memcmp(data, payload, sizeof(payload)), ==, 0);
-	g_assert_cmpint(tv.tv_sec, ==, 123);
-	g_assert_cmpint(tv.tv_usec, ==, 456);
-
-	g_byte_array_unref(trace);
-}
-
-static void test_pklg_little_endian_valid(void)
-{
-	GByteArray *trace = g_byte_array_new();
-	const uint8_t payload[] = { 0x01, 0x02, 0x03 };
-	uint8_t data[sizeof(payload)];
-	struct timeval tv;
-	uint16_t size = 0;
-	uint16_t index = 0xffff;
-	uint16_t opcode = 0xffff;
-
-	append_pklg_packet(trace, true, sizeof(payload),
-			((uint64_t) 456 << 32) | 123, 0x00, payload,
-			sizeof(payload));
-
-	g_assert_true(read_tmp_trace(trace->data, trace->len,
-					BTSNOOP_FLAG_PKLG_SUPPORT, sizeof(data),
-					data, &size, &index, &opcode, &tv));
-	g_assert_cmpint(index, ==, 0);
-	g_assert_cmpint(opcode, ==, BTSNOOP_OPCODE_COMMAND_PKT);
-	g_assert_cmpint(size, ==, sizeof(payload));
-	g_assert_cmpint(data[0], ==, payload[0]);
-	g_assert_cmpint(tv.tv_sec, ==, 123);
-	g_assert_cmpint(tv.tv_usec, ==, 456);
-
-	g_byte_array_unref(trace);
-}
-
-static void test_pklg_rejects_short_length(void)
-{
-	GByteArray *trace = g_byte_array_new();
-	struct test_pklg_pkt pkt;
-	const uint8_t padding[] = { 0x00, 0x00, 0x00 };
-	struct timeval tv;
-	uint16_t size = 0;
-	uint16_t index = 0;
-	uint16_t opcode = 0;
-
-	pkt.len = htobe32(PKLG_PAYLOAD_OFFSET - 1);
-	pkt.ts = 0;
-	pkt.type = 0x01;
-
-	append_bytes(trace, &pkt, sizeof(pkt));
-	append_bytes(trace, padding, sizeof(padding));
-
-	g_assert_false(read_tmp_trace(trace->data, trace->len,
-					BTSNOOP_FLAG_PKLG_SUPPORT, 0, NULL,
-					&size, &index, &opcode, &tv));
-
-	g_byte_array_unref(trace);
-}
-
-static void test_pklg_rejects_small_capacity(void)
-{
-	GByteArray *trace = g_byte_array_new();
-	const uint8_t payload[] = { 0x01, 0x02, 0x03 };
-	uint8_t data[4] = { 0xa5, 0xa5, 0xa5, 0xa5 };
-	struct timeval tv;
-	uint16_t size = 0;
-	uint16_t index = 0;
-	uint16_t opcode = 0;
-
-	append_pklg_packet(trace, false, sizeof(payload), 0, 0x01, payload,
-							sizeof(payload));
-
-	g_assert_false(read_tmp_trace(trace->data, trace->len,
-					BTSNOOP_FLAG_PKLG_SUPPORT, 2, data,
-					&size, &index, &opcode, &tv));
-	g_assert_cmpint(data[0], ==, 0xa5);
-	g_assert_cmpint(data[1], ==, 0xa5);
-	g_assert_cmpint(data[2], ==, 0xa5);
-	g_assert_cmpint(data[3], ==, 0xa5);
+	g_assert_false(read_tmp_trace(trace->data, trace->len, 0, 3, &result));
 
 	g_byte_array_unref(trace);
 }
 
-static void test_pklg_rejects_short_payload(void)
-{
-	GByteArray *trace = g_byte_array_new();
-	const uint8_t payload[] = { 0x01, 0x02, 0x03 };
-	uint8_t data[4];
-	struct timeval tv;
-	uint16_t size = 0;
-	uint16_t index = 0;
-	uint16_t opcode = 0;
-
-	append_pklg_packet(trace, false, 4, 0, 0x01, payload,
-							sizeof(payload));
-
-	g_assert_false(read_tmp_trace(trace->data, trace->len,
-					BTSNOOP_FLAG_PKLG_SUPPORT, sizeof(data),
-					data, &size, &index, &opcode, &tv));
-
-	g_byte_array_unref(trace);
-}
-
-static void test_pklg_type_map(void)
-{
-	static const struct {
-		uint8_t type;
-		uint16_t index;
-		uint16_t opcode;
-	} cases[] = {
-		{ 0x02, 0x0000, BTSNOOP_OPCODE_ACL_TX_PKT },
-		{ 0x03, 0x0000, BTSNOOP_OPCODE_ACL_RX_PKT },
-		{ 0x08, 0x0000, BTSNOOP_OPCODE_SCO_TX_PKT },
-		{ 0x09, 0x0000, BTSNOOP_OPCODE_SCO_RX_PKT },
-		{ 0x12, 0x0000, BTSNOOP_OPCODE_ISO_TX_PKT },
-		{ 0x13, 0x0000, BTSNOOP_OPCODE_ISO_RX_PKT },
-		{ 0x0b, 0x0000, BTSNOOP_OPCODE_VENDOR_DIAG },
-		{ 0xfc, 0xffff, BTSNOOP_OPCODE_SYSTEM_NOTE },
-		{ 0xaa, 0xffff, 0xffff },
-	};
-	const uint8_t payload[] = { 0x00, 0x01, 0x02 };
-	unsigned int i;
-
-	for (i = 0; i < G_N_ELEMENTS(cases); i++) {
-		GByteArray *trace = g_byte_array_new();
-		uint8_t data[sizeof(payload)];
-		struct timeval tv;
-		uint16_t size = 0;
-		uint16_t index = 0;
-		uint16_t opcode = 0;
-
-		append_pklg_packet(trace, false, sizeof(payload), 0,
-						cases[i].type, payload,
-						sizeof(payload));
-
-		g_assert_true(read_tmp_trace(trace->data, trace->len,
-						BTSNOOP_FLAG_PKLG_SUPPORT,
-						sizeof(data), data, &size,
-						&index, &opcode, &tv));
-		g_assert_cmpint(index, ==, cases[i].index);
-		g_assert_cmpint(opcode, ==, cases[i].opcode);
-		g_byte_array_unref(trace);
-	}
-}
-
 static void test_btsnoop_truncation_fuzz(void)
 {
 	GByteArray *trace = g_byte_array_new();
@@ -710,40 +497,10 @@ static void test_btsnoop_truncation_fuzz(void)
 			BTSNOOP_EPOCH_OFFSET, payload, sizeof(payload));
 
 	for (len = 0; len < trace->len; len++) {
-		uint8_t data[sizeof(payload)];
-		struct timeval tv;
-		uint16_t size = 0;
-		uint16_t index = 0;
-		uint16_t opcode = 0;
+		struct read_result result;
 
 		g_assert_false(read_tmp_trace(trace->data, len, 0,
-						sizeof(data), data, &size,
-						&index, &opcode, &tv));
-	}
-
-	g_byte_array_unref(trace);
-}
-
-static void test_pklg_truncation_fuzz(void)
-{
-	GByteArray *trace = g_byte_array_new();
-	const uint8_t payload[] = { 0x01, 0x02, 0x03 };
-	size_t len;
-
-	append_pklg_packet(trace, false, sizeof(payload), 0, 0x01, payload,
-							sizeof(payload));
-
-	for (len = 0; len < trace->len; len++) {
-		uint8_t data[sizeof(payload)];
-		struct timeval tv;
-		uint16_t size = 0;
-		uint16_t index = 0;
-		uint16_t opcode = 0;
-
-		g_assert_false(read_tmp_trace(trace->data, len,
-						BTSNOOP_FLAG_PKLG_SUPPORT,
-						sizeof(data), data, &size,
-						&index, &opcode, &tv));
+						sizeof(payload), &result));
 	}
 
 	g_byte_array_unref(trace);
@@ -778,17 +535,10 @@ int main(int argc, char *argv[])
 			test_btsnoop_rejects_uart_short_type);
 	g_test_add_func("/btsnoop/payload/short",
 			test_btsnoop_rejects_short_payload);
-	g_test_add_func("/pklg/big-endian/valid", test_pklg_big_endian_valid);
-	g_test_add_func("/pklg/little-endian/valid",
-			test_pklg_little_endian_valid);
-	g_test_add_func("/pklg/length/short", test_pklg_rejects_short_length);
-	g_test_add_func("/pklg/capacity/reject",
-			test_pklg_rejects_small_capacity);
-	g_test_add_func("/pklg/payload/short", test_pklg_rejects_short_payload);
-	g_test_add_func("/pklg/type-map", test_pklg_type_map);
 	g_test_add_func("/btsnoop/fuzz/truncation",
 			test_btsnoop_truncation_fuzz);
-	g_test_add_func("/pklg/fuzz/truncation", test_pklg_truncation_fuzz);
+
+	add_pklg_tests();
 
 	return g_test_run();
 }
-- 
2.43.0

