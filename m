Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v1 1/8] scan: Add plugin skeleton
Date: Mon,  3 Sep 2012 15:12:38 -0300
Message-Id: <1346695965-25422-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1346695965-25422-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345664723-30814-1-git-send-email-claudio.takahasi@openbossa.org>
 <1346695965-25422-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the Makefile changes and plugin declaration to support
Scan Parameters service. BlueZ will act as Scan Client writting to a Scan
Server the scanning parameters.
---
 Makefile.am               |  5 +++--
 profiles/scanparam/main.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 2 deletions(-)
 create mode 100644 profiles/scanparam/main.c

diff --git a/Makefile.am b/Makefile.am
index 4977a05..161586e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -212,7 +212,7 @@ endif
 
 if GATTMODULES
 builtin_modules += thermometer alert time gatt_example proximity deviceinfo \
-			gatt
+			gatt scanparam
 builtin_sources += profiles/thermometer/main.c \
 			profiles/thermometer/manager.h \
 			profiles/thermometer/manager.c \
@@ -241,7 +241,8 @@ builtin_sources += profiles/thermometer/main.c \
 			profiles/deviceinfo/deviceinfo.c \
 			profiles/gatt/main.c profiles/gatt/manager.h \
 			profiles/gatt/manager.c profiles/gatt/gas.h \
-			profiles/gatt/gas.c
+			profiles/gatt/gas.c \
+			profiles/scanparam/main.c
 endif
 
 builtin_modules += formfactor
diff --git a/profiles/scanparam/main.c b/profiles/scanparam/main.c
new file mode 100644
index 0000000..6e90929
--- /dev/null
+++ b/profiles/scanparam/main.c
@@ -0,0 +1,53 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Nordic Semiconductor Inc.
+ *  Copyright (C) 2012  Instituto Nokia de Tecnologia - INdT
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
+#include <errno.h>
+#include <stdint.h>
+#include <glib.h>
+
+#include "log.h"
+#include "plugin.h"
+#include "hcid.h"
+
+static int scan_param_init(void)
+{
+	if (!main_opts.gatt_enabled) {
+		DBG("Scan Parameters: GATT is disabled");
+		return -ENOTSUP;
+	}
+
+	return 0;
+}
+
+static void scan_param_exit(void)
+{
+}
+
+BLUETOOTH_PLUGIN_DEFINE(scanparam, VERSION,
+			BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+			scan_param_init, scan_param_exit)
-- 
1.7.12

