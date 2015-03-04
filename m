Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v3 5/7] core/gatt: Register descriptors
Date: Tue,  3 Mar 2015 20:30:09 -0800
Message-Id: <1425443411-11958-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1425443411-11958-1-git-send-email-armansito@chromium.org>
References: <1425443411-11958-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for registering external descriptor objects.
---
 src/gatt-database.c | 191 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 176 insertions(+), 15 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 915461c..0ee8042 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -53,6 +53,7 @@
 #define GATT_MANAGER_IFACE	"org.bluez.GattManager1"
 #define GATT_SERVICE_IFACE	"org.bluez.GattService1"
 #define GATT_CHRC_IFACE		"org.bluez.GattCharacteristic1"
+#define GATT_DESC_IFACE		"org.bluez.GattDescriptor1"
 
 #define UUID_GAP	0x1800
 #define UUID_GATT	0x1801
@@ -87,10 +88,12 @@ struct external_service {
 	struct gatt_db_attribute *attrib;
 	uint16_t attr_cnt;
 	struct queue *chrcs;
+	struct queue *descs;
 };
 
 struct external_chrc {
 	struct external_service *service;
+	char *path;
 	GDBusProxy *proxy;
 	uint8_t props;
 	uint8_t ext_props;
@@ -101,6 +104,14 @@ struct external_chrc {
 	unsigned int ntfy_cnt;
 };
 
+struct external_desc {
+	struct external_service *service;
+	char *chrc_path;
+	GDBusProxy *proxy;
+	struct gatt_db_attribute *attrib;
+	bool handled;
+};
+
 struct pending_op {
 	struct external_chrc *chrc;
 	unsigned int id;
@@ -300,6 +311,9 @@ static void chrc_free(void *data)
 	queue_destroy(chrc->pending_reads, cancel_pending_read);
 	queue_destroy(chrc->pending_writes, cancel_pending_write);
 
+	if (chrc->path)
+		g_free(chrc->path);
+
 	if (chrc->proxy)
 		g_dbus_proxy_set_property_watch(chrc->proxy, NULL, NULL);
 
@@ -308,11 +322,25 @@ static void chrc_free(void *data)
 	free(chrc);
 }
 
+static void desc_free(void *data)
+{
+	struct external_desc *desc = data;
+
+	if (desc->proxy)
+		g_dbus_proxy_unref(desc->proxy);
+
+	if (desc->chrc_path)
+		g_free(desc->chrc_path);
+
+	free(desc);
+}
+
 static void service_free(void *data)
 {
 	struct external_service *service = data;
 
 	queue_destroy(service->chrcs, chrc_free);
+	queue_destroy(service->descs, desc_free);
 
 	gatt_db_remove_service(service->database->db, service->attrib);
 
@@ -1002,7 +1030,8 @@ static void service_remove(void *data)
 }
 
 static struct external_chrc *chrc_create(struct external_service *service,
-							GDBusProxy *proxy)
+							GDBusProxy *proxy,
+							const char *path)
 {
 	struct external_chrc *chrc;
 
@@ -1023,12 +1052,42 @@ static struct external_chrc *chrc_create(struct external_service *service,
 		return NULL;
 	}
 
+	chrc->path = g_strdup(path);
+	if (!chrc->path) {
+		queue_destroy(chrc->pending_reads, NULL);
+		queue_destroy(chrc->pending_writes, NULL);
+		free(chrc);
+		return NULL;
+	}
+
 	chrc->service = service;
 	chrc->proxy = g_dbus_proxy_ref(proxy);
 
 	return chrc;
 }
 
+static struct external_desc *desc_create(struct external_service *service,
+							GDBusProxy *proxy,
+							const char *chrc_path)
+{
+	struct external_desc *desc;
+
+	desc = new0(struct external_desc, 1);
+	if (!desc)
+		return NULL;
+
+	desc->chrc_path = g_strdup(chrc_path);
+	if (!desc->chrc_path) {
+		free(desc);
+		return NULL;
+	}
+
+	desc->service = service;
+	desc->proxy = g_dbus_proxy_ref(proxy);
+
+	return desc;
+}
+
 static bool incr_attr_count(struct external_service *service, uint16_t incr)
 {
 	if (service->attr_cnt > UINT16_MAX - incr)
@@ -1039,18 +1098,28 @@ static bool incr_attr_count(struct external_service *service, uint16_t incr)
 	return true;
 }
 
-static bool parse_service(GDBusProxy *proxy, struct external_service *service)
+static bool parse_path(GDBusProxy *proxy, const char *name, const char **path)
 {
 	DBusMessageIter iter;
-	const char *service_path;
 
-	if (!g_dbus_proxy_get_property(proxy, "Service", &iter))
+	if (!g_dbus_proxy_get_property(proxy, name, &iter))
 		return false;
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_OBJECT_PATH)
 		return false;
 
-	dbus_message_iter_get_basic(&iter, &service_path);
+	dbus_message_iter_get_basic(&iter, path);
+
+	return true;
+}
+
+static bool check_service_path(GDBusProxy *proxy,
+					struct external_service *service)
+{
+	const char *service_path;
+
+	if (!parse_path(proxy, "Service", &service_path))
+		return false;
 
 	return g_strcmp0(service_path, service->path) == 0;
 }
@@ -1110,7 +1179,6 @@ static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
 {
 	struct external_service *service = user_data;
 	const char *iface, *path;
-	struct external_chrc *chrc;
 
 	if (service->failed || service->attrib)
 		return;
@@ -1121,8 +1189,6 @@ static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
 	if (!g_str_has_prefix(path, service->path))
 		return;
 
-	/* TODO: Handle descriptors here */
-
 	if (g_strcmp0(iface, GATT_SERVICE_IFACE) == 0) {
 		if (service->proxy)
 			return;
@@ -1146,13 +1212,15 @@ static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
 
 		service->proxy = g_dbus_proxy_ref(proxy);
 	} else if (g_strcmp0(iface, GATT_CHRC_IFACE) == 0) {
+		struct external_chrc *chrc;
+
 		if (g_strcmp0(path, service->path) == 0) {
 			error("Characteristic path same as service path");
 			service->failed = true;
 			return;
 		}
 
-		chrc = chrc_create(service, proxy);
+		chrc = chrc_create(service, proxy, path);
 		if (!chrc) {
 			service->failed = true;
 			return;
@@ -1194,8 +1262,35 @@ static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
 		}
 
 		queue_push_tail(service->chrcs, chrc);
-	} else
+	} else if (g_strcmp0(iface, GATT_DESC_IFACE) == 0) {
+		struct external_desc *desc;
+		const char *chrc_path;
+
+		if (!parse_path(proxy, "Characteristic", &chrc_path)) {
+			error("Failed to obtain characteristic path for "
+								"descriptor");
+			service->failed = true;
+			return;
+		}
+
+		desc = desc_create(service, proxy, chrc_path);
+		if (!desc) {
+			service->failed = true;
+			return;
+		}
+
+		/* Add 1 for the descriptor attribute */
+		if (!incr_attr_count(service, 1)) {
+			error("Failed to increment attribute count");
+			service->failed = true;
+			return;
+		}
+
+		queue_push_tail(service->descs, desc);
+	} else {
+		DBG("Ignoring unrelated interface: %s", iface);
 		return;
+	}
 
 	DBG("Object added to service - path: %s, iface: %s", path, iface);
 }
@@ -1680,18 +1775,47 @@ static bool create_cep_entry(struct external_service *service,
 	return true;
 }
 
+static bool database_add_desc(struct external_service *service,
+						struct external_desc *desc)
+{
+	bt_uuid_t uuid;
+
+	if (!parse_uuid(desc->proxy, &uuid)) {
+		error("Failed to read \"UUID\" property of descriptor");
+		return false;
+	}
+
+	/*
+	 * TODO: Set read/write callbacks and property set permissions based on
+	 * a D-Bus property of the external descriptor.
+	 */
+	desc->attrib = gatt_db_service_add_descriptor(service->attrib,
+								&uuid, 0, NULL,
+								NULL, NULL);
+
+	if (!desc->attrib) {
+		error("Failed to create descriptor entry in database");
+		return false;
+	}
+
+	desc->handled = true;
+
+	return true;
+}
+
 static bool database_add_chrc(struct external_service *service,
 						struct external_chrc *chrc)
 {
 	bt_uuid_t uuid;
 	uint32_t perm;
+	const struct queue_entry *entry;
 
 	if (!parse_uuid(chrc->proxy, &uuid)) {
 		error("Failed to read \"UUID\" property of characteristic");
 		return false;
 	}
 
-	if (!parse_service(chrc->proxy, service)) {
+	if (!check_service_path(chrc->proxy, service)) {
 		error("Invalid service path for characteristic");
 		return false;
 	}
@@ -1717,9 +1841,33 @@ static bool database_add_chrc(struct external_service *service,
 	if (!create_cep_entry(service, chrc))
 		return false;
 
+	/* Handle the descriptors that belong to this characteristic. */
+	entry = queue_get_entries(service->descs);
+	while (entry) {
+		struct external_desc *desc = entry->data;
+
+		if (desc->handled || g_strcmp0(desc->chrc_path, chrc->path))
+			continue;
+
+		if (!database_add_desc(service, desc)) {
+			chrc->attrib = NULL;
+			error("Failed to create descriptor entry");
+			return false;
+		}
+
+		entry = entry->next;
+	}
+
 	return true;
 }
 
+static bool match_desc_unhandled(const void *a, const void *b)
+{
+	const struct external_desc *desc = a;
+
+	return !desc->handled;
+}
+
 static bool create_service_entry(struct external_service *service)
 {
 	bt_uuid_t uuid;
@@ -1747,18 +1895,27 @@ static bool create_service_entry(struct external_service *service)
 
 		if (!database_add_chrc(service, chrc)) {
 			error("Failed to add characteristic");
-			gatt_db_remove_service(service->database->db,
-							service->attrib);
-			service->attrib = NULL;
-			return false;
+			goto fail;
 		}
 
 		entry = entry->next;
 	}
 
+	/* If there are any unhandled descriptors, return an error */
+	if (queue_find(service->descs, match_desc_unhandled, NULL)) {
+		error("Found descriptor with no matching characteristic!");
+		goto fail;
+	}
+
 	gatt_db_service_set_active(service->attrib, true);
 
 	return true;
+
+fail:
+	gatt_db_remove_service(service->database->db, service->attrib);
+	service->attrib = NULL;
+
+	return false;
 }
 
 static void client_ready_cb(GDBusClient *client, void *user_data)
@@ -1825,6 +1982,10 @@ static struct external_service *service_create(DBusConnection *conn,
 	if (!service->chrcs)
 		goto fail;
 
+	service->descs = queue_new();
+	if (!service->descs)
+		goto fail;
+
 	service->reg = dbus_message_ref(msg);
 
 	g_dbus_client_set_disconnect_watch(service->client,
-- 
2.2.0.rc0.207.ga3a616c

