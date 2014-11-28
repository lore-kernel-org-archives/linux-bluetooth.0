Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] android/client: Add support for gattc multi_adv_disable cmd
Date: Fri, 28 Nov 2014 09:22:00 +0100
Message-Id: <1417162925-17511-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1417162925-17511-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1417162925-17511-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-gatt.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 5072f91..89fa45f 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -2009,6 +2009,26 @@ static void multi_adv_set_inst_data_p(int argc, const char **argv)
 		(char *) manufacturer_data, service_data_len,
 		(char *) service_data, service_uuid_len, (char *) service_uuid);
 }
+
+/* multi advertising disable */
+static void multi_adv_disable_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 2) {
+		*user = client_if_str;
+		*enum_func = enum_one_string;
+	}
+}
+
+static void multi_adv_disable_p(int argc, const char **argv)
+{
+	int client_if;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CLIENT_IF(2, client_if);
+
+	EXEC(if_gatt->client->multi_adv_disable, client_if);
+}
 #endif
 
 /* get_device_type */
@@ -2106,6 +2126,7 @@ static struct method client_methods[] = {
 			" <include_name> [<include_txpower>] <appearance>"
 			" [<manufacturer_data>] [<service_data>]"
 			" [<service_uuid>]"),
+	STD_METHODCH(multi_adv_disable, "<client_if>"),
 #else
 	STD_METHODCH(scan, "<client_if> [1|0]"),
 	STD_METHODCH(connect, "<client_if> <addr> [<is_direct>]"),
-- 
1.9.3

