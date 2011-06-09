Return-Path: <cyrus@holtmann.org>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To: linux-bluetooth@vger.kernel.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH] Fix typo from deamon to daemon
Date: Thu,  9 Jun 2011 23:00:50 +0900
Message-Id: <1307628050-3670-1-git-send-email-iwamatsu@nigauri.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/log.c     |    2 +-
 tracer/main.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/log.c b/src/log.c
index 6fbbba9..2c492e9 100644
--- a/src/log.c
+++ b/src/log.c
@@ -111,7 +111,7 @@ void __btd_log_init(const char *debug, int detach)
 
 	openlog("bluetoothd", option, LOG_DAEMON);
 
-	syslog(LOG_INFO, "Bluetooth deamon %s", VERSION);
+	syslog(LOG_INFO, "Bluetooth daemon %s", VERSION);
 }
 
 void __btd_log_cleanup(void)
diff --git a/tracer/main.c b/tracer/main.c
index 0806ffe..3b37f59 100644
--- a/tracer/main.c
+++ b/tracer/main.c
@@ -118,7 +118,7 @@ int main(int argc, char *argv[])
 
 	openlog("hcitrace", LOG_PID | LOG_NDELAY | LOG_PERROR, LOG_DAEMON);
 
-	syslog(LOG_INFO, "HCI trace deamon %s", VERSION);
+	syslog(LOG_INFO, "HCI trace daemon %s", VERSION);
 
 	memset(&sa, 0, sizeof(sa));
 	sa.sa_flags = SA_NOCLDSTOP;
-- 
1.7.5.3

