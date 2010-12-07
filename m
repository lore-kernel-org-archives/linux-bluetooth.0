Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Fix logging for obex-client
Date: Tue,  7 Dec 2010 17:01:00 +0200
Message-Id: <1291734061-24408-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1291734061-24408-1-git-send-email-luiz.dentz@gmail.com>
References: <1291734061-24408-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Since obex-client and obexd share the same log code they both were using
obexd for openlog which makes it very confusing when reading the logs.

To fix this now __obex_log_init takes the binary name so that each daemon
can be properly labeled.
---
 client/main.c |    2 +-
 src/log.c     |    6 +++---
 src/log.h     |    2 +-
 src/main.c    |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/client/main.c b/client/main.c
index 74db15e..20d56d2 100644
--- a/client/main.c
+++ b/client/main.c
@@ -613,7 +613,7 @@ int main(int argc, char *argv[])
 
 	event_loop = g_main_loop_new(NULL, FALSE);
 
-	__obex_log_init(option_debug, !option_stderr);
+	__obex_log_init("obex-client", option_debug, !option_stderr);
 
 	DBG("Entering main loop");
 
diff --git a/src/log.c b/src/log.c
index 39489a2..baa57c5 100644
--- a/src/log.c
+++ b/src/log.c
@@ -100,7 +100,7 @@ void __obex_log_enable_debug()
 		desc->flags |= OBEX_DEBUG_FLAG_PRINT;
 }
 
-void __obex_log_init(const char *debug, int detach)
+void __obex_log_init(const char *label, const char *debug, int detach)
 {
 	int option = LOG_NDELAY | LOG_PID;
 	struct obex_debug_desc *desc;
@@ -125,9 +125,9 @@ void __obex_log_init(const char *debug, int detach)
 	if (!detach)
 		option |= LOG_PERROR;
 
-	openlog("obexd", option, LOG_DAEMON);
+	openlog(label, option, LOG_DAEMON);
 
-	syslog(LOG_INFO, "OBEX daemon %s", VERSION);
+	syslog(LOG_INFO, "%s daemon %s", label, VERSION);
 }
 
 void __obex_log_cleanup(void)
diff --git a/src/log.h b/src/log.h
index 1bf1b05..e322565 100644
--- a/src/log.h
+++ b/src/log.h
@@ -26,7 +26,7 @@ void error(const char *format, ...) __attribute__((format(printf, 1, 2)));
 
 void obex_debug(const char *format, ...) __attribute__((format(printf, 1, 2)));
 
-void __obex_log_init(const char *debug, int detach);
+void __obex_log_init(const char *label, const char *debug, int detach);
 void __obex_log_cleanup(void);
 void __obex_log_enable_debug(void);
 
diff --git a/src/main.c b/src/main.c
index 14e7d16..1e78615 100644
--- a/src/main.c
+++ b/src/main.c
@@ -218,7 +218,7 @@ int main(int argc, char *argv[])
 		exit(EXIT_FAILURE);
 	}
 
-	__obex_log_init(option_debug, option_detach);
+	__obex_log_init("obexd", option_debug, option_detach);
 
 	DBG("Entering main loop");
 
-- 
1.7.1

