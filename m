Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH BlueZ v0 1/7] gatt: Add helper for removing GATT services
Date: Wed,  2 Apr 2014 15:30:20 -0300
Message-Id: <1396463426-7268-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1396463426-7268-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1396463426-7268-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andre Guedes <andre.guedes@openbossa.org>

This patch adds the btd_gatt_remove_service() helper which removes a GATT
primary (or secondary) Service declaration (including its characteristics)
from the local attribute database.
---
 src/gatt.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 src/gatt.h |  7 +++++++
 2 files changed, 49 insertions(+)

diff --git a/src/gatt.c b/src/gatt.c
index f07effa..3060462 100644
--- a/src/gatt.c
+++ b/src/gatt.c
@@ -26,6 +26,7 @@
 #endif
 
 #include <glib.h>
+#include <stdbool.h>
 
 #include "log.h"
 #include "lib/uuid.h"
@@ -104,6 +105,18 @@ static struct btd_attribute *new_attribute(const bt_uuid_t *type,
 	return attr;
 }
 
+static bool is_service(const struct btd_attribute *attr)
+{
+	if (attr->type.type != BT_UUID16)
+		return false;
+
+	if (attr->type.value.u16 == GATT_PRIM_SVC_UUID ||
+			attr->type.value.u16 == GATT_SND_SVC_UUID)
+		return true;
+
+	return false;
+}
+
 static int local_database_add(uint16_t handle, struct btd_attribute *attr)
 {
 	attr->handle = handle;
@@ -149,6 +162,35 @@ struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
 	return attr;
 }
 
+void btd_gatt_remove_service(struct btd_attribute *service)
+{
+	GList *list = g_list_find(local_attribute_db, service);
+	bool first_node;
+
+	if (!list)
+		return;
+
+	first_node = local_attribute_db == list;
+
+	/* Remove service declaration attribute */
+	free(list->data);
+	list = g_list_delete_link(list, list);
+
+	/* Remove all characteristics until next service declaration */
+	while (list && !is_service(list->data)) {
+		free(list->data);
+		list = g_list_delete_link(list, list);
+	}
+
+	/*
+	 * When removing the first node, local attribute database head
+	 * needs to be updated. Node removed from middle doesn't change
+	 * the list head address.
+	 */
+	if (first_node)
+		local_attribute_db = list;
+}
+
 struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
 						uint8_t properties,
 						btd_attr_read_t read_cb,
diff --git a/src/gatt.h b/src/gatt.h
index da7af92..f16541e 100644
--- a/src/gatt.h
+++ b/src/gatt.h
@@ -81,6 +81,13 @@ typedef void (*btd_attr_write_t) (struct btd_attribute *attr,
 struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid);
 
 /*
+ * btd_gatt_remove_service - Remove a service (along with all its
+ * characteristics) from the local attribute database.
+ * @service:	Service declaration attribute.
+ */
+void btd_gatt_remove_service(struct btd_attribute *service);
+
+/*
  * btd_gatt_add_char - Add a characteristic (declaration and value attributes)
  * to local attribute database.
  * @uuid:	Characteristic UUID (16-bits or 128-bits).
-- 
1.8.3.1

