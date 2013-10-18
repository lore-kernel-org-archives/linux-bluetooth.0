Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/5] android: Fix cutils/log.h stubs
Date: Sat, 19 Oct 2013 01:01:38 +0200
Message-Id: <1382137302-17237-2-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1382137302-17237-1-git-send-email-szymon.janc@gmail.com>
References: <1382137302-17237-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@tieto.com>

Provide dummy functions that will use macro parameters. This fix
build errors about set-but-not-used used local variables on linux.
---
 android/cutils/log.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/android/cutils/log.h b/android/cutils/log.h
index d87da72..7374add 100644
--- a/android/cutils/log.h
+++ b/android/cutils/log.h
@@ -17,11 +17,13 @@
 #ifndef _CUTILS_LOG_H
 #define _CUTILS_LOG_H
 
-#define ALOGV(...)
-#define ALOGD(...)
-#define ALOGI(...)
-#define ALOGW(...)
-#define ALOGE(...)
+static inline void dummy_printf(const char *fmt, ...) { }
+
+#define ALOGV(...) dummy_printf("", __VA_ARGS__)
+#define ALOGD(...) dummy_printf("", __VA_ARGS__)
+#define ALOGI(...) dummy_printf("", __VA_ARGS__)
+#define ALOGW(...) dummy_printf("", __VA_ARGS__)
+#define ALOGE(...) dummy_printf("", __VA_ARGS__)
 #define LOG_ALWAYS_FATAL(...)   do { ALOGE(__VA_ARGS__); exit(1); } while (0)
 
 #endif // _CUTILS_LOG_H
-- 
1.8.4.rc3

