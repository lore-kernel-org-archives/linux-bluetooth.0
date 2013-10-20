Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/6] android: Improve cutils/log.h stubs
Date: Sun, 20 Oct 2013 11:53:54 +0200
Message-Id: <1382262838-25725-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382262838-25725-1-git-send-email-szymon.janc@tieto.com>
References: <1382262838-25725-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Provide dummy function that will use ALOG* macros parameters. This fix
build errors about set-but-not-used used local variables on linux.
---
 android/cutils/log.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/android/cutils/log.h b/android/cutils/log.h
index d87da72..389542b 100644
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
+static inline void ALOG() {};
+
+#define ALOGV(...) ALOG("V", __VA_ARGS__)
+#define ALOGD(...) ALOG("D", __VA_ARGS__)
+#define ALOGI(...) ALOG("I", __VA_ARGS__)
+#define ALOGW(...) ALOG("W", __VA_ARGS__)
+#define ALOGE(...) ALOG("E", __VA_ARGS__)
 #define LOG_ALWAYS_FATAL(...)   do { ALOGE(__VA_ARGS__); exit(1); } while (0)
 
 #endif // _CUTILS_LOG_H
-- 
1.8.4

