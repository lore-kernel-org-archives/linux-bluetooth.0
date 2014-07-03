Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/19] android/tester-bluetooth: Initial bluetooth HAL tester
Date: Thu,  3 Jul 2014 18:00:06 +0200
Message-Id: <1404403222-26911-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is initial patch for android bluetooth HAL tester. It'll contain
test cases for bluetooth hal using android tester framework
(tester-main). Test step actions for this and every tester should be
declared in main tester. Cohesion of test action make action function
more useful and centralized.
---
 android/Makefile.am        |  1 +
 android/tester-bluetooth.c | 32 ++++++++++++++++++++++++++++++++
 android/tester-main.h      |  4 ++++
 3 files changed, 37 insertions(+)
 create mode 100644 android/tester-bluetooth.c

diff --git a/android/Makefile.am b/android/Makefile.am
index 0192935..8cb10ab 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -178,6 +178,7 @@ android_android_tester_ng_SOURCES = emulator/btdev.h emulator/btdev.c \
 				src/shared/timeout.h src/shared/timeout-glib.c \
 				monitor/rfcomm.h \
 				android/hardware/hardware.c \
+				android/tester-bluetooth.c \
 				android/tester-main.h android/tester-main.c
 
 android_android_tester_ng_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
new file mode 100644
index 0000000..9acf999
--- /dev/null
+++ b/android/tester-bluetooth.c
@@ -0,0 +1,32 @@
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
+#include "tester-main.h"
+
+static struct queue *list; /* List of bluetooth test cases */
+
+struct queue *get_bluetooth_tests(void)
+{
+	list = queue_new();
+
+	return list;
+}
+
+void remove_bluetooth_tests(void)
+{
+	queue_destroy(list, NULL);
+}
diff --git a/android/tester-main.h b/android/tester-main.h
index da87c8b..8f10e9f 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -84,3 +84,7 @@ struct step {
 	void (*action)(void);
 	struct bt_action_data action_result;
 };
+
+/* Get, remove test cases API */
+struct queue *get_bluetooth_tests(void);
+void remove_bluetooth_tests(void);
-- 
1.9.3

