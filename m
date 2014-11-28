Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] android/client: Add support for gattc batchscan_read_reports cmd
Date: Fri, 28 Nov 2014 09:22:04 +0100
Message-Id: <1417162925-17511-6-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1417162925-17511-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1417162925-17511-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-gatt.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index df40f33..b39a5ec 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -2106,6 +2106,28 @@ static void batchscan_dis_batch_scan_p(int argc, const char **argv)
 
 	EXEC(if_gatt->client->batchscan_dis_batch_scan, client_if);
 }
+
+/* batchscan read reports */
+static void batchscan_read_reports_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 2) {
+		*user = client_if_str;
+		*enum_func = enum_one_string;
+	}
+}
+
+static void batchscan_read_reports_p(int argc, const char **argv)
+{
+	int client_if;
+	int scan_mode;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CLIENT_IF(2, client_if);
+	VERIFY_SCAN_MODE(3, scan_mode);
+
+	EXEC(if_gatt->client->batchscan_read_reports, client_if, scan_mode);
+}
 #endif
 
 /* get_device_type */
@@ -2211,6 +2233,7 @@ static struct method client_methods[] = {
 			" <scan_interval> <scan_window> <addr_type>"
 			" <discard_rule>"),
 	STD_METHODCH(batchscan_dis_batch_scan, "<client_if>"),
+	STD_METHODCH(batchscan_read_reports, "<client_if> <scan_mode>"),
 #else
 	STD_METHODCH(scan, "<client_if> [1|0]"),
 	STD_METHODCH(connect, "<client_if> <addr> [<is_direct>]"),
-- 
1.9.3

