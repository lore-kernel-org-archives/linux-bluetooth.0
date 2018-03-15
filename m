Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: avichal <avichal.a@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com, anupam.r@samsung.com,
        avichal <avichal.a@samsung.com>
Subject: [PATCH BlueZ] tools/gatt-service: Add reference implementation for
 Included Service
Date: Thu, 15 Mar 2018 20:15:38 +0530
Message-id: <1521125138-24229-4-git-send-email-avichal.a@samsung.com>
In-reply-to: <1521125138-24229-1-git-send-email-avichal.a@samsung.com>
References: <avichal.a@samsung.com>
        <1521125138-24229-1-git-send-email-avichal.a@samsung.com>
        <CGME20180315144724epcas1p4ea57deffd99cd3ac2bb1e3c6f51445b6@epcas1p4.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Created two new primary services which will act as includes services for
first  primary service

Signed-off-by: avichal <avichal.a@samsung.com>
---
 tools/gatt-service.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 2 deletions(-)

diff --git a/tools/gatt-service.c b/tools/gatt-service.c
index 6bd5576..379c120 100644
--- a/tools/gatt-service.c
+++ b/tools/gatt-service.c
@@ -47,9 +47,17 @@
 /* Immediate Alert Service UUID */
 #define IAS_UUID			"00001802-0000-1000-8000-00805f9b34fb"
 #define ALERT_LEVEL_CHR_UUID		"00002a06-0000-1000-8000-00805f9b34fb"
+#define IAS_UUID1   "A00B"
+#define IAS_UUID2   "A00C"
+#define IAS_UUID3   "A00D"
+#define ALERT_LEVEL_CHR_UUID1		"00002b06-0000-1000-8000-00805f9b34fb"
+#define ALERT_LEVEL_CHR_UUID2		"00002c07-0000-1000-8000-00805f9b34fb"
+/* Random UUID for testing purpose */
 
 /* Random UUID for testing purpose */
 #define READ_WRITE_DESCRIPTOR_UUID	"8260c653-1a54-426b-9e36-e84c238bc669"
+#define READ_WRITE_DESCRIPTOR_UUID1 "0260c653-1a54-426b-9e36-e84c238bc669"
+#define READ_WRITE_DESCRIPTOR_UUID2 "FFFF"
 
 static GMainLoop *main_loop;
 static GSList *services;
@@ -335,18 +343,47 @@ static gboolean service_get_includes(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
 {
 	const char *uuid = user_data;
+	char service_path[100] = {0,};
+	DBusMessageIter array;
+	char *p = NULL;
 
+	snprintf(service_path,100,"/service3");
 	printf("Get Includes: %s\n", uuid);
 
+	p = service_path;
+
+	printf("Includes path: %s\n", p);
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+			DBUS_TYPE_OBJECT_PATH_AS_STRING, &array);
+
+	dbus_message_iter_append_basic(&array, DBUS_TYPE_OBJECT_PATH,
+							&p);
+
+	snprintf(service_path,100,"/service2");
+	p = service_path;
+	printf("Get Includes: %s\n", p);
+
+	dbus_message_iter_append_basic(&array, DBUS_TYPE_OBJECT_PATH,
+							&p);
+	dbus_message_iter_close_container(iter, &array);
+
+
 	return TRUE;
+
 }
 
+
 static gboolean service_exist_includes(const GDBusPropertyTable *property,
 							void *user_data)
 {
 	const char *uuid = user_data;
 
 	printf("Exist Includes: %s\n", uuid);
+	if(strncmp(uuid,"00001802",8) == 0)
+	{
+		return TRUE;
+	}
 
 	return FALSE;
 }
@@ -624,7 +661,7 @@ static char *register_service(const char *uuid)
 	return path;
 }
 
-static void create_services()
+static void create_services_one()
 {
 	char *service_path;
 	uint8_t level = 0;
@@ -651,6 +688,59 @@ static void create_services()
 	printf("Registered service: %s\n", service_path);
 }
 
+
+static void create_services_two()
+{
+	char *service_path;
+	uint8_t level = 0;
+
+	service_path = register_service(IAS_UUID2);
+	if (!service_path)
+		return;
+
+	if (!register_characteristic(ALERT_LEVEL_CHR_UUID2,
+						&level, sizeof(level),
+						ias_alert_level_props,
+						READ_WRITE_DESCRIPTOR_UUID2,
+						desc_props,
+						service_path)) {
+		printf("Couldn't register Alert Level characteristic (IAS)\n");
+		g_dbus_unregister_interface(connection, service_path,
+							GATT_SERVICE_IFACE);
+		g_free(service_path);
+		return;
+	}
+	services = g_slist_prepend(services, service_path);
+	printf("Registered service: %s\n", service_path);
+}
+
+static void create_services_three()
+{
+	char *service_path;
+	uint8_t level = 0;
+
+	service_path = register_service(IAS_UUID3);
+	if (!service_path)
+		return;
+
+	if (!register_characteristic(ALERT_LEVEL_CHR_UUID1,
+						&level, sizeof(level),
+						ias_alert_level_props,
+						READ_WRITE_DESCRIPTOR_UUID1,
+						desc_props,
+						service_path)) {
+		printf("Couldn't register Alert Level characteristic (IAS)\n");
+		g_dbus_unregister_interface(connection, service_path,
+							GATT_SERVICE_IFACE);
+		g_free(service_path);
+		return;
+	}
+
+
+	services = g_slist_prepend(services, service_path);
+	printf("Registered service: %s\n", service_path);
+}
+
 static void register_app_reply(DBusMessage *reply, void *user_data)
 {
 	DBusError derr;
@@ -789,7 +879,9 @@ int main(int argc, char *argv[])
 	printf("gatt-service unique name: %s\n",
 				dbus_bus_get_unique_name(connection));
 
-	create_services();
+	create_services_one();
+	create_services_two();
+	create_services_three();
 
 	client = g_dbus_client_new(connection, "org.bluez", "/");
 
-- 
2.7.4

