Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Add function for printing warnings
Date: Mon, 16 Apr 2012 17:26:59 +0900
Message-id: <1334564820-31556-1-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1334562608.16897.164.camel@aeonflux>
References: <1334562608.16897.164.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

---
 src/log.c |   12 ++++++++++++
 src/log.h |    1 +
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/src/log.c b/src/log.c
index 4a50117..adbfba9 100644
--- a/src/log.c
+++ b/src/log.c
@@ -55,6 +55,18 @@ void error(const char *format, ...)
 	va_end(ap);
 }
 
+void warn(const char *format, ...)
+{
+	va_list ap;
+
+	va_start(ap, format);
+
+	vsyslog(LOG_WARNING, format, ap);
+
+	va_end(ap);
+}
+
+
 void btd_debug(const char *format, ...)
 {
 	va_list ap;
diff --git a/src/log.h b/src/log.h
index 51c52e6..cdcb146 100644
--- a/src/log.h
+++ b/src/log.h
@@ -23,6 +23,7 @@
 
 void info(const char *format, ...) __attribute__((format(printf, 1, 2)));
 void error(const char *format, ...) __attribute__((format(printf, 1, 2)));
+void warn(const char *format, ...) __attribute__((format(printf, 1, 2)));
 
 void btd_debug(const char *format, ...) __attribute__((format(printf, 1, 2)));
 
-- 
1.7.5.4

