Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [PATCH obexd] Fix encoding of empty unicode headers
Date: Sun, 14 Aug 2011 15:16:25 +0200
Message-Id: <1313327785-7767-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to IrOBEX:
"An empty Name header is defined as a Name header
of length 3 (one byte opcode + two byte length)."

The current code encodes an empty header with 5 bytes,
including two bytes of null-terminator.

This patch assumes that this definition of emptyness
applies to all unicode headers, not just the name header.
---
 gobex/gobex-header.c     |   11 ++++++++-
 unit/test-gobex-header.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletions(-)

diff --git a/gobex/gobex-header.c b/gobex/gobex-header.c
index d4351cb..9096f44 100644
--- a/gobex/gobex-header.c
+++ b/gobex/gobex-header.c
@@ -157,6 +157,15 @@ GObexHeader *g_obex_header_decode(const void *data, gsize len,
 		}
 		ptr = get_bytes(&hdr_len, ptr, sizeof(hdr_len));
 		hdr_len = g_ntohs(hdr_len);
+
+		if (hdr_len == 3) {
+			header->v.string = g_strdup("");
+			header->vlen = 0;
+			header->hlen = hdr_len;
+			*parsed = hdr_len;
+			break;
+		}
+
 		if (hdr_len > len || hdr_len < 5) {
 			g_set_error(err, G_OBEX_ERROR,
 				G_OBEX_ERROR_PARSE_ERROR,
@@ -331,7 +340,7 @@ GObexHeader *g_obex_header_new_unicode(guint8 id, const char *str)
 	len = g_utf8_strlen(str, -1);
 
 	header->vlen = len;
-	header->hlen = 3 + ((len + 1) * 2);
+	header->hlen = len == 0 ? 3 : 3 + ((len + 1) * 2);
 	header->v.string = g_strdup(str);
 
 	return header;
diff --git a/unit/test-gobex-header.c b/unit/test-gobex-header.c
index f67b3a8..93da949 100644
--- a/unit/test-gobex-header.c
+++ b/unit/test-gobex-header.c
@@ -27,6 +27,7 @@
 #include "util.h"
 
 static uint8_t hdr_connid[] = { G_OBEX_HDR_CONNECTION, 1, 2, 3, 4 };
+static uint8_t hdr_name_empty[] = { G_OBEX_HDR_NAME, 0x00, 0x03 };
 static uint8_t hdr_name_ascii[] = { G_OBEX_HDR_NAME, 0x00, 0x0b,
 				0x00, 'f', 0x00, 'o', 0x00, 'o',
 				0x00, 0x00 };
@@ -46,6 +47,23 @@ static uint8_t hdr_bytes_nval_short[] = { G_OBEX_HDR_BODY, 0xab, 0xcd,
 						0x01, 0x02, 0x03 };
 static uint8_t hdr_bytes_nval_data[] = { G_OBEX_HDR_BODY, 0xab };
 
+static void test_header_name_empty(void)
+{
+	GObexHeader *header;
+	uint8_t buf[1024];
+	size_t len;
+
+	header = g_obex_header_new_unicode(G_OBEX_HDR_NAME, "");
+
+	g_assert(header != NULL);
+
+	len = g_obex_header_encode(header, buf, sizeof(buf));
+
+	assert_memequal(hdr_name_empty, sizeof(hdr_name_empty), buf, len);
+
+	g_obex_header_free(header);
+}
+
 static void test_header_name_ascii(void)
 {
 	GObexHeader *header;
@@ -194,6 +212,22 @@ static void test_header_encode_name_umlaut(void)
 	g_obex_header_free(header);
 }
 
+static void test_header_encode_name_empty(void)
+{
+	GObexHeader *header;
+	const char *str;
+	gboolean ret;
+
+	header = parse_and_encode(hdr_name_empty, sizeof(hdr_name_empty));
+
+	ret = g_obex_header_get_unicode(header, &str);
+
+	g_assert(ret == TRUE);
+	g_assert_cmpstr(str, ==, "");
+
+	g_obex_header_free(header);
+}
+
 static void test_header_encode_body(void)
 {
 	GObexHeader *header;
@@ -258,6 +292,21 @@ static void test_decode_header_name_ascii(void)
 	g_obex_header_free(header);
 }
 
+static void test_decode_header_name_empty(void)
+{
+	GObexHeader *header;
+	size_t parsed;
+	GError *err = NULL;
+
+	header = g_obex_header_decode(hdr_name_empty, sizeof(hdr_name_empty),
+					G_OBEX_DATA_REF, &parsed, &err);
+	g_assert_no_error(err);
+
+	g_assert_cmpuint(parsed, ==, sizeof(hdr_name_empty));
+
+	g_obex_header_free(header);
+}
+
 static void test_decode_header_name_umlaut(void)
 {
 	GObexHeader *header;
@@ -412,6 +461,8 @@ int main(int argc, char *argv[])
 
 	g_test_add_func("/gobex/test_decode_header_connid",
 						test_decode_header_connid);
+	g_test_add_func("/gobex/test_decode_header_name_empty",
+					test_decode_header_name_empty);
 	g_test_add_func("/gobex/test_decode_header_name_ascii",
 					test_decode_header_name_ascii);
 	g_test_add_func("/gobex/test_decode_header_name_umlaut",
@@ -438,6 +489,8 @@ int main(int argc, char *argv[])
 
 	g_test_add_func("/gobex/test_header_encode_connid",
 						test_header_encode_connid);
+	g_test_add_func("/gobex/test_header_encode_name_empty",
+					test_header_encode_name_empty);
 	g_test_add_func("/gobex/test_header_encode_name_ascii",
 					test_header_encode_name_ascii);
 	g_test_add_func("/gobex/test_header_encode_name_umlaut",
@@ -447,6 +500,8 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gobex/test_header_encode_connid",
 						test_header_encode_actionid);
 
+	g_test_add_func("/gobex/test_header_name_empty",
+						test_header_name_empty);
 	g_test_add_func("/gobex/test_header_name_ascii",
 						test_header_name_ascii);
 	g_test_add_func("/gobex/test_header_name_umlaut",
-- 
1.7.4.1

