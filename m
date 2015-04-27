Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/8] core/gatt: Add Flags property to GattDescriptor
Date: Mon, 27 Apr 2015 16:14:34 +0300
Message-Id: <1430140475-20349-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1430140475-20349-1-git-send-email-luiz.dentz@gmail.com>
References: <1430140475-20349-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the implementation of Flags property to GattDescriptor
interface and properly convert it to permissions when adding the
descriptor to the database.
---
 src/gatt-database.c | 107 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 86 insertions(+), 21 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 9397bff..57e60a5 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -119,6 +119,8 @@ struct external_desc {
 	struct external_service *service;
 	char *chrc_path;
 	GDBusProxy *proxy;
+	uint8_t props;
+	uint8_t ext_props;
 	struct gatt_db_attribute *attrib;
 	bool handled;
 	struct queue *pending_reads;
@@ -1202,26 +1204,16 @@ static bool check_service_path(GDBusProxy *proxy,
 	return g_strcmp0(service_path, service->path) == 0;
 }
 
-static bool parse_flags(GDBusProxy *proxy, uint8_t *props, uint8_t *ext_props)
+static bool parse_chrc_flags(DBusMessageIter *array, uint8_t *props,
+							uint8_t *ext_props)
 {
-	DBusMessageIter iter, array;
 	const char *flag;
 
-	*props = *ext_props = 0;
-
-	if (!g_dbus_proxy_get_property(proxy, "Flags", &iter))
-		return false;
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
-		return false;
-
-	dbus_message_iter_recurse(&iter, &array);
-
 	do {
-		if (dbus_message_iter_get_arg_type(&array) != DBUS_TYPE_STRING)
+		if (dbus_message_iter_get_arg_type(array) != DBUS_TYPE_STRING)
 			return false;
 
-		dbus_message_iter_get_basic(&array, &flag);
+		dbus_message_iter_get_basic(array, &flag);
 
 		if (!strcmp("broadcast", flag))
 			*props |= BT_GATT_PROP_BROADCAST;
@@ -1257,7 +1249,50 @@ static bool parse_flags(GDBusProxy *proxy, uint8_t *props, uint8_t *ext_props)
 			error("Invalid characteristic flag: %s", flag);
 			return false;
 		}
-	} while (dbus_message_iter_next(&array));
+	} while (dbus_message_iter_next(array));
+
+	if (*ext_props)
+		*props |= BT_GATT_PROP_EXT_PROP;
+
+	return true;
+}
+
+static bool parse_desc_flags(DBusMessageIter *array, uint8_t *props,
+							uint8_t *ext_props)
+{
+	const char *flag;
+
+	do {
+		if (dbus_message_iter_get_arg_type(array) != DBUS_TYPE_STRING)
+			return false;
+
+		dbus_message_iter_get_basic(array, &flag);
+
+		if (!strcmp("read", flag))
+			*props |= BT_GATT_PROP_READ;
+		else if (!strcmp("write-without-response", flag))
+			*props |= BT_GATT_PROP_WRITE_WITHOUT_RESP;
+		else if (!strcmp("write", flag))
+			*props |= BT_GATT_PROP_WRITE;
+		else if (!strcmp("authenticated-signed-writes", flag))
+			*props |= BT_GATT_PROP_AUTH;
+		else if (!strcmp("encrypt-read", flag)) {
+			*props |= BT_GATT_PROP_READ;
+			*ext_props |= BT_GATT_EXT_PROP_ENC_READ;
+		} else if (!strcmp("encrypt-write", flag)) {
+			*props |= BT_GATT_PROP_WRITE;
+			*ext_props |= BT_GATT_EXT_PROP_ENC_WRITE;
+		} else if (!strcmp("encrypt-authenticated-read", flag)) {
+			*props |= BT_GATT_PROP_READ;
+			*ext_props |= BT_GATT_EXT_PROP_AUTH_READ;
+		} else if (!strcmp("encrypt-authenticated-write", flag)) {
+			*props |= BT_GATT_PROP_WRITE;
+			*ext_props |= BT_GATT_EXT_PROP_AUTH_WRITE;
+		} else {
+			error("Invalid descriptor flag: %s", flag);
+			return false;
+		}
+	} while (dbus_message_iter_next(array));
 
 	if (*ext_props)
 		*props |= BT_GATT_PROP_EXT_PROP;
@@ -1265,6 +1300,28 @@ static bool parse_flags(GDBusProxy *proxy, uint8_t *props, uint8_t *ext_props)
 	return true;
 }
 
+static bool parse_flags(GDBusProxy *proxy, uint8_t *props, uint8_t *ext_props)
+{
+	DBusMessageIter iter, array;
+	const char *iface;
+
+	*props = *ext_props = 0;
+
+	if (!g_dbus_proxy_get_property(proxy, "Flags", &iter))
+		return false;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+		return false;
+
+	dbus_message_iter_recurse(&iter, &array);
+
+	iface = g_dbus_proxy_get_interface(proxy);
+	if (!strcmp(iface, GATT_CHRC_IFACE))
+		return parse_chrc_flags(&array, props, ext_props);
+
+	return parse_desc_flags(&array, props, ext_props);
+}
+
 static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
 {
 	struct external_service *service = user_data;
@@ -1376,6 +1433,16 @@ static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
 			return;
 		}
 
+		/*
+		 * Parse descriptors flags here since they are used to
+		 * determine the permission the descriptor should have
+		 */
+		if (!parse_flags(proxy, &desc->props, &desc->ext_props)) {
+			error("Failed to parse characteristic properties");
+			service->failed = true;
+			return;
+		}
+
 		queue_push_tail(service->descs, desc);
 	} else {
 		DBG("Ignoring unrelated interface: %s", iface);
@@ -1896,19 +1963,17 @@ static bool database_add_desc(struct external_service *service,
 						struct external_desc *desc)
 {
 	bt_uuid_t uuid;
+	uint32_t perm;
 
 	if (!parse_uuid(desc->proxy, &uuid)) {
 		error("Failed to read \"UUID\" property of descriptor");
 		return false;
 	}
 
-	/*
-	 * TODO: Set permissions based on a D-Bus property of the external
-	 * descriptor.
-	 */
+	perm = permissions_from_props(desc->props, desc->ext_props);
 	desc->attrib = gatt_db_service_add_descriptor(service->attrib, &uuid,
-					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
-					desc_read_cb, desc_write_cb, desc);
+							perm, desc_read_cb,
+							desc_write_cb, desc);
 	if (!desc->attrib) {
 		error("Failed to create descriptor entry in database");
 		return false;
-- 
2.1.0

