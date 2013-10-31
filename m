Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 10/10] android/client: Add GATT server methods
Date: Thu, 31 Oct 2013 11:45:15 +0100
Message-ID: <1383216315-30627-11-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1383216315-30627-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1383216315-30627-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements GATT server method calls.
---
 android/client/if-gatt.c |  256 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 246 insertions(+), 10 deletions(-)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index a262b90..e90e58b 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -579,6 +579,9 @@ static const btgatt_client_callbacks_t btgatt_client_callbacks = {
 
 /* BT-GATT Server callbacks */
 
+/* Cache server_if and conn_id for tab completion */
+static char server_if_str[20];
+
 /* Callback invoked in response to register_server */
 static void gatts_register_server_cb(int status, int server_if,
 							bt_uuid_t *app_uuid)
@@ -599,6 +602,7 @@ static void gatts_connection_cb(int conn_id, int server_if, int connected,
 	haltest_info("%s: conn_id=%d server_if=%d connected=%d bda=%s\n",
 					__func__, conn_id, server_if, connected,
 					bt_bdaddr_t2str(bda, last_addr));
+	snprintf(conn_id_str, sizeof(conn_id_str), "%d", conn_id);
 }
 
 /* Callback invoked in response to create_service */
@@ -607,6 +611,8 @@ static void gatts_service_added_cb(int status, int server_if,
 {
 	char buf[MAX_SRVC_ID_STR_LEN];
 
+	snprintf(server_if_str, sizeof(server_if_str), "%d", server_if);
+
 	haltest_info("%s: status=%d server_if=%d srvc_id=%s handle=%x\n",
 			__func__, status, server_if,
 			btgatt_srvc_id_t2str(srvc_id, buf), srvc_handle);
@@ -1392,78 +1398,308 @@ const struct interface gatt_client_if = {
 
 static void gatts_register_server_p(int argc, const char *argv[])
 {
+	bt_uuid_t uuid;
+
+	RETURN_IF_NULL(if_gatt);
+
+	/* uuid */
+	if (argc <= 2)
+		gatt_str2bt_uuid_t("bed4babe", -1, &uuid);
+	else
+		gatt_str2bt_uuid_t(argv[2], -1, &uuid);
+
+	EXEC(if_gatt->server->register_server, &uuid);
 }
 
 /* unregister_server */
 
+static void gatts_unregister_server_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 3) {
+		*user = server_if_str;
+		*enum_func = enum_one_string;
+	}
+}
+
 static void gatts_unregister_server_p(int argc, const char *argv[])
 {
+	int server_if;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_SERVER_IF(2, server_if);
+
+	EXEC(if_gatt->server->unregister_server, server_if);
 }
 
 /* connect */
 
+static void gatts_connect_c(int argc, const char **argv, enum_func *enum_func,
+								void **user)
+{
+	if (argc == 3) {
+		*user = server_if_str;
+		*enum_func = enum_one_string;
+	} else if (argc == 4) {
+		*user = NULL;
+		*enum_func = enum_devices;
+	}
+}
+
 static void gatts_connect_p(int argc, const char *argv[])
 {
+	int server_if;
+	bt_bdaddr_t bd_addr;
+	int is_direct = 1;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_SERVER_IF(2, server_if);
+	VERIFY_ADDR_ARG(3, &bd_addr);
+
+	/* is_direct */
+	if (argc > 4)
+		is_direct = atoi(argv[4]);
+
+	EXEC(if_gatt->server->connect, server_if, &bd_addr, is_direct);
 }
 
 /* disconnect */
 
+static void gatts_disconnect_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 3) {
+		*user = server_if_str;
+		*enum_func = enum_one_string;
+	} else if (argc == 4) {
+		*user = last_addr;
+		*enum_func = enum_one_string;
+	} else if (argc == 5) {
+		*user = conn_id_str;
+		*enum_func = enum_one_string;
+	}
+}
+
 static void gatts_disconnect_p(int argc, const char *argv[])
 {
+	int server_if;
+	bt_bdaddr_t bd_addr;
+	int conn_id;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_SERVER_IF(2, server_if);
+	VERIFY_ADDR_ARG(3, &bd_addr);
+	VERIFY_CONN_ID(4, conn_id);
+
+	EXEC(if_gatt->server->disconnect, server_if, &bd_addr, conn_id);
 }
 
 /* add_service */
 
+/* Same completion as gatts_unregister_server_c */
+#define gatts_add_service_c gatts_unregister_server_c
+
 static void gatts_add_service_p(int argc, const char *argv[])
 {
+	int server_if;
+	btgatt_srvc_id_t srvc_id;
+	int num_handles;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_SERVER_IF(2, server_if);
+	VERIFY_SRVC_ID(3, &srvc_id);
+
+	/* num handles */
+	if (argc <= 4) {
+		haltest_error("No num_handles specified\n");
+		return;
+	}
+	num_handles = atoi(argv[4]);
+
+	EXEC(if_gatt->server->add_service, server_if, &srvc_id, num_handles);
 }
 
 /* add_included_service */
 
+/* Same completion as gatts_unregister_server_c */
+#define gatts_add_included_service_c gatts_unregister_server_c
+
 static void gatts_add_included_service_p(int argc, const char *argv[])
 {
+	int server_if;
+	int service_handle;
+	int included_handle;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_SERVER_IF(2, server_if);
+	VERIFY_SERVICE_HANDLE(3, service_handle);
+	VERIFY_HANDLE(4, included_handle);
+
+	EXEC(if_gatt->server->add_included_service, server_if, service_handle,
+							included_handle);
 }
 
 /* add_characteristic */
 
+/* Same completion as gatts_unregister_server_c */
+#define gatts_add_characteristic_c gatts_unregister_server_c
+
 static void gatts_add_characteristic_p(int argc, const char *argv[])
 {
+	int server_if;
+	int service_handle;
+	int properties;
+	int permissions;
+	bt_uuid_t uuid;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_SERVER_IF(2, server_if);
+	VERIFY_SERVICE_HANDLE(3, service_handle);
+	VERIFY_UUID(4, &uuid);
+
+	/* properties */
+	if (argc <= 5) {
+		haltest_error("No properties specified\n");
+		return;
+	}
+	properties = atoi(argv[5]);
+
+	/* permissions */
+	if (argc <= 6) {
+		haltest_error("No permissions specified\n");
+		return;
+	}
+	permissions = atoi(argv[6]);
+
+	EXEC(if_gatt->server->add_characteristic, server_if, service_handle,
+						&uuid, properties, permissions);
 }
 
 /* add_descriptor */
 
+/* Same completion as gatts_unregister_server_c */
+#define gatts_add_descriptor_c gatts_unregister_server_c
+
 static void gatts_add_descriptor_p(int argc, const char *argv[])
 {
+	int server_if;
+	int service_handle;
+	int permissions;
+	bt_uuid_t uuid;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_SERVER_IF(2, server_if);
+	VERIFY_SERVICE_HANDLE(3, service_handle);
+	VERIFY_UUID(4, &uuid);
+
+	/* permissions */
+	if (argc <= 5) {
+		haltest_error("No permissions specified\n");
+		return;
+	}
+	permissions = atoi(argv[5]);
+
+	EXEC(if_gatt->server->add_descriptor, server_if, service_handle, &uuid,
+								permissions);
 }
 
 /* start_service */
 
+/* Same completion as gatts_unregister_server_c */
+#define gatts_start_service_c gatts_unregister_server_c
+
 static void gatts_start_service_p(int argc, const char *argv[])
 {
+	int server_if;
+	int service_handle;
+	int transport;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_SERVER_IF(2, server_if);
+	VERIFY_SERVICE_HANDLE(3, service_handle);
+
+	/* transport */
+	if (argc <= 4) {
+		haltest_error("No transport specified\n");
+		return;
+	}
+	transport = atoi(argv[4]);
+
+	EXEC(if_gatt->server->start_service, server_if, service_handle,
+								transport);
 }
 
 /* stop_service */
 
+/* Same completion as gatts_unregister_server_c */
+#define gatts_stop_service_c gatts_unregister_server_c
+
 static void gatts_stop_service_p(int argc, const char *argv[])
 {
+	int server_if;
+	int service_handle;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_SERVER_IF(2, server_if);
+	VERIFY_SERVICE_HANDLE(3, service_handle);
+
+	EXEC(if_gatt->server->stop_service, server_if, service_handle);
 }
 
 /* delete_service */
 
+/* Same completion as gatts_unregister_server_c */
+#define gatts_delete_service_c gatts_unregister_server_c
+
 static void gatts_delete_service_p(int argc, const char *argv[])
 {
+	int server_if;
+	int service_handle;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_SERVER_IF(2, server_if);
+	VERIFY_SERVICE_HANDLE(3, service_handle);
+
+	EXEC(if_gatt->server->delete_service, server_if, service_handle);
 }
 
 /* send_indication */
 
 static void gatts_send_indication_p(int argc, const char *argv[])
 {
+	int server_if;
+	int attr_handle;
+	int conn_id;
+	int confirm;
+	char data[200];
+	int len = 0;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_SERVER_IF(2, server_if);
+	VERIFY_HANDLE(3, attr_handle);
+	VERIFY_CONN_ID(4, conn_id);
+
+	/* confirm */
+	if (argc <= 5) {
+		haltest_error("No transport specified\n");
+		return;
+	}
+	confirm = atoi(argv[5]);
+
+	if (argc > 6) {
+		len = strlen(argv[6]);
+		scan_field(argv[6], len, (uint8_t *) data, sizeof(data));
+	}
+
+	EXEC(if_gatt->server->send_indication, server_if, attr_handle, conn_id,
+							len, confirm, data);
 }
 
 /* send_response */
 
 static void gatts_send_response_p(int argc, const char *argv[])
 {
+	haltest_warn("%s is not implemented yet\n", __func__);
 }
 
 #define GATTS_METHODH(n, h) METHOD(#n, gatts_##n##_p, NULL, h)
@@ -1471,19 +1707,19 @@ static void gatts_send_response_p(int argc, const char *argv[])
 
 static struct method server_methods[] = {
 	GATTS_METHODH(register_server, "[<uuid>]"),
-	GATTS_METHODH(unregister_server, "<server_if>"),
-	GATTS_METHODH(connect, "<server_if> <addr> [<is_direct>]"),
-	GATTS_METHODH(disconnect, "<server_if> <addr> <conn_id>"),
-	GATTS_METHODH(add_service, "<server_if> <srvc_id> <num_handles>"),
-	GATTS_METHODH(add_included_service,
+	GATTS_METHODCH(unregister_server, "<server_if>"),
+	GATTS_METHODCH(connect, "<server_if> <addr> [<is_direct>]"),
+	GATTS_METHODCH(disconnect, "<server_if> <addr> <conn_id>"),
+	GATTS_METHODCH(add_service, "<server_if> <srvc_id> <num_handles>"),
+	GATTS_METHODCH(add_included_service,
 			"<server_if> <service_handle> <included_handle>"),
-	GATTS_METHODH(add_characteristic,
+	GATTS_METHODCH(add_characteristic,
 		"<server_if> <service_handle> <uuid> <properites> <permissions>"),
-	GATTS_METHODH(add_descriptor, "<server_if> <uuid> <permissions>"),
-	GATTS_METHODH(start_service,
+	GATTS_METHODCH(add_descriptor, "<server_if> <uuid> <permissions>"),
+	GATTS_METHODCH(start_service,
 				"<server_if> <service_handle> <transport>"),
-	GATTS_METHODH(stop_service, "<server_if> <service_handle>"),
-	GATTS_METHODH(delete_service, "<server_if> <service_handle>"),
+	GATTS_METHODCH(stop_service, "<server_if> <service_handle>"),
+	GATTS_METHODCH(delete_service, "<server_if> <service_handle>"),
 	GATTS_METHODH(send_indication,
 			"<server_if> <attr_handle> <conn_id> <confirm> [<data>]"),
 	GATTS_METHODH(send_response, "<conn_id> <trans_id> <status>"),
-- 
1.7.9.5

