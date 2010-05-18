Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org
Subject: [PATCH 1/4] Add manual log to hcitrace
Date: Mon, 17 May 2010 23:27:15 -0300
Message-Id: <1274149638-31580-1-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Remove the BlueZ log scheme from hcitrace to avoid intersection with the
new BlueZ dynamic debug.
---
 Makefile.tools |    3 +--
 tracer/main.c  |   38 ++++++++++++++++++++++++++------------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index d9a2425..b311223 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -63,8 +63,7 @@ EXTRA_DIST += tools/rfcomm.conf
 if TRACER
 sbin_PROGRAMS += tracer/hcitrace
 
-tracer_hcitrace_SOURCES = tracer/main.c \
-				src/logging.h src/logging.c
+tracer_hcitrace_SOURCES = tracer/main.c
 tracer_hcitrace_LDADD = lib/libbluetooth.la \
 				@GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS@
 tracer_hcitrace_DEPENDENCIES = lib/libbluetooth.la
diff --git a/tracer/main.c b/tracer/main.c
index 5ec5ff2..0806ffe 100644
--- a/tracer/main.c
+++ b/tracer/main.c
@@ -32,11 +32,10 @@
 #include <string.h>
 #include <signal.h>
 #include <sys/stat.h>
+#include <syslog.h>
 
 #include <glib.h>
 
-#include "logging.h"
-
 #ifdef HAVE_CAPNG
 #include <cap-ng.h>
 #endif
@@ -48,11 +47,6 @@ static void sig_term(int sig)
 	g_main_loop_quit(event_loop);
 }
 
-static void sig_debug(int sig)
-{
-	toggle_debug();
-}
-
 static gboolean option_detach = TRUE;
 static gboolean option_debug = FALSE;
 
@@ -65,6 +59,25 @@ static GOptionEntry options[] = {
 	{ NULL },
 };
 
+static void debug(const char *format, ...)
+{
+	va_list ap;
+
+	if (!option_debug)
+		return;
+
+	va_start(ap, format);
+
+	vsyslog(LOG_DEBUG, format, ap);
+
+	va_end(ap);
+}
+
+static void sig_debug(int sig)
+{
+	option_debug = !option_debug;
+}
+
 int main(int argc, char *argv[])
 {
 	GOptionContext *context;
@@ -103,7 +116,9 @@ int main(int argc, char *argv[])
 
 	umask(0077);
 
-	start_logging("hcitrace", "HCI trace daemon %s", VERSION);
+	openlog("hcitrace", LOG_PID | LOG_NDELAY | LOG_PERROR, LOG_DAEMON);
+
+	syslog(LOG_INFO, "HCI trace deamon %s", VERSION);
 
 	memset(&sa, 0, sizeof(sa));
 	sa.sa_flags = SA_NOCLDSTOP;
@@ -118,8 +133,7 @@ int main(int argc, char *argv[])
 	sigaction(SIGPIPE, &sa, NULL);
 
 	if (option_debug == TRUE) {
-		info("Enabling debug information");
-		enable_debug();
+		syslog(LOG_INFO, "Enabling debug information");
 	}
 
 	event_loop = g_main_loop_new(NULL, FALSE);
@@ -130,9 +144,9 @@ int main(int argc, char *argv[])
 
 	g_main_loop_unref(event_loop);
 
-	info("Exit");
+	syslog(LOG_INFO, "Exit");
 
-	stop_logging();
+	closelog();
 
 	return 0;
 }
-- 
1.7.1
