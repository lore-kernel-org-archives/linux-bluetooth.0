Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 07/18] core: gatt: Register characteristics
Date: Fri, 20 Feb 2015 17:56:52 -0800
Message-Id: <1424483824-27374-8-git-send-email-armansito@chromium.org>
In-Reply-To: <1424483824-27374-1-git-send-email-armansito@chromium.org>
References: <1424483824-27374-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for registering characteristic objects. This
adds internal plumbing for determining the final attribute count for
a service handle range and creates characteristic entries in the server
database.
---
 src/gatt-manager.c | 250 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 240 insertions(+), 10 deletions(-)

diff --git a/src/gatt-manager.c b/src/gatt-manager.c
index a69c7ea..01f2f55 100644
--- a/src/gatt-manager.c
+++ b/src/gatt-manager.c
@@ -43,6 +43,7 @@
 
 #define GATT_MANAGER_IFACE	"org.bluez.GattManager1"
 #define GATT_SERVICE_IFACE	"org.bluez.GattService1"
+#define GATT_CHRC_IFACE		"org.bluez.GattCharacteristic1"
 
 #define UUID_GAP	0x1800
 #define UUID_GATT	0x1801
@@ -55,12 +56,22 @@ struct btd_gatt_manager {
 
 struct external_service {
 	struct btd_gatt_manager *manager;
+	bool failed;
 	char *owner;
 	char *om_path;	/* Path to ObjectManager */
 	char *path;	/* Path to GattService1 */
 	DBusMessage *reg;
 	GDBusClient *client;
 	GDBusProxy *proxy;
+	uint16_t attr_cnt;
+	struct gatt_db_attribute *attrib;
+	struct queue *chrcs;
+};
+
+struct external_chrc {
+	GDBusProxy *proxy;
+	uint8_t props;
+	uint8_t ext_props;
 	struct gatt_db_attribute *attrib;
 };
 
@@ -72,10 +83,23 @@ static bool match_service_path(const void *a, const void *b)
 	return g_strcmp0(service->path, path) == 0;
 }
 
+static void chrc_free(void *data)
+{
+	struct external_chrc *chrc = data;
+
+	if (chrc->proxy)
+		g_dbus_proxy_unref(chrc->proxy);
+
+	free(chrc);
+}
+
 static void service_free(void *data)
 {
 	struct external_service *service = data;
 
+	if (service->chrcs)
+		queue_destroy(service->chrcs, chrc_free);
+
 	gatt_db_remove_service(service->manager->db, service->attrib);
 
 	if (service->client) {
@@ -141,13 +165,114 @@ static void service_remove(void *data)
 	 */
 	g_dbus_client_set_disconnect_watch(service->client, NULL, NULL);
 
+	/*
+	 * Set proxy handlers to NULL, so that this gets called only once when
+	 * the first proxy that belongs to this service gets removed.
+	 */
+	g_dbus_client_set_proxy_handlers(service->client, NULL, NULL,
+								NULL, NULL);
+
 	service_remove_helper(service);
 }
 
+static struct external_chrc *chrc_create(GDBusProxy *proxy)
+{
+	struct external_chrc *chrc;
+
+	chrc = new0(struct external_chrc, 1);
+	if (!chrc)
+		return NULL;
+
+	chrc->proxy = g_dbus_proxy_ref(proxy);
+
+	return chrc;
+}
+
+static bool incr_attr_count(struct external_service *service, uint16_t incr)
+{
+	if (service->attr_cnt > UINT16_MAX - incr)
+		return false;
+
+	service->attr_cnt += incr;
+
+	return true;
+}
+
+static bool parse_service(GDBusProxy *proxy, struct external_service *service)
+{
+	DBusMessageIter iter;
+	const char *service_path;
+
+	if (!g_dbus_proxy_get_property(proxy, "Service", &iter))
+		return false;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_OBJECT_PATH)
+		return false;
+
+	dbus_message_iter_get_basic(&iter, &service_path);
+
+	return g_strcmp0(service_path, service->path) == 0;
+}
+
+static bool parse_flags(GDBusProxy *proxy, uint8_t *props, uint8_t *ext_props)
+{
+	DBusMessageIter iter, array;
+	const char *flag;
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
+	do {
+		if (dbus_message_iter_get_arg_type(&array) != DBUS_TYPE_STRING)
+			return false;
+
+		dbus_message_iter_get_basic(&array, &flag);
+
+		if (!strcmp("broadcast", flag))
+			*props |= BT_GATT_CHRC_PROP_BROADCAST;
+		else if (!strcmp("read", flag))
+			*props |= BT_GATT_CHRC_PROP_READ;
+		else if (!strcmp("write-without-response", flag))
+			*props |= BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP;
+		else if (!strcmp("write", flag))
+			*props |= BT_GATT_CHRC_PROP_WRITE;
+		else if (!strcmp("notify", flag))
+			*props |= BT_GATT_CHRC_PROP_NOTIFY;
+		else if (!strcmp("indicate", flag))
+			*props |= BT_GATT_CHRC_PROP_INDICATE;
+		else if (!strcmp("authenticated-signed-writes", flag))
+			*props |= BT_GATT_CHRC_PROP_AUTH;
+		else if (!strcmp("reliable-write", flag))
+			*ext_props |= BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE;
+		else if (!strcmp("writable-auxiliaries", flag))
+			*ext_props |= BT_GATT_CHRC_EXT_PROP_WRITABLE_AUX;
+		else {
+			error("Invalid characteristic flag: %s", flag);
+			return false;
+		}
+	} while (dbus_message_iter_next(&array));
+
+	if (*ext_props)
+		*props |= BT_GATT_CHRC_PROP_EXT_PROP;
+
+	return true;
+}
+
 static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
 {
 	struct external_service *service = user_data;
 	const char *iface, *path;
+	struct external_chrc *chrc;
+
+	if (service->failed || service->attrib)
+		return;
 
 	iface = g_dbus_proxy_get_interface(proxy);
 	path = g_dbus_proxy_get_path(proxy);
@@ -155,14 +280,74 @@ static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
 	if (!g_str_has_prefix(path, service->path))
 		return;
 
-	/* TODO: Handle characteristic and descriptors here */
-
-	if (g_strcmp0(iface, GATT_SERVICE_IFACE))
+	/* TODO: Handle descriptors here */
+
+	if (g_strcmp0(iface, GATT_SERVICE_IFACE) == 0) {
+		if (service->proxy)
+			return;
+
+		/*
+		 * TODO: We may want to support adding included services in a
+		 * single hierarchy.
+		 */
+		if (g_strcmp0(path, service->path) != 0) {
+			error("Multiple services added within hierarchy");
+			service->failed = true;
+			return;
+		}
+
+		/* Add 1 for the service declaration */
+		if (!incr_attr_count(service, 1)) {
+			error("Failed to increment attribute count");
+			service->failed = true;
+			return;
+		}
+
+		service->proxy = g_dbus_proxy_ref(proxy);
+	} else if (g_strcmp0(iface, GATT_CHRC_IFACE) == 0) {
+		if (g_strcmp0(path, service->path) == 0) {
+			error("Characteristic path same as service path");
+			service->failed = true;
+			return;
+		}
+
+		chrc = chrc_create(proxy);
+		if (!chrc) {
+			service->failed = true;
+			return;
+		}
+
+		/*
+		 * Add 2 for the characteristic declaration and the value
+		 * attribute.
+		 */
+		if (!incr_attr_count(service, 2)) {
+			error("Failed to increment attribute count");
+			service->failed = true;
+			return;
+		}
+
+		/*
+		 * Parse characteristic flags (i.e. properties) here since they
+		 * are used to determine if any special descriptors should be
+		 * created.
+		 */
+		if (!parse_flags(proxy, &chrc->props, &chrc->ext_props)) {
+			error("Failed to parse characteristic properties");
+			service->failed = true;
+			return;
+		}
+
+		/*
+		 * TODO: Determine descriptors count to add based on special
+		 * characteristic properties (e.g. extended properties).
+		 */
+
+		queue_push_tail(service->chrcs, chrc);
+	} else
 		return;
 
 	DBG("Object added to service - path: %s, iface: %s", path, iface);
-
-	service->proxy = g_dbus_proxy_ref(proxy);
 }
 
 static void proxy_removed_cb(GDBusProxy *proxy, void *user_data)
@@ -228,10 +413,37 @@ static bool parse_primary(GDBusProxy *proxy, bool *primary)
 	return true;
 }
 
+static bool create_chrc_entry(struct external_service *service,
+						struct external_chrc *chrc)
+{
+	bt_uuid_t uuid;
+
+	if (!parse_uuid(chrc->proxy, &uuid)) {
+		error("Failed to read \"UUID\" property of characteristic");
+		return false;
+	}
+
+	if (!parse_service(chrc->proxy, service)) {
+		error("Invalid service path for characteristic");
+		service->failed = true;
+		return false;
+	}
+
+	/* TODO: Assign permissions and read/write callbacks */
+	chrc->attrib = gatt_db_service_add_characteristic(service->attrib,
+							&uuid, 0, chrc->props,
+							NULL, NULL, NULL);
+
+	/* TODO: Create descriptor entries */
+
+	return !!chrc->attrib;
+}
+
 static bool create_service_entry(struct external_service *service)
 {
 	bt_uuid_t uuid;
 	bool primary;
+	const struct queue_entry *entry;
 
 	if (!parse_uuid(service->proxy, &uuid)) {
 		error("Failed to read \"UUID\" property of service");
@@ -243,12 +455,26 @@ static bool create_service_entry(struct external_service *service)
 		return false;
 	}
 
-	/* TODO: Determine the correct attribute count */
 	service->attrib = gatt_db_add_service(service->manager->db, &uuid,
-								primary, 1);
+						primary, service->attr_cnt);
 	if (!service->attrib)
 		return false;
 
+	entry = queue_get_entries(service->chrcs);
+	while (entry) {
+		struct external_chrc *chrc = entry->data;
+
+		if (!create_chrc_entry(service, chrc)) {
+			error("Failed to create characteristic entry");
+			gatt_db_remove_service(service->manager->db,
+							service->attrib);
+			service->attrib = NULL;
+			return false;
+		}
+
+		entry = entry->next;
+	}
+
 	gatt_db_service_set_active(service->attrib, true);
 
 	return true;
@@ -260,11 +486,11 @@ static void client_ready_cb(GDBusClient *client, void *user_data)
 	DBusMessage *reply;
 	bool fail = false;
 
-	if (!service->proxy) {
-		error("No external GATT objects found");
+	if (!service->proxy || service->failed) {
+		error("No valid external GATT objects found");
 		fail = true;
 		reply = btd_error_failed(service->reg,
-						"No service object found");
+					"No valid service object found");
 		goto reply;
 	}
 
@@ -316,6 +542,10 @@ static struct external_service *service_create(DBusConnection *conn,
 	if (!service->om_path)
 		goto fail;
 
+	service->chrcs = queue_new();
+	if (!service->chrcs)
+		goto fail;
+
 	service->reg = dbus_message_ref(msg);
 
 	g_dbus_client_set_disconnect_watch(service->client,
-- 
2.2.0.rc0.207.ga3a616c

