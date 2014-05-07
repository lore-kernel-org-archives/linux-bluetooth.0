Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] shared/tester: Add support for debug logs for tester
Date: Wed,  7 May 2014 16:45:07 +0200
Message-Id: <1399473907-9698-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It allows to print debug logs if debug mode is enabled. It could help in
case of additional debug prints need (verbose mode).
---
 src/shared/tester.c | 14 ++++++++++++++
 src/shared/tester.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index 56e5696..7f1b980 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -134,6 +134,20 @@ void tester_print(const char *format, ...)
 	printf("%s\n", COLOR_OFF);
 }
 
+void tester_debug(const char *format, ...)
+{
+	va_list ap;
+
+	if (!tester_use_debug())
+		return;
+
+	printf("   tester-dbg: %s", COLOR_WHITE);
+	va_start(ap, format);
+	vprintf(format, ap);
+	va_end(ap);
+	printf("%s\n", COLOR_OFF);
+}
+
 void tester_warn(const char *format, ...)
 {
 	va_list ap;
diff --git a/src/shared/tester.h b/src/shared/tester.h
index 85d5e95..0231f19 100644
--- a/src/shared/tester.h
+++ b/src/shared/tester.h
@@ -33,6 +33,8 @@ void tester_print(const char *format, ...)
 				__attribute__((format(printf, 1, 2)));
 void tester_warn(const char *format, ...)
 				__attribute__((format(printf, 1, 2)));
+void tester_debug(const char *format, ...)
+				__attribute__((format(printf, 1, 2)));
 
 typedef void (*tester_destroy_func_t)(void *user_data);
 typedef void (*tester_data_func_t)(const void *test_data);
-- 
1.9.2

