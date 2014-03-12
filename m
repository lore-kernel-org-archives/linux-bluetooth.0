Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v1 05/15] gatt: Add read callback to btd_gatt_add_char helper
Date: Wed, 12 Mar 2014 13:27:01 -0300
Message-Id: <1394641631-1534-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1394641631-1534-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1394477445-8987-1-git-send-email-claudio.takahasi@openbossa.org>
 <1394641631-1534-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a function callback for read operations. When a remote
device wants to reads a given attribute, the core calls the specified
read callback to get the value from the external services.
---
 src/gatt-dbus.c |  2 +-
 src/gatt.c      |  7 +++++--
 src/gatt.h      | 20 +++++++++++++++++++-
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index f60260e..275b263 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -198,7 +198,7 @@ static int register_external_characteristics(GSList *proxies)
 		 * Reference table 3.5: Characteristic Properties bit field.
 		 */
 
-		attr = btd_gatt_add_char(&uuid, 0x00);
+		attr = btd_gatt_add_char(&uuid, 0x00, NULL);
 		if (attr == NULL)
 			return -EINVAL;
 
diff --git a/src/gatt.c b/src/gatt.c
index 669c716..634e23a 100644
--- a/src/gatt.c
+++ b/src/gatt.c
@@ -46,6 +46,7 @@ static const bt_uuid_t chr_uuid = { .type = BT_UUID16,
 struct btd_attribute {
 	uint16_t handle;
 	bt_uuid_t type;
+	btd_attr_read_t read_cb;
 	uint16_t value_len;
 	uint8_t value[0];
 };
@@ -129,7 +130,8 @@ struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
 }
 
 struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
-							uint8_t properties)
+						uint8_t properties,
+						btd_attr_read_t read_cb)
 {
 	struct btd_attribute *char_decl, *char_value = NULL;
 
@@ -181,8 +183,9 @@ struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
 
 	char_value = new0(struct btd_attribute, 1);
 	char_value->type = *uuid;
+	char_value->read_cb = read_cb;
 
-	/* TODO: Read & Write callbacks */
+	/* TODO: Write callbacks */
 
 	if (local_database_add(next_handle, char_value) < 0)
 		goto fail;
diff --git a/src/gatt.h b/src/gatt.h
index d7acc5b..e446fa0 100644
--- a/src/gatt.h
+++ b/src/gatt.h
@@ -27,6 +27,22 @@ void gatt_init(void);
 
 void gatt_cleanup(void);
 
+/*
+ * Callbacks of this type are called once the value from the attribute is
+ * ready to be read from the service implementation. Result callback is
+ * the asynchronous function that should be used to inform the caller
+ * the read value.
+ * @err:	error in errno format.
+ * @value:	pointer to value
+ * @len:	length of value
+ * @user_data:	user_data passed in btd_attr_read_t callback
+ */
+typedef void (*btd_attr_read_result_t) (int err, uint8_t *value, size_t len,
+							void *user_data);
+typedef void (*btd_attr_read_t) (struct btd_attribute *attr,
+						btd_attr_read_result_t result,
+						void *user_data);
+
 /* btd_gatt_add_service - Add a service declaration to local attribute database.
  * @uuid:	Service UUID.
  *
@@ -40,9 +56,11 @@ struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid);
  * to local attribute database.
  * @uuid:	Characteristic UUID (16-bits or 128-bits).
  * @properties:	Characteristic properties. See Core SPEC 4.1 page 2183.
+ * @read_cb:	Callback used to provide the characteristic value.
  *
  * Returns a reference to characteristic value attribute. In case of error,
  * NULL is returned.
  */
 struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
-							uint8_t properties);
+						uint8_t properties,
+						btd_attr_read_t read_cb);
-- 
1.8.3.1

