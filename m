Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCH] Fix regression with debug via SIGUSR2
Date: Sat,  5 Jun 2010 01:51:02 -0300
Message-Id: <1275713462-20977-1-git-send-email-gustavo@padovan.org>
In-Reply-To: <1275712886-20127-3-git-send-email-gustavo@padovan.org>
References: <1275712886-20127-3-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The new dynamic debug feature was not using the SIGUSR2 signal so this was
causing bluetoothd to crash when one tries to toggle debug via SIGUSR2.
This patch brings back such compatibility andadds debug_string and
debug_enabled vars.
---
 src/log.c  |   17 +++++++++++++++--
 src/log.h  |    4 +++-
 src/main.c |    8 ++++++++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/src/log.c b/src/log.c
index cb02aad..1bc0a42 100644
--- a/src/log.c
+++ b/src/log.c
@@ -71,6 +71,8 @@ extern struct btd_debug_desc __stop___debug[];
 
 static gchar **enabled = NULL;
 
+int debug_enabled = FALSE;
+
 static gboolean is_enabled(struct btd_debug_desc *desc)
 {
         int i;
@@ -90,14 +92,25 @@ static gboolean is_enabled(struct btd_debug_desc *desc)
         return 0;
 }
 
+void __btd_toggle_debug()
+{
+	debug_enabled = !debug_enabled;
+}
+
 void __btd_log_init(const char *debug, int detach)
 {
 	int option = LOG_NDELAY | LOG_PID;
 	struct btd_debug_desc *desc;
 	const char *name = NULL, *file = NULL;
 
-	if (debug != NULL)
-		enabled = g_strsplit_set(debug, ":, ", 0);
+	if (debug != NULL) {
+		debug_enabled = TRUE;
+	} else {
+		debug = g_strdup("*");
+		debug_enabled = FALSE;
+	}
+
+	enabled = g_strsplit_set(debug, ":, ", 0);
 
 	for (desc = __start___debug; desc < __stop___debug; desc++) {
 		if (file != NULL || name != NULL) {
diff --git a/src/log.h b/src/log.h
index 33168c7..c9412c4 100644
--- a/src/log.h
+++ b/src/log.h
@@ -29,6 +29,7 @@ void debug(const char *format, ...) __attribute__((format(printf, 1, 2)));
 
 void __btd_log_init(const char *debug, int detach);
 void __btd_log_cleanup(void);
+void __btd_toggle_debug();
 
 struct btd_debug_desc {
         const char *name;
@@ -51,7 +52,8 @@ struct btd_debug_desc {
         __attribute__((used, section("__debug"), aligned(8))) = { \
                 .file = __FILE__, .flags = BTD_DEBUG_FLAG_DEFAULT, \
         }; \
-        if (__btd_debug_desc.flags & BTD_DEBUG_FLAG_PRINT) \
+        if (debug_enabled && \
+			__btd_debug_desc.flags & BTD_DEBUG_FLAG_PRINT) \
                 debug("%s:%s() " fmt, \
                                         __FILE__, __FUNCTION__ , ## arg); \
 } while (0)
diff --git a/src/main.c b/src/main.c
index 3118a34..ba18523 100644
--- a/src/main.c
+++ b/src/main.c
@@ -288,6 +288,11 @@ static void sig_term(int sig)
 	g_main_loop_quit(event_loop);
 }
 
+static void sig_debug(int sig)
+{
+	__btd_toggle_debug();
+}
+
 static gchar *option_debug = NULL;
 static gboolean option_detach = TRUE;
 static gboolean option_udev = FALSE;
@@ -406,6 +411,9 @@ int main(int argc, char *argv[])
 	sigaction(SIGTERM, &sa, NULL);
 	sigaction(SIGINT,  &sa, NULL);
 
+	sa.sa_handler = sig_debug;
+	sigaction(SIGUSR2, &sa, NULL);
+
 	sa.sa_handler = SIG_IGN;
 	sigaction(SIGPIPE, &sa, NULL);
 
-- 
1.7.1

