Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] src: Add function for printing warnings
Date: Mon, 16 Apr 2012 20:56:32 +0900
Message-id: <1334577394-577-1-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1334565413.16897.167.camel@aeonflux>
References: <1334565413.16897.167.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

---
 src/log.c |   11 +++++++++++
 src/log.h |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/src/log.c b/src/log.c
index 4a50117..75a98a9 100644
--- a/src/log.c
+++ b/src/log.c
@@ -44,6 +44,17 @@ void info(const char *format, ...)
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
 void error(const char *format, ...)
 {
 	va_list ap;
diff --git a/src/log.h b/src/log.h
index 51c52e6..3d34fa3 100644
--- a/src/log.h
+++ b/src/log.h
@@ -22,6 +22,7 @@
  */
 
 void info(const char *format, ...) __attribute__((format(printf, 1, 2)));
+void warn(const char *format, ...) __attribute__((format(printf, 1, 2)));
 void error(const char *format, ...) __attribute__((format(printf, 1, 2)));
 
 void btd_debug(const char *format, ...) __attribute__((format(printf, 1, 2)));
-- 
1.7.5.4

