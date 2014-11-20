Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] android/client: Add support for gattc scan_filter_clear cmd
Date: Thu, 20 Nov 2014 16:34:05 +0100
Message-Id: <1416497645-6313-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1416497645-6313-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1416497645-6313-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-gatt.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 4c9dcfa..c06a1a5 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -1739,6 +1739,28 @@ static void scan_filter_add_remove_p(int argc, const char **argv)
 		&p_uuid, &p_uuid_mask, &bd_addr, addr_type, data_len,
 		(char *) p_data, mask_len, (char *) p_mask);
 }
+
+/* scan filter clean */
+static void scan_filter_clear_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 2) {
+		*user = client_if_str;
+		*enum_func = enum_one_string;
+	}
+}
+
+static void scan_filter_clear_p(int argc, const char **argv)
+{
+	int client_if;
+	int filt_index;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CLIENT_IF(2, client_if);
+	VERIFY_FILT_INDEX(3, filt_index);
+
+	EXEC(if_gatt->client->scan_filter_clear, client_if, filt_index);
+}
 #endif
 
 /* get_device_type */
@@ -1816,6 +1838,7 @@ static struct method client_methods[] = {
 			" <filt_index> <company_id> <company_id_mask>"
 			" [<p_uuid>] <p_uuid_mask> <addr> <addr_type>"
 			" <data_len> [<p_data>] <mask_len> [<p_mask>]"),
+	STD_METHODCH(scan_filter_clear, "<client_if> <filt_index>"),
 #else
 	STD_METHODCH(scan, "<client_if> [1|0]"),
 	STD_METHODCH(connect, "<client_if> <addr> [<is_direct>]"),
-- 
1.9.3

