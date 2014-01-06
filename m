Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] tools/rfcomm-tester: Initial version of rfcomm-tester
Date: Mon,  6 Jan 2014 19:42:38 +0100
Message-Id: <1389033760-16764-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add rfcomm-tester to tree.
---
 .gitignore            |  1 +
 Makefile.tools        |  6 +++++-
 tools/rfcomm-tester.c | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 tools/rfcomm-tester.c

diff --git a/.gitignore b/.gitignore
index 3e0641d..4ac216d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -81,6 +81,7 @@ unit/test-mgmt
 tools/mgmt-tester
 tools/smp-tester
 tools/gap-tester
+tools/rfcomm-tester
 tools/btattach
 tools/btmgmt
 tools/btsnoop
diff --git a/Makefile.tools b/Makefile.tools
index 1f61d15..ec3c71b 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -36,7 +36,7 @@ if EXPERIMENTAL
 noinst_PROGRAMS += emulator/btvirt emulator/b1ee tools/3dsp \
 					tools/mgmt-tester tools/gap-tester \
 					tools/l2cap-tester tools/sco-tester \
-					tools/smp-tester
+					tools/smp-tester tools/rfcomm-tester
 
 emulator_btvirt_SOURCES = emulator/main.c monitor/bt.h \
 					monitor/mainloop.h monitor/mainloop.c \
@@ -73,6 +73,10 @@ tools_l2cap_tester_SOURCES = tools/l2cap-tester.c monitor/bt.h \
 				src/shared/tester.h src/shared/tester.c
 tools_l2cap_tester_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
+tools_rfcomm_tester_SOURCES = tools/rfcomm-tester.c src/shared/tester.h \
+				src/shared/tester.c
+tools_rfcomm_tester_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+
 tools_smp_tester_SOURCES = tools/smp-tester.c monitor/bt.h \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
new file mode 100644
index 0000000..194e2e6
--- /dev/null
+++ b/tools/rfcomm-tester.c
@@ -0,0 +1,36 @@
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <glib.h>
+#include "src/shared/tester.h"
+
+int main(int argc, char *argv[])
+{
+	tester_init(&argc, &argv);
+
+	return tester_run();
+}
-- 
1.8.3.1

