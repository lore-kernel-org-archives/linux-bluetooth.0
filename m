Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] android/client: Add support for gattc batchscan_dis_batch_scan cmd
Date: Fri, 28 Nov 2014 09:22:03 +0100
Message-Id: <1417162925-17511-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1417162925-17511-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1417162925-17511-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-gatt.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index cf55e96..df40f33 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -2086,6 +2086,26 @@ static void batchscan_enb_batch_scan_p(int argc, const char **argv)
 	EXEC(if_gatt->client->batchscan_enb_batch_scan, client_if, scan_mode,
 			scan_interval, scan_window, addr_type, discard_rule);
 }
+
+/* batchscan disable */
+static void batchscan_dis_batch_scan_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 2) {
+		*user = client_if_str;
+		*enum_func = enum_one_string;
+	}
+}
+
+static void batchscan_dis_batch_scan_p(int argc, const char **argv)
+{
+	int client_if;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CLIENT_IF(2, client_if);
+
+	EXEC(if_gatt->client->batchscan_dis_batch_scan, client_if);
+}
 #endif
 
 /* get_device_type */
@@ -2190,6 +2210,7 @@ static struct method client_methods[] = {
 	STD_METHODCH(batchscan_enb_batch_scan, "<client_if> <scan_mode>"
 			" <scan_interval> <scan_window> <addr_type>"
 			" <discard_rule>"),
+	STD_METHODCH(batchscan_dis_batch_scan, "<client_if>"),
 #else
 	STD_METHODCH(scan, "<client_if> [1|0]"),
 	STD_METHODCH(connect, "<client_if> <addr> [<is_direct>]"),
-- 
1.9.3

