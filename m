Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 1/6] android: Add android-tester
Date: Thu, 28 Nov 2013 10:34:50 +0100
Message-Id: <1385631296-2856-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1385631296-2856-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1385631296-2856-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

This commit add android-tester.c to tree and Makefile.am.
This will contain set of unit tests for testing android daemon.

Change-Id: I0acf021aa33a0d7531f1e9faae8cd0b68d6b0438
---
 android/Makefile.am      |  4 ++++
 android/android-tester.c | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 android/android-tester.c

diff --git a/android/Makefile.am b/android/Makefile.am
index 94d231f..9390422 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -82,6 +82,10 @@ android_haltest_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
 
 android_haltest_LDFLAGS = -pthread
 
+noinst_PROGRAMS += android/android-tester
+
+android_android_tester_SOURCES = android/android-tester.c
+
 endif
 
 EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
diff --git a/android/android-tester.c b/android/android-tester.c
new file mode 100644
index 0000000..f5c42b0
--- /dev/null
+++ b/android/android-tester.c
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) 2013 Intel Corporation
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ *
+ */
+
+int main(int argc, char *argv[])
+{
+	return 0;
+}
-- 
1.8.4.2

