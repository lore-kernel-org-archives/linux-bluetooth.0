Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] core/gatt-client: Add support for Includes property
Date: Tue, 25 Apr 2017 13:56:11 +0200
Message-Id: <1493121371-29377-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1493121371-29377-1-git-send-email-marcin.kraglak@tieto.com>
References: <1493121371-29377-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add implementation of Includes property in GATT service interface.
---
 src/gatt-client.c | 144 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 136 insertions(+), 8 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 114981c..15219e2 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -72,6 +72,15 @@ struct service {
 	bt_uuid_t uuid;
 	char *path;
 	struct queue *chrcs;
+	struct queue *incl_services;
+};
+
+struct incl_service {
+	uint16_t handle;
+	uint16_t start_handle;
+	uint16_t end_handle;
+	struct service *service;
+	struct service *incl_service;
 };
 
 typedef bool (*async_dbus_op_complete_t)(void *data);
@@ -1398,10 +1407,39 @@ static gboolean service_get_primary(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static void append_incl_service_path(void *data, void *user_data)
+{
+	struct incl_service *incl_service = data;
+	DBusMessageIter *array = user_data;
+
+	if (!incl_service->incl_service)
+		return;
+
+	dbus_message_iter_append_basic(array, DBUS_TYPE_OBJECT_PATH,
+					&incl_service->incl_service->path);
+}
+
+static gboolean service_get_includes(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct service *service = data;
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{o}", &array);
+
+	queue_foreach(service->incl_services, append_incl_service_path, &array);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+
+}
+
 static const GDBusPropertyTable service_properties[] = {
 	{ "UUID", "s", service_get_uuid },
 	{ "Device", "o", service_get_device },
 	{ "Primary", "b", service_get_primary },
+	{ "Includes", "ao", service_get_includes },
 	{ }
 };
 
@@ -1410,10 +1448,40 @@ static void service_free(void *data)
 	struct service *service = data;
 
 	queue_destroy(service->chrcs, NULL);  /* List should be empty here */
+	queue_destroy(service->incl_services, NULL);
 	g_free(service->path);
 	free(service);
 }
 
+static bool match_service_handle(const void *a, const void *b)
+{
+	const struct service *service = a;
+	uint16_t start_handle = PTR_TO_UINT(b);
+
+	return service->start_handle == start_handle;
+}
+
+static void add_included_service(struct gatt_db_attribute *attrib,
+							void *user_data)
+{
+	struct service *service = user_data;
+	struct incl_service *incl_service;
+	struct btd_gatt_client *client = service->client;
+
+	incl_service = new0(struct incl_service, 1);
+	incl_service->service = service;
+
+	gatt_db_attribute_get_incl_data(attrib, &incl_service->handle,
+					&incl_service->start_handle,
+					&incl_service->end_handle);
+
+	incl_service->incl_service = queue_find(client->services,
+				match_service_handle,
+				UINT_TO_PTR(incl_service->start_handle));
+
+	queue_push_tail(service->incl_services, incl_service);
+}
+
 static struct service *service_create(struct gatt_db_attribute *attr,
 						struct btd_gatt_client *client)
 {
@@ -1423,6 +1491,7 @@ static struct service *service_create(struct gatt_db_attribute *attr,
 
 	service = new0(struct service, 1);
 	service->chrcs = queue_new();
+	service->incl_services = queue_new();
 	service->client = client;
 
 	gatt_db_attribute_get_service_data(attr, &service->start_handle,
@@ -1434,6 +1503,8 @@ static struct service *service_create(struct gatt_db_attribute *attr,
 	service->path = g_strdup_printf("%s/service%04x", device_path,
 							service->start_handle);
 
+	gatt_db_service_foreach_incl(attr, add_included_service, service);
+
 	if (!g_dbus_register_interface(btd_get_dbus_connection(), service->path,
 						GATT_SERVICE_IFACE,
 						NULL, NULL,
@@ -1459,6 +1530,63 @@ static struct service *service_create(struct gatt_db_attribute *attr,
 	return service;
 }
 
+static void incl_service_on_unregister(void *data, void *user_data)
+{
+	struct incl_service *incl_service = (struct incl_service *) data;
+	struct service *service = (struct service *) user_data;
+
+	if (incl_service->incl_service == service) {
+		incl_service->incl_service = NULL;
+
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						incl_service->service->path,
+						GATT_SERVICE_IFACE,
+						"Includes");
+	}
+}
+
+static void incl_service_on_register(void *data, void *user_data)
+{
+	struct incl_service *incl_service = (struct incl_service *) data;
+	struct service *service = (struct service *) user_data;
+
+	if (!incl_service->incl_service &&
+			incl_service->start_handle == service->start_handle) {
+		incl_service->incl_service = service;
+
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						incl_service->service->path,
+						GATT_SERVICE_IFACE,
+						"Includes");
+	}
+}
+
+struct foreach_incl_service_data {
+	queue_foreach_func_t func;
+	void *user_data;
+};
+
+static void incl_service_cb(void *data, void *user_data)
+{
+	struct service *service = (struct service *) data;
+	struct foreach_incl_service_data *incl_data =
+				(struct foreach_incl_service_data *) user_data;
+
+	queue_foreach(service->incl_services, incl_data->func,
+							incl_data->user_data);
+}
+
+static void client_foreach_incl_service(struct btd_gatt_client *client,
+				queue_foreach_func_t func, void *user_data)
+{
+	struct foreach_incl_service_data incl_data = {
+		.user_data = user_data,
+		.func = func,
+	};
+
+	queue_foreach(client->services, incl_service_cb, &incl_data);
+}
+
 static void unregister_service(void *data)
 {
 	struct service *service = data;
@@ -1466,6 +1594,11 @@ static void unregister_service(void *data)
 	DBG("Removing GATT service: %s", service->path);
 
 	queue_remove_all(service->chrcs, NULL, NULL, unregister_characteristic);
+	queue_remove_all(service->incl_services, NULL, NULL, free);
+
+	/* Make sure that no one included service points to this one */
+	client_foreach_incl_service(service->client,
+					incl_service_on_unregister, service);
 
 	g_dbus_unregister_interface(btd_get_dbus_connection(), service->path,
 							GATT_SERVICE_IFACE);
@@ -1564,6 +1697,9 @@ static void export_service(struct gatt_db_attribute *attr, void *user_data)
 		return;
 	}
 
+	/* Check if any included service points to this one */
+	client_foreach_incl_service(client, incl_service_on_register, service);
+
 	queue_push_tail(client->services, service);
 }
 
@@ -1691,14 +1827,6 @@ void btd_gatt_client_service_added(struct btd_gatt_client *client,
 	export_service(attrib, client);
 }
 
-static bool match_service_handle(const void *a, const void *b)
-{
-	const struct service *service = a;
-	uint16_t start_handle = PTR_TO_UINT(b);
-
-	return service->start_handle == start_handle;
-}
-
 void btd_gatt_client_service_removed(struct btd_gatt_client *client,
 					struct gatt_db_attribute *attrib)
 {
-- 
2.4.3

