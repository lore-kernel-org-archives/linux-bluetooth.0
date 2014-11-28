Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] android/client: Add support for gattc batchscan_enb_batch_scan cmd
Date: Fri, 28 Nov 2014 09:22:02 +0100
Message-Id: <1417162925-17511-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1417162925-17511-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1417162925-17511-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-gatt.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index d43a5e8..cf55e96 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -2057,6 +2057,35 @@ static void batchscan_cfg_storage_p(int argc, const char **argv)
 				batch_scan_full_max, batch_scan_trunc_max,
 				batch_scan_notify_threshold);
 }
+
+/* enable batch scan */
+static void batchscan_enb_batch_scan_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 2) {
+		*user = client_if_str;
+		*enum_func = enum_one_string;
+	}
+}
+
+static void batchscan_enb_batch_scan_p(int argc, const char **argv)
+{
+	int client_if;
+	int scan_mode, scan_interval, scan_window;
+	int addr_type;
+	int discard_rule;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CLIENT_IF(2, client_if);
+	VERIFY_SCAN_MODE(3, scan_mode);
+	VERIFY_SCAN_INTERVAL(4, scan_interval);
+	VERIFY_SCAN_WINDOW(5, scan_window);
+	VERIFY_ADDR_TYPE(6, addr_type);
+	VERIFY_DISCARD_RULE(7, discard_rule);
+
+	EXEC(if_gatt->client->batchscan_enb_batch_scan, client_if, scan_mode,
+			scan_interval, scan_window, addr_type, discard_rule);
+}
 #endif
 
 /* get_device_type */
@@ -2158,6 +2187,9 @@ static struct method client_methods[] = {
 	STD_METHODCH(batchscan_cfg_storage, "<client_if> <batch_scan_full_max>"
 					" <batch_scan_trunc_max>"
 					" <batch_scan_notify_threshold>"),
+	STD_METHODCH(batchscan_enb_batch_scan, "<client_if> <scan_mode>"
+			" <scan_interval> <scan_window> <addr_type>"
+			" <discard_rule>"),
 #else
 	STD_METHODCH(scan, "<client_if> [1|0]"),
 	STD_METHODCH(connect, "<client_if> <addr> [<is_direct>]"),
-- 
1.9.3

