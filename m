Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 03/16] android: Enable Socket interface
Date: Fri, 27 Sep 2013 17:12:28 +0300
Message-Id: <1380291161-10232-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Returns socket interface, use header hal.h to avoid externs.
---
 android/hal.h           |   18 ++++++++++++++++++
 android/hal_bluetooth.c |   12 ++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 android/hal.h

diff --git a/android/hal.h b/android/hal.h
new file mode 100644
index 0000000..40fbf03
--- /dev/null
+++ b/android/hal.h
@@ -0,0 +1,18 @@
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
+btsock_interface_t *bt_get_sock_interface(void);
diff --git a/android/hal_bluetooth.c b/android/hal_bluetooth.c
index 9970374..5298618 100644
--- a/android/hal_bluetooth.c
+++ b/android/hal_bluetooth.c
@@ -21,10 +21,13 @@
 #include <stdbool.h>
 
 #include <hardware/bluetooth.h>
+#include <hardware/bt_sock.h>
 
 #define LOG_TAG "BlueZ"
 #include <cutils/log.h>
 
+#include "hal.h"
+
 bt_callbacks_t *bt_hal_cbacks = NULL;
 
 static bool interface_ready(void)
@@ -32,6 +35,12 @@ static bool interface_ready(void)
 	return bt_hal_cbacks != NULL;
 }
 
+static bool is_profile(const char *profile, const char *str)
+{
+	return (strlen(str) == strlen(profile)) &&
+		(strncmp(profile, str, strlen(str)) == 0);
+}
+
 static int init(bt_callbacks_t *callbacks)
 {
 	ALOGD(__func__);
@@ -246,6 +255,9 @@ static const void *get_profile_interface(const char *profile_id)
 	if (interface_ready() == false)
 		return NULL;
 
+	if (is_profile(profile_id, BT_PROFILE_SOCKETS_ID))
+		return bt_get_sock_interface();
+
 	return NULL;
 }
 
-- 
1.7.10.4

