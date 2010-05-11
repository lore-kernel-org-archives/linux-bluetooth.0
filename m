Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCH 1/2] Add dynamic debug feature
Date: Tue, 11 May 2010 00:51:40 -0300
Message-Id: <1273549901-28856-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is still needed a sed work in the sources to changes debug() to DBG()

Thanks, to Vinicius Gomes that helped me sort out a linking issue with
this patch.
---
 src/logging.c |   64 +++++++++++++++++++++++++++++++++++++++++---------------
 src/logging.h |   28 +++++++++++++++++++++++-
 src/main.c    |   34 ++++++++++++++----------------
 tracer/main.c |   24 +++++----------------
 4 files changed, 95 insertions(+), 55 deletions(-)

diff --git a/src/logging.c b/src/logging.c
index 704f848..a9956be 100644
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
@@ -74,26 +71,57 @@ void debug(const char *format, ...)
 	va_end(ap);
 }
 
-void toggle_debug(void)
-{
-	debug_enabled = (debug_enabled + 1) % 2;
-}
+extern struct bluez_debug_desc __start___debug[];
+extern struct bluez_debug_desc __stop___debug[];
 
-void enable_debug(void)
-{
-	debug_enabled = 1;
-}
+static gchar **enabled = NULL;
 
-void disable_debug(void)
+static gboolean is_enabled(struct bluez_debug_desc *desc)
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
+void start_logging(const char *debug, int detach, const char *ident, const char *message, ...)
 {
+	int option = LOG_NDELAY | LOG_PID;
+	struct bluez_debug_desc *desc;
+	const char *name = NULL, *file = NULL;
 	va_list ap;
 
-	openlog(ident, LOG_PID | LOG_NDELAY | LOG_PERROR, LOG_DAEMON);
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
+			desc->flags |= BLUEZ_DEBUG_FLAG_PRINT;
+	}
+
+	if (!detach)
+		option |= LOG_PERROR;
+
+	openlog(ident, option, LOG_DAEMON);
 
 	va_start(ap, message);
 
@@ -105,4 +133,6 @@ void start_logging(const char *ident, const char *message, ...)
 void stop_logging(void)
 {
 	closelog();
+
+	g_strfreev(enabled);
 }
diff --git a/src/logging.h b/src/logging.h
index 2e9d564..b1a58a8 100644
--- a/src/logging.h
+++ b/src/logging.h
@@ -30,9 +30,33 @@ void debug(const char *format, ...) __attribute__((format(printf, 1, 2)));
 void toggle_debug(void);
 void enable_debug(void);
 void disable_debug(void);
-void start_logging(const char *ident, const char *message, ...);
+void start_logging(const char *debug, int detach, const char *ident, const char *message, ...);
 void stop_logging(void);
 
-#define DBG(fmt, arg...)  debug("%s: " fmt "\n" , __FUNCTION__ , ## arg)
+struct bluez_debug_desc {
+        const char *name;
+        const char *file;
+#define BLUEZ_DEBUG_FLAG_DEFAULT (0)
+#define BLUEZ_DEBUG_FLAG_PRINT   (1 << 0)
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
+        static struct bluez_debug_desc __bluez_debug_desc \
+        __attribute__((used, section("__debug"), aligned(8))) = { \
+                .file = __FILE__, .flags = BLUEZ_DEBUG_FLAG_DEFAULT, \
+        }; \
+        if (__bluez_debug_desc.flags & BLUEZ_DEBUG_FLAG_PRINT) \
+                debug("%s:%s() " fmt, \
+                                        __FILE__, __FUNCTION__ , ## arg); \
+} while (0)
 
 #endif /* __LOGGING_H */
diff --git a/src/main.c b/src/main.c
index 014d8b6..c090493 100644
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
@@ -327,12 +322,22 @@ void btd_stop_exit_timer(void)
 	last_adapter_timeout = 0;
 }
 
+static gboolean parse_debug(const char *key, const char *value, gpointer user_data, GError **error)
+{
+	option_debug = g_strdup(value);
+	if (!option_debug)
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
@@ -392,7 +397,8 @@ int main(int argc, char *argv[])
 
 	umask(0077);
 
-	start_logging("bluetoothd", "Bluetooth daemon %s", VERSION);
+	start_logging(option_debug, option_detach,
+			"bluetoothd", "Bluetooth daemon %s", VERSION);
 
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
 
diff --git a/tracer/main.c b/tracer/main.c
index 5ec5ff2..0257e00 100644
--- a/tracer/main.c
+++ b/tracer/main.c
@@ -48,20 +48,15 @@ static void sig_term(int sig)
 	g_main_loop_quit(event_loop);
 }
 
-static void sig_debug(int sig)
-{
-	toggle_debug();
-}
-
 static gboolean option_detach = TRUE;
-static gboolean option_debug = FALSE;
+static gchar *option_debug = NULL;
 
 static GOptionEntry options[] = {
 	{ "nodaemon", 'n', G_OPTION_FLAG_REVERSE,
 				G_OPTION_ARG_NONE, &option_detach,
 				"Don't run as daemon in background" },
-	{ "debug", 'd', 0, G_OPTION_ARG_NONE, &option_debug,
-				"Enable debug information output" },
+	{ "debug", 'd', 0, G_OPTION_ARG_STRING, &option_debug,
+				"Enable debug information output", "DEBUG" },
 	{ NULL },
 };
 
@@ -103,7 +98,8 @@ int main(int argc, char *argv[])
 
 	umask(0077);
 
-	start_logging("hcitrace", "HCI trace daemon %s", VERSION);
+	start_logging(option_debug, option_detach,
+			"hcitrace", "HCI trace daemon %s", VERSION);
 
 	memset(&sa, 0, sizeof(sa));
 	sa.sa_flags = SA_NOCLDSTOP;
@@ -111,20 +107,12 @@ int main(int argc, char *argv[])
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
 	event_loop = g_main_loop_new(NULL, FALSE);
 
-	debug("Entering main loop");
+	DBG("Entering main loop");
 
 	g_main_loop_run(event_loop);
 
-- 
1.7.1

