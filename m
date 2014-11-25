Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] android/client: Add support for gattc conn_parameter_update cmd
Date: Tue, 25 Nov 2014 11:13:13 +0100
Message-Id: <1416910396-23174-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1416910396-23174-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1416910396-23174-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-gatt.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 9681bc2..eb54ddd 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -1857,6 +1857,34 @@ static void configure_mtu_p(int argc, const char **argv)
 
 	EXEC(if_gatt->client->configure_mtu, conn_id, mtu);
 }
+
+/* con parameter update */
+static void conn_parameter_update_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 2) {
+		*user = last_addr;
+		*enum_func = enum_one_string;
+	}
+}
+
+static void conn_parameter_update_p(int argc, const char **argv)
+{
+	bt_bdaddr_t bd_addr;
+	int min_interval, max_interval;
+	int latency;
+	int timeout;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_ADDR_ARG(2, &bd_addr);
+	VERIFY_MIN_INTERVAL(3, min_interval);
+	VERIFY_MAX_INTERVAL(4, max_interval);
+	VERIFY_LATENCY(5, latency);
+	VERIFY_TIMEOUT(6, timeout);
+
+	EXEC(if_gatt->client->conn_parameter_update, &bd_addr, min_interval,
+						max_interval, latency, timeout);
+}
 #endif
 
 /* get_device_type */
@@ -1941,6 +1969,8 @@ static struct method client_methods[] = {
 			" <appearance> [<manufacturer_data>] [<service_data>]"
 			" [<service_uuid>]"),
 	STD_METHODCH(configure_mtu, "<conn_id> <mtu>"),
+	STD_METHODCH(conn_parameter_update, "<bd_addr> <min_interval>"
+					" <max_interval> <latency> <timeout>"),
 #else
 	STD_METHODCH(scan, "<client_if> [1|0]"),
 	STD_METHODCH(connect, "<client_if> <addr> [<is_direct>]"),
-- 
1.9.3

