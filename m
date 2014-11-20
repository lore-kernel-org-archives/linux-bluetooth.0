Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] android/client: Add support for gattc scan_filter_add_remove cmd
Date: Thu, 20 Nov 2014 16:34:04 +0100
Message-Id: <1416497645-6313-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1416497645-6313-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1416497645-6313-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-gatt.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 568eba6..4c9dcfa 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -1678,6 +1678,67 @@ static void scan_filter_param_setup_p(int argc, const char **argv)
 		rssi_high_thres, rssi_low_thres, dely_mode, found_timeout,
 		lost_timeout, found_timeout_cnt);
 }
+
+/* scan filter add remove */
+
+static void scan_filter_add_remove_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 2) {
+		*user = client_if_str;
+		*enum_func = enum_one_string;
+	} else if (argc == 10) {
+		*user = last_addr;
+		*enum_func = enum_one_string;
+	}
+}
+
+static void scan_filter_add_remove_p(int argc, const char **argv)
+{
+	int client_if;
+	int action;
+	int filt_type;
+	int filt_index;
+	int company_id;
+	int company_id_mask;
+	bt_uuid_t p_uuid;
+	bt_uuid_t p_uuid_mask;
+	bt_bdaddr_t bd_addr;
+	char addr_type;
+	int data_len;
+	uint8_t p_data[100];
+	int mask_len;
+	uint8_t p_mask[100];
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CLIENT_IF(2, client_if);
+	VERIFY_ACTION(3, action);
+	VERIFY_FILT_TYPE(4, filt_type);
+	VERIFY_FILT_INDEX(5, filt_index);
+	VERIFY_COMP_ID(6, company_id);
+	VERIFY_COMP_ID_MASK(7, company_id_mask);
+
+	if (argc <= 9) {
+		haltest_error("No p_uuid, p_uuid_mask specified\n");
+		return;
+	}
+	gatt_str2bt_uuid_t(argv[8], -1, &p_uuid);
+	gatt_str2bt_uuid_t(argv[9], -1, &p_uuid_mask);
+
+	VERIFY_UUID(8, &p_uuid);
+	VERIFY_UUID(9, &p_uuid_mask);
+	VERIFY_ADDR_ARG(10, &bd_addr);
+	VERIFY_ADDR_TYPE(11, addr_type);
+	VERIFY_DATA_LEN(12, data_len);
+	GET_VERIFY_HEX_STRING(13, p_data, data_len);
+	VERIFY_MASK_LEN(14, mask_len);
+	GET_VERIFY_HEX_STRING(15, p_mask, mask_len);
+
+	EXEC(if_gatt->client->scan_filter_add_remove, client_if, action,
+		filt_type, filt_index, company_id, company_id_mask,
+		&p_uuid, &p_uuid_mask, &bd_addr, addr_type, data_len,
+		(char *) p_data, mask_len, (char *) p_mask);
+}
 #endif
 
 /* get_device_type */
@@ -1751,6 +1812,10 @@ static struct method client_methods[] = {
 			" <filt_logic_type> <rssi_high_thres> <rssi_low_thres>"
 			" <dely_mode> <found_timeout> <lost_timeout>"
 			" <found_timeout_cnt>"),
+	STD_METHODCH(scan_filter_add_remove, "<client_if> <action> <filt_type>"
+			" <filt_index> <company_id> <company_id_mask>"
+			" [<p_uuid>] <p_uuid_mask> <addr> <addr_type>"
+			" <data_len> [<p_data>] <mask_len> [<p_mask>]"),
 #else
 	STD_METHODCH(scan, "<client_if> [1|0]"),
 	STD_METHODCH(connect, "<client_if> <addr> [<is_direct>]"),
-- 
1.9.3

