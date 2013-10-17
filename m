Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 5/9] android: Add cutils/properties.h
Date: Thu, 17 Oct 2013 11:55:24 +0300
Message-Id: <1382000128-23762-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1382000128-23762-1-git-send-email-luiz.dentz@gmail.com>
References: <1382000128-23762-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/cutils/properties.h | 65 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 android/cutils/properties.h

diff --git a/android/cutils/properties.h b/android/cutils/properties.h
new file mode 100644
index 0000000..a9f7554
--- /dev/null
+++ b/android/cutils/properties.h
@@ -0,0 +1,65 @@
+/*
+ * Copyright (C) 2006 The Android Open Source Project
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
+ */
+
+#ifndef __CUTILS_PROPERTIES_H
+#define __CUTILS_PROPERTIES_H
+
+#include <stdlib.h>
+#include <string.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define PROPERTY_KEY_MAX   32
+#define PROPERTY_VALUE_MAX  92
+
+/* property_get: returns the length of the value which will never be
+** greater than PROPERTY_VALUE_MAX - 1 and will always be zero terminated.
+** (the length does not include the terminating zero).
+**
+** If the property read fails or returns an empty value, the default
+** value is used (if nonnull).
+*/
+static inline int property_get(const char *key, char *value,
+						const char *default_value)
+{
+	const char *env;
+
+	env = getenv(key);
+	if (!env)
+		env = default_value;
+
+	if (!value)
+		return 0;
+
+	strncpy(value, env, PROPERTY_VALUE_MAX);
+
+	return strlen(value);
+}
+
+/* property_set: returns 0 on success, < 0 on failure
+*/
+static inline int property_set(const char *key, const char *value)
+{
+	return setenv(key, value, 0);
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
-- 
1.8.3.1

