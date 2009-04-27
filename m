Return-Path: <cyrus@holtmann.org>
From: Alok Barsode <alokbarsode@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 1/8] Initialing HCI raw socket plugin "hciops".
Date: Mon, 27 Apr 2009 19:45:38 +0530
Message-Id: <1240841745-11006-1-git-send-email-alok.barsode@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 plugins/Makefile.am |    6 +++++-
 plugins/hciops.c    |   43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletions(-)
 create mode 100644 plugins/hciops.c

diff --git a/plugins/Makefile.am b/plugins/Makefile.am
index a1e933f..bbabf64 100644
--- a/plugins/Makefile.am
+++ b/plugins/Makefile.am
@@ -13,7 +13,7 @@ else
 service_plugins =
 endif
 
-plugin_LTLIBRARIES = hal.la $(netlink_plugins) $(service_plugins)
+plugin_LTLIBRARIES = hal.la hciops.la $(netlink_plugins) $(service_plugins)
 
 noinst_LTLIBRARIES = echo.la storage.la
 
@@ -21,6 +21,8 @@ echo_la_SOURCES = echo.c
 
 storage_la_SOURCES = storage.c
 
+hciops_la_SOURCES = hciops.c
+
 if NETLINK
 netlink_la_SOURCES = netlink.c
 
@@ -47,6 +49,7 @@ all-local:
 	@$(LN_S) -f $(top_srcdir)/network/.libs/network.so
 	@$(LN_S) -f .libs/service.so
 	@$(LN_S) -f .libs/hal.so
+	@$(LN_S) -f .libs/hciops.so
 
 clean-local:
 	@rm -f hal.so
@@ -55,3 +58,4 @@ clean-local:
 	@rm -f serial.so
 	@rm -f audio.so
 	@rm -f input.so
+	@rm -f hciops.so
diff --git a/plugins/hciops.c b/plugins/hciops.c
new file mode 100644
index 0000000..4f56443
--- /dev/null
+++ b/plugins/hciops.c
@@ -0,0 +1,43 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2009	     Alok Barsode <alok.barsode@azingo.com>
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
+#include <bluetooth/bluetooth.h>
+
+#include "plugin.h"
+#include "logging.h"
+
+static int hciops_init(void)
+{
+	return 0;
+}
+
+static void hciops_exit(void)
+{
+}
+
+BLUETOOTH_PLUGIN_DEFINE(hciops, VERSION,
+			BLUETOOTH_PLUGIN_PRIORITY_DEFAULT, hciops_init, hciops_exit)
-- 
1.5.6.3
