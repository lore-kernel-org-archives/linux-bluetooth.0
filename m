Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] android/client: Add support for gattc batch_cfg_storage cmd
Date: Fri, 28 Nov 2014 09:22:01 +0100
Message-Id: <1417162925-17511-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1417162925-17511-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1417162925-17511-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-gatt.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 89fa45f..d43a5e8 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -2029,6 +2029,34 @@ static void multi_adv_disable_p(int argc, const char **argv)
 
 	EXEC(if_gatt->client->multi_adv_disable, client_if);
 }
+
+/* batch scanconfigure storage */
+static void batchscan_cfg_storage_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 2) {
+		*user = client_if_str;
+		*enum_func = enum_one_string;
+	}
+}
+
+static void batchscan_cfg_storage_p(int argc, const char **argv)
+{
+	int client_if;
+	int batch_scan_full_max;
+	int batch_scan_trunc_max;
+	int batch_scan_notify_threshold;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CLIENT_IF(2, client_if);
+	VERIFY_BATCH_SCAN_FULL_MAX(3, batch_scan_full_max);
+	VERIFY_BATCH_SCAN_TRUNC_MAX(4, batch_scan_trunc_max);
+	VERIFY_BATCH_SCAN_NOTIFY_THR(5, batch_scan_notify_threshold);
+
+	EXEC(if_gatt->client->batchscan_cfg_storage, client_if,
+				batch_scan_full_max, batch_scan_trunc_max,
+				batch_scan_notify_threshold);
+}
 #endif
 
 /* get_device_type */
@@ -2127,6 +2155,9 @@ static struct method client_methods[] = {
 			" [<manufacturer_data>] [<service_data>]"
 			" [<service_uuid>]"),
 	STD_METHODCH(multi_adv_disable, "<client_if>"),
+	STD_METHODCH(batchscan_cfg_storage, "<client_if> <batch_scan_full_max>"
+					" <batch_scan_trunc_max>"
+					" <batch_scan_notify_threshold>"),
 #else
 	STD_METHODCH(scan, "<client_if> [1|0]"),
 	STD_METHODCH(connect, "<client_if> <addr> [<is_direct>]"),
-- 
1.9.3

