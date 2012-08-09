Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/9] gobex: Add unit tests for GObexApparam API
Date: Thu,  9 Aug 2012 13:32:26 +0300
Message-Id: <1344508353-24647-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1344508353-24647-1-git-send-email-luiz.dentz@gmail.com>
References: <1344508353-24647-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 Makefile.am               |  11 +-
 unit/test-gobex-apparam.c | 422 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 430 insertions(+), 3 deletions(-)
 create mode 100644 unit/test-gobex-apparam.c

diff --git a/Makefile.am b/Makefile.am
index a1b4da0..4757f60 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -166,11 +166,12 @@ plugins/phonebook.c: plugins/@PHONEBOOK_DRIVER@
 plugins/messages.c: plugins/@MESSAGES_DRIVER@
 	$(AM_V_GEN)$(LN_S) @abs_top_srcdir@/$< $@
 
-TESTS = unit/test-gobex-header unit/test-gobex-packet unit/test-gobex \
-						unit/test-gobex-transfer
+TESTS = unit/test-gobex-apparam unit/test-gobex-header unit/test-gobex-packet \
+				unit/test-gobex unit/test-gobex-transfer
 
 noinst_PROGRAMS += unit/test-gobex-header unit/test-gobex-packet \
-				unit/test-gobex unit/test-gobex-transfer
+			unit/test-gobex unit/test-gobex-transfer \
+			unit/test-gobex-apparam
 
 unit_test_gobex_SOURCES = $(gobex_sources) unit/test-gobex.c \
 							unit/util.c unit/util.h
@@ -188,6 +189,10 @@ unit_test_gobex_transfer_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
 						unit/test-gobex-transfer.c
 unit_test_gobex_transfer_LDADD = @GLIB_LIBS@
 
+unit_test_gobex_apparam_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
+						unit/test-gobex-apparam.c
+unit_test_gobex_apparam_LDADD = @GLIB_LIBS@
+
 if READLINE
 noinst_PROGRAMS += tools/test-client
 tools_test_client_SOURCES = $(gobex_sources) $(btio_sources) \
diff --git a/unit/test-gobex-apparam.c b/unit/test-gobex-apparam.c
new file mode 100644
index 0000000..573de99
--- /dev/null
+++ b/unit/test-gobex-apparam.c
@@ -0,0 +1,422 @@
+/*
+ *
+ *  OBEX library with GLib integration
+ *
+ *  Copyright (C) 2012  Intel Corporation.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <stdint.h>
+#include <string.h>
+
+#include <gobex/gobex-apparam.h>
+
+#include "util.h"
+
+#define TAG_U8 0x00
+#define TAG_U16 0x01
+#define TAG_U32 0x02
+#define TAG_U64 0x03
+#define TAG_STRING 0x04
+#define TAG_BYTES 0x05
+
+static uint8_t tag_nval_short[] = { TAG_U8 };
+static uint8_t tag_nval_data[] = { TAG_U8, 0x01 };
+static uint8_t tag_nval2_short[] = { TAG_U8, 0x01, 0x1, TAG_U16 };
+static uint8_t tag_nval2_data[] = { TAG_U8, 0x01, 0x1, TAG_U16, 0x02 };
+static uint8_t tag_uint8[] = { TAG_U8, 0x01, 0x01 };
+static uint8_t tag_uint16[] = { TAG_U16, 0x02, 0x01, 0x02 };
+static uint8_t tag_uint32[] = { TAG_U32, 0x04, 0x01, 0x02, 0x03, 0x04 };
+static uint8_t tag_uint64[] = { TAG_U64, 0x08, 0x01, 0x02, 0x03, 0x04,
+						0x05, 0x06, 0x07, 0x08 };
+static uint8_t tag_string[] = { TAG_STRING, 0x04, 'A', 'B', 'C', '\0' };
+static uint8_t tag_bytes[257] = { TAG_BYTES, 0xFF };
+static uint8_t tag_multi[] = { TAG_U8, 0x01, 0x01,
+				TAG_U16, 0x02, 0x01, 0x02,
+				TAG_U32, 0x04, 0x01, 0x02, 0x03, 0x04,
+				TAG_U64, 0x08, 0x01, 0x02, 0x03, 0x04,
+						0x05, 0x06, 0x07, 0x08,
+				TAG_STRING, 0x04, 'A', 'B', 'C', '\0' };
+
+
+static GObexApparam *parse_and_decode(const void *data, gsize size)
+{
+	GObexApparam *apparam;
+	guint8 encoded[1024];
+	gsize len;
+
+	apparam = g_obex_apparam_decode(data, size);
+
+	g_assert(apparam != NULL);
+
+	len = g_obex_apparam_encode(apparam, encoded, sizeof(encoded));
+
+	assert_memequal(data, size, encoded, len);
+
+	return apparam;
+}
+
+static void test_apparam_nval_short(void)
+{
+	GObexApparam *apparam;
+
+	apparam = g_obex_apparam_decode(tag_nval_short,
+						sizeof(tag_nval_short));
+
+	g_assert(apparam == NULL);
+}
+
+static void test_apparam_nval_data(void)
+{
+	GObexApparam *apparam;
+
+	apparam = g_obex_apparam_decode(tag_nval_data,
+						sizeof(tag_nval_data));
+
+	g_assert(apparam == NULL);
+}
+
+static void test_apparam_nval2_short(void)
+{
+	GObexApparam *apparam;
+
+	apparam = g_obex_apparam_decode(tag_nval2_short,
+						sizeof(tag_nval2_short));
+
+	g_assert(apparam == NULL);
+}
+
+static void test_apparam_nval2_data(void)
+{
+	GObexApparam *apparam;
+
+	apparam = g_obex_apparam_decode(tag_nval2_data,
+						sizeof(tag_nval2_data));
+
+	g_assert(apparam == NULL);
+}
+
+static void test_apparam_get_uint8(void)
+{
+	GObexApparam *apparam;
+	guint8 data;
+	gboolean ret;
+
+	apparam = parse_and_decode(tag_uint8, sizeof(tag_uint8));
+
+	ret = g_obex_apparam_get_uint8(apparam, TAG_U8, &data);
+
+	g_assert(ret == TRUE);
+	g_assert(data == 0x01);
+
+	g_obex_apparam_free(apparam);
+}
+
+static void test_apparam_get_uint16(void)
+{
+	GObexApparam *apparam;
+	uint16_t data;
+	gboolean ret;
+
+	apparam = parse_and_decode(tag_uint16, sizeof(tag_uint16));
+
+	ret = g_obex_apparam_get_uint16(apparam, TAG_U16, &data);
+
+	g_assert(ret == TRUE);
+	g_assert(data == 0x0102);
+
+	g_obex_apparam_free(apparam);
+}
+
+static void test_apparam_get_uint32(void)
+{
+	GObexApparam *apparam;
+	uint32_t data;
+	gboolean ret;
+
+	apparam = parse_and_decode(tag_uint32, sizeof(tag_uint32));
+
+	ret = g_obex_apparam_get_uint32(apparam, TAG_U32, &data);
+
+	g_assert(ret == TRUE);
+	g_assert(data == 0x01020304);
+
+	g_obex_apparam_free(apparam);
+}
+
+static void test_apparam_get_uint64(void)
+{
+	GObexApparam *apparam;
+	uint64_t data;
+	gboolean ret;
+
+	apparam = parse_and_decode(tag_uint64, sizeof(tag_uint64));
+
+	ret = g_obex_apparam_get_uint64(apparam, TAG_U64, &data);
+
+	g_assert(ret == TRUE);
+	g_assert(data == 0x0102030405060708);
+
+	g_obex_apparam_free(apparam);
+}
+
+static void test_apparam_get_string(void)
+{
+	GObexApparam *apparam;
+	char *string;
+
+	apparam = parse_and_decode(tag_string, sizeof(tag_string));
+
+	string = g_obex_apparam_get_string(apparam, TAG_STRING);
+
+	g_assert(string != NULL);
+	g_assert_cmpstr(string, ==, "ABC");
+
+	g_free(string);
+	g_obex_apparam_free(apparam);
+}
+
+static void test_apparam_get_bytes(void)
+{
+	GObexApparam *apparam;
+	const uint8_t *data;
+	gsize len;
+	gboolean ret;
+
+	apparam = parse_and_decode(tag_bytes, sizeof(tag_bytes));
+
+	ret = g_obex_apparam_get_bytes(apparam, TAG_BYTES, &data, &len);
+
+	g_assert(ret == TRUE);
+	assert_memequal(tag_bytes + 2, sizeof(tag_bytes) - 2, data, len);
+
+	g_obex_apparam_free(apparam);
+}
+
+static void test_apparam_get_multi(void)
+{
+	GObexApparam *apparam;
+	char *string;
+	uint8_t data8;
+	uint16_t data16;
+	uint32_t data32;
+	uint64_t data64;
+	gboolean ret;
+
+	apparam = g_obex_apparam_decode(tag_multi, sizeof(tag_multi));
+
+	g_assert(apparam != NULL);
+
+	ret = g_obex_apparam_get_uint8(apparam, TAG_U8, &data8);
+
+	g_assert(ret == TRUE);
+	g_assert(data8 == 0x01);
+
+	ret = g_obex_apparam_get_uint16(apparam, TAG_U16, &data16);
+
+	g_assert(ret == TRUE);
+	g_assert(data16 == 0x0102);
+
+	ret = g_obex_apparam_get_uint32(apparam, TAG_U32, &data32);
+
+	g_assert(ret == TRUE);
+	g_assert(data32 == 0x01020304);
+
+	ret = g_obex_apparam_get_uint64(apparam, TAG_U64, &data64);
+
+	g_assert(ret == TRUE);
+	g_assert(data64 == 0x0102030405060708);
+
+	string = g_obex_apparam_get_string(apparam, TAG_STRING);
+
+	g_assert(string != NULL);
+	g_assert_cmpstr(string, ==, "ABC");
+
+	g_obex_apparam_free(apparam);
+}
+
+static void test_apparam_set_uint8(void)
+{
+	GObexApparam *apparam;
+	guint8 buf[1024];
+	gsize len;
+
+	apparam = g_obex_apparam_set_uint8(NULL, TAG_U8, 0x01);
+	g_assert(apparam != NULL);
+
+	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
+	assert_memequal(tag_uint8, sizeof(tag_uint8), buf, len);
+
+	g_obex_apparam_free(apparam);
+}
+
+static void test_apparam_set_uint16(void)
+{
+	GObexApparam *apparam;
+	guint8 buf[1024];
+	gsize len;
+
+	apparam = g_obex_apparam_set_uint16(NULL, TAG_U16, 0x0102);
+	g_assert(apparam != NULL);
+
+	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
+	assert_memequal(tag_uint16, sizeof(tag_uint16), buf, len);
+
+	g_obex_apparam_free(apparam);
+}
+
+static void test_apparam_set_uint32(void)
+{
+	GObexApparam *apparam;
+	guint8 buf[1024];
+	gsize len;
+
+	apparam = g_obex_apparam_set_uint32(NULL, TAG_U32, 0x01020304);
+	g_assert(apparam != NULL);
+
+	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
+	assert_memequal(tag_uint32, sizeof(tag_uint32), buf, len);
+
+	g_obex_apparam_free(apparam);
+}
+
+static void test_apparam_set_uint64(void)
+{
+	GObexApparam *apparam;
+	guint8 buf[1024];
+	gsize len;
+
+	apparam = g_obex_apparam_set_uint64(NULL, TAG_U64, 0x0102030405060708);
+	g_assert(apparam != NULL);
+
+	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
+	assert_memequal(tag_uint64, sizeof(tag_uint64), buf, len);
+
+	g_obex_apparam_free(apparam);
+}
+
+static void test_apparam_set_string(void)
+{
+	GObexApparam *apparam;
+	guint8 buf[1024];
+	gsize len;
+
+	apparam = g_obex_apparam_set_string(NULL, TAG_STRING, "ABC");
+	g_assert(apparam != NULL);
+
+	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
+	assert_memequal(tag_string, sizeof(tag_string), buf, len);
+
+	g_obex_apparam_free(apparam);
+}
+
+static void test_apparam_set_bytes(void)
+{
+	GObexApparam *apparam;
+	guint8 buf[1024];
+	gsize len;
+
+	apparam = g_obex_apparam_set_bytes(NULL, TAG_BYTES, tag_bytes + 2, 255);
+	g_assert(apparam != NULL);
+
+	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
+	assert_memequal(tag_bytes, sizeof(tag_bytes), buf, len);
+
+	g_obex_apparam_free(apparam);
+}
+
+static void test_apparam_set_multi(void)
+{
+	GObexApparam *apparam;
+	guint8 buf[1024];
+	gsize len;
+
+	apparam = g_obex_apparam_set_uint8(NULL, TAG_U8, 0x01);
+
+	g_assert(apparam != NULL);
+
+	apparam = g_obex_apparam_set_uint16(apparam, TAG_U16, 0x0102);
+
+	g_assert(apparam != NULL);
+
+	apparam = g_obex_apparam_set_uint32(apparam, TAG_U32, 0x01020304);
+
+	g_assert(apparam != NULL);
+
+	apparam = g_obex_apparam_set_uint64(apparam, TAG_U64,
+							0x0102030405060708);
+
+	g_assert(apparam != NULL);
+
+	apparam = g_obex_apparam_set_string(apparam, TAG_STRING, "ABC");
+
+	g_assert(apparam != NULL);
+
+	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
+
+	g_assert_cmpuint(len, ==, sizeof(tag_multi));
+
+	g_obex_apparam_free(apparam);
+}
+
+int main(int argc, char *argv[])
+{
+	g_test_init(&argc, &argv, NULL);
+
+	g_test_add_func("/gobex/test_apparam_nval_short",
+						test_apparam_nval_short);
+	g_test_add_func("/gobex/test_apparam_nval_data",
+						test_apparam_nval_data);
+
+	g_test_add_func("/gobex/test_apparam_nval2_short",
+						test_apparam_nval2_short);
+	g_test_add_func("/gobex/test_apparam_nval2_data",
+						test_apparam_nval2_data);
+
+	g_test_add_func("/gobex/test_apparam_get_uint8",
+						test_apparam_get_uint8);
+	g_test_add_func("/gobex/test_apparam_get_uint16",
+						test_apparam_get_uint16);
+	g_test_add_func("/gobex/test_apparam_get_uint32",
+						test_apparam_get_uint32);
+	g_test_add_func("/gobex/test_apparam_get_uint64",
+						test_apparam_get_uint64);
+	g_test_add_func("/gobex/test_apparam_get_string",
+						test_apparam_get_string);
+	g_test_add_func("/gobex/test_apparam_get_bytes",
+						test_apparam_get_bytes);
+	g_test_add_func("/gobex/test_apparam_get_multi",
+						test_apparam_get_multi);
+
+	g_test_add_func("/gobex/test_apparam_set_uint8",
+						test_apparam_set_uint8);
+	g_test_add_func("/gobex/test_apparam_set_uint16",
+						test_apparam_set_uint16);
+	g_test_add_func("/gobex/test_apparam_set_uint32",
+						test_apparam_set_uint32);
+	g_test_add_func("/gobex/test_apparam_set_uint64",
+						test_apparam_set_uint64);
+	g_test_add_func("/gobex/test_apparam_set_string",
+						test_apparam_set_string);
+	g_test_add_func("/gobex/test_apparam_set_bytes",
+						test_apparam_set_bytes);
+	g_test_add_func("/gobex/test_apparam_set_multi",
+						test_apparam_set_multi);
+
+	g_test_run();
+
+	return 0;
+}
-- 
1.7.11.2

