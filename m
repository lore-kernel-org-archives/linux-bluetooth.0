Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 6/6] android: Remove not needed cutils/log.h stub
Date: Sun, 20 Oct 2013 19:45:46 +0200
Message-Id: <1382291146-23518-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382291146-23518-1-git-send-email-szymon.janc@tieto.com>
References: <1382291146-23518-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.android     |  2 --
 android/cutils/log.h | 29 -----------------------------
 2 files changed, 31 deletions(-)
 delete mode 100644 android/cutils/log.h

diff --git a/Makefile.android b/Makefile.android
index e9992d9..8196583 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -31,7 +31,6 @@ android_libhal_internal_la_SOURCES = android/hal.h android/hal-bluetooth.c \
 					android/hardware/bt_rc.h \
 					android/hardware/bt_sock.h \
 					android/hardware/hardware.h \
-					android/cutils/log.h \
 					android/cutils/properties.h \
 					android/hal-log.h
 
@@ -93,5 +92,4 @@ EXTRA_DIST += android/hardware/bluetooth.h \
 		android/hardware/bt_rc.h \
 		android/hardware/bt_sock.h \
 		android/hardware/hardware.h \
-		android/cutils/log.h \
 		android/cutils/properties.h
diff --git a/android/cutils/log.h b/android/cutils/log.h
deleted file mode 100644
index 389542b..0000000
--- a/android/cutils/log.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * Copyright (C) 2007 The Android Open Source Project
- *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- */
-
-#ifndef _CUTILS_LOG_H
-#define _CUTILS_LOG_H
-
-static inline void ALOG() {};
-
-#define ALOGV(...) ALOG("V", __VA_ARGS__)
-#define ALOGD(...) ALOG("D", __VA_ARGS__)
-#define ALOGI(...) ALOG("I", __VA_ARGS__)
-#define ALOGW(...) ALOG("W", __VA_ARGS__)
-#define ALOGE(...) ALOG("E", __VA_ARGS__)
-#define LOG_ALWAYS_FATAL(...)   do { ALOGE(__VA_ARGS__); exit(1); } while (0)
-
-#endif // _CUTILS_LOG_H
-- 
1.8.4

