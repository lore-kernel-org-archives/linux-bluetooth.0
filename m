Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v8 1/8] gatt: Add write callback to btd_gatt_add_char helper
Date: Mon, 24 Mar 2014 10:30:02 -0300
Message-Id: <1395667809-17602-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395667809-17602-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395429403-493-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395667809-17602-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a function callback for write operations. When a remote
device writes to a given attribute, the core calls the specified write
callback informing the attribute server the new characteristic value.
---
 src/gatt-dbus.c |  2 +-
 src/gatt.c      |  7 ++++---
 src/gatt.h      | 14 +++++++++++++-
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index 4418353..ef137a8 100644
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
index 76bbe20..45b5e26 100644
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
@@ -133,7 +134,8 @@ struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
 
 struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
 						uint8_t properties,
-						btd_attr_read_t read_cb)
+						btd_attr_read_t read_cb,
+						btd_attr_write_t write_cb)
 {
 	struct btd_attribute *char_decl, *char_value = NULL;
 
@@ -192,8 +194,7 @@ struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
 
 	char_value->type = *uuid;
 	char_value->read_cb = read_cb;
-
-	/* TODO: Write callbacks */
+	char_value->write_cb = write_cb;
 
 	if (local_database_add(next_handle, char_value) < 0)
 		/* TODO: remove declaration */
diff --git a/src/gatt.h b/src/gatt.h
index daa8d54..d5dc7e6 100644
--- a/src/gatt.h
+++ b/src/gatt.h
@@ -42,6 +42,15 @@ typedef void (*btd_attr_read_result_t) (int err, uint8_t *value, size_t len,
 typedef void (*btd_attr_read_t) (struct btd_attribute *attr,
 						btd_attr_read_result_t result,
 						void *user_data);
+/*
+ * Service implementation callback passed to core (ATT layer). It manages write
+ * operations received from remote devices.
+ * @attr:	reference of the attribute to be changed.
+ * @value:	new attribute value.
+ * @len:	length of value.
+ */
+typedef void (*btd_attr_write_t) (struct btd_attribute *attr,
+					const uint8_t *value, size_t len);
 
 /* btd_gatt_add_service - Add a service declaration to local attribute database.
  * @uuid:	Service UUID.
@@ -57,10 +66,13 @@ struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid);
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

