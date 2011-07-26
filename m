Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<ulrik.lauren@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 3/3] Enhance plugin interface with external debug section
Date: Tue, 26 Jul 2011 15:57:12 +0200
Message-ID: <1311688632-19334-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1311688632-19334-1-git-send-email-szymon.janc@tieto.com>
References: <1311688632-19334-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Store pointers to debug section of non-built-in plugin in
bluetooth_plugin_desc structure. This is used to register plugin's
debug section in logging system when plugin is not of built-in type.
---
 src/plugin.c |   10 +++++++---
 src/plugin.h |    8 ++++++--
 2 files changed, 13 insertions(+), 5 deletions(-)

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

