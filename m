Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v0 07/16] gatt: Add helper for reading characteristics
Date: Mon, 10 Mar 2014 15:50:36 -0300
Message-Id: <1394477445-8987-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1394477445-8987-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1394477445-8987-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the btd_gatt_read_attribute() helper. It reads the
attribute value based on its read callback function. The callback can
the an abstraction for reading an external object proxy or a remote
attribute, acting as a helper function for server and client
implementations.
---
 src/gatt.c | 22 ++++++++++++++++++++++
 src/gatt.h |  9 +++++++++
 2 files changed, 31 insertions(+)

diff --git a/src/gatt.c b/src/gatt.c
index 059e085..0137123 100644
--- a/src/gatt.c
+++ b/src/gatt.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <errno.h>
 #include <glib.h>
 
 #include "log.h"
@@ -194,6 +195,27 @@ fail:
 	return NULL;
 }
 
+void btd_gatt_read_attribute(struct btd_attribute *attr,
+					btd_attr_read_result_t result,
+					void *user_data)
+{
+	/*
+	 * When read_cb is available, it means that the attribute value
+	 * is dynamic, and its value must be read from the external
+	 * implementation. If "value_len" is set, the attribute value is
+	 * constant. Additional checking are performed by the attribute server
+	 * when the ATT Read request arrives based on the characteristic
+	 * properties. At this point, properties bitmask doesn't need to be
+	 * checked.
+	 */
+	if (attr->read_cb)
+		attr->read_cb(attr, result, user_data);
+	else if (attr->value_len > 0)
+		result(0, attr->value, attr->value_len, user_data);
+	else
+		result(EPERM, NULL, 0, user_data);
+}
+
 void gatt_init(void)
 {
 	DBG("Starting GATT server");
diff --git a/src/gatt.h b/src/gatt.h
index 0021076..4363769 100644
--- a/src/gatt.h
+++ b/src/gatt.h
@@ -62,3 +62,12 @@ struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid);
  */
 struct btd_attribute *btd_gatt_add_char(bt_uuid_t *uuid, uint8_t properties,
 						btd_attr_read_t read_cb);
+
+/* btd_gatt_read_attribute - Read the value of an attribute.
+ * @attr:	Attribute to be read.
+ * @result:	Callback function to be called with the result.
+ * @user_data:	Data to be passed to the result callback function.
+ */
+void btd_gatt_read_attribute(struct btd_attribute *attr,
+					btd_attr_read_result_t result,
+					void *user_data);
-- 
1.8.3.1

