Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/15] android/tester-ng: Add android-tester-ng
Date: Fri,  9 May 2014 16:42:34 +0200
Message-Id: <1399646568-20742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Based on past experience with android-tester, new android tester is
written from scrath with fixed all known bugs and framework
inadvertances. Once new test case will be added, same one from old
android tester will be removed, until whole test case list will be
replaced.
---
 .gitignore                  |  1 +
 android/Makefile.am         | 24 ++++++++++++++++++++++++
 android/android-tester-ng.c | 21 +++++++++++++++++++++
 3 files changed, 46 insertions(+)
 create mode 100644 android/android-tester-ng.c

diff --git a/.gitignore b/.gitignore
index 7a2af5a..23887b9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -127,3 +127,4 @@ android/bluetoothd-snoop
 android/test-ipc
 android/test-*.log
 android/test-*.trs
+android/android-tester-ng
diff --git a/android/Makefile.am b/android/Makefile.am
index c7a56f8..24c348a 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -141,6 +141,30 @@ android_android_tester_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
 android_android_tester_LDFLAGS = -pthread -ldl
 
+noinst_PROGRAMS += android/android-tester-ng
+
+android_android_tester_ng_SOURCES = emulator/btdev.h emulator/btdev.c \
+				emulator/bthost.h emulator/bthost.c \
+				emulator/smp.c \
+				src/shared/crypto.h src/shared/crypto.c \
+				src/shared/io.h src/shared/io-glib.c \
+				src/shared/queue.h src/shared/queue.c \
+				src/shared/util.h src/shared/util.c \
+				src/shared/mgmt.h src/shared/mgmt.c \
+				src/shared/hciemu.h src/shared/hciemu.c \
+				src/shared/tester.h src/shared/tester.c \
+				src/shared/timeout.h src/shared/timeout-glib.c \
+				monitor/rfcomm.h \
+				android/hardware/hardware.c \
+				android/android-tester-ng.c
+
+android_android_tester_ng_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
+				-DPLUGINDIR=\""$(android_plugindir)"\"
+
+android_android_tester_ng_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+
+android_android_tester_ng_LDFLAGS = -pthread -ldl
+
 noinst_PROGRAMS += android/ipc-tester
 
 android_ipc_tester_SOURCES = emulator/btdev.h emulator/btdev.c \
diff --git a/android/android-tester-ng.c b/android/android-tester-ng.c
new file mode 100644
index 0000000..a3c3d3c
--- /dev/null
+++ b/android/android-tester-ng.c
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) 2014 Intel Corporation
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
1.9.2

