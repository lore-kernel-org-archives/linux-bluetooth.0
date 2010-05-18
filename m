Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org
Subject: [PATCH 4/4] Move logging.{c,h} to log.{c,h}
Date: Mon, 17 May 2010 23:27:18 -0300
Message-Id: <1274149638-31580-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1274149638-31580-3-git-send-email-gustavo@padovan.org>
References: <1274149638-31580-1-git-send-email-gustavo@padovan.org>
 <1274149638-31580-2-git-send-email-gustavo@padovan.org>
 <1274149638-31580-3-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Try to make log stuff more similar to ConnMan and oFono.
---
 Makefile.am              |    2 +-
 audio/a2dp.c             |    2 +-
 audio/avdtp.c            |    2 +-
 audio/control.c          |    2 +-
 audio/device.c           |    2 +-
 audio/gateway.c          |    2 +-
 audio/headset.c          |    2 +-
 audio/main.c             |    2 +-
 audio/manager.c          |    2 +-
 audio/sink.c             |    2 +-
 audio/source.c           |    2 +-
 audio/telephony-dummy.c  |    2 +-
 audio/telephony-maemo5.c |    2 +-
 audio/telephony-maemo6.c |    2 +-
 audio/telephony-ofono.c  |    2 +-
 audio/unix.c             |    2 +-
 input/device.c           |    2 +-
 input/fakehid.c          |    2 +-
 input/main.c             |    2 +-
 input/manager.c          |    2 +-
 input/server.c           |    2 +-
 network/bridge.c         |    2 +-
 network/common.c         |    2 +-
 network/connection.c     |    2 +-
 network/manager.c        |    2 +-
 network/server.c         |    2 +-
 plugins/echo.c           |    2 +-
 plugins/hal.c            |    2 +-
 plugins/hciops.c         |    2 +-
 plugins/netlink.c        |    2 +-
 plugins/pnat.c           |    2 +-
 plugins/service.c        |    2 +-
 plugins/storage.c        |    2 +-
 serial/manager.c         |    2 +-
 serial/port.c            |    2 +-
 serial/proxy.c           |    2 +-
 src/adapter.c            |    2 +-
 src/agent.c              |    2 +-
 src/dbus-common.c        |    2 +-
 src/dbus-hci.c           |    2 +-
 src/device.c             |    2 +-
 src/log.c                |  133 ++++++++++++++++++++++++++++++++++++++++++++++
 src/log.h                |   60 +++++++++++++++++++++
 src/logging.c            |  133 ----------------------------------------------
 src/logging.h            |   60 ---------------------
 src/main.c               |    2 +-
 src/manager.c            |    2 +-
 src/plugin.c             |    2 +-
 src/rfkill.c             |    2 +-
 src/sdpd-database.c      |    2 +-
 src/sdpd-request.c       |    2 +-
 src/sdpd-server.c        |    2 +-
 src/sdpd-service.c       |    2 +-
 src/security.c           |    2 +-
 54 files changed, 243 insertions(+), 243 deletions(-)
 create mode 100644 src/log.c
 create mode 100644 src/log.h
 delete mode 100644 src/logging.c
 delete mode 100644 src/logging.h

diff --git a/Makefile.am b/Makefile.am
index f991121..75cee3d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -180,7 +180,7 @@ builtin_sources += plugins/storage.c
 sbin_PROGRAMS += src/bluetoothd
 
 src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
-			src/main.c src/logging.h src/logging.c \
+			src/main.c src/log.h src/log.c \
 			src/security.c src/rfkill.c src/hcid.h src/sdpd.h \
 			src/sdpd-server.c src/sdpd-request.c \
 			src/sdpd-service.c src/sdpd-database.c \
diff --git a/audio/a2dp.c b/audio/a2dp.c
index fd12fbe..6221c14 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -36,7 +36,7 @@
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
-#include "logging.h"
+#include "log.h"
 #include "device.h"
 #include "manager.h"
 #include "avdtp.h"
diff --git a/audio/avdtp.c b/audio/avdtp.c
index 19a15a4..540bdf3 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -42,7 +42,7 @@
 #include <glib.h>
 #include <dbus/dbus.h>
 
-#include "logging.h"
+#include "log.h"
 
 #include "../src/manager.h"
 #include "../src/adapter.h"
diff --git a/audio/control.c b/audio/control.c
index da2bb5f..c8aba53 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -46,7 +46,7 @@
 #include <dbus/dbus.h>
 #include <gdbus.h>
 
-#include "logging.h"
+#include "log.h"
 #include "error.h"
 #include "uinput.h"
 #include "adapter.h"
diff --git a/audio/device.c b/audio/device.c
index fceb7a1..b59be6a 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -43,7 +43,7 @@
 #include <dbus/dbus.h>
 #include <gdbus.h>
 
-#include "logging.h"
+#include "log.h"
 #include "textfile.h"
 #include "../src/adapter.h"
 #include "../src/device.h"
diff --git a/audio/gateway.c b/audio/gateway.c
index 62b3f60..dfe7145 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -48,7 +48,7 @@
 #include "glib-helper.h"
 #include "device.h"
 #include "gateway.h"
-#include "logging.h"
+#include "log.h"
 #include "error.h"
 #include "btio.h"
 #include "dbus-common.h"
diff --git a/audio/headset.c b/audio/headset.c
index 7bcaa96..9a5d767 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -51,7 +51,7 @@
 #include <dbus/dbus.h>
 #include <gdbus.h>
 
-#include "logging.h"
+#include "log.h"
 #include "device.h"
 #include "manager.h"
 #include "error.h"
diff --git a/audio/main.c b/audio/main.c
index 34b45a8..9d316ec 100644
--- a/audio/main.c
+++ b/audio/main.c
@@ -40,7 +40,7 @@
 #include "glib-helper.h"
 #include "btio.h"
 #include "plugin.h"
-#include "logging.h"
+#include "log.h"
 #include "device.h"
 #include "unix.h"
 #include "headset.h"
diff --git a/audio/manager.c b/audio/manager.c
index ec795e6..32b7d03 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -55,7 +55,7 @@
 #include "../src/adapter.h"
 #include "../src/device.h"
 
-#include "logging.h"
+#include "log.h"
 #include "textfile.h"
 #include "ipc.h"
 #include "device.h"
diff --git a/audio/sink.c b/audio/sink.c
index 0ca0519..f4dce28 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -36,7 +36,7 @@
 #include <dbus/dbus.h>
 #include <gdbus.h>
 
-#include "logging.h"
+#include "log.h"
 
 #include "device.h"
 #include "avdtp.h"
diff --git a/audio/source.c b/audio/source.c
index ea4610f..35d8136 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -37,7 +37,7 @@
 #include <dbus/dbus.h>
 #include <gdbus.h>
 
-#include "logging.h"
+#include "log.h"
 
 #include "device.h"
 #include "avdtp.h"
diff --git a/audio/telephony-dummy.c b/audio/telephony-dummy.c
index f20aa79..06cb798 100644
--- a/audio/telephony-dummy.c
+++ b/audio/telephony-dummy.c
@@ -33,7 +33,7 @@
 #include <dbus/dbus.h>
 #include <gdbus.h>
 
-#include "logging.h"
+#include "log.h"
 #include "telephony.h"
 
 #define TELEPHONY_DUMMY_IFACE "org.bluez.TelephonyTest"
diff --git a/audio/telephony-maemo5.c b/audio/telephony-maemo5.c
index 910fa32..4d0134c 100644
--- a/audio/telephony-maemo5.c
+++ b/audio/telephony-maemo5.c
@@ -36,7 +36,7 @@
 #include <dbus/dbus.h>
 #include <gdbus.h>
 
-#include "logging.h"
+#include "log.h"
 #include "telephony.h"
 
 /* SSC D-Bus definitions */
diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index a48b7e2..1decf41 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -36,7 +36,7 @@
 #include <dbus/dbus.h>
 #include <gdbus.h>
 
-#include "logging.h"
+#include "log.h"
 #include "telephony.h"
 
 /* SSC D-Bus definitions */
diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 4511ab6..e710ce8 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -35,7 +35,7 @@
 #include <dbus/dbus.h>
 #include <gdbus.h>
 
-#include "logging.h"
+#include "log.h"
 #include "telephony.h"
 
 enum net_registration_status {
diff --git a/audio/unix.c b/audio/unix.c
index 3fdf5c8..42c0d80 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -39,7 +39,7 @@
 #include <dbus/dbus.h>
 #include <glib.h>
 
-#include "logging.h"
+#include "log.h"
 #include "ipc.h"
 #include "device.h"
 #include "manager.h"
diff --git a/input/device.c b/input/device.c
index 511ac95..8daf8b2 100644
--- a/input/device.c
+++ b/input/device.c
@@ -46,7 +46,7 @@
 #include <dbus/dbus.h>
 #include <gdbus.h>
 
-#include "logging.h"
+#include "log.h"
 #include "textfile.h"
 #include "uinput.h"
 
diff --git a/input/fakehid.c b/input/fakehid.c
index 69a9abb..ee1f77a 100644
--- a/input/fakehid.c
+++ b/input/fakehid.c
@@ -43,7 +43,7 @@
 #include "../src/adapter.h"
 #include "../src/device.h"
 
-#include "logging.h"
+#include "log.h"
 #include "device.h"
 #include "fakehid.h"
 #include "uinput.h"
diff --git a/input/main.c b/input/main.c
index 7c058f2..e165ab4 100644
--- a/input/main.c
+++ b/input/main.c
@@ -32,7 +32,7 @@
 #include <gdbus.h>
 
 #include "plugin.h"
-#include "logging.h"
+#include "log.h"
 #include "manager.h"
 
 static GKeyFile *load_config_file(const char *file)
diff --git a/input/manager.c b/input/manager.c
index 30cdd3e..a98a080 100644
--- a/input/manager.c
+++ b/input/manager.c
@@ -34,7 +34,7 @@
 
 #include <gdbus.h>
 
-#include "logging.h"
+#include "log.h"
 #include "../src/adapter.h"
 #include "../src/device.h"
 
diff --git a/input/server.c b/input/server.c
index 1197379..d98018b 100644
--- a/input/server.c
+++ b/input/server.c
@@ -34,7 +34,7 @@
 #include <glib.h>
 #include <dbus/dbus.h>
 
-#include "logging.h"
+#include "log.h"
 
 #include "glib-helper.h"
 #include "btio.h"
diff --git a/network/bridge.c b/network/bridge.c
index f3528ad..9166975 100644
--- a/network/bridge.c
+++ b/network/bridge.c
@@ -38,7 +38,7 @@
 #include <bluetooth/l2cap.h>
 #include <bluetooth/bnep.h>
 
-#include "logging.h"
+#include "log.h"
 #include "bridge.h"
 #include "common.h"
 
diff --git a/network/common.c b/network/common.c
index 6340883..f5e0ee8 100644
--- a/network/common.c
+++ b/network/common.c
@@ -41,7 +41,7 @@
 
 #include <glib.h>
 
-#include "logging.h"
+#include "log.h"
 #include "common.h"
 
 static int ctl;
diff --git a/network/connection.c b/network/connection.c
index 17c3396..01178d7 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -38,7 +38,7 @@
 #include <glib.h>
 #include <gdbus.h>
 
-#include "logging.h"
+#include "log.h"
 #include "glib-helper.h"
 #include "btio.h"
 #include "dbus-common.h"
diff --git a/network/manager.c b/network/manager.c
index ee19c03..80a5ded 100644
--- a/network/manager.c
+++ b/network/manager.c
@@ -33,7 +33,7 @@
 #include <glib.h>
 #include <gdbus.h>
 
-#include "logging.h"
+#include "log.h"
 
 #include "adapter.h"
 #include "device.h"
diff --git a/network/server.c b/network/server.c
index 475f12c..a82d4ff 100644
--- a/network/server.c
+++ b/network/server.c
@@ -44,7 +44,7 @@
 #include "../src/dbus-common.h"
 #include "../src/adapter.h"
 
-#include "logging.h"
+#include "log.h"
 #include "error.h"
 #include "sdpd.h"
 #include "btio.h"
diff --git a/plugins/echo.c b/plugins/echo.c
index d884d41..23f6e49 100644
--- a/plugins/echo.c
+++ b/plugins/echo.c
@@ -38,7 +38,7 @@
 
 #include "plugin.h"
 #include "adapter.h"
-#include "logging.h"
+#include "log.h"
 
 static gboolean session_event(GIOChannel *chan,
 					GIOCondition cond, gpointer data)
diff --git a/plugins/hal.c b/plugins/hal.c
index 73355d5..f6121c5 100644
--- a/plugins/hal.c
+++ b/plugins/hal.c
@@ -34,7 +34,7 @@
 
 #include "plugin.h"
 #include "adapter.h"
-#include "logging.h"
+#include "log.h"
 #include "dbus-hci.h"
 
 static void formfactor_reply(DBusPendingCall *call, void *user_data)
diff --git a/plugins/hciops.c b/plugins/hciops.c
index 9190c80..da2e3d0 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -42,7 +42,7 @@
 #include "sdpd.h"
 #include "adapter.h"
 #include "plugin.h"
-#include "logging.h"
+#include "log.h"
 #include "manager.h"
 
 static int child_pipe[2] = { -1, -1 };
diff --git a/plugins/netlink.c b/plugins/netlink.c
index 5b4915b..081ffa2 100644
--- a/plugins/netlink.c
+++ b/plugins/netlink.c
@@ -37,7 +37,7 @@
 #include <glib.h>
 
 #include "plugin.h"
-#include "logging.h"
+#include "log.h"
 
 static struct nl_handle *handle;
 static struct nl_cache *cache;
diff --git a/plugins/pnat.c b/plugins/pnat.c
index 4a06582..987008f 100644
--- a/plugins/pnat.c
+++ b/plugins/pnat.c
@@ -48,7 +48,7 @@
 #include "sdpd.h"
 #include "btio.h"
 #include "adapter.h"
-#include "logging.h"
+#include "log.h"
 
 /* FIXME: This location should be build-time configurable */
 #define PNATD "/usr/sbin/phonet-at"
diff --git a/plugins/service.c b/plugins/service.c
index 182b829..96280bd 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -43,7 +43,7 @@
 #include "plugin.h"
 #include "adapter.h"
 #include "error.h"
-#include "logging.h"
+#include "log.h"
 
 #define SERVICE_INTERFACE "org.bluez.Service"
 
diff --git a/plugins/storage.c b/plugins/storage.c
index 6c1cd45..04a02c7 100644
--- a/plugins/storage.c
+++ b/plugins/storage.c
@@ -28,7 +28,7 @@
 #include <bluetooth/bluetooth.h>
 
 #include "plugin.h"
-#include "logging.h"
+#include "log.h"
 
 static int storage_init(void)
 {
diff --git a/serial/manager.c b/serial/manager.c
index d4ebf2e..a7deab1 100644
--- a/serial/manager.c
+++ b/serial/manager.c
@@ -55,7 +55,7 @@
 #include "adapter.h"
 #include "device.h"
 
-#include "logging.h"
+#include "log.h"
 #include "textfile.h"
 
 #include "error.h"
diff --git a/serial/port.c b/serial/port.c
index 7382cf3..48a60b4 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -47,7 +47,7 @@
 
 #include "../src/dbus-common.h"
 
-#include "logging.h"
+#include "log.h"
 #include "glib-helper.h"
 #include "btio.h"
 
diff --git a/serial/proxy.c b/serial/proxy.c
index 442ce5d..80c1189 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -54,7 +54,7 @@
 #include "../src/dbus-common.h"
 #include "../src/adapter.h"
 
-#include "logging.h"
+#include "log.h"
 #include "textfile.h"
 
 #include "error.h"
diff --git a/src/adapter.c b/src/adapter.c
index d4887aa..e885879 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -43,7 +43,7 @@
 #include <dbus/dbus.h>
 #include <gdbus.h>
 
-#include "logging.h"
+#include "log.h"
 #include "textfile.h"
 
 #include "hcid.h"
diff --git a/src/agent.c b/src/agent.c
index 5ce0ec9..c7fdbd4 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -41,7 +41,7 @@
 #include <dbus/dbus.h>
 #include <gdbus.h>
 
-#include "logging.h"
+#include "log.h"
 
 #include "hcid.h"
 #include "adapter.h"
diff --git a/src/dbus-common.c b/src/dbus-common.c
index c6eedf9..1245b4f 100644
--- a/src/dbus-common.c
+++ b/src/dbus-common.c
@@ -42,7 +42,7 @@
 #include <dbus/dbus.h>
 #include <gdbus.h>
 
-#include "logging.h"
+#include "log.h"
 
 #include "manager.h"
 #include "adapter.h"
diff --git a/src/dbus-hci.c b/src/dbus-hci.c
index 58da70a..caa91ec 100644
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -45,7 +45,7 @@
 #include <dbus/dbus.h>
 #include <gdbus.h>
 
-#include "logging.h"
+#include "log.h"
 #include "textfile.h"
 
 #include "hcid.h"
diff --git a/src/device.c b/src/device.c
index 4a27545..66b0310 100644
--- a/src/device.c
+++ b/src/device.c
@@ -44,7 +44,7 @@
 #include <dbus/dbus.h>
 #include <gdbus.h>
 
-#include "logging.h"
+#include "log.h"
 #include "textfile.h"
 
 #include "hcid.h"
diff --git a/src/log.c b/src/log.c
new file mode 100644
index 0000000..29e2d7d
--- /dev/null
+++ b/src/log.c
@@ -0,0 +1,133 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
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
+#include <stdarg.h>
+#include <syslog.h>
+
+#include <glib.h>
+
+#include "log.h"
+
+static inline void vinfo(const char *format, va_list ap)
+{
+	vsyslog(LOG_INFO, format, ap);
+}
+
+void info(const char *format, ...)
+{
+	va_list ap;
+
+	va_start(ap, format);
+
+	vinfo(format, ap);
+
+	va_end(ap);
+}
+
+void error(const char *format, ...)
+{
+	va_list ap;
+
+	va_start(ap, format);
+
+	vsyslog(LOG_ERR, format, ap);
+
+	va_end(ap);
+}
+
+void debug(const char *format, ...)
+{
+	va_list ap;
+
+	va_start(ap, format);
+
+	vsyslog(LOG_DEBUG, format, ap);
+
+	va_end(ap);
+}
+
+extern struct btd_debug_desc __start___debug[];
+extern struct btd_debug_desc __stop___debug[];
+
+static gchar **enabled = NULL;
+
+static gboolean is_enabled(struct btd_debug_desc *desc)
+{
+        int i;
+
+        if (enabled == NULL)
+                return 0;
+
+        for (i = 0; enabled[i] != NULL; i++) {
+                if (desc->name != NULL && g_pattern_match_simple(enabled[i],
+                                                        desc->name) == TRUE)
+                        return 1;
+                if (desc->file != NULL && g_pattern_match_simple(enabled[i],
+                                                        desc->file) == TRUE)
+                        return 1;
+        }
+
+        return 0;
+}
+
+void __btd_log_init(const char *debug, int detach)
+{
+	int option = LOG_NDELAY | LOG_PID;
+	struct btd_debug_desc *desc;
+	const char *name = NULL, *file = NULL;
+
+	if (debug != NULL)
+		enabled = g_strsplit_set(debug, ":, ", 0);
+
+	for (desc = __start___debug; desc < __stop___debug; desc++) {
+		if (file != NULL || name != NULL) {
+			if (g_strcmp0(desc->file, file) == 0) {
+				if (desc->name == NULL)
+					desc->name = name;
+			} else
+				file = NULL;
+		}
+
+		if (is_enabled(desc))
+			desc->flags |= BTD_DEBUG_FLAG_PRINT;
+	}
+
+	if (!detach)
+		option |= LOG_PERROR;
+
+	openlog("bluetoothd", option, LOG_DAEMON);
+
+	syslog(LOG_INFO, "Bluetooth deamon %s", VERSION);
+}
+
+void __btd_log_cleanup(void)
+{
+	closelog();
+
+	g_strfreev(enabled);
+}
diff --git a/src/log.h b/src/log.h
new file mode 100644
index 0000000..9af51e7
--- /dev/null
+++ b/src/log.h
@@ -0,0 +1,60 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
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
+#ifndef __LOGGING_H
+#define __LOGGING_H
+
+void info(const char *format, ...) __attribute__((format(printf, 1, 2)));
+void error(const char *format, ...) __attribute__((format(printf, 1, 2)));
+void debug(const char *format, ...) __attribute__((format(printf, 1, 2)));
+
+void __btd_log_init(const char *debug, int detach);
+void __btd_log_cleanup(void);
+
+struct btd_debug_desc {
+        const char *name;
+        const char *file;
+#define BTD_DEBUG_FLAG_DEFAULT (0)
+#define BTD_DEBUG_FLAG_PRINT   (1 << 0)
+        unsigned int flags;
+} __attribute__((aligned(8)));
+
+/**
+ * DBG:
+ * @fmt: format string
+ * @arg...: list of arguments
+ *
+ * Simple macro around debug() which also include the function
+ * name it is called in.
+ */
+#define DBG(fmt, arg...) do { \
+        static struct btd_debug_desc __btd_debug_desc \
+        __attribute__((used, section("__debug"), aligned(8))) = { \
+                .file = __FILE__, .flags = BTD_DEBUG_FLAG_DEFAULT, \
+        }; \
+        if (__btd_debug_desc.flags & BTD_DEBUG_FLAG_PRINT) \
+                debug("%s:%s() " fmt, \
+                                        __FILE__, __FUNCTION__ , ## arg); \
+} while (0)
+
+#endif /* __LOGGING_H */
diff --git a/src/logging.c b/src/logging.c
deleted file mode 100644
index 39a5142..0000000
--- a/src/logging.c
+++ /dev/null
@@ -1,133 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdio.h>
-#include <stdarg.h>
-#include <syslog.h>
-
-#include <glib.h>
-
-#include "logging.h"
-
-static inline void vinfo(const char *format, va_list ap)
-{
-	vsyslog(LOG_INFO, format, ap);
-}
-
-void info(const char *format, ...)
-{
-	va_list ap;
-
-	va_start(ap, format);
-
-	vinfo(format, ap);
-
-	va_end(ap);
-}
-
-void error(const char *format, ...)
-{
-	va_list ap;
-
-	va_start(ap, format);
-
-	vsyslog(LOG_ERR, format, ap);
-
-	va_end(ap);
-}
-
-void debug(const char *format, ...)
-{
-	va_list ap;
-
-	va_start(ap, format);
-
-	vsyslog(LOG_DEBUG, format, ap);
-
-	va_end(ap);
-}
-
-extern struct btd_debug_desc __start___debug[];
-extern struct btd_debug_desc __stop___debug[];
-
-static gchar **enabled = NULL;
-
-static gboolean is_enabled(struct btd_debug_desc *desc)
-{
-        int i;
-
-        if (enabled == NULL)
-                return 0;
-
-        for (i = 0; enabled[i] != NULL; i++) {
-                if (desc->name != NULL && g_pattern_match_simple(enabled[i],
-                                                        desc->name) == TRUE)
-                        return 1;
-                if (desc->file != NULL && g_pattern_match_simple(enabled[i],
-                                                        desc->file) == TRUE)
-                        return 1;
-        }
-
-        return 0;
-}
-
-void __btd_log_init(const char *debug, int detach)
-{
-	int option = LOG_NDELAY | LOG_PID;
-	struct btd_debug_desc *desc;
-	const char *name = NULL, *file = NULL;
-
-	if (debug != NULL)
-		enabled = g_strsplit_set(debug, ":, ", 0);
-
-	for (desc = __start___debug; desc < __stop___debug; desc++) {
-		if (file != NULL || name != NULL) {
-			if (g_strcmp0(desc->file, file) == 0) {
-				if (desc->name == NULL)
-					desc->name = name;
-			} else
-				file = NULL;
-		}
-
-		if (is_enabled(desc))
-			desc->flags |= BTD_DEBUG_FLAG_PRINT;
-	}
-
-	if (!detach)
-		option |= LOG_PERROR;
-
-	openlog("bluetoothd", option, LOG_DAEMON);
-
-	syslog(LOG_INFO, "Bluetooth deamon %s", VERSION);
-}
-
-void __btd_log_cleanup(void)
-{
-	closelog();
-
-	g_strfreev(enabled);
-}
diff --git a/src/logging.h b/src/logging.h
deleted file mode 100644
index 9af51e7..0000000
--- a/src/logging.h
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifndef __LOGGING_H
-#define __LOGGING_H
-
-void info(const char *format, ...) __attribute__((format(printf, 1, 2)));
-void error(const char *format, ...) __attribute__((format(printf, 1, 2)));
-void debug(const char *format, ...) __attribute__((format(printf, 1, 2)));
-
-void __btd_log_init(const char *debug, int detach);
-void __btd_log_cleanup(void);
-
-struct btd_debug_desc {
-        const char *name;
-        const char *file;
-#define BTD_DEBUG_FLAG_DEFAULT (0)
-#define BTD_DEBUG_FLAG_PRINT   (1 << 0)
-        unsigned int flags;
-} __attribute__((aligned(8)));
-
-/**
- * DBG:
- * @fmt: format string
- * @arg...: list of arguments
- *
- * Simple macro around debug() which also include the function
- * name it is called in.
- */
-#define DBG(fmt, arg...) do { \
-        static struct btd_debug_desc __btd_debug_desc \
-        __attribute__((used, section("__debug"), aligned(8))) = { \
-                .file = __FILE__, .flags = BTD_DEBUG_FLAG_DEFAULT, \
-        }; \
-        if (__btd_debug_desc.flags & BTD_DEBUG_FLAG_PRINT) \
-                debug("%s:%s() " fmt, \
-                                        __FILE__, __FUNCTION__ , ## arg); \
-} while (0)
-
-#endif /* __LOGGING_H */
diff --git a/src/main.c b/src/main.c
index 7a573bc..3118a34 100644
--- a/src/main.c
+++ b/src/main.c
@@ -46,7 +46,7 @@
 
 #include <dbus/dbus.h>
 
-#include "logging.h"
+#include "log.h"
 
 #include "hcid.h"
 #include "sdpd.h"
diff --git a/src/manager.c b/src/manager.c
index 0c75ff7..ea1180a 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -45,7 +45,7 @@
 
 #include "hcid.h"
 #include "dbus-common.h"
-#include "logging.h"
+#include "log.h"
 #include "adapter.h"
 #include "error.h"
 #include "manager.h"
diff --git a/src/plugin.c b/src/plugin.c
index 5bc2bb2..a63ce8e 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -35,7 +35,7 @@
 #include <glib.h>
 
 #include "plugin.h"
-#include "logging.h"
+#include "log.h"
 #include "hcid.h"
 #include "btio.h"
 
diff --git a/src/rfkill.c b/src/rfkill.c
index 2d0629b..7810846 100644
--- a/src/rfkill.c
+++ b/src/rfkill.c
@@ -35,7 +35,7 @@
 
 #include <glib.h>
 
-#include "logging.h"
+#include "log.h"
 #include "manager.h"
 #include "adapter.h"
 #include "hcid.h"
diff --git a/src/sdpd-database.c b/src/sdpd-database.c
index 263b16e..4c8acb7 100644
--- a/src/sdpd-database.c
+++ b/src/sdpd-database.c
@@ -39,7 +39,7 @@
 #include <bluetooth/sdp_lib.h>
 
 #include "sdpd.h"
-#include "logging.h"
+#include "log.h"
 #include "adapter.h"
 
 static sdp_list_t *service_db;
diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index a8af8e4..8c88d6e 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -43,7 +43,7 @@
 #include <netinet/in.h>
 
 #include "sdpd.h"
-#include "logging.h"
+#include "log.h"
 
 #define MIN(x, y) ((x) < (y)) ? (x): (y)
 
diff --git a/src/sdpd-server.c b/src/sdpd-server.c
index 207bd47..efd6fd0 100644
--- a/src/sdpd-server.c
+++ b/src/sdpd-server.c
@@ -45,7 +45,7 @@
 
 #include <glib.h>
 
-#include "logging.h"
+#include "log.h"
 #include "sdpd.h"
 
 static GIOChannel *l2cap_io = NULL, *unix_io = NULL;
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index a1caa2c..cdbb4f4 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -45,7 +45,7 @@
 #include <dbus/dbus.h>
 
 #include "sdpd.h"
-#include "logging.h"
+#include "log.h"
 #include "manager.h"
 #include "adapter.h"
 
diff --git a/src/security.c b/src/security.c
index f2756c5..1d0da45 100644
--- a/src/security.c
+++ b/src/security.c
@@ -47,7 +47,7 @@
 #include <dbus/dbus.h>
 
 #include "hcid.h"
-#include "logging.h"
+#include "log.h"
 #include "textfile.h"
 
 #include "adapter.h"
-- 
1.7.1
