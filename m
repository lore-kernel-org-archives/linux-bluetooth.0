Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <radoslawjablonski@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <radoslawjablonski@gmail.com>
Subject: [PATCH Bluez 1/7] Add skeleton for unit tests for lib/sdp
Date: Wed,  8 Feb 2012 12:40:49 +0100
Message-Id: <1328701255-24245-2-git-send-email-radoslawjablonski@gmail.com>
In-Reply-To: <1328701255-24245-1-git-send-email-radoslawjablonski@gmail.com>
References: <1328701255-24245-1-git-send-email-radoslawjablonski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds dummy test-sdp.c file with skeleton
for unit tests for lib/sdp.c
---
 Makefile.am     |    7 ++++++-
 unit/test-sdp.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 1 deletions(-)
 create mode 100644 unit/test-sdp.c

diff --git a/Makefile.am b/Makefile.am
index 102ee62..1764cfb 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -446,7 +446,7 @@ endif
 unit_objects =
 
 if TEST
-unit_tests = unit/test-eir
+unit_tests = unit/test-eir unit/test-sdp
 
 noinst_PROGRAMS += $(unit_tests)
 
@@ -454,6 +454,11 @@ unit_test_eir_SOURCES = unit/test-eir.c src/eir.c src/glib-helper.c
 unit_test_eir_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@ @CHECK_LIBS@
 unit_test_eir_CFLAGS = $(AM_CFLAGS) @CHECK_CFLAGS@
 unit_objects += $(unit_test_eir_OBJECTS)
+
+unit_test_sdp_SOURCES = unit/test-sdp.c
+unit_test_sdp_LDADD = lib/libbluetooth.la @GLIB_LIBS@ @CHECK_LIBS@
+unit_test_sdp_CFLAGS = $(AM_CFLAGS) @CHECK_CFLAGS@
+unit_objects += $(unit_test_sdp_OBJECTS)
 else
 unit_tests =
 endif
diff --git a/unit/test-sdp.c b/unit/test-sdp.c
new file mode 100644
index 0000000..ea2521b
--- /dev/null
+++ b/unit/test-sdp.c
@@ -0,0 +1,55 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Nokia Corporation
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
+#include <check.h>
+#include <stdint.h>
+#include <glib.h>
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+#include <bluetooth/sdp.h>
+
+int main(int argc, char *argv[])
+{
+	int fails;
+	SRunner *sr;
+	Suite *s;
+
+	s = suite_create("SDP");
+
+	sr = srunner_create(s);
+
+	srunner_run_all(sr, CK_NORMAL);
+
+	fails = srunner_ntests_failed(sr);
+
+	srunner_free(sr);
+
+	if (fails > 0)
+		return -1;
+
+	return 0;
+}
-- 
1.7.0.4

