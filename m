Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] android/client: Add support for gattc multi_adv_enable cmd
Date: Tue, 25 Nov 2014 11:13:15 +0100
Message-Id: <1416910396-23174-6-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1416910396-23174-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1416910396-23174-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-gatt.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 920b243..c94aaea 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -1898,6 +1898,38 @@ static void set_scan_parameters_p(int argc, const char **argv)
 
 	EXEC(if_gatt->client->set_scan_parameters, scan_interval, scan_window);
 }
+
+/* enable multi advertising */
+static void multi_adv_enable_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 2) {
+		*user = client_if_str;
+		*enum_func = enum_one_string;
+	}
+}
+
+static void multi_adv_enable_p(int argc, const char **argv)
+{
+	int client_if;
+	int min_interval, max_interval;
+	int adv_type;
+	int chnl_map;
+	int tx_power;
+	int timeout_s;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CLIENT_IF(2, client_if);
+	VERIFY_MIN_INTERVAL(3, min_interval);
+	VERIFY_MAX_INTERVAL(4, max_interval);
+	VERIFY_ADV_TYPE(5, adv_type);
+	VERIFY_CHNL_MAP(6, chnl_map);
+	VERIFY_TX_POWER(7, tx_power);
+	VERIFY_TIMEOUT_S(8, timeout_s);
+
+	EXEC(if_gatt->client->multi_adv_enable, client_if, min_interval,
+			max_interval, adv_type, chnl_map, tx_power, timeout_s);
+}
 #endif
 
 /* get_device_type */
@@ -1985,6 +2017,9 @@ static struct method client_methods[] = {
 	STD_METHODCH(conn_parameter_update, "<bd_addr> <min_interval>"
 					" <max_interval> <latency> <timeout>"),
 	STD_METHODH(set_scan_parameters, "<scan_inverval> <scan_window>"),
+	STD_METHODCH(multi_adv_enable, "<client_if> <min_interval>"
+			" <max_interval> <adv_type> <chnl_map> <tx_power>"
+			" <timeout_s>"),
 #else
 	STD_METHODCH(scan, "<client_if> [1|0]"),
 	STD_METHODCH(connect, "<client_if> <addr> [<is_direct>]"),
-- 
1.9.3

