Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 15/17] core/gatt: Register descriptors
Date: Wed, 25 Feb 2015 21:13:28 -0800
Message-Id: <1424927610-26226-16-git-send-email-armansito@chromium.org>
In-Reply-To: <1424927610-26226-1-git-send-email-armansito@chromium.org>
References: <1424927610-26226-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for registering external descriptor objects.
---
 src/gatt-manager.c | 206 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 191 insertions(+), 15 deletions(-)

diff --git a/src/gatt-manager.c b/src/gatt-manager.c
index dd22071..d31d13f 100644
--- a/src/gatt-manager.c
+++ b/src/gatt-manager.c
@@ -44,6 +44,7 @@
 #define GATT_MANAGER_IFACE	"org.bluez.GattManager1"
 #define GATT_SERVICE_IFACE	"org.bluez.GattService1"
 #define GATT_CHRC_IFACE		"org.bluez.GattCharacteristic1"
+#define GATT_DESC_IFACE		"org.bluez.GattDescriptor1"
 
 #define UUID_GAP	0x1800
 #define UUID_GATT	0x1801
@@ -69,10 +70,12 @@ struct external_service {
 	uint16_t attr_cnt;
 	struct gatt_db_attribute *attrib;
 	struct queue *chrcs;
+	struct queue *descs;
 };
 
 struct external_chrc {
 	struct external_service *service;
+	char *path;
 	GDBusProxy *proxy;
 	uint8_t props;
 	uint8_t ext_props;
@@ -82,6 +85,14 @@ struct external_chrc {
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
 struct pending_dbus_op {
 	struct external_chrc *chrc;
 	unsigned int id;
@@ -127,9 +138,25 @@ static void chrc_free(void *data)
 		g_dbus_proxy_unref(chrc->proxy);
 	}
 
+	if (chrc->path)
+		g_free(chrc->path);
+
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
@@ -137,6 +164,9 @@ static void service_free(void *data)
 	if (service->chrcs)
 		queue_destroy(service->chrcs, chrc_free);
 
+	if (service->descs)
+		queue_destroy(service->descs, desc_free);
+
 	gatt_db_remove_service(service->manager->db, service->attrib);
 
 	if (service->client) {
@@ -210,7 +240,8 @@ static void service_remove(void *data)
 }
 
 static struct external_chrc *chrc_create(struct external_service *service,
-							GDBusProxy *proxy)
+							GDBusProxy *proxy,
+							const char *path)
 {
 	struct external_chrc *chrc;
 
@@ -224,12 +255,41 @@ static struct external_chrc *chrc_create(struct external_service *service,
 		return NULL;
 	}
 
+	chrc->path = g_strdup(path);
+	if (!chrc->path) {
+		queue_destroy(chrc->pending_ops, NULL);
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
@@ -240,18 +300,27 @@ static bool incr_attr_count(struct external_service *service, uint16_t incr)
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
+static bool check_service_path(GDBusProxy *proxy, struct external_service *service)
+{
+	const char *service_path;
+
+	if (!parse_path(proxy, "Service", &service_path))
+		return false;
 
 	return g_strcmp0(service_path, service->path) == 0;
 }
@@ -311,7 +380,6 @@ static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
 {
 	struct external_service *service = user_data;
 	const char *iface, *path;
-	struct external_chrc *chrc;
 
 	if (service->failed || service->attrib)
 		return;
@@ -322,8 +390,6 @@ static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
 	if (!g_str_has_prefix(path, service->path))
 		return;
 
-	/* TODO: Handle descriptors here */
-
 	if (g_strcmp0(iface, GATT_SERVICE_IFACE) == 0) {
 		if (service->proxy)
 			return;
@@ -347,13 +413,15 @@ static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
 
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
@@ -395,8 +463,35 @@ static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
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
@@ -446,6 +541,20 @@ static bool parse_uuid(GDBusProxy *proxy, bt_uuid_t *uuid)
 		return false;
 	}
 
+	/* The CCC & CEP descriptors are created and managed by BlueZ */
+	bt_uuid16_create(&tmp, GATT_CLIENT_CHARAC_CFG_UUID);
+	if (!bt_uuid_cmp(&tmp, uuid)) {
+		error("CCC descriptors must be handled by BlueZ");
+		return false;
+	}
+
+	/* The CCC & CEP descriptors are created and managed by BlueZ */
+	bt_uuid16_create(&tmp, GATT_CHARAC_EXT_PROPER_UUID);
+	if (!bt_uuid_cmp(&tmp, uuid)) {
+		error("CEP descriptors must be handled by BlueZ");
+		return false;
+	}
+
 	return true;
 }
 
@@ -858,18 +967,47 @@ static bool create_cep_entry(struct external_service *service,
 	return true;
 }
 
+static bool create_desc_entry(struct external_service *service,
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
 static bool create_chrc_entry(struct external_service *service,
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
@@ -896,9 +1034,33 @@ static bool create_chrc_entry(struct external_service *service,
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
+		if (!create_desc_entry(service, desc)) {
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
@@ -926,18 +1088,28 @@ static bool create_service_entry(struct external_service *service)
 
 		if (!create_chrc_entry(service, chrc)) {
 			error("Failed to create characteristic entry");
-			gatt_db_remove_service(service->manager->db,
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
+	gatt_db_remove_service(service->manager->db,
+					service->attrib);
+	service->attrib = NULL;
+
+	return false;
 }
 
 static void client_ready_cb(GDBusClient *client, void *user_data)
@@ -1004,6 +1176,10 @@ static struct external_service *service_create(DBusConnection *conn,
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

