Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v0 05/16] gatt: Add read callback to btd_gatt_add_char helper
Date: Mon, 10 Mar 2014 15:50:34 -0300
Message-Id: <1394477445-8987-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1394477445-8987-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1394477445-8987-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a function callback for read operations. When a remote
device wants to reads a given attribute, the core calls the specified
read callback to get the value from the external services.
---
 src/gatt-dbus.c |  2 +-
 src/gatt.c      |  7 +++++--
 src/gatt.h      | 19 ++++++++++++++++++-
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index 014b8d6..a904a97 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -193,7 +193,7 @@ static int register_external_characteristics(GSList *proxies)
 			return -EINVAL;
 
 		/* TODO: Missing Flags/property */
-		attr = btd_gatt_add_char(&uuid, 0x00);
+		attr = btd_gatt_add_char(&uuid, 0x00, NULL);
 		if (attr == NULL)
 			return -EINVAL;
 
diff --git a/src/gatt.c b/src/gatt.c
index 7f7af80..059e085 100644
--- a/src/gatt.c
+++ b/src/gatt.c
@@ -45,6 +45,7 @@ static const bt_uuid_t chr_uuid = { .type = BT_UUID16,
 struct btd_attribute {
 	uint16_t handle;
 	bt_uuid_t type;
+	btd_attr_read_t read_cb;
 	uint16_t value_len;
 	uint8_t value[0];
 };
@@ -114,7 +115,8 @@ struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
 	return attr;
 }
 
-struct btd_attribute *btd_gatt_add_char(bt_uuid_t *uuid, uint8_t properties)
+struct btd_attribute *btd_gatt_add_char(bt_uuid_t *uuid, uint8_t properties,
+						btd_attr_read_t read_cb)
 {
 	struct btd_attribute *char_decl, *char_value = NULL;
 
@@ -166,8 +168,9 @@ struct btd_attribute *btd_gatt_add_char(bt_uuid_t *uuid, uint8_t properties)
 
 	char_value = new0(struct btd_attribute, 1);
 	memcpy(&char_value->type, uuid, sizeof(char_value->type));
+	char_value->read_cb = read_cb;
 
-	/* TODO: Read & Write callbacks */
+	/* TODO: Write callbacks */
 
 	if (local_database_add(next_handle, char_value) < 0)
 		goto fail;
diff --git a/src/gatt.h b/src/gatt.h
index 7df82cf..0021076 100644
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
@@ -44,4 +60,5 @@ struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid);
  * Returns a reference to characteristic value attribute. In case of error,
  * NULL is returned.
  */
-struct btd_attribute *btd_gatt_add_char(bt_uuid_t *uuid, uint8_t properties);
+struct btd_attribute *btd_gatt_add_char(bt_uuid_t *uuid, uint8_t properties,
+						btd_attr_read_t read_cb);
-- 
1.8.3.1

