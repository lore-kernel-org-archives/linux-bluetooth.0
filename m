Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] android/client: Add support for gattc set_scan_parameters cmd
Date: Tue, 25 Nov 2014 11:13:14 +0100
Message-Id: <1416910396-23174-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1416910396-23174-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1416910396-23174-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-gatt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index eb54ddd..920b243 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -1885,6 +1885,19 @@ static void conn_parameter_update_p(int argc, const char **argv)
 	EXEC(if_gatt->client->conn_parameter_update, &bd_addr, min_interval,
 						max_interval, latency, timeout);
 }
+
+/* set scan parameters */
+static void set_scan_parameters_p(int argc, const char **argv)
+{
+	int scan_interval;
+	int scan_window;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_SCAN_INTERVAL(2, scan_interval);
+	VERIFY_SCAN_WINDOW(3, scan_window);
+
+	EXEC(if_gatt->client->set_scan_parameters, scan_interval, scan_window);
+}
 #endif
 
 /* get_device_type */
@@ -1971,6 +1984,7 @@ static struct method client_methods[] = {
 	STD_METHODCH(configure_mtu, "<conn_id> <mtu>"),
 	STD_METHODCH(conn_parameter_update, "<bd_addr> <min_interval>"
 					" <max_interval> <latency> <timeout>"),
+	STD_METHODH(set_scan_parameters, "<scan_inverval> <scan_window>"),
 #else
 	STD_METHODCH(scan, "<client_if> [1|0]"),
 	STD_METHODCH(connect, "<client_if> <addr> [<is_direct>]"),
-- 
1.9.3

