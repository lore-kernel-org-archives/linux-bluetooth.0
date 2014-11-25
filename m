Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] android/client: Add support for gattc configure_mtu cmd
Date: Tue, 25 Nov 2014 11:13:12 +0100
Message-Id: <1416910396-23174-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1416910396-23174-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1416910396-23174-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-gatt.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 42dd119..9681bc2 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -1835,6 +1835,28 @@ static void set_adv_data_p(int argc, const char **argv)
 		service_data_len, (char *) service_data, service_uuid_len,
 		(char *) service_uuid);
 }
+
+/* configure mtu */
+static void configure_mtu_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 2) {
+		*user = conn_id_str;
+		*enum_func = enum_one_string;
+	}
+}
+
+static void configure_mtu_p(int argc, const char **argv)
+{
+	int conn_id;
+	int mtu;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CONN_ID(2, conn_id);
+	VERIFY_MTU(3, mtu);
+
+	EXEC(if_gatt->client->configure_mtu, conn_id, mtu);
+}
 #endif
 
 /* get_device_type */
@@ -1918,6 +1940,7 @@ static struct method client_methods[] = {
 			" [<include_txpower>] <min_interval> <max_interval>"
 			" <appearance> [<manufacturer_data>] [<service_data>]"
 			" [<service_uuid>]"),
+	STD_METHODCH(configure_mtu, "<conn_id> <mtu>"),
 #else
 	STD_METHODCH(scan, "<client_if> [1|0]"),
 	STD_METHODCH(connect, "<client_if> <addr> [<is_direct>]"),
-- 
1.9.3

