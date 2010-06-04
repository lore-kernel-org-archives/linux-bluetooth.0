Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCH 1/4] Fix regression with debug via SIGUSR2
Date: Fri,  4 Jun 2010 07:16:50 -0300
Message-Id: <1275646613-32639-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The new dynamic debug feature was not using the SIGUSR2 signal so this was
causing bluetoothd to crash when one tries to toogle debug via SIGUSR2.
This patch brings back such compatibility.
---
 src/log.c  |   31 +++++++++++++++++++++++++++++--
 src/log.h  |    1 +
 src/main.c |    8 ++++++++
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/src/log.c b/src/log.c
index 29e2d7d..4ef178a 100644
--- a/src/log.c
+++ b/src/log.c
@@ -95,9 +95,8 @@ static gboolean is_enabled(struct btd_debug_desc *desc)
         return 0;
 }
 
-void __btd_log_init(const char *debug, int detach)
+static void turn_debug_on(const char *debug)
 {
-	int option = LOG_NDELAY | LOG_PID;
 	struct btd_debug_desc *desc;
 	const char *name = NULL, *file = NULL;
 
@@ -116,6 +115,34 @@ void __btd_log_init(const char *debug, int detach)
 		if (is_enabled(desc))
 			desc->flags |= BTD_DEBUG_FLAG_PRINT;
 	}
+}
+
+static void turn_debug_off()
+{
+	struct btd_debug_desc *desc;
+
+	for (desc = __start___debug; desc < __stop___debug; desc++) {
+		if (is_enabled(desc))
+			desc->flags &= ~BTD_DEBUG_FLAG_PRINT;
+	}
+
+	g_strfreev(enabled);
+	enabled = NULL;
+}
+
+void __btd_toogle_debug()
+{
+	if (enabled == NULL)
+		turn_debug_on("*");
+	else
+		turn_debug_off();
+}
+
+void __btd_log_init(const char *debug, int detach)
+{
+	int option = LOG_NDELAY | LOG_PID;
+
+	turn_debug_on(debug);
 
 	if (!detach)
 		option |= LOG_PERROR;
diff --git a/src/log.h b/src/log.h
index 9af51e7..8c1b937 100644
--- a/src/log.h
+++ b/src/log.h
@@ -30,6 +30,7 @@ void debug(const char *format, ...) __attribute__((format(printf, 1, 2)));
 
 void __btd_log_init(const char *debug, int detach);
 void __btd_log_cleanup(void);
+void __btd_toogle_debug();
 
 struct btd_debug_desc {
         const char *name;
diff --git a/src/main.c b/src/main.c
index 3118a34..d6559b5 100644
--- a/src/main.c
+++ b/src/main.c
@@ -288,6 +288,11 @@ static void sig_term(int sig)
 	g_main_loop_quit(event_loop);
 }
 
+static void sig_debug(int sig)
+{
+	__btd_toogle_debug();
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

