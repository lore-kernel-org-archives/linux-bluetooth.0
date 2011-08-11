Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<ulrik.lauren@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v3 1/2] Add external dummy plugin for testing
Date: Thu, 11 Aug 2011 15:10:15 +0200
Message-ID: <1313068216-16802-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1313068216-16802-1-git-send-email-szymon.janc@tieto.com>
References: <1313068216-16802-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am              |    7 +++++++
 plugins/external-dummy.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 0 deletions(-)
 create mode 100644 plugins/external-dummy.c

diff --git a/Makefile.am b/Makefile.am
index 68380d9..c370b55 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -258,6 +258,13 @@ builtin_modules += dbusoob
 builtin_sources += plugins/dbusoob.c
 endif
 
+if MAINTAINER_MODE
+plugin_LTLIBRARIES += plugins/external-dummy.la
+plugins_external_dummy_la_SOURCES = plugins/external-dummy.c
+plugins_external_dummy_la_LDFLAGS = -module -avoid-version -no-undefined
+plugins_external_dummy_la_CFLAGS = -fvisibility=hidden
+endif
+
 sbin_PROGRAMS += src/bluetoothd
 
 src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
diff --git a/plugins/external-dummy.c b/plugins/external-dummy.c
new file mode 100644
index 0000000..c6f5a36
--- /dev/null
+++ b/plugins/external-dummy.c
@@ -0,0 +1,42 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
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
+#include "plugin.h"
+#include "log.h"
+
+static int dummy_init(void)
+{
+	DBG("");
+
+	return 0;
+}
+
+static void dummy_exit(void)
+{
+	DBG("");
+}
+
+BLUETOOTH_PLUGIN_DEFINE(external_dummy, VERSION,
+		BLUETOOTH_PLUGIN_PRIORITY_LOW, dummy_init, dummy_exit)
+
-- 
on behalf of ST-Ericsson

