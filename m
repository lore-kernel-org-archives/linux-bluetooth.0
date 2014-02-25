Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/9] unit: Add hfp_at tester
Date: Tue, 25 Feb 2014 10:23:40 +0100
Message-Id: <1393320227-10931-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1393320227-10931-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393320227-10931-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will test hfp_at parser. Initial versione performs three test cases
with hfp_at_new() calls.
---
 .gitignore         |  1 +
 Makefile.am        |  8 ++++-
 unit/test-hfp-at.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 unit/test-hfp-at.c

diff --git a/.gitignore b/.gitignore
index 94c0c78..fa34348 100644
--- a/.gitignore
+++ b/.gitignore
@@ -84,6 +84,7 @@ unit/test-gdbus-client
 unit/test-sdp
 unit/test-lib
 unit/test-mgmt
+unit/test-hfp-at
 tools/mgmt-tester
 tools/smp-tester
 tools/gap-tester
diff --git a/Makefile.am b/Makefile.am
index 0c79e58..c886ba8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -225,7 +225,8 @@ AM_CFLAGS += @DBUS_CFLAGS@ @GLIB_CFLAGS@
 AM_CPPFLAGS = -I$(builddir)/lib -I$(srcdir)/gdbus
 
 
-unit_tests += unit/test-eir unit/test-uuid unit/test-textfile unit/test-crc
+unit_tests += unit/test-eir unit/test-uuid unit/test-textfile unit/test-crc \
+		unit/test-hfp-at
 
 unit_test_eir_SOURCES = unit/test-eir.c src/eir.c src/uuid-helper.c
 unit_test_eir_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
@@ -239,6 +240,11 @@ unit_test_textfile_LDADD = @GLIB_LIBS@
 unit_test_crc_SOURCES = unit/test-crc.c monitor/crc.h monitor/crc.c
 unit_test_crc_LDADD = @GLIB_LIBS@
 
+unit_test_hfp_at_SOURCES = unit/test-hfp-at.c \
+				src/shared/util.h src/shared/util.c \
+				src/shared/hfp_at.h src/shared/hfp_at.c
+unit_test_hfp_at_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+
 unit_tests += unit/test-ringbuf unit/test-queue
 
 unit_test_ringbuf_SOURCES = unit/test-ringbuf.c \
diff --git a/unit/test-hfp-at.c b/unit/test-hfp-at.c
new file mode 100644
index 0000000..4374a70
--- /dev/null
+++ b/unit/test-hfp-at.c
@@ -0,0 +1,95 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation
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
+#include <stdio.h>
+#include <glib.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include "src/shared/hfp_at.h"
+
+struct test_data {
+	const struct hfp_at_handler *handlers;
+};
+
+static void test_init(gconstpointer data)
+{
+	struct hfp_at *hfp_at;
+	const struct test_data *test_data = data;
+
+	hfp_at = hfp_at_new(test_data->handlers);
+	g_assert(hfp_at != NULL);
+
+	hfp_at_free(hfp_at);
+}
+
+static void process_generic(struct hfp_at *hfp_at, enum hfp_cmd_type type,
+						const char *at, void *user_data)
+{
+}
+
+const struct hfp_at_handler handlers_1[] = {};
+
+const struct hfp_at_handler handlers_2[] = {
+	{
+		.prefix = NULL,
+		.cb = process_generic
+	}
+};
+
+const struct hfp_at_handler handlers_3[] = {
+	{
+		.prefix = "+BRSF",
+		.cb = process_generic
+	},
+	{
+		.prefix = NULL,
+		.cb = process_generic
+	}
+};
+
+const struct test_data data_1 = {
+	.handlers = handlers_1,
+};
+
+const struct test_data data_2 = {
+	.handlers = handlers_2,
+};
+
+const struct test_data data_3 = {
+	.handlers = handlers_3,
+};
+
+int main(int argc, char *argv[])
+{
+	g_test_init(&argc, &argv, NULL);
+	/* Tests for hfp_at_new() */
+	g_test_add_data_func("/hfp_at/init_1", &data_1, test_init);
+	g_test_add_data_func("/hfp_at/init_2", &data_2, test_init);
+	g_test_add_data_func("/hfp_at/init_3", &data_3, test_init);
+
+	return g_test_run();
+}
-- 
1.8.5.3

