Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] android/client: Add support for gattc set_adv_data cmd
Date: Tue, 25 Nov 2014 11:13:11 +0100
Message-Id: <1416910396-23174-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1416910396-23174-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1416910396-23174-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-gatt.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 112a49d..42dd119 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -1784,6 +1784,57 @@ static void scan_filter_enable_p(int argc, const char **argv)
 
 	EXEC(if_gatt->client->scan_filter_clear, client_if, enable);
 }
+
+/* set advertising data */
+static void set_adv_data_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 2) {
+		*user = client_if_str;
+		*enum_func = enum_one_string;
+	}
+}
+
+static void set_adv_data_p(int argc, const char **argv)
+{
+	int client_if;
+	bool set_scan_rsp;
+	bool include_name, include_txpower;
+	int min_interval, max_interval;
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
+	VERIFY_MIN_INTERVAL(6, min_interval);
+	VERIFY_MAX_INTERVAL(7, max_interval);
+	VERIFY_APPEARANCE(8, appearance);
+	GET_VERIFY_HEX_STRING(9, manufacturer_data, manufacturer_len);
+	GET_VERIFY_HEX_STRING(10, service_data, service_data_len);
+	GET_VERIFY_HEX_STRING(11, service_uuid, service_uuid_len);
+
+	EXEC(if_gatt->client->set_adv_data, client_if, set_scan_rsp,
+		include_name, include_txpower, min_interval, max_interval,
+		appearance, manufacturer_len, (char *) manufacturer_data,
+		service_data_len, (char *) service_data, service_uuid_len,
+		(char *) service_uuid);
+}
 #endif
 
 /* get_device_type */
@@ -1863,6 +1914,10 @@ static struct method client_methods[] = {
 			" [<p_data>] [<p_mask>]"),
 	STD_METHODCH(scan_filter_clear, "<client_if> <filt_index>"),
 	STD_METHODCH(scan_filter_enable, "<client_if> [<enable>]"),
+	STD_METHODCH(set_adv_data, "<client_if> [<set_scan_rsp>] <include_name>"
+			" [<include_txpower>] <min_interval> <max_interval>"
+			" <appearance> [<manufacturer_data>] [<service_data>]"
+			" [<service_uuid>]"),
 #else
 	STD_METHODCH(scan, "<client_if> [1|0]"),
 	STD_METHODCH(connect, "<client_if> <addr> [<is_direct>]"),
-- 
1.9.3

