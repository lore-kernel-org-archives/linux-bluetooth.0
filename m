Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org,
	Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH BlueZ v2 06/18] gatt: Add helper for creating GATT services
Date: Tue, 21 Jan 2014 10:26:42 -0300
Message-Id: <1390310814-19880-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1390310814-19880-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1390310814-19880-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andre Guedes <andre.guedes@openbossa.org>

This patch adds the btd_gatt_add_service() helper which adds a
GATT Service declaration to the local attribute database.
---
 lib/uuid.h |  5 +++++
 src/gatt.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/gatt.h | 10 ++++++++++
 3 files changed, 77 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index c24cee5..237145b 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -158,6 +158,11 @@ void bt_uuid_to_uuid128(const bt_uuid_t *src, bt_uuid_t *dst);
 int bt_uuid_to_string(const bt_uuid_t *uuid, char *str, size_t n);
 int bt_string_to_uuid(bt_uuid_t *uuid, const char *string);
 
+static inline int bt_uuid_len(const bt_uuid_t *uuid)
+{
+	return uuid->type / 8;
+}
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/gatt.c b/src/gatt.c
index e8b691a..ee045b1 100644
--- a/src/gatt.c
+++ b/src/gatt.c
@@ -27,11 +27,73 @@
 
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
+static GList *local_attribute_db;
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
+	/*
+	 * Service DECLARATION
+	 *
+	 *   TYPE         ATTRIBUTE VALUE
+	 * +-------+---------------------------------+
+	 * |0x2800 | 0xYYYY...                       |
+	 * | (1)   | (2)                             |
+	 * +------+----------------------------------+
+	 * (1) - 2 octets: Primary/Secondary Service UUID
+	 * (2) - 2 or 16 octets: Service UUID
+	 */
+
+	attr->type = primary_uuid;
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
index 3a320b4..8dd1312 100644
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

