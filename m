Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/client: Allow parsing hex and int arguments
Date: Wed, 15 Apr 2015 10:35:35 +0200
Message-Id: <1429086935-17657-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch modify parsing of arguments. Arguments should be properly
parsed as hex (string with 0x) and as integer.
---
 android/client/if-gatt.c | 56 ++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 70287fc..aaa4394 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -1170,13 +1170,13 @@ static void scan_p(int argc, const char **argv)
 
 	/* start */
 	if (argc >= 4)
-		start = atoi(argv[3]);
+		start = strtol(argv[3], NULL, 0);
 
 	EXEC(if_gatt->client->scan, client_if, start);
 #else
 	/* start */
 	if (argc >= 3)
-		start = atoi(argv[2]);
+		start = strtol(argv[2], NULL, 0);
 
 	EXEC(if_gatt->client->scan, start);
 #endif
@@ -1211,14 +1211,14 @@ static void connect_p(int argc, const char **argv)
 
 	/* is_direct */
 	if (argc > 4)
-		is_direct = atoi(argv[4]);
+		is_direct = strtol(argv[4], NULL, 0);
 
 #if ANDROID_VERSION < PLATFORM_VER(5, 0, 0)
 	EXEC(if_gatt->client->connect, client_if, &bd_addr, is_direct);
 #else
 	/* transport */
 	if (argc > 5)
-		transport = atoi(argv[5]);
+		transport = strtol(argv[5], NULL, 0);
 
 	EXEC(if_gatt->client->connect, client_if, &bd_addr, is_direct,
 								transport);
@@ -1272,7 +1272,7 @@ static void listen_p(int argc, const char **argv)
 
 	/* start */
 	if (argc >= 4)
-		start = atoi(argv[3]);
+		start = strtol(argv[3], NULL, 0);
 
 	EXEC(if_gatt->client->listen, client_if, start);
 }
@@ -1412,7 +1412,7 @@ static void read_characteristic_p(int argc, const char **argv)
 
 	/* auth_req */
 	if (argc > 5)
-		auth_req = atoi(argv[5]);
+		auth_req = strtol(argv[5], NULL, 0);
 
 	EXEC(if_gatt->client->read_characteristic, conn_id, &srvc_id, &char_id,
 								auth_req);
@@ -1458,13 +1458,13 @@ static void write_characteristic_p(int argc, const char **argv)
 		haltest_error("No write type specified\n");
 		return;
 	}
-	write_type = atoi(argv[5]);
+	write_type = strtol(argv[5], NULL, 0);
 
 	GET_VERIFY_HEX_STRING(6, value, len);
 
 	/* auth_req */
 	if (argc > 7)
-		auth_req = atoi(argv[7]);
+		auth_req = strtol(argv[7], NULL, 0);
 
 	EXEC(if_gatt->client->write_characteristic, conn_id, &srvc_id, &char_id,
 				write_type, len, auth_req, (char *) value);
@@ -1491,7 +1491,7 @@ static void read_descriptor_p(int argc, const char **argv)
 
 	/* auth_req */
 	if (argc > 6)
-		auth_req = atoi(argv[6]);
+		auth_req = strtol(argv[6], NULL, 0);
 
 	EXEC(if_gatt->client->read_descriptor, conn_id, &srvc_id, &char_id,
 							&descr_id, auth_req);
@@ -1539,7 +1539,7 @@ static void write_descriptor_p(int argc, const char **argv)
 		haltest_error("No write type specified\n");
 		return;
 	}
-	write_type = atoi(argv[6]);
+	write_type = strtol(argv[6], NULL, 0);
 
 	/* value */
 	if (argc <= 7) {
@@ -1557,7 +1557,7 @@ static void write_descriptor_p(int argc, const char **argv)
 
 	/* auth_req */
 	if (argc > 8)
-		auth_req = atoi(argv[8]);
+		auth_req = strtol(argv[8], NULL, 0);
 
 	EXEC(if_gatt->client->write_descriptor, conn_id, &srvc_id, &char_id,
 			&descr_id, write_type, len, auth_req, (char *) value);
@@ -1581,7 +1581,7 @@ static void execute_write_p(int argc, const char **argv)
 		haltest_error("No execute specified\n");
 		return;
 	}
-	execute = atoi(argv[3]);
+	execute = strtol(argv[3], NULL, 0);
 
 	EXEC(if_gatt->client->execute_write, conn_id, execute);
 }
@@ -1807,7 +1807,7 @@ static void scan_filter_enable_p(int argc, const char **argv)
 
 	/* enable */
 	if (argc >= 4)
-		enable = atoi(argv[3]);
+		enable = strtol(argv[3], NULL, 0);
 
 	EXEC(if_gatt->client->scan_filter_clear, client_if, enable);
 }
@@ -1841,13 +1841,13 @@ static void set_adv_data_p(int argc, const char **argv)
 
 	/* set scan response */
 	if (argc >= 4)
-		set_scan_rsp = atoi(argv[3]);
+		set_scan_rsp = strtol(argv[3], NULL, 0);
 	/* include name */
 	if (argc >= 5)
-		include_name = atoi(argv[4]);
+		include_name = strtol(argv[4], NULL, 0);
 	/* include txpower */
 	if (argc >= 6)
-		include_txpower = atoi(argv[5]);
+		include_txpower = strtol(argv[5], NULL, 0);
 
 	VERIFY_MIN_INTERVAL(6, min_interval);
 	VERIFY_MAX_INTERVAL(7, max_interval);
@@ -2018,13 +2018,13 @@ static void multi_adv_set_inst_data_p(int argc, const char **argv)
 
 	/* set scan response */
 	if (argc >= 4)
-		set_scan_rsp = atoi(argv[3]);
+		set_scan_rsp = strtol(argv[3], NULL, 0);
 	/* include name */
 	if (argc >= 5)
-		include_name = atoi(argv[4]);
+		include_name = strtol(argv[4], NULL, 0);
 	/* include txpower */
 	if (argc >= 6)
-		include_txpower = atoi(argv[5]);
+		include_txpower = strtol(argv[5], NULL, 0);
 
 	VERIFY_APPEARANCE(6, appearance);
 	GET_VERIFY_HEX_STRING(7, manufacturer_data, manufacturer_len);
@@ -2206,7 +2206,7 @@ static void test_command_p(int argc, const char **argv)
 		haltest_error("No command specified\n");
 		return;
 	}
-	command = atoi(argv[2]);
+	command = strtol(argv[2], NULL, 0);
 
 	VERIFY_ADDR_ARG(3, &bd_addr);
 	VERIFY_UUID(4, &uuid);
@@ -2366,14 +2366,14 @@ static void gatts_connect_p(int argc, const char *argv[])
 
 	/* is_direct */
 	if (argc > 4)
-		is_direct = atoi(argv[4]);
+		is_direct = strtol(argv[4], NULL, 0);
 
 #if ANDROID_VERSION < PLATFORM_VER(5, 0, 0)
 	EXEC(if_gatt->server->connect, server_if, &bd_addr, is_direct);
 #else
 	/* transport */
 	if (argc > 5)
-		transport = atoi(argv[5]);
+		transport = strtol(argv[5], NULL, 0);
 
 	EXEC(if_gatt->server->connect, server_if, &bd_addr, is_direct,
 								transport);
@@ -2431,7 +2431,7 @@ static void gatts_add_service_p(int argc, const char *argv[])
 		haltest_error("No num_handles specified\n");
 		return;
 	}
-	num_handles = atoi(argv[4]);
+	num_handles = strtol(argv[4], NULL, 0);
 
 	EXEC(if_gatt->server->add_service, server_if, &srvc_id, num_handles);
 }
@@ -2479,14 +2479,14 @@ static void gatts_add_characteristic_p(int argc, const char *argv[])
 		haltest_error("No properties specified\n");
 		return;
 	}
-	properties = atoi(argv[5]);
+	properties = strtol(argv[5], NULL, 0);
 
 	/* permissions */
 	if (argc <= 6) {
 		haltest_error("No permissions specified\n");
 		return;
 	}
-	permissions = atoi(argv[6]);
+	permissions = strtol(argv[6], NULL, 0);
 
 	EXEC(if_gatt->server->add_characteristic, server_if, service_handle,
 						&uuid, properties, permissions);
@@ -2514,7 +2514,7 @@ static void gatts_add_descriptor_p(int argc, const char *argv[])
 		haltest_error("No permissions specified\n");
 		return;
 	}
-	permissions = atoi(argv[5]);
+	permissions = strtol(argv[5], NULL, 0);
 
 	EXEC(if_gatt->server->add_descriptor, server_if, service_handle, &uuid,
 								permissions);
@@ -2540,7 +2540,7 @@ static void gatts_start_service_p(int argc, const char *argv[])
 		haltest_error("No transport specified\n");
 		return;
 	}
-	transport = atoi(argv[4]);
+	transport = strtol(argv[4], NULL, 0);
 
 	EXEC(if_gatt->server->start_service, server_if, service_handle,
 								transport);
@@ -2601,7 +2601,7 @@ static void gatts_send_indication_p(int argc, const char *argv[])
 		haltest_error("No transport specified\n");
 		return;
 	}
-	confirm = atoi(argv[5]);
+	confirm = strtol(argv[5], NULL, 0);
 
 	GET_VERIFY_HEX_STRING(6, data, len);
 
-- 
2.1.0

