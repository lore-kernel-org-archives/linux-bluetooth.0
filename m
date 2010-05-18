Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org
Subject: [PATCH 2/4] Add dynamic debug feature
Date: Mon, 17 May 2010 23:27:16 -0300
Message-Id: <1274149638-31580-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1274149638-31580-1-git-send-email-gustavo@padovan.org>
References: <1274149638-31580-1-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

It is still needed a sed work in the sources to changes debug() to DBG()

Thanks, to Vinicius Gomes that helped me sort out a linking issue with
this patch.
---
 src/logging.c |   69 ++++++++++++++++++++++++++++++++++++++------------------
 src/logging.h |   34 +++++++++++++++++++++++-----
 src/main.c    |   36 ++++++++++++++---------------
 3 files changed, 92 insertions(+), 47 deletions(-)

diff --git a/src/logging.c b/src/logging.c
index 704f848..39a5142 100644
--- a/src/logging.c
+++ b/src/logging.c
@@ -29,9 +29,9 @@
 #include <stdarg.h>
 #include <syslog.h>
 
-#include "logging.h"
+#include <glib.h>
 
-static volatile int debug_enabled = 0;
+#include "logging.h"
 
 static inline void vinfo(const char *format, va_list ap)
 {
@@ -64,9 +64,6 @@ void debug(const char *format, ...)
 {
 	va_list ap;
 
-	if (!debug_enabled)
-		return;
-
 	va_start(ap, format);
 
 	vsyslog(LOG_DEBUG, format, ap);
@@ -74,35 +71,63 @@ void debug(const char *format, ...)
 	va_end(ap);
 }
 
-void toggle_debug(void)
-{
-	debug_enabled = (debug_enabled + 1) % 2;
-}
+extern struct btd_debug_desc __start___debug[];
+extern struct btd_debug_desc __stop___debug[];
 
-void enable_debug(void)
-{
-	debug_enabled = 1;
-}
+static gchar **enabled = NULL;
 
-void disable_debug(void)
+static gboolean is_enabled(struct btd_debug_desc *desc)
 {
-	debug_enabled = 0;
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
 }
 
-void start_logging(const char *ident, const char *message, ...)
+void __btd_log_init(const char *debug, int detach)
 {
-	va_list ap;
+	int option = LOG_NDELAY | LOG_PID;
+	struct btd_debug_desc *desc;
+	const char *name = NULL, *file = NULL;
 
-	openlog(ident, LOG_PID | LOG_NDELAY | LOG_PERROR, LOG_DAEMON);
+	if (debug != NULL)
+		enabled = g_strsplit_set(debug, ":, ", 0);
 
-	va_start(ap, message);
+	for (desc = __start___debug; desc < __stop___debug; desc++) {
+		if (file != NULL || name != NULL) {
+			if (g_strcmp0(desc->file, file) == 0) {
+				if (desc->name == NULL)
+					desc->name = name;
+			} else
+				file = NULL;
+		}
 
-	vinfo(message, ap);
+		if (is_enabled(desc))
+			desc->flags |= BTD_DEBUG_FLAG_PRINT;
+	}
 
-	va_end(ap);
+	if (!detach)
+		option |= LOG_PERROR;
+
+	openlog("bluetoothd", option, LOG_DAEMON);
+
+	syslog(LOG_INFO, "Bluetooth deamon %s", VERSION);
 }
 
-void stop_logging(void)
+void __btd_log_cleanup(void)
 {
 	closelog();
+
+	g_strfreev(enabled);
 }
diff --git a/src/logging.h b/src/logging.h
index 2e9d564..9af51e7 100644
--- a/src/logging.h
+++ b/src/logging.h
@@ -27,12 +27,34 @@
 void info(const char *format, ...) __attribute__((format(printf, 1, 2)));
 void error(const char *format, ...) __attribute__((format(printf, 1, 2)));
 void debug(const char *format, ...) __attribute__((format(printf, 1, 2)));
-void toggle_debug(void);
-void enable_debug(void);
-void disable_debug(void);
-void start_logging(const char *ident, const char *message, ...);
-void stop_logging(void);
 
-#define DBG(fmt, arg...)  debug("%s: " fmt "\n" , __FUNCTION__ , ## arg)
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
 
 #endif /* __LOGGING_H */
diff --git a/src/main.c b/src/main.c
index 014d8b6..ac14165 100644
--- a/src/main.c
+++ b/src/main.c
@@ -288,13 +288,8 @@ static void sig_term(int sig)
 	g_main_loop_quit(event_loop);
 }
 
-static void sig_debug(int sig)
-{
-	toggle_debug();
-}
-
+static gchar *option_debug = NULL;
 static gboolean option_detach = TRUE;
-static gboolean option_debug = FALSE;
 static gboolean option_udev = FALSE;
 
 static guint last_adapter_timeout = 0;
@@ -327,12 +322,23 @@ void btd_stop_exit_timer(void)
 	last_adapter_timeout = 0;
 }
 
+static gboolean parse_debug(const char *key, const char *value, gpointer user_data, GError **error)
+{
+	if (value)
+		option_debug = g_strdup(value);
+	else
+		option_debug = g_strdup("*");
+
+	return TRUE;
+}
+
 static GOptionEntry options[] = {
 	{ "nodaemon", 'n', G_OPTION_FLAG_REVERSE,
 				G_OPTION_ARG_NONE, &option_detach,
 				"Don't run as daemon in background" },
-	{ "debug", 'd', 0, G_OPTION_ARG_NONE, &option_debug,
-				"Enable debug information output" },
+	{ "debug", 'd', G_OPTION_FLAG_OPTIONAL_ARG,
+				G_OPTION_ARG_CALLBACK, parse_debug,
+				"Enable debug information output", "DEBUG" },
 	{ "udev", 'u', 0, G_OPTION_ARG_NONE, &option_udev,
 				"Run from udev mode of operation" },
 	{ NULL },
@@ -392,7 +398,7 @@ int main(int argc, char *argv[])
 
 	umask(0077);
 
-	start_logging("bluetoothd", "Bluetooth daemon %s", VERSION);
+	__btd_log_init(option_debug, option_detach);
 
 	memset(&sa, 0, sizeof(sa));
 	sa.sa_flags = SA_NOCLDSTOP;
@@ -400,17 +406,9 @@ int main(int argc, char *argv[])
 	sigaction(SIGTERM, &sa, NULL);
 	sigaction(SIGINT,  &sa, NULL);
 
-	sa.sa_handler = sig_debug;
-	sigaction(SIGUSR2, &sa, NULL);
-
 	sa.sa_handler = SIG_IGN;
 	sigaction(SIGPIPE, &sa, NULL);
 
-	if (option_debug == TRUE) {
-		info("Enabling debug information");
-		enable_debug();
-	}
-
 	config = load_config(CONFIGDIR "/main.conf");
 
 	parse_config(config);
@@ -446,7 +444,7 @@ int main(int argc, char *argv[])
 
 	rfkill_init();
 
-	debug("Entering main loop");
+	DBG("Entering main loop");
 
 	g_main_loop_run(event_loop);
 
@@ -469,7 +467,7 @@ int main(int argc, char *argv[])
 
 	info("Exit");
 
-	stop_logging();
+	__btd_log_cleanup();
 
 	return 0;
 }
-- 
1.7.1
