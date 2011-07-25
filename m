Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<ulrik.lauren@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Fix debug messages logging from non-built-in plugins
Date: Mon, 25 Jul 2011 13:09:04 +0200
Message-ID: <1311592144-14140-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/main.c           |    2 +-
 health/hdp_main.c      |    1 +
 input/main.c           |    2 +-
 network/main.c         |    1 +
 plugins/adaptername.c  |    2 +-
 plugins/formfactor.c   |    2 +-
 plugins/gatt-example.c |    2 +-
 plugins/hciops.c       |    2 +-
 plugins/mgmtops.c      |    2 +-
 plugins/service.c      |    2 +-
 plugins/storage.c      |    2 +-
 sap/main.c             |    1 +
 serial/main.c          |    1 +
 src/log.c              |   25 +++++++++++++++++++++++++
 src/log.h              |    8 ++++++++
 src/plugin.c           |   10 +++++++---
 src/plugin.h           |    8 ++++++--
 17 files changed, 59 insertions(+), 14 deletions(-)

diff --git a/audio/main.c b/audio/main.c
index 745c307..f2042f0 100644
--- a/audio/main.c
+++ b/audio/main.c
@@ -39,8 +39,8 @@
 
 #include "glib-helper.h"
 #include "btio.h"
-#include "plugin.h"
 #include "log.h"
+#include "plugin.h"
 #include "device.h"
 #include "headset.h"
 #include "manager.h"
diff --git a/health/hdp_main.c b/health/hdp_main.c
index b40a37c..ae2340d 100644
--- a/health/hdp_main.c
+++ b/health/hdp_main.c
@@ -31,6 +31,7 @@
 
 #include <gdbus.h>
 
+#include "log.h"
 #include "plugin.h"
 #include "hdp_manager.h"
 
diff --git a/input/main.c b/input/main.c
index e165ab4..33d7493 100644
--- a/input/main.c
+++ b/input/main.c
@@ -31,8 +31,8 @@
 
 #include <gdbus.h>
 
-#include "plugin.h"
 #include "log.h"
+#include "plugin.h"
 #include "manager.h"
 
 static GKeyFile *load_config_file(const char *file)
diff --git a/network/main.c b/network/main.c
index 88e77ee..17e5731 100644
--- a/network/main.c
+++ b/network/main.c
@@ -29,6 +29,7 @@
 
 #include <gdbus.h>
 
+#include "log.h"
 #include "plugin.h"
 #include "manager.h"
 
diff --git a/plugins/adaptername.c b/plugins/adaptername.c
index 2a54cc0..ddf50d2 100644
--- a/plugins/adaptername.c
+++ b/plugins/adaptername.c
@@ -36,13 +36,13 @@
 #include <glib.h>
 #include <bluetooth/bluetooth.h>
 
+#include "log.h"
 #include "plugin.h"
 #include "hcid.h" /* For main_opts */
 #include "adapter.h"
 #include "manager.h"
 #include "device.h" /* Needed for storage.h */
 #include "storage.h"
-#include "log.h"
 
 #include <sys/inotify.h>
 #define EVENT_SIZE  (sizeof (struct inotify_event))
diff --git a/plugins/formfactor.c b/plugins/formfactor.c
index 758d481..300e723 100644
--- a/plugins/formfactor.c
+++ b/plugins/formfactor.c
@@ -30,9 +30,9 @@
 
 #include <bluetooth/bluetooth.h>
 
+#include "log.h"
 #include "plugin.h"
 #include "adapter.h"
-#include "log.h"
 
 #define DMI_CHASSIS_FILE "/sys/class/dmi/id/chassis_type"
 #define DMI_CHASSIS_FILE_FALLBACK "/sys/devices/virtual/dmi/id/chassis_type"
diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index f86e76d..40f19aa 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -29,9 +29,9 @@
 #include <glib.h>
 #include <bluetooth/uuid.h>
 
+#include "log.h"
 #include "plugin.h"
 #include "hcid.h"
-#include "log.h"
 #include "attrib-server.h"
 #include "att.h"
 
diff --git a/plugins/hciops.c b/plugins/hciops.c
index ecc0e86..da4738d 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -46,8 +46,8 @@
 #include "btio.h"
 #include "adapter.h"
 #include "device.h"
-#include "plugin.h"
 #include "log.h"
+#include "plugin.h"
 #include "storage.h"
 #include "event.h"
 #include "manager.h"
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 3cdb97e..5647065 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -41,8 +41,8 @@
 #include <bluetooth/sdp_lib.h>
 #include <bluetooth/mgmt.h>
 
-#include "plugin.h"
 #include "log.h"
+#include "plugin.h"
 #include "adapter.h"
 #include "manager.h"
 #include "device.h"
diff --git a/plugins/service.c b/plugins/service.c
index d73cdea..01ed7bb 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -38,10 +38,10 @@
 
 #include "sdpd.h"
 #include "sdp-xml.h"
+#include "log.h"
 #include "plugin.h"
 #include "adapter.h"
 #include "error.h"
-#include "log.h"
 
 #define SERVICE_INTERFACE "org.bluez.Service"
 
diff --git a/plugins/storage.c b/plugins/storage.c
index 04a02c7..56ee04a 100644
--- a/plugins/storage.c
+++ b/plugins/storage.c
@@ -27,8 +27,8 @@
 
 #include <bluetooth/bluetooth.h>
 
-#include "plugin.h"
 #include "log.h"
+#include "plugin.h"
 
 static int storage_init(void)
 {
diff --git a/sap/main.c b/sap/main.c
index c9c90bd..57a7028 100644
--- a/sap/main.c
+++ b/sap/main.c
@@ -24,6 +24,7 @@
 
 #include <errno.h>
 #include <gdbus.h>
+#include "log.h"
 #include "plugin.h"
 #include "manager.h"
 
diff --git a/serial/main.c b/serial/main.c
index 38ded03..d640aba 100644
--- a/serial/main.c
+++ b/serial/main.c
@@ -29,6 +29,7 @@
 
 #include <gdbus.h>
 
+#include "log.h"
 #include "plugin.h"
 #include "manager.h"
 
diff --git a/src/log.c b/src/log.c
index 2c492e9..c5e0c74 100644
--- a/src/log.c
+++ b/src/log.c
@@ -70,6 +70,7 @@ extern struct btd_debug_desc __start___debug[];
 extern struct btd_debug_desc __stop___debug[];
 
 static gchar **enabled = NULL;
+static GSList *ext_debugs = NULL;
 
 static gboolean is_enabled(struct btd_debug_desc *desc)
 {
@@ -89,9 +90,17 @@ static gboolean is_enabled(struct btd_debug_desc *desc)
 void __btd_toggle_debug(void)
 {
 	struct btd_debug_desc *desc;
+	GSList *l;
 
 	for (desc = __start___debug; desc < __stop___debug; desc++)
 		desc->flags |= BTD_DEBUG_FLAG_PRINT;
+
+	for (l = ext_debugs; l; l = l->next) {
+		struct btd_debug_section *debug = l->data;
+
+		for (desc = debug->start; desc < debug->stop; desc++)
+			desc->flags |= BTD_DEBUG_FLAG_PRINT;
+	}
 }
 
 void __btd_log_init(const char *debug, int detach)
@@ -120,3 +129,19 @@ void __btd_log_cleanup(void)
 
 	g_strfreev(enabled);
 }
+
+void __btd_log_add(struct btd_debug_section *debug)
+{
+	struct btd_debug_desc *desc;
+
+	ext_debugs = g_slist_prepend(ext_debugs, debug);
+
+	for (desc = debug->start; desc < debug->stop; desc++)
+		if (is_enabled(desc))
+			desc->flags |= BTD_DEBUG_FLAG_PRINT;
+}
+
+void __btd_log_remove(struct btd_debug_section *debug)
+{
+	ext_debugs = g_slist_remove(ext_debugs, debug);
+}
diff --git a/src/log.h b/src/log.h
index 78bbdd8..1f2d13d 100644
--- a/src/log.h
+++ b/src/log.h
@@ -37,6 +37,14 @@ struct btd_debug_desc {
 	unsigned int flags;
 } __attribute__((aligned(8)));
 
+struct btd_debug_section {
+	struct btd_debug_desc *start;
+	struct btd_debug_desc *stop;
+};
+
+void __btd_log_add(struct btd_debug_section *debug);
+void __btd_log_remove(struct btd_debug_section *debug);
+
 /**
  * DBG:
  * @fmt: format string
diff --git a/src/plugin.c b/src/plugin.c
index 3506553..79db9b3 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -34,8 +34,8 @@
 
 #include <glib.h>
 
-#include "plugin.h"
 #include "log.h"
+#include "plugin.h"
 #include "hcid.h"
 #include "btio.h"
 
@@ -202,7 +202,9 @@ gboolean plugin_init(GKeyFile *config, const char *enable, const char *disable)
 			continue;
 		}
 
-		if (add_plugin(handle, desc) == FALSE)
+		if (add_plugin(handle, desc) == TRUE)
+			__btd_log_add(&desc->debug);
+		else
 			dlclose(handle);
 	}
 
@@ -239,8 +241,10 @@ void plugin_cleanup(void)
 		if (plugin->active == TRUE && plugin->desc->exit)
 			plugin->desc->exit();
 
-		if (plugin->handle != NULL)
+		if (plugin->handle != NULL) {
+			__btd_log_remove(&plugin->desc->debug);
 			dlclose(plugin->handle);
+		}
 
 		g_free(plugin);
 	}
diff --git a/src/plugin.h b/src/plugin.h
index 30bd415..2327735 100644
--- a/src/plugin.h
+++ b/src/plugin.h
@@ -30,18 +30,22 @@ struct bluetooth_plugin_desc {
 	int priority;
 	int (*init) (void);
 	void (*exit) (void);
+	struct btd_debug_section debug;
 };
 
 #ifdef BLUETOOTH_PLUGIN_BUILTIN
 #define BLUETOOTH_PLUGIN_DEFINE(name, version, priority, init, exit) \
 		struct bluetooth_plugin_desc __bluetooth_builtin_ ## name = { \
-			#name, version, priority, init, exit \
+			#name, version, priority, init, exit, { NULL, NULL } \
 		};
 #else
 #define BLUETOOTH_PLUGIN_DEFINE(name, version, priority, init, exit) \
+		extern struct btd_debug_desc __start___debug[]; \
+		extern struct btd_debug_desc __stop___debug[]; \
 		extern struct bluetooth_plugin_desc bluetooth_plugin_desc \
 				__attribute__ ((visibility("default"))); \
 		struct bluetooth_plugin_desc bluetooth_plugin_desc = { \
-			#name, version, priority, init, exit \
+			#name, version, priority, init, exit, \
+			{ __start___debug, __stop___debug } \
 		};
 #endif
-- 
on behalf of ST-Ericsson

