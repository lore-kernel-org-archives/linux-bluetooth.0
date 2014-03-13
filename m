Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v3 12/20] gatt: Add write callback to btd_gatt_add_char helper
Date: Thu, 13 Mar 2014 17:22:40 -0300
Message-Id: <1394742168-31073-13-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1394742168-31073-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1394721533-6932-1-git-send-email-claudio.takahasi@openbossa.org>
 <1394742168-31073-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a function callback for write operations. When a remote
device writes to a given attribute, the core calls the specified write
callback informing the attribute server the new characteristic value.
---
 src/gatt-dbus.c |  2 +-
 src/gatt.c      |  7 ++++---
 src/gatt.h      | 13 ++++++++++++-
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index fff2d3a..a02d565 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -238,7 +238,7 @@ static int register_external_characteristics(GSList *proxies)
 		 * Reference table 3.5: Characteristic Properties bit field.
 		 */
 
-		attr = btd_gatt_add_char(&uuid, 0x00, proxy_read_cb);
+		attr = btd_gatt_add_char(&uuid, 0x00, proxy_read_cb, NULL);
 		if (attr == NULL)
 			return -EINVAL;
 
diff --git a/src/gatt.c b/src/gatt.c
index 7d063a3..abf0c34 100644
--- a/src/gatt.c
+++ b/src/gatt.c
@@ -46,6 +46,7 @@ struct btd_attribute {
 	uint16_t handle;
 	bt_uuid_t type;
 	btd_attr_read_t read_cb;
+	btd_attr_write_t write_cb;
 	uint16_t value_len;
 	uint8_t value[0];
 };
@@ -132,7 +133,8 @@ struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
 
 struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
 						uint8_t properties,
-						btd_attr_read_t read_cb)
+						btd_attr_read_t read_cb,
+						btd_attr_write_t write_cb)
 {
 	struct btd_attribute *char_decl, *char_value = NULL;
 
@@ -191,8 +193,7 @@ struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
 
 	char_value->type = *uuid;
 	char_value->read_cb = read_cb;
-
-	/* TODO: Write callbacks */
+	char_value->write_cb = write_cb;
 
 	if (local_database_add(next_handle, char_value) < 0)
 		/* TODO: remove declaration */
diff --git a/src/gatt.h b/src/gatt.h
index e446fa0..f4eebe5 100644
--- a/src/gatt.h
+++ b/src/gatt.h
@@ -42,6 +42,14 @@ typedef void (*btd_attr_read_result_t) (int err, uint8_t *value, size_t len,
 typedef void (*btd_attr_read_t) (struct btd_attribute *attr,
 						btd_attr_read_result_t result,
 						void *user_data);
+/*
+ * Callbacks from this type are called once the value from the attribute was
+ * written.
+ * @err:	error in errno format.
+ * @user_data:	user_data passed in btd_attr_write_t callback
+ */
+typedef void (*btd_attr_write_t) (struct btd_attribute *attr,
+					const uint8_t *value, size_t len);
 
 /* btd_gatt_add_service - Add a service declaration to local attribute database.
  * @uuid:	Service UUID.
@@ -57,10 +65,13 @@ struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid);
  * @uuid:	Characteristic UUID (16-bits or 128-bits).
  * @properties:	Characteristic properties. See Core SPEC 4.1 page 2183.
  * @read_cb:	Callback used to provide the characteristic value.
+ * @write_cb:	Callback called to notify the implementation that a new value
+ *              is available.
  *
  * Returns a reference to characteristic value attribute. In case of error,
  * NULL is returned.
  */
 struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
 						uint8_t properties,
-						btd_attr_read_t read_cb);
+						btd_attr_read_t read_cb,
+						btd_attr_write_t write_cb);
-- 
1.8.3.1

