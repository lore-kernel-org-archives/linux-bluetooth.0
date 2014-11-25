Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] android/client: Omit length parameter for hex string data
Date: Tue, 25 Nov 2014 11:13:10 +0100
Message-Id: <1416910396-23174-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to pass length parameter to functions. Length of hex
strings is automatically calculated from string in GET_VERIFY_HEX_STRING
macro.
---
 android/client/if-gatt.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 2b874c3..112a49d 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -1729,10 +1729,8 @@ static void scan_filter_add_remove_p(int argc, const char **argv)
 	VERIFY_UUID(9, &p_uuid_mask);
 	VERIFY_ADDR_ARG(10, &bd_addr);
 	VERIFY_ADDR_TYPE(11, addr_type);
-	VERIFY_DATA_LEN(12, data_len);
-	GET_VERIFY_HEX_STRING(13, p_data, data_len);
-	VERIFY_MASK_LEN(14, mask_len);
-	GET_VERIFY_HEX_STRING(15, p_mask, mask_len);
+	GET_VERIFY_HEX_STRING(12, p_data, data_len);
+	GET_VERIFY_HEX_STRING(13, p_mask, mask_len);
 
 	EXEC(if_gatt->client->scan_filter_add_remove, client_if, action,
 		filt_type, filt_index, company_id, company_id_mask,
@@ -1862,7 +1860,7 @@ static struct method client_methods[] = {
 	STD_METHODCH(scan_filter_add_remove, "<client_if> <action> <filt_type>"
 			" <filt_index> <company_id> <company_id_mask>"
 			" [<p_uuid>] <p_uuid_mask> <addr> <addr_type>"
-			" <data_len> [<p_data>] <mask_len> [<p_mask>]"),
+			" [<p_data>] [<p_mask>]"),
 	STD_METHODCH(scan_filter_clear, "<client_if> <filt_index>"),
 	STD_METHODCH(scan_filter_enable, "<client_if> [<enable>]"),
 #else
-- 
1.9.3

