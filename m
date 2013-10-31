Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 06/10] android/client: Add GATT client method calls
Date: Thu, 31 Oct 2013 11:45:11 +0100
Message-ID: <1383216315-30627-7-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1383216315-30627-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1383216315-30627-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds code for all GATT client methods.
---
 android/client/if-gatt.c |  317 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 317 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 60b1ec5..70dbb24 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -130,6 +130,18 @@ static char *gatt_uuid_t2str(const bt_uuid_t *uuid, char *buf)
 	return buf;
 }
 
+/*
+ * Tries to convert hex string of given size into out buffer.
+ * Output buffer is little endian.
+ */
+static void scan_field(const char *str, int len, uint8_t *out, int out_size)
+{
+}
+
+static void gatt_str2bt_uuid_t(const char *str, int len, bt_uuid_t *uuid)
+{
+}
+
 /* char_id formating function */
 static char *btgatt_char_id_t2str(const btgatt_char_id_t *char_id, char *buf)
 {
@@ -140,6 +152,11 @@ static char *btgatt_char_id_t2str(const btgatt_char_id_t *char_id, char *buf)
 	return buf;
 }
 
+/* Parse btgatt_char_id_t */
+static void str2btgatt_char_id_t(const char *buf, btgatt_char_id_t *char_id)
+{
+}
+
 /* service_id formating function */
 static char *btgatt_srvc_id_t2str(const btgatt_srvc_id_t *srvc_id, char *buf)
 {
@@ -150,6 +167,11 @@ static char *btgatt_srvc_id_t2str(const btgatt_srvc_id_t *srvc_id, char *buf)
 	return buf;
 }
 
+/* Parse btgatt_srvc_id_t */
+static void str2btgatt_srvc_id_t(const char *buf, btgatt_srvc_id_t *srvc_id)
+{
+}
+
 /* Converts array of uint8_t to string representation */
 static char *array2str(const uint8_t *v, int size, char *buf, int out_size)
 {
@@ -584,120 +606,415 @@ const struct interface gatt_if = {
 
 static void register_client_p(int argc, const char **argv)
 {
+	bt_uuid_t uuid;
+
+	RETURN_IF_NULL(if_gatt);
+
+	/* uuid */
+	if (argc <= 2)
+		gatt_str2bt_uuid_t("babe4bed", -1, &uuid);
+	else
+		gatt_str2bt_uuid_t(argv[2], -1, &uuid);
+
+	EXEC(if_gatt->client->register_client, &uuid);
 }
 
 /* unregister_client */
 
 static void unregister_client_p(int argc, const char **argv)
 {
+	int client_if;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CLIENT_IF(2, client_if);
+
+	EXEC(if_gatt->client->unregister_client, client_if);
 }
 
 /* scan */
 
 static void scan_p(int argc, const char **argv)
 {
+	int client_if;
+	int start = 1;
+
+	RETURN_IF_NULL(if_gatt);
+
+	VERIFY_CLIENT_IF(2, client_if);
+
+	/* start */
+	if (argc >= 3)
+		start = atoi(argv[3]);
+
+	EXEC(if_gatt->client->scan, client_if, start);
 }
 
 /* connect */
 
 static void connect_p(int argc, const char **argv)
 {
+	int client_if;
+	bt_bdaddr_t bd_addr;
+	int is_direct = 1;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CLIENT_IF(2, client_if);
+	VERIFY_ADDR_ARG(3, &bd_addr);
+
+	/* is_direct */
+	if (argc > 4)
+		is_direct = atoi(argv[4]);
+
+	EXEC(if_gatt->client->connect, client_if, &bd_addr, is_direct);
 }
 
 /* disconnect */
 
 static void disconnect_p(int argc, const char **argv)
 {
+	int client_if;
+	bt_bdaddr_t bd_addr;
+	int conn_id;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CLIENT_IF(2, client_if);
+	VERIFY_ADDR_ARG(3, &bd_addr);
+	VERIFY_CONN_ID(4, conn_id);
+
+	EXEC(if_gatt->client->disconnect, client_if, &bd_addr, conn_id);
 }
 
 /* refresh */
 
 static void refresh_p(int argc, const char **argv)
 {
+	int client_if;
+	bt_bdaddr_t bd_addr;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CLIENT_IF(2, client_if);
+	VERIFY_ADDR_ARG(3, &bd_addr);
+
+	EXEC(if_gatt->client->refresh, client_if, &bd_addr);
 }
 
 /* search_service */
 
 static void search_service_p(int argc, const char **argv)
 {
+	int conn_id;
+	bt_uuid_t filter_uuid;
+
+	RETURN_IF_NULL(if_gatt);
+
+	VERIFY_CONN_ID(2, conn_id);
+
+	/* uuid */
+	if (argc <= 3)
+		memset(&filter_uuid, 0, sizeof(bt_uuid_t));
+	else
+		gatt_str2bt_uuid_t(argv[3], -1, &filter_uuid);
+
+	EXEC(if_gatt->client->search_service, conn_id, &filter_uuid);
 }
 
 /* get_included_service */
 
 static void get_included_service_p(int argc, const char **argv)
 {
+	int conn_id;
+	btgatt_srvc_id_t srvc_id;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CONN_ID(2, conn_id);
+	VERIFY_SRVC_ID(3, &srvc_id);
+
+	EXEC(if_gatt->client->get_included_service, conn_id, &srvc_id, NULL);
 }
 
 /* get_characteristic */
 
 static void get_characteristic_p(int argc, const char **argv)
 {
+	int conn_id;
+	btgatt_srvc_id_t srvc_id;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CONN_ID(2, conn_id);
+	VERIFY_SRVC_ID(3, &srvc_id);
+
+	EXEC(if_gatt->client->get_characteristic, conn_id, &srvc_id, NULL);
 }
 
 /* get_descriptor */
 
 static void get_descriptor_p(int argc, const char **argv)
 {
+	int conn_id;
+	btgatt_srvc_id_t srvc_id;
+	btgatt_char_id_t char_id;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CONN_ID(2, conn_id);
+	VERIFY_SRVC_ID(3, &srvc_id);
+	VERIFY_CHAR_ID(4, &char_id);
+
+	EXEC(if_gatt->client->get_descriptor, conn_id, &srvc_id, &char_id,
+									NULL);
 }
 
 /* read_characteristic */
 
 static void read_characteristic_p(int argc, const char **argv)
 {
+	int conn_id;
+	btgatt_srvc_id_t srvc_id;
+	btgatt_char_id_t char_id;
+	int auth_req = 0;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CONN_ID(2, conn_id);
+	VERIFY_SRVC_ID(3, &srvc_id);
+	VERIFY_CHAR_ID(4, &char_id);
+
+	/* auth_req */
+	if (argc > 5)
+		auth_req = atoi(argv[5]);
+
+	EXEC(if_gatt->client->read_characteristic, conn_id, &srvc_id, &char_id,
+								auth_req);
 }
 
 /* write_characteristic */
 
 static void write_characteristic_p(int argc, const char **argv)
 {
+	int conn_id;
+	btgatt_srvc_id_t srvc_id;
+	btgatt_char_id_t char_id;
+	int write_type;
+	int len;
+	int auth_req = 0;
+	uint8_t value[100];
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CONN_ID(2, conn_id);
+	VERIFY_SRVC_ID(3, &srvc_id);
+	VERIFY_CHAR_ID(4, &char_id);
+
+	/* write type */
+	if (argc <= 5) {
+		haltest_error("No write type specified\n");
+		return;
+	}
+	write_type = atoi(argv[5]);
+
+	/* value */
+	if (argc <= 6) {
+		haltest_error("No value specified\n");
+		return;
+	}
+
+	/* len in chars */
+	len = strlen(argv[6]);
+	scan_field(argv[6], len, value, sizeof(value));
+	/* len in bytes converted from ascii chars */
+	len = (len + 1) / 2;
+
+	/* auth_req */
+	if (argc > 7)
+		auth_req = atoi(argv[7]);
+
+	EXEC(if_gatt->client->write_characteristic, conn_id, &srvc_id, &char_id,
+				write_type, len, auth_req, (char *) value);
 }
 
 /* read_descriptor */
 
 static void read_descriptor_p(int argc, const char **argv)
 {
+	int conn_id;
+	btgatt_srvc_id_t srvc_id;
+	btgatt_char_id_t char_id;
+	bt_uuid_t descr_id;
+	int auth_req = 0;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CONN_ID(2, conn_id);
+	VERIFY_SRVC_ID(3, &srvc_id);
+	VERIFY_CHAR_ID(4, &char_id);
+	VERIFY_UUID(5, &descr_id);
+
+	/* auth_req */
+	if (argc > 6)
+		auth_req = atoi(argv[6]);
+
+	EXEC(if_gatt->client->read_descriptor, conn_id, &srvc_id, &char_id,
+							&descr_id, auth_req);
 }
 
 /* write_descriptor */
 
 static void write_descriptor_p(int argc, const char **argv)
 {
+	int conn_id;
+	btgatt_srvc_id_t srvc_id;
+	btgatt_char_id_t char_id;
+	bt_uuid_t descr_id;
+	int write_type;
+	int len;
+	int auth_req = 0;
+	uint8_t value[200] = {0};
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CONN_ID(2, conn_id);
+	VERIFY_SRVC_ID(3, &srvc_id);
+	VERIFY_CHAR_ID(4, &char_id);
+	VERIFY_UUID(5, &descr_id);
+
+	/* write type */
+	if (argc <= 6) {
+		haltest_error("No write type specified\n");
+		return;
+	}
+	write_type = atoi(argv[6]);
+
+	/* value */
+	if (argc <= 7) {
+		haltest_error("No value specified\n");
+		return;
+	}
+
+	/* len in chars */
+	len = strlen(argv[7]);
+	scan_field(argv[7], len, value, sizeof(value));
+	/* len in bytes converted from ascii chars */
+	len = (len + 1) / 2;
+
+	/* auth_req */
+	if (argc > 8)
+		auth_req = atoi(argv[8]);
+
+	EXEC(if_gatt->client->write_descriptor, conn_id, &srvc_id, &char_id,
+			&descr_id, write_type, len, auth_req, (char *) value);
 }
 
 /* execute_write */
 
 static void execute_write_p(int argc, const char **argv)
 {
+	int conn_id;
+	int execute;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CONN_ID(2, conn_id);
+
+	/* execute */
+	if (argc <= 3) {
+		haltest_error("No execute specified\n");
+		return;
+	}
+	execute = atoi(argv[3]);
+
+	EXEC(if_gatt->client->execute_write, conn_id, execute);
 }
 
 /* register_for_notification */
 
 static void register_for_notification_p(int argc, const char **argv)
 {
+	int client_if;
+	bt_bdaddr_t bd_addr;
+	btgatt_srvc_id_t srvc_id;
+	btgatt_char_id_t char_id;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CLIENT_IF(2, client_if);
+	VERIFY_ADDR_ARG(3, &bd_addr);
+	VERIFY_SRVC_ID(4, &srvc_id);
+	VERIFY_CHAR_ID(5, &char_id);
+
+	EXEC(if_gatt->client->register_for_notification, client_if, &bd_addr,
+							&srvc_id, &char_id);
 }
 
 /* deregister_for_notification */
 
 static void deregister_for_notification_p(int argc, const char **argv)
 {
+	int client_if;
+	bt_bdaddr_t bd_addr;
+	btgatt_srvc_id_t srvc_id;
+	btgatt_char_id_t char_id;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CLIENT_IF(2, client_if);
+	VERIFY_ADDR_ARG(3, &bd_addr);
+	VERIFY_SRVC_ID(4, &srvc_id);
+	VERIFY_CHAR_ID(5, &char_id);
+
+	EXEC(if_gatt->client->deregister_for_notification, client_if, &bd_addr,
+							&srvc_id, &char_id);
 }
 
 /* read_remote_rssi */
 
 static void read_remote_rssi_p(int argc, const char **argv)
 {
+	int client_if;
+	bt_bdaddr_t bd_addr;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CLIENT_IF(2, client_if);
+	VERIFY_ADDR_ARG(3, &bd_addr);
+
+	EXEC(if_gatt->client->read_remote_rssi, client_if, &bd_addr);
 }
 
 /* get_device_type */
 
 static void get_device_type_p(int argc, const char **argv)
 {
+	bt_bdaddr_t bd_addr;
+	int dev_type;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_ADDR_ARG(2, &bd_addr);
+
+	dev_type = if_gatt->client->get_device_type(&bd_addr);
+	haltest_info("%s: %d\n", "get_device_type", dev_type);
 }
 
 /* test_command */
 
 static void test_command_p(int argc, const char **argv)
 {
+	int command;
+	int i;
+	bt_bdaddr_t bd_addr;
+	bt_uuid_t uuid;
+	btgatt_test_params_t params = {
+		.bda1 = &bd_addr,
+		.uuid1 = &uuid
+	};
+	uint16_t *u = &params.u1;
+
+	RETURN_IF_NULL(if_gatt);
+
+	/* command */
+	if (argc <= 2) {
+		haltest_error("No command specified\n");
+		return;
+	}
+	command = atoi(argv[2]);
+
+	VERIFY_ADDR_ARG(3, &bd_addr);
+	VERIFY_UUID(4, &uuid);
+
+	for (i = 5; i < argc; i++)
+		*u++ = atoi(argv[i]);
+
+	EXEC(if_gatt->client->test_command, command, &params);
 }
 
 static struct method client_methods[] = {
-- 
1.7.9.5

