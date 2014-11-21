Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] android/client: Add support for gattc scan_filter_enable
Date: Fri, 21 Nov 2014 12:40:51 +0100
Message-Id: <1416570051-18218-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-gatt.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index c06a1a5..2b874c3 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -1761,6 +1761,31 @@ static void scan_filter_clear_p(int argc, const char **argv)
 
 	EXEC(if_gatt->client->scan_filter_clear, client_if, filt_index);
 }
+
+/* scan filter enable */
+static void scan_filter_enable_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 2) {
+		*user = client_if_str;
+		*enum_func = enum_one_string;
+	}
+}
+
+static void scan_filter_enable_p(int argc, const char **argv)
+{
+	int client_if;
+	int enable = 0;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CLIENT_IF(2, client_if);
+
+	/* enable */
+	if (argc >= 4)
+		enable = atoi(argv[3]);
+
+	EXEC(if_gatt->client->scan_filter_clear, client_if, enable);
+}
 #endif
 
 /* get_device_type */
@@ -1839,6 +1864,7 @@ static struct method client_methods[] = {
 			" [<p_uuid>] <p_uuid_mask> <addr> <addr_type>"
 			" <data_len> [<p_data>] <mask_len> [<p_mask>]"),
 	STD_METHODCH(scan_filter_clear, "<client_if> <filt_index>"),
+	STD_METHODCH(scan_filter_enable, "<client_if> [<enable>]"),
 #else
 	STD_METHODCH(scan, "<client_if> [1|0]"),
 	STD_METHODCH(connect, "<client_if> <addr> [<is_direct>]"),
-- 
1.9.3

