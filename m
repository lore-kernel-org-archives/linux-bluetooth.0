Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/22] unit: Add basic tests for the circular buffer implementation
Date: Mon, 14 Oct 2013 10:34:18 +0200
Message-Id: <1381739678-16260-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am         |    6 ++
 unit/test-cbuffer.c |  186 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 192 insertions(+)
 create mode 100644 unit/test-cbuffer.c

diff --git a/Makefile.am b/Makefile.am
index 51204f4..079405f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -283,6 +283,12 @@ unit_tests += unit/test-lib
 unit_test_lib_SOURCES = unit/test-lib.c
 unit_test_lib_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
+unit_tests += unit/test-cbuffer
+
+unit_test_cbuffer_SOURCES = unit/test-cbuffer.c \
+				src/shared/cbuffer.h src/shared/cbuffer.c
+unit_test_cbuffer_LDADD = @GLIB_LIBS@
+
 noinst_PROGRAMS += $(unit_tests)
 
 TESTS = $(unit_tests)
diff --git a/unit/test-cbuffer.c b/unit/test-cbuffer.c
new file mode 100644
index 0000000..4af73b8
--- /dev/null
+++ b/unit/test-cbuffer.c
@@ -0,0 +1,186 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Intel Corporation. All rights reserved.
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
+#include <stdio.h>
+#include <glib.h>
+#include "src/shared/cbuffer.h"
+
+#define BUFFER_SIZE 100
+
+struct cbt_fixture {
+	struct circular_buffer *cbuff;
+};
+
+static void cbt_fix_setup(struct cbt_fixture *fix, gconstpointer tdata)
+{
+	/* the best fitting size is being determined during buffer init */
+	fix->cbuff = cbuffer_init(BUFFER_SIZE);
+}
+
+static void cbt_fix_teardown(struct cbt_fixture *fix, gconstpointer tdata)
+{
+	cbuffer_free(fix->cbuff);
+}
+
+static void cbt_deinit(struct cbt_fixture *fix, gconstpointer test_data)
+{
+	cbuffer_free(fix->cbuff);
+
+	fix->cbuff = cbuffer_init(BUFFER_SIZE);
+	g_assert(fix->cbuff != NULL);
+}
+
+static void cbt_write(struct cbt_fixture *fix, gconstpointer test_data)
+{
+	int ret;
+
+	ret = cbuffer_write(fix->cbuff, 'a');
+	g_assert_cmpint(ret, >=, 0);
+
+	ret = cbuffer_write(fix->cbuff, 'b');
+	g_assert_cmpint(ret, >=, 0);
+}
+
+static void cbt_read_empty(struct cbt_fixture *fix, gconstpointer test_data)
+{
+	int ret;
+	char ch = 111;
+
+	ret = cbuffer_read(fix->cbuff, &ch);
+	g_assert_cmpint(ret, <, 0);
+	g_assert_cmpint(111, ==, ch);
+}
+
+static void cbt_read_write(struct cbt_fixture *fix, gconstpointer test_data)
+{
+	int res;
+	char ch = 111;
+
+	res = cbuffer_write(fix->cbuff, 'a');
+	g_assert_cmpint(res, >=, 0);
+	res = cbuffer_read(fix->cbuff, &ch);
+	g_assert_cmpint(res, >=, 0);
+	g_assert_cmpint('a', ==, ch);
+	res = cbuffer_read(fix->cbuff, &ch);
+	g_assert_cmpint(res, <, 0);
+
+	res = cbuffer_write(fix->cbuff, 'a');
+	g_assert_cmpint(res, >=, 0);
+	res = cbuffer_write(fix->cbuff, 'b');
+	g_assert_cmpint(res, >=, 0);
+	res = cbuffer_read(fix->cbuff, &ch);
+	g_assert_cmpint(res, >=, 0);
+	g_assert_cmpint('a', ==, ch);
+	res = cbuffer_read(fix->cbuff, &ch);
+	g_assert_cmpint(res, >=, 0);
+	g_assert_cmpint('b', ==, ch);
+	res = cbuffer_read(fix->cbuff, &ch);
+	g_assert_cmpint(res, <, 0);
+
+	res = cbuffer_write(fix->cbuff, 'a');
+	g_assert_cmpint(res, >=, 0);
+	res = cbuffer_write(fix->cbuff, 'b');
+	g_assert_cmpint(res, >=, 0);
+	res = cbuffer_write(fix->cbuff, 'c');
+	g_assert_cmpint(res, >=, 0);
+	res = cbuffer_read(fix->cbuff, &ch);
+	g_assert_cmpint(res, >=, 0);
+	res = cbuffer_read(fix->cbuff, &ch);
+	g_assert_cmpint(res, >=, 0);
+	res = cbuffer_read(fix->cbuff, &ch);
+	g_assert_cmpint(res, >=, 0);
+	g_assert_cmpint('c', ==, ch);
+	res = cbuffer_read(fix->cbuff, &ch);
+	g_assert_cmpint(res, <, 0);
+}
+
+static void cbt_overflow(struct cbt_fixture *fix, gconstpointer test_data)
+{
+	int res;
+	unsigned int i = 0;
+	char ch = 1;
+
+	for (i = 0; i < cbuffer_get_size(fix->cbuff); ++i) {
+		res = cbuffer_write(fix->cbuff, 'a');
+		g_assert_cmpint(res, >=, 0);
+	}
+
+	res = cbuffer_write(fix->cbuff, 'b');
+	g_assert_cmpint(res, <, 0);
+
+	res = cbuffer_read(fix->cbuff, &ch);
+	g_assert_cmpint(res, >=, 0);
+	g_assert_cmpint('a', ==, ch);
+
+	res = cbuffer_write(fix->cbuff, 'b');
+	g_assert_cmpint(res, >=, 0);
+
+	res = cbuffer_read(fix->cbuff, &ch);
+	g_assert_cmpint(res, >=, 0);
+	g_assert_cmpint('a', ==, ch);
+
+	res = cbuffer_read(fix->cbuff, &ch);
+	g_assert_cmpint(res, >=, 0);
+	g_assert_cmpint('a', ==, ch);
+}
+
+static void cbt_drain(struct cbt_fixture *fix, gconstpointer test_data)
+{
+	char ch = 1;
+
+	g_assert_cmpint(cbuffer_write(fix->cbuff, 'a'), >=, 0);
+	g_assert_cmpint(cbuffer_read(fix->cbuff, &ch), >=, 0);
+	g_assert_cmpint('a', ==, ch);
+	g_assert_cmpint(cbuffer_is_empty(fix->cbuff), >, 0);
+
+	g_assert_cmpint(cbuffer_write(fix->cbuff, 'a'),
+				>=, 0);
+	g_assert_cmpint(cbuffer_write(fix->cbuff, 'a'),
+				>=, 0);
+	g_assert_cmpint(cbuffer_write(fix->cbuff, 'a'),
+				>=, 0);
+	cbuffer_drain(fix->cbuff);
+	g_assert_cmpint(cbuffer_is_empty(fix->cbuff), >, 0);
+	ch = 1;
+	g_assert_cmpint(cbuffer_read(fix->cbuff, &ch), <, 0);
+	g_assert_cmpint(1, ==, ch);
+	g_assert_cmpint(cbuffer_is_empty(fix->cbuff), >, 0);
+}
+
+int main(int argc, char **argv)
+{
+	g_test_init(&argc, &argv, NULL);
+	g_test_add("/cbuffer/(de)initialization", struct cbt_fixture, 0,
+			cbt_fix_setup, cbt_deinit, cbt_fix_teardown);
+	g_test_add("/cbuffer/write", struct cbt_fixture, 0, cbt_fix_setup,
+			cbt_write, cbt_fix_teardown);
+	g_test_add("/cbuffer/read_empty", struct cbt_fixture, 0, cbt_fix_setup,
+			cbt_read_empty, cbt_fix_teardown);
+	g_test_add("/cbuffer/read_write", struct cbt_fixture, 0, cbt_fix_setup,
+			cbt_read_write, cbt_fix_teardown);
+	g_test_add("/cbuffer/overflow", struct cbt_fixture, 0, cbt_fix_setup,
+			cbt_overflow, cbt_fix_teardown);
+	g_test_add("/cbuffer/drain", struct cbt_fixture, 0, cbt_fix_setup,
+			cbt_drain, cbt_fix_teardown);
+	return g_test_run();
+}
-- 
1.7.9.5

