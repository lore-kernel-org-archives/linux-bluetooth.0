Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: avichal <avichal.a@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com, anupam.r@samsung.com,
        avichal <avichal.a@samsung.com>
Subject: [PATCH v2 BlueZ 2/2] gatt-database: Add support for Included
 service
Date: Mon, 19 Mar 2018 14:40:46 +0530
Message-id: <1521450646-31184-1-git-send-email-avichal.a@samsung.com>
References: <CGME20180319091106epcas1p1c5eafd1f0bdb22199c8feb3ac2e0fc79@epcas1p1.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support of included services in gatt server.While
registring the service new property is added
"includes"
        array{object} type  [read-only]
        Array of object paths representing the included
        services of this service.
---
 src/gatt-database.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 9a33ae7..d1acc65 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -109,6 +109,7 @@ struct external_service {
 	uint16_t attr_cnt;
 	struct queue *chrcs;
 	struct queue *descs;
+	struct queue *includes;
 };
 
 struct external_profile {
@@ -444,12 +445,20 @@ static void desc_free(void *data)
 	free(desc);
 }
 
+static void inc_free(void *data)
+{
+	struct external_desc *inc = data;
+
+	free(inc);
+}
+
 static void service_free(void *data)
 {
 	struct external_service *service = data;
 
 	queue_destroy(service->chrcs, chrc_free);
 	queue_destroy(service->descs, desc_free);
+	queue_destroy(service->includes,inc_free );
 
 	if (service->attrib)
 		gatt_db_remove_service(service->app->database->db,
@@ -1533,6 +1542,7 @@ static struct external_service *create_service(struct gatt_app *app,
 	service->proxy = g_dbus_proxy_ref(proxy);
 	service->chrcs = queue_new();
 	service->descs = queue_new();
+	service->includes = queue_new();
 
 	/* Add 1 for the service declaration */
 	if (!incr_attr_count(service, 1)) {
@@ -1616,6 +1626,39 @@ static bool parse_uuid(GDBusProxy *proxy, bt_uuid_t *uuid)
 	return true;
 }
 
+static bool parse_includes(GDBusProxy *proxy, struct external_service *service)
+{
+	DBusMessageIter iter;
+	DBusMessageIter array;
+	char *obj;
+
+	if (!g_dbus_proxy_get_property(proxy, "Includes", &iter))
+		return false;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+		return false;
+
+	dbus_message_iter_recurse(&iter, &array);
+
+	do {
+		if (dbus_message_iter_get_arg_type(&array) != DBUS_TYPE_OBJECT_PATH)
+			return false;
+
+		dbus_message_iter_get_basic(&array, &obj);
+
+		if (queue_push_tail(service->includes,obj)){
+			DBG("Included paths added\n");
+			incr_attr_count(service ,1);
+		}else {
+			error("Failed to add Includes path in que\n");
+			return FALSE;
+		}
+
+	} while (dbus_message_iter_next(&array));
+
+	return true;
+}
+
 static bool parse_primary(GDBusProxy *proxy, bool *primary)
 {
 	DBusMessageIter iter;
@@ -2488,6 +2531,40 @@ fail:
 	gatt_db_attribute_write_result(attrib, id, BT_ATT_ERROR_UNLIKELY);
 }
 
+static void include_services(void *data ,void *userdata)
+{
+	char *obj = (char *)data;
+	struct external_service *service = (struct external_service *)userdata;
+	struct gatt_db_attribute *attrib=NULL;
+	struct external_service  *service_inc=NULL;
+
+	DBG("object path receieved %s,",obj);
+
+	service_inc = queue_find(service->app->services, match_service_by_path, obj);
+	if(service_inc)	{
+
+		if (!(service)->attrib)
+			error("service attibute not found\n");
+
+		if (!service_inc->attrib)
+			error("include attribute not found\n");
+
+		attrib = gatt_db_service_add_included((service)->attrib ,service_inc->attrib);
+		if (attrib == NULL)
+			error("include service attributes failed\n");
+		else
+			(service)->attrib = attrib;
+
+	} else
+		error("include service not found\n");
+
+}
+
+static void database_add_includes(struct external_service *service)
+{
+	queue_foreach(service->includes,include_services,service );
+}
+
 static bool database_add_chrc(struct external_service *service,
 						struct external_chrc *chrc)
 {
@@ -2560,11 +2637,17 @@ static bool database_add_service(struct external_service *service)
 		return false;
 	}
 
+	if (!parse_includes(service->proxy,service))
+		error("Failed to read \"Includes\" property of service");
+
 	service->attrib = gatt_db_add_service(service->app->database->db, &uuid,
 						primary, service->attr_cnt);
 	if (!service->attrib)
 		return false;
 
+	database_add_includes(service);
+	DBG("ATTR count %d\n",service->attr_cnt);
+
 	entry = queue_get_entries(service->chrcs);
 	while (entry) {
 		struct external_chrc *chrc = entry->data;
-- 
2.7.4

