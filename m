Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC BlueZ v0 05/17] gatt: Add helper for creating GATT services
Date: Wed, 27 Nov 2013 17:50:45 -0300
Message-Id: <1385585457-26951-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1385585457-26951-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1385585457-26951-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andre Guedes <andre.guedes@openbossa.org>

This patch adds the btd_gatt_add_service() helper which adds a
GATT Service declaration to the local attribute database.
---
 lib/uuid.c | 14 ++++++++++++++
 lib/uuid.h |  2 ++
 src/gatt.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/gatt.h | 10 ++++++++++
 4 files changed, 76 insertions(+)

diff --git a/lib/uuid.c b/lib/uuid.c
index 4363aee..15d1321 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -276,3 +276,17 @@ int bt_uuid_strcmp(const void *a, const void *b)
 {
 	return strcasecmp(a, b);
 }
+
+int bt_uuid_len(const bt_uuid_t *uuid)
+{
+	switch (uuid->type) {
+	case BT_UUID16:
+		return 2;
+	case BT_UUID32:
+		return 4;
+	case BT_UUID128:
+		return 16;
+	default:
+		return 0;
+	}
+}
diff --git a/lib/uuid.h b/lib/uuid.h
index 87e0bd0..f8b2593 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -136,6 +136,8 @@ void bt_uuid_to_uuid128(const bt_uuid_t *src, bt_uuid_t *dst);
 int bt_uuid_to_string(const bt_uuid_t *uuid, char *str, size_t n);
 int bt_string_to_uuid(bt_uuid_t *uuid, const char *string);
 
+int bt_uuid_len(const bt_uuid_t *uuid);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/gatt.c b/src/gatt.c
index 45fd9f8..86023a4 100644
--- a/src/gatt.c
+++ b/src/gatt.c
@@ -27,11 +27,61 @@
 
 #include <glib.h>
 
+#include "adapter.h"
+#include "device.h"
+
 #include "log.h"
+#include "lib/uuid.h"
+#include "attrib/att.h"
 
 #include "gatt-dbus.h"
 #include "gatt.h"
 
+/* Common GATT UUIDs */
+static const bt_uuid_t primary_uuid  = { .type = BT_UUID16,
+					.value.u16 = GATT_PRIM_SVC_UUID };
+
+struct btd_attribute {
+	uint16_t handle;
+	bt_uuid_t type;
+	uint16_t value_len;
+	uint8_t value[0];
+};
+
+static GList *local_attribute_db = NULL;
+static uint16_t next_handle = 0x0001;
+
+static int local_database_add(uint16_t handle, struct btd_attribute *attr)
+{
+	attr->handle = handle;
+
+	local_attribute_db = g_list_append(local_attribute_db, attr);
+
+	return 0;
+}
+
+struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
+{
+	uint16_t len = bt_uuid_len(uuid);
+	struct btd_attribute *attr = g_malloc0(sizeof(struct btd_attribute) +
+									len);
+
+	memcpy(&attr->type, &primary_uuid, sizeof(primary_uuid));
+
+	att_put_uuid(*uuid, attr->value);
+	attr->value_len = len;
+
+	if (local_database_add(next_handle, attr) < 0) {
+		g_free(attr);
+		return NULL;
+	}
+
+	/* TODO: missing overflow checking */
+	next_handle = next_handle + 1;
+
+	return attr;
+}
+
 void gatt_init(void)
 {
 	DBG("Starting GATT server");
diff --git a/src/gatt.h b/src/gatt.h
index 03a68a1..41ca4b6 100644
--- a/src/gatt.h
+++ b/src/gatt.h
@@ -21,6 +21,16 @@
  *
  */
 
+struct btd_attribute;
+
 void gatt_init(void);
 
 void gatt_cleanup(void);
+
+/* btd_gatt_add_service - Add a service declaration to local attribute database.
+ * @uuid:	Service UUID.
+ *
+ * Returns a reference to service declaration attribute. In case of error,
+ * NULL is returned.
+ */
+struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid);
-- 
1.8.3.1

