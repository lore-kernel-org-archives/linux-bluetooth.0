Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 1/2] android: Create debug hal-utils helpers
Date: Wed,  6 Nov 2013 17:10:42 +0200
Message-Id: <1383750643-1139-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <903E7C5D-33E0-4EDB-BD6D-02B183278514@holtmann.org>
References: <903E7C5D-33E0-4EDB-BD6D-02B183278514@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Create hal-utils helpers which helps to decode packets Android
sends through HAL interface.
---
 android/Android.mk        |    2 ++
 android/Makefile.am       |    3 ++-
 android/client/if-gatt.c  |    1 +
 android/client/textconv.c |   42 ++------------------------------
 android/client/textconv.h |    2 --
 android/hal-utils.c       |   58 +++++++++++++++++++++++++++++++++++++++++++++
 android/hal-utils.h       |   26 ++++++++++++++++++++
 7 files changed, 91 insertions(+), 43 deletions(-)
 create mode 100644 android/hal-utils.c
 create mode 100644 android/hal-utils.h

diff --git a/android/Android.mk b/android/Android.mk
index d76dfaf..32bb591 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -88,6 +88,7 @@ LOCAL_SRC_FILES := \
 	hal-pan.c \
 	hal-av.c \
 	client/textconv.c \
+	hal-utils.c \
 
 LOCAL_C_INCLUDES += \
 	$(call include-path-for, system-core) \
@@ -125,6 +126,7 @@ LOCAL_SRC_FILES := \
 	client/if-hh.c \
 	client/if-pan.c \
 	client/if-sock.c \
+	hal-utils.c \
 
 ANDROID_4_3_OR_ABOVE := $(shell echo 0 | awk -v v=$(PLATFORM_SDK_VERSION) 'END {print (v > 17) ? 1 : 0}')
 
diff --git a/android/Makefile.am b/android/Makefile.am
index 8619641..e4adf6c 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -68,7 +68,8 @@ android_haltest_SOURCES = android/client/haltest.c \
 				android/client/if-hh.c \
 				android/client/if-pan.c \
 				android/client/if-sock.c \
-				android/client/hwmodule.c
+				android/client/hwmodule.c \
+				android/hal-utils.h android/hal-utils.c
 
 android_haltest_LDADD = android/libhal-internal.la
 
diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index b2b20cb..bb53952 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -17,6 +17,7 @@
 
 #include <hardware/bluetooth.h>
 
+#include "../hal-utils.h"
 #include "if-main.h"
 
 const btgatt_interface_t *if_gatt = NULL;
diff --git a/android/client/textconv.c b/android/client/textconv.c
index 4def3da..469b2c3 100644
--- a/android/client/textconv.c
+++ b/android/client/textconv.c
@@ -19,6 +19,8 @@
 #include <stdio.h>
 #include <hardware/bluetooth.h>
 
+#include "../hal-utils.h"
+
 #include "textconv.h"
 
 /*
@@ -154,39 +156,6 @@ void str2bt_bdaddr_t(const char *str, bt_bdaddr_t *bd_addr)
 				&p[0], &p[1], &p[2], &p[3], &p[4], &p[5]);
 }
 
-static const char BT_BASE_UUID[] = {
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
-	0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb
-};
-
-/*
- * converts uuid to string
- * buf should be at least 39 bytes
- *
- * returns string representation of uuid
- */
-char *bt_uuid_t2str(const bt_uuid_t *uuid, char *buf)
-{
-	int shift = 0;
-	int i;
-	int is_bt;
-
-	is_bt = !memcmp(&uuid->uu[4], &BT_BASE_UUID[4], sizeof(bt_uuid_t) - 4);
-
-	for (i = 0; i < (int) sizeof(bt_uuid_t); i++) {
-		if (i == 4 && is_bt)
-			break;
-
-		if (i == 4 || i == 6 || i == 8 || i == 10) {
-			buf[i * 2 + shift] = '-';
-			shift++;
-		}
-		sprintf(buf + i * 2 + shift, "%02x", uuid->uu[i]);
-	}
-
-	return buf;
-}
-
 /* converts string to uuid */
 void str2bt_uuid_t(const char *str, bt_uuid_t *uuid)
 {
@@ -234,13 +203,6 @@ char *bdaddr2str(const bt_bdaddr_t *bd_addr)
 	return bt_bdaddr_t2str(bd_addr, buf);
 }
 
-static char *btuuid2str(const bt_uuid_t *uuid)
-{
-	static char buf[MAX_UUID_STR_LEN];
-
-	return bt_uuid_t2str(uuid, buf);
-}
-
 char *btproperty2str(const bt_property_t *property)
 {
 	static char buf[4096];
diff --git a/android/client/textconv.h b/android/client/textconv.h
index 1c848ef..837eb4e 100644
--- a/android/client/textconv.h
+++ b/android/client/textconv.h
@@ -103,8 +103,6 @@ static struct int2str __##type##2str[] = {
 char *bt_bdaddr_t2str(const bt_bdaddr_t *bd_addr, char *buf);
 void str2bt_bdaddr_t(const char *str, bt_bdaddr_t *bd_addr);
 
-#define MAX_UUID_STR_LEN 37
-char *bt_uuid_t2str(const bt_uuid_t *uuid, char *buf);
 void str2bt_uuid_t(const char *str, bt_uuid_t *uuid);
 
 char *btproperty2str(const bt_property_t *property);
diff --git a/android/hal-utils.c b/android/hal-utils.c
new file mode 100644
index 0000000..84cfad1
--- /dev/null
+++ b/android/hal-utils.c
@@ -0,0 +1,58 @@
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
+#include <stdio.h>
+#include <string.h>
+
+#include <hardware/bluetooth.h>
+
+#include "hal-utils.h"
+
+/*
+ * converts uuid to string
+ * buf should be at least 39 bytes
+ *
+ * returns string representation of uuid
+ */
+char *bt_uuid_t2str(const bt_uuid_t *uuid, char *buf)
+{
+	int shift = 0;
+	int i;
+	int is_bt;
+
+	is_bt = !memcmp(&uuid->uu[4], &BT_BASE_UUID[4], sizeof(bt_uuid_t) - 4);
+
+	for (i = 0; i < (int) sizeof(bt_uuid_t); i++) {
+		if (i == 4 && is_bt)
+			break;
+
+		if (i == 4 || i == 6 || i == 8 || i == 10) {
+			buf[i * 2 + shift] = '-';
+			shift++;
+		}
+		sprintf(buf + i * 2 + shift, "%02x", uuid->uu[i]);
+	}
+
+	return buf;
+}
+
+char *btuuid2str(const bt_uuid_t *uuid)
+{
+	static char buf[MAX_UUID_STR_LEN];
+
+	return bt_uuid_t2str(uuid, buf);
+}
diff --git a/android/hal-utils.h b/android/hal-utils.h
new file mode 100644
index 0000000..d40b430
--- /dev/null
+++ b/android/hal-utils.h
@@ -0,0 +1,26 @@
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
+#define MAX_UUID_STR_LEN 37
+
+static const char BT_BASE_UUID[] = {
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
+	0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb
+};
+
+char *btuuid2str(const bt_uuid_t *uuid);
+char *bt_uuid_t2str(const bt_uuid_t *uuid, char *buf);
-- 
1.7.10.4

