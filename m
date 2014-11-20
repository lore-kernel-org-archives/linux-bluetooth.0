Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] android/client: Add support for gattc scan_filter_param_setup
Date: Thu, 20 Nov 2014 16:34:03 +0100
Message-Id: <1416497645-6313-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1416497645-6313-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1416497645-6313-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is new command introduced in Android 5.0 bluetooth gatt client api.
---
 android/client/if-gatt.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index c412d58..568eba6 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -1637,6 +1637,49 @@ static void read_remote_rssi_p(int argc, const char **argv)
 	EXEC(if_gatt->client->read_remote_rssi, client_if, &bd_addr);
 }
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+/* scan filter parameter setup */
+static void scan_filter_param_setup_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 2) {
+		*user = client_if_str;
+		*enum_func = enum_one_string;
+	}
+}
+
+static void scan_filter_param_setup_p(int argc, const char **argv)
+{
+	int client_if;
+	int action;
+	int filt_index;
+	int feat_seln;
+	int list_logic_type, filt_logic_type;
+	int rssi_high_thres, rssi_low_thres;
+	int dely_mode;
+	int found_timeout, lost_timeout, found_timeout_cnt;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CLIENT_IF(2, client_if);
+	VERIFY_ACTION(3, action);
+	VERIFY_FILT_INDEX(4, filt_index);
+	VERIFY_FEAT_SELN(5, feat_seln);
+	VERIFY_LIST_LOGIC_TYPE(6, list_logic_type);
+	VERIFY_FILT_LOGIC_TYPE(7, filt_logic_type);
+	VERIFY_RSSI_HI_THR(8, rssi_high_thres);
+	VERIFY_RSSI_LOW_THR(9, rssi_low_thres);
+	VERIFY_DELY_MODE(10, dely_mode);
+	VERIFY_FND_TIME(11, found_timeout);
+	VERIFY_LOST_TIME(12, lost_timeout);
+	VERIFY_FND_TIME_CNT(13, found_timeout_cnt);
+
+	EXEC(if_gatt->client->scan_filter_param_setup, client_if, action,
+		filt_index, feat_seln, list_logic_type, filt_logic_type,
+		rssi_high_thres, rssi_low_thres, dely_mode, found_timeout,
+		lost_timeout, found_timeout_cnt);
+}
+#endif
+
 /* get_device_type */
 
 static void get_device_type_c(int argc, const char **argv, enum_func *enum_func,
@@ -1703,6 +1746,11 @@ static struct method client_methods[] = {
 #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 	STD_METHODCH(scan, "[1|0]"),
 	STD_METHODCH(connect, "<client_if> <addr> [<is_direct>] [<transport]"),
+	STD_METHODCH(scan_filter_param_setup, "<client_if> <action>"
+			" <filt_index> <feat_seln> <list_logic_type>"
+			" <filt_logic_type> <rssi_high_thres> <rssi_low_thres>"
+			" <dely_mode> <found_timeout> <lost_timeout>"
+			" <found_timeout_cnt>"),
 #else
 	STD_METHODCH(scan, "<client_if> [1|0]"),
 	STD_METHODCH(connect, "<client_if> <addr> [<is_direct>]"),
-- 
1.9.3

