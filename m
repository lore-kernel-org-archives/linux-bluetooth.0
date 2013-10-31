Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 08/10] android/client: Add tab completion to GATT client
Date: Thu, 31 Oct 2013 11:45:13 +0100
Message-ID: <1383216315-30627-9-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1383216315-30627-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1383216315-30627-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds tab completion to GATT client methods.
---
 android/client/if-gatt.c |  209 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 187 insertions(+), 22 deletions(-)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 62e0a81..3fe55e8 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -356,12 +356,20 @@ static char *btgatt_read_params_t2str(const btgatt_read_params_t *data,
 
 /* BT-GATT Client callbacks. */
 
+/* Cache client_if and conn_id for tab completion */
+static char client_if_str[20];
+static char conn_id_str[20];
+/* Cache address for tab completion */
+static char last_addr[MAX_ADDR_STR_LEN];
+
 /* Callback invoked in response to register_client */
 static void gattc_register_client_cb(int status, int client_if,
 							bt_uuid_t *app_uuid)
 {
 	char buf[MAX_UUID_STR_LEN];
 
+	snprintf(client_if_str, sizeof(client_if_str), "%d", client_if);
+
 	haltest_info("%s: status=%d client_if=%d app_uuid=%s\n", __func__,
 						status, client_if,
 						gatt_uuid_t2str(app_uuid, buf));
@@ -380,11 +388,9 @@ static void gattc_scan_result_cb(bt_bdaddr_t *bda, int rssi, uint8_t *adv_data)
 static void gattc_connect_cb(int conn_id, int status, int client_if,
 							bt_bdaddr_t *bda)
 {
-	char buf[MAX_ADDR_STR_LEN];
-
 	haltest_info("%s: conn_id=%d status=%d, client_if=%d bda=%s\n",
 					__func__, conn_id, status, client_if,
-					bt_bdaddr_t2str(bda, buf));
+					bt_bdaddr_t2str(bda, last_addr));
 }
 
 /* Callback invoked in response to close */
@@ -740,6 +746,15 @@ static void register_client_p(int argc, const char **argv)
 
 /* unregister_client */
 
+static void unregister_client_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 3) {
+		*user = client_if_str;
+		*enum_func = enum_one_string;
+	}
+}
+
 static void unregister_client_p(int argc, const char **argv)
 {
 	int client_if;
@@ -752,6 +767,9 @@ static void unregister_client_p(int argc, const char **argv)
 
 /* scan */
 
+/* Same completion as unregister for now, start stop is not auto completed */
+#define scan_c unregister_client_c
+
 static void scan_p(int argc, const char **argv)
 {
 	int client_if;
@@ -770,6 +788,18 @@ static void scan_p(int argc, const char **argv)
 
 /* connect */
 
+static void connect_c(int argc, const char **argv, enum_func *enum_func,
+								void **user)
+{
+	if (argc == 3) {
+		*user = client_if_str;
+		*enum_func = enum_one_string;
+	} else if (argc == 4) {
+		*user = NULL;
+		*enum_func = enum_devices;
+	}
+}
+
 static void connect_p(int argc, const char **argv)
 {
 	int client_if;
@@ -789,6 +819,21 @@ static void connect_p(int argc, const char **argv)
 
 /* disconnect */
 
+static void disconnect_c(int argc, const char **argv, enum_func *enum_func,
+								void **user)
+{
+	if (argc == 3) {
+		*user = client_if_str;
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
 static void disconnect_p(int argc, const char **argv)
 {
 	int client_if;
@@ -805,6 +850,17 @@ static void disconnect_p(int argc, const char **argv)
 
 /* refresh */
 
+static void refresh_c(int argc, const char **argv, enum_func *enum_func,
+								void **user)
+{
+	if (argc == 3) {
+		*user = client_if_str;
+		*enum_func = enum_one_string;
+	} else if (argc == 4) {
+		*enum_func = enum_devices;
+	}
+}
+
 static void refresh_p(int argc, const char **argv)
 {
 	int client_if;
@@ -819,6 +875,15 @@ static void refresh_p(int argc, const char **argv)
 
 /* search_service */
 
+static void search_service_c(int argc, const char **argv, enum_func *enum_func,
+								void **user)
+{
+	if (argc == 3) {
+		*user = conn_id_str;
+		*enum_func = enum_one_string;
+	}
+}
+
 static void search_service_p(int argc, const char **argv)
 {
 	int conn_id;
@@ -839,6 +904,15 @@ static void search_service_p(int argc, const char **argv)
 
 /* get_included_service */
 
+static void get_included_service_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 3) {
+		*user = conn_id_str;
+		*enum_func = enum_one_string;
+	}
+}
+
 static void get_included_service_p(int argc, const char **argv)
 {
 	int conn_id;
@@ -853,6 +927,9 @@ static void get_included_service_p(int argc, const char **argv)
 
 /* get_characteristic */
 
+/* Same completion as get_included_service_c */
+#define get_characteristic_c get_included_service_c
+
 static void get_characteristic_p(int argc, const char **argv)
 {
 	int conn_id;
@@ -867,6 +944,9 @@ static void get_characteristic_p(int argc, const char **argv)
 
 /* get_descriptor */
 
+/* Same completion as get_included_service_c */
+#define get_descriptor_c get_included_service_c
+
 static void get_descriptor_p(int argc, const char **argv)
 {
 	int conn_id;
@@ -884,6 +964,9 @@ static void get_descriptor_p(int argc, const char **argv)
 
 /* read_characteristic */
 
+/* Same completion as get_included_service_c */
+#define read_characteristic_c get_included_service_c
+
 static void read_characteristic_p(int argc, const char **argv)
 {
 	int conn_id;
@@ -906,6 +989,24 @@ static void read_characteristic_p(int argc, const char **argv)
 
 /* write_characteristic */
 
+static void write_characteristic_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	/*
+	 * This should be from tGATT_WRITE_TYPE but it's burried
+	 * inside bluedroid guts
+	 */
+	static const char *wrtypes[] = { "1", "2", "3", NULL };
+
+	if (argc == 3) {
+		*user = conn_id_str;
+		*enum_func = enum_one_string;
+	} else if (argc == 6) {
+		*user = wrtypes;
+		*enum_func = enum_strings;
+	}
+}
+
 static void write_characteristic_p(int argc, const char **argv)
 {
 	int conn_id;
@@ -950,6 +1051,9 @@ static void write_characteristic_p(int argc, const char **argv)
 
 /* read_descriptor */
 
+/* Same completion as get_included_service_c */
+#define read_descriptor_c get_included_service_c
+
 static void read_descriptor_p(int argc, const char **argv)
 {
 	int conn_id;
@@ -974,6 +1078,24 @@ static void read_descriptor_p(int argc, const char **argv)
 
 /* write_descriptor */
 
+static void write_descriptor_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	/*
+	 * This should be from tGATT_WRITE_TYPE but it's burried
+	 * inside bluedroid guts
+	 */
+	static const char *wrtypes[] = { "1", "2", "3", NULL };
+
+	if (argc == 3) {
+		*user = conn_id_str;
+		*enum_func = enum_one_string;
+	} else if (argc == 7) {
+		*user = wrtypes;
+		*enum_func = enum_strings;
+	}
+}
+
 static void write_descriptor_p(int argc, const char **argv)
 {
 	int conn_id;
@@ -1020,6 +1142,9 @@ static void write_descriptor_p(int argc, const char **argv)
 
 /* execute_write */
 
+/* Same completion as search_service */
+#define execute_write_c search_service_c
+
 static void execute_write_p(int argc, const char **argv)
 {
 	int conn_id;
@@ -1040,6 +1165,18 @@ static void execute_write_p(int argc, const char **argv)
 
 /* register_for_notification */
 
+static void register_for_notification_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 3) {
+		*user = client_if_str;
+		*enum_func = enum_one_string;
+	} else if (argc == 4) {
+		*user = last_addr;
+		*enum_func = enum_one_string;
+	}
+}
+
 static void register_for_notification_p(int argc, const char **argv)
 {
 	int client_if;
@@ -1059,6 +1196,9 @@ static void register_for_notification_p(int argc, const char **argv)
 
 /* deregister_for_notification */
 
+/* Same completion as search_service */
+#define deregister_for_notification_c register_for_notification_c
+
 static void deregister_for_notification_p(int argc, const char **argv)
 {
 	int client_if;
@@ -1078,6 +1218,17 @@ static void deregister_for_notification_p(int argc, const char **argv)
 
 /* read_remote_rssi */
 
+static void read_remote_rssi_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 3) {
+		*user = client_if_str;
+		*enum_func = enum_one_string;
+	} else if (argc == 4) {
+		*enum_func = enum_devices;
+	}
+}
+
 static void read_remote_rssi_p(int argc, const char **argv)
 {
 	int client_if;
@@ -1092,6 +1243,13 @@ static void read_remote_rssi_p(int argc, const char **argv)
 
 /* get_device_type */
 
+static void get_device_type_c(int argc, const char **argv, enum_func *enum_func,
+								void **user)
+{
+	if (argc == 3)
+		*enum_func = enum_devices;
+}
+
 static void get_device_type_p(int argc, const char **argv)
 {
 	bt_bdaddr_t bd_addr;
@@ -1106,6 +1264,13 @@ static void get_device_type_p(int argc, const char **argv)
 
 /* test_command */
 
+static void test_command_c(int argc, const char **argv, enum_func *enum_func,
+								void **user)
+{
+	if (argc == 4)
+		*enum_func = enum_devices;
+}
+
 static void test_command_p(int argc, const char **argv)
 {
 	int command;
@@ -1138,31 +1303,31 @@ static void test_command_p(int argc, const char **argv)
 
 static struct method client_methods[] = {
 	STD_METHODH(register_client, "[<uuid>]"),
-	STD_METHODH(unregister_client, "<client_if>"),
-	STD_METHODH(scan, "<client_if> [1|0]"),
-	STD_METHODH(connect, "<client_if> <addr> [<is_direct>]"),
-	STD_METHODH(disconnect, "<client_if> <addr> <conn_id>"),
-	STD_METHODH(refresh, "<client_if> <addr>"),
-	STD_METHODH(search_service, "<conn_id> [<uuid>]"),
-	STD_METHODH(get_included_service, "<conn_id> <srvc_id>"),
-	STD_METHODH(get_characteristic, "<conn_id> <srvc_id>"),
-	STD_METHODH(get_descriptor, "<conn_id> <srvc_id> <char_id>"),
-	STD_METHODH(read_characteristic,
+	STD_METHODCH(unregister_client, "<client_if>"),
+	STD_METHODCH(scan, "<client_if> [1|0]"),
+	STD_METHODCH(connect, "<client_if> <addr> [<is_direct>]"),
+	STD_METHODCH(disconnect, "<client_if> <addr> <conn_id>"),
+	STD_METHODCH(refresh, "<client_if> <addr>"),
+	STD_METHODCH(search_service, "<conn_id> [<uuid>]"),
+	STD_METHODCH(get_included_service, "<conn_id> <srvc_id>"),
+	STD_METHODCH(get_characteristic, "<conn_id> <srvc_id>"),
+	STD_METHODCH(get_descriptor, "<conn_id> <srvc_id> <char_id>"),
+	STD_METHODCH(read_characteristic,
 			"<conn_id> <srvc_id> <char_id> [<auth_req>]"),
-	STD_METHODH(write_characteristic,
+	STD_METHODCH(write_characteristic,
 			"<conn_id> <srvc_id> <char_id> <write_type> <hex_value> [<auth_req>]"),
-	STD_METHODH(read_descriptor,
+	STD_METHODCH(read_descriptor,
 			"<conn_id> <srvc_id> <char_id> <descr_id> [<auth_req>]"),
-	STD_METHODH(write_descriptor,
+	STD_METHODCH(write_descriptor,
 			"<conn_id> <srvc_id> <char_id> <descr_id> <write_type> <hex_value> [<auth_req>]"),
-	STD_METHODH(execute_write, "<conn_id> <execute>"),
-	STD_METHODH(register_for_notification,
+	STD_METHODCH(execute_write, "<conn_id> <execute>"),
+	STD_METHODCH(register_for_notification,
 			"<client_if> <addr> <srvc_id> <char_id>"),
-	STD_METHODH(deregister_for_notification,
+	STD_METHODCH(deregister_for_notification,
 			"<client_if> <addr> <srvc_id> <char_id>"),
-	STD_METHODH(read_remote_rssi, "<client_if> <addr>"),
-	STD_METHODH(get_device_type, "<addr>"),
-	STD_METHODH(test_command,
+	STD_METHODCH(read_remote_rssi, "<client_if> <addr>"),
+	STD_METHODCH(get_device_type, "<addr>"),
+	STD_METHODCH(test_command,
 			"<cmd> <addr> <uuid> [u1] [u2] [u3] [u4] [u5]"),
 	END_METHOD
 };
-- 
1.7.9.5

