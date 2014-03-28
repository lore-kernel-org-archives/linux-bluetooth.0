Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org,
	Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH BlueZ v0 1/5] gatt: Introduce helper for adding descriptors
Date: Fri, 28 Mar 2014 11:19:06 -0300
Message-Id: <1396016350-16943-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1396016350-16943-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1396016350-16943-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andre Guedes <andre.guedes@openbossa.org>

This patch adds btd_gatt_add_char_desc() helper which adds a
characteristic descriptor to the local attribute database.
---
 src/gatt.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 src/gatt.h | 16 ++++++++++++++++
 2 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/src/gatt.c b/src/gatt.c
index 92092d3..f07effa 100644
--- a/src/gatt.c
+++ b/src/gatt.c
@@ -87,6 +87,23 @@ static struct btd_attribute *new_const_attribute(const bt_uuid_t *type,
 	return attr;
 }
 
+static struct btd_attribute *new_attribute(const bt_uuid_t *type,
+						btd_attr_read_t read_cb,
+						btd_attr_write_t write_cb)
+{
+	struct btd_attribute *attr;
+
+	attr = new0(struct btd_attribute, 1);
+	if (!attr)
+		return NULL;
+
+	attr->type = *type;
+	attr->read_cb = read_cb;
+	attr->write_cb = write_cb;
+
+	return attr;
+}
+
 static int local_database_add(uint16_t handle, struct btd_attribute *attr)
 {
 	attr->handle = handle;
@@ -170,7 +187,7 @@ struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
 	if (!char_decl)
 		goto fail;
 
-	char_value = new0(struct btd_attribute, 1);
+	char_value = new_attribute(uuid, read_cb, write_cb);
 	if (!char_value)
 		goto fail;
 
@@ -192,10 +209,6 @@ struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
 	 * implementation (external entity).
 	 */
 
-	char_value->type = *uuid;
-	char_value->read_cb = read_cb;
-	char_value->write_cb = write_cb;
-
 	if (local_database_add(next_handle, char_value) < 0)
 		/* TODO: remove declaration */
 		goto fail;
@@ -219,6 +232,37 @@ fail:
 	return NULL;
 }
 
+struct btd_attribute *btd_gatt_add_char_desc(const bt_uuid_t *uuid,
+						btd_attr_read_t read_cb,
+						btd_attr_write_t write_cb)
+{
+	struct btd_attribute *attr;
+
+	/*
+	 * From Core SPEC 4.1 page 2184:
+	 * "Characteristic descriptor declaration permissions are defined by a
+	 * higher layer profile or are implementation specific. A client shall
+	 * not assume all characteristic descriptor declarations are readable."
+	 *
+	 * The read/write callbacks presence will define the descriptor
+	 * permissions managed directly by the core. The upper layer can define
+	 * additional permissions constraints.
+	 */
+
+	attr = new_attribute(uuid, read_cb, write_cb);
+	if (!attr)
+		return NULL;
+
+	if (local_database_add(next_handle, attr) < 0) {
+		free(attr);
+		return NULL;
+	}
+
+	next_handle = next_handle + 1;
+
+	return attr;
+}
+
 void gatt_init(void)
 {
 	DBG("Starting GATT server");
diff --git a/src/gatt.h b/src/gatt.h
index 6c7f57e..da7af92 100644
--- a/src/gatt.h
+++ b/src/gatt.h
@@ -96,3 +96,19 @@ struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
 						uint8_t properties,
 						btd_attr_read_t read_cb,
 						btd_attr_write_t write_cb);
+
+/*
+ * btd_gatt_add_char_desc - Add a characteristic descriptor to the local
+ * attribute database.
+ * @uuid:	Characteristic Descriptor UUID (16-bits or 128-bits).
+ * @read_cb:	Callback that should be called once the characteristic
+ *		descriptor attribute is read.
+ * @write_cb:	Callback that should be called once the characteristic
+ *		descriptor attribute is written.
+ *
+ * Returns a reference to characteristic descriptor attribute. In case of
+ * error, NULL is returned.
+ */
+struct btd_attribute *btd_gatt_add_char_desc(const bt_uuid_t *uuid,
+						btd_attr_read_t read_cb,
+						btd_attr_write_t write_cb);
-- 
1.8.3.1

