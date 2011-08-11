Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<ulrik.lauren@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v3 2/2] Fix debug messages logging from non-built-in plugins
Date: Thu, 11 Aug 2011 15:10:16 +0200
Message-ID: <1313068216-16802-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1313068216-16802-1-git-send-email-szymon.janc@tieto.com>
References: <1313068216-16802-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/log.c    |   38 +++++++++++++++++++++++++++++++-------
 src/log.h    |    8 ++++++++
 src/plugin.h |   15 +++++++++++++++
 3 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/src/log.c b/src/log.c
index 2c492e9..ab4f92d 100644
--- a/src/log.c
+++ b/src/log.c
@@ -68,8 +68,10 @@ void btd_debug(const char *format, ...)
 
 extern struct btd_debug_desc __start___debug[];
 extern struct btd_debug_desc __stop___debug[];
+static struct btd_debug_section debug_section;
 
 static gchar **enabled = NULL;
+static GSList *debug_sections = NULL;
 
 static gboolean is_enabled(struct btd_debug_desc *desc)
 {
@@ -88,23 +90,27 @@ static gboolean is_enabled(struct btd_debug_desc *desc)
 
 void __btd_toggle_debug(void)
 {
-	struct btd_debug_desc *desc;
+	GSList *l;
+
+	for (l = debug_sections; l; l = l->next) {
+		struct btd_debug_section *s = l->data;
+		struct btd_debug_desc *desc;
 
-	for (desc = __start___debug; desc < __stop___debug; desc++)
-		desc->flags |= BTD_DEBUG_FLAG_PRINT;
+		for (desc = s->start; desc < s->stop; desc++)
+			desc->flags |= BTD_DEBUG_FLAG_PRINT;
+	}
 }
 
 void __btd_log_init(const char *debug, int detach)
 {
 	int option = LOG_NDELAY | LOG_PID;
-	struct btd_debug_desc *desc;
 
 	if (debug != NULL)
 		enabled = g_strsplit_set(debug, ":, ", 0);
 
-	for (desc = __start___debug; desc < __stop___debug; desc++)
-		if (is_enabled(desc))
-			desc->flags |= BTD_DEBUG_FLAG_PRINT;
+	debug_section.start = __start___debug;
+	debug_section.stop = __stop___debug;
+	btd_log_add(&debug_section);
 
 	if (!detach)
 		option |= LOG_PERROR;
@@ -116,7 +122,25 @@ void __btd_log_init(const char *debug, int detach)
 
 void __btd_log_cleanup(void)
 {
+	btd_log_remove(&debug_section);
+
 	closelog();
 
 	g_strfreev(enabled);
 }
+
+void btd_log_add(struct btd_debug_section *s)
+{
+	struct btd_debug_desc *desc;
+
+	for (desc = s->start; desc < s->stop; desc++)
+		if (is_enabled(desc))
+			desc->flags |= BTD_DEBUG_FLAG_PRINT;
+
+	debug_sections = g_slist_prepend(debug_sections, s);
+}
+
+void btd_log_remove(struct btd_debug_section *s)
+{
+	debug_sections = g_slist_remove(debug_sections, s);
+}
diff --git a/src/log.h b/src/log.h
index 78bbdd8..960c05c 100644
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
+void btd_log_add(struct btd_debug_section *s);
+void btd_log_remove(struct btd_debug_section *s);
+
 /**
  * DBG:
  * @fmt: format string
diff --git a/src/plugin.h b/src/plugin.h
index 30bd415..5556cf5 100644
--- a/src/plugin.h
+++ b/src/plugin.h
@@ -39,6 +39,21 @@ struct bluetooth_plugin_desc {
 		};
 #else
 #define BLUETOOTH_PLUGIN_DEFINE(name, version, priority, init, exit) \
+		extern struct btd_debug_desc __start___debug[] \
+				__attribute__ ((visibility("hidden"))); \
+		extern struct btd_debug_desc __stop___debug[] \
+				__attribute__ ((visibility("hidden"))); \
+		static struct btd_debug_section __ds; \
+		static void __attribute__((constructor)) log_init(void) \
+		{ \
+			__ds.start = __start___debug; \
+			__ds.stop = __stop___debug; \
+			btd_log_add(&__ds); \
+		} \
+		static void __attribute__((destructor)) log_fini(void) \
+		{ \
+			btd_log_remove(&__ds); \
+		} \
 		extern struct bluetooth_plugin_desc bluetooth_plugin_desc \
 				__attribute__ ((visibility("default"))); \
 		struct bluetooth_plugin_desc bluetooth_plugin_desc = { \
-- 
on behalf of ST-Ericsson

