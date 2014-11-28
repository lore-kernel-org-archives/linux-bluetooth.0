Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] android/client: Add support for gattc multi_adv_set_inst_data cmd
Date: Fri, 28 Nov 2014 09:21:59 +0100
Message-Id: <1417162925-17511-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-gatt.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index fa17eb2..5072f91 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -1962,6 +1962,53 @@ static void multi_adv_update_p(int argc, const char **argv)
 	EXEC(if_gatt->client->multi_adv_update, client_if, min_interval,
 			max_interval, adv_type, chnl_map, tx_power, timeout_s);
 }
+
+/* set advertising data */
+static void multi_adv_set_inst_data_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 2) {
+		*user = client_if_str;
+		*enum_func = enum_one_string;
+	}
+}
+
+static void multi_adv_set_inst_data_p(int argc, const char **argv)
+{
+	int client_if;
+	bool set_scan_rsp;
+	bool include_name, include_txpower;
+	int appearance;
+	uint16_t manufacturer_len;
+	uint8_t manufacturer_data[100];
+	uint16_t service_data_len;
+	uint8_t service_data[100];
+	uint16_t service_uuid_len;
+	uint8_t service_uuid[100];
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CLIENT_IF(2, client_if);
+
+	/* set scan response */
+	if (argc >= 4)
+		set_scan_rsp = atoi(argv[3]);
+	/* include name */
+	if (argc >= 5)
+		include_name = atoi(argv[4]);
+	/* include txpower */
+	if (argc >= 6)
+		include_txpower = atoi(argv[5]);
+
+	VERIFY_APPEARANCE(6, appearance);
+	GET_VERIFY_HEX_STRING(7, manufacturer_data, manufacturer_len);
+	GET_VERIFY_HEX_STRING(8, service_data, service_data_len);
+	GET_VERIFY_HEX_STRING(9, service_uuid, service_uuid_len);
+
+	EXEC(if_gatt->client->multi_adv_set_inst_data, client_if, set_scan_rsp,
+		include_name, include_txpower, appearance, manufacturer_len,
+		(char *) manufacturer_data, service_data_len,
+		(char *) service_data, service_uuid_len, (char *) service_uuid);
+}
 #endif
 
 /* get_device_type */
@@ -2055,6 +2102,10 @@ static struct method client_methods[] = {
 	STD_METHODCH(multi_adv_update, "<client_if> <min_interval>"
 			" <max_interval> <adv_type> <chnl_map> <tx_power>"
 			" <timeout_s>"),
+	STD_METHODCH(multi_adv_set_inst_data, "<client_if> [<set_scan_rsp>]"
+			" <include_name> [<include_txpower>] <appearance>"
+			" [<manufacturer_data>] [<service_data>]"
+			" [<service_uuid>]"),
 #else
 	STD_METHODCH(scan, "<client_if> [1|0]"),
 	STD_METHODCH(connect, "<client_if> <addr> [<is_direct>]"),
-- 
1.9.3

