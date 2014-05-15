Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 3/3] unit: Add test case for AES-CMAC-128
Date: Thu, 15 May 2014 08:15:32 +0200
Message-Id: <1400134532-26574-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1400134532-26574-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400134532-26574-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Test vectors taken from the NIST Special Publication 800-38B
(http://csrc.nist.gov/publications/PubsSPs.html)
---
 .gitignore         |   1 +
 Makefile.am        |   7 ++-
 unit/test-crypto.c | 172 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 179 insertions(+), 1 deletion(-)
 create mode 100644 unit/test-crypto.c

diff --git a/.gitignore b/.gitignore
index 803758b..bf66a5d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -87,6 +87,7 @@ unit/test-sdp
 unit/test-lib
 unit/test-mgmt
 unit/test-hfp
+unit/test-crypto
 tools/mgmt-tester
 tools/smp-tester
 tools/gap-tester
diff --git a/Makefile.am b/Makefile.am
index f96c700..35e0306 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -226,7 +226,8 @@ AM_CFLAGS += @DBUS_CFLAGS@ @GLIB_CFLAGS@
 AM_CPPFLAGS = -I$(builddir)/lib -I$(srcdir)/gdbus
 
 
-unit_tests += unit/test-eir unit/test-uuid unit/test-textfile unit/test-crc
+unit_tests += unit/test-eir unit/test-uuid unit/test-textfile unit/test-crc \
+							 unit/test-crypto
 
 unit_test_eir_SOURCES = unit/test-eir.c src/eir.c src/uuid-helper.c
 unit_test_eir_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
@@ -240,6 +241,10 @@ unit_test_textfile_LDADD = @GLIB_LIBS@
 unit_test_crc_SOURCES = unit/test-crc.c monitor/crc.h monitor/crc.c
 unit_test_crc_LDADD = @GLIB_LIBS@
 
+unit_test_crypto_SOURCES = unit/test-crypto.c \
+				src/shared/crypto.h src/shared/crypto.c
+unit_test_crypto_LDADD = @GLIB_LIBS@
+
 unit_tests += unit/test-ringbuf unit/test-queue
 
 unit_test_ringbuf_SOURCES = unit/test-ringbuf.c \
diff --git a/unit/test-crypto.c b/unit/test-crypto.c
new file mode 100644
index 0000000..8b44f4e
--- /dev/null
+++ b/unit/test-crypto.c
@@ -0,0 +1,172 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  Intel Corporation
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include "src/shared/crypto.h"
+
+#include <string.h>
+#include <glib.h>
+
+static struct bt_crypto *crypto;
+
+struct test_data {
+	const uint8_t *msg;
+	uint16_t msg_len;
+	const uint8_t *t;
+};
+
+static const uint8_t key[] = {
+	0x3c, 0x4f, 0xcf, 0x09, 0x88, 0x15, 0xf7, 0xab, 0xa6, 0xd2, 0xae, 0x28,
+	0x16, 0x15, 0x7e, 0x2b
+};
+
+static const uint8_t msg_1[] = { 0x00 };
+
+static const uint8_t t_msg_1[] = {
+	0x12, 0x7d, 0xa3, 0x7f, 0x28, 0x37, 0x59, 0xe9, 0x29, 0x69, 0x1d, 0xbb
+};
+
+static const struct test_data test_data_1 = {
+	.msg = msg_1,
+	.msg_len = 0,
+	.t = t_msg_1
+};
+
+static const uint8_t msg_2[] = {
+	0x6b, 0xc1, 0xbe, 0xe2, 0x2e, 0x40, 0x9f, 0x96, 0xe9, 0x3d, 0x7e, 0x11,
+	0x73, 0x93, 0x17, 0x2a
+
+};
+
+static const uint8_t t_msg_2[] = {
+	0x9d, 0xdd, 0x9b, 0xf7, 0x44, 0x41, 0x4d, 0x6b, 0xb4, 0x16, 0x0a, 0x07
+};
+
+static const struct test_data test_data_2 = {
+	.msg = msg_2,
+	.msg_len = 16,
+	.t = t_msg_2
+};
+
+static const uint8_t msg_3[] = {
+	0x6b, 0xc1, 0xbe, 0xe2, 0x2e, 0x40, 0x9f, 0x96, 0xe9, 0x3d, 0x7e, 0x11,
+	0x73, 0x93, 0x17, 0x2a, 0xae, 0x2d, 0x8a, 0x57, 0x1e, 0x03, 0xac, 0x9c,
+	0x9e, 0xb7, 0x6f, 0xac, 0x45, 0xaf, 0x8e, 0x51, 0x30, 0xc8, 0x1c, 0x46,
+	0xa3, 0x5c, 0xe4, 0x11
+};
+
+static const uint8_t t_msg_3[12] = {
+	0x61, 0x32, 0xca, 0x30, 0x30, 0xe6, 0x9a, 0xde, 0x47, 0x67, 0xa6, 0xdf
+};
+
+static const struct test_data test_data_3 = {
+	.msg = msg_3,
+	.msg_len = 40,
+	.t = t_msg_3
+};
+
+static const uint8_t msg_4[] = {
+	0x6b, 0xc1, 0xbe, 0xe2, 0x2e, 0x40, 0x9f, 0x96, 0xe9, 0x3d, 0x7e, 0x11,
+	0x73, 0x93, 0x17, 0x2a, 0xae, 0x2d, 0x8a, 0x57, 0x1e, 0x03, 0xac, 0x9c,
+	0x9e, 0xb7, 0x6f, 0xac, 0x45, 0xaf, 0x8e, 0x51, 0x30, 0xc8, 0x1c, 0x46,
+	0xa3, 0x5c, 0xe4, 0x11, 0xe5, 0xfb, 0xc1, 0x19, 0x1a, 0x0a, 0x52, 0xef,
+	0xf6, 0x9f, 0x24, 0x45, 0xdf, 0x4f, 0x9b, 0x17, 0xad, 0x2b, 0x41, 0x7b,
+	0xe6, 0x6c, 0x37, 0x10
+};
+
+static const uint8_t t_msg_4[12] = {
+	0x17, 0x74, 0x49, 0xfc, 0x92, 0x9d, 0x3b, 0x7e, 0xbf, 0xbe, 0xf0, 0x51
+};
+
+static const struct test_data test_data_4 = {
+	.msg = msg_4,
+	.msg_len = 64,
+	.t = t_msg_4
+};
+
+static void test_start(void)
+{
+	crypto = bt_crypto_new();
+	g_assert(crypto);
+}
+
+static void print_buf(const uint8_t *t, uint8_t len)
+{
+	int i;
+
+	for (i = 0; i < len; i++)
+		g_print("0x%02x, ", t[i]);
+
+	g_print("\n");
+}
+
+static bool result_compare(const uint8_t exp[12], uint8_t res[12])
+{
+	int i;
+	for (i = 0; i < 12; i++)
+		if (exp[i] != res[i])
+			return false;
+
+	return true;
+}
+
+static void test_sign(gconstpointer data)
+{
+	uint8_t t[12];
+	const struct test_data *d = data;
+
+	memset(t, 0, 12);
+	if (!bt_crypto_sign_att(crypto, key, d->msg, d->msg_len, t))
+		g_assert(true);
+
+	if (g_test_verbose()) {
+		g_print("Result T: ");
+		print_buf(t, 12);
+		g_print("Expected T:");
+		print_buf(d->t, 12);
+	}
+
+	g_assert(result_compare(d->t, t));
+}
+
+static void test_stop(void)
+{
+	bt_crypto_unref(crypto);
+}
+
+int main(int argc, char *argv[])
+{
+	g_test_init(&argc, &argv, NULL);
+
+	g_test_add_func("/crypto/start", test_start);
+	g_test_add_data_func("/crypto/sign_att_1", &test_data_1, test_sign);
+	g_test_add_data_func("/crypto/sign_att_2", &test_data_2, test_sign);
+	g_test_add_data_func("/crypto/sign_att_3", &test_data_3, test_sign);
+	g_test_add_data_func("/crypto/sign_att_4", &test_data_4, test_sign);
+	g_test_add_func("/crypto/stop", test_stop);
+
+	return g_test_run();
+}
-- 
1.8.4

