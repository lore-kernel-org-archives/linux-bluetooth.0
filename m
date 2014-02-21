Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 13/13] android/tester: Add guard for late callback calls
Date: Fri, 21 Feb 2014 13:57:53 +0100
Message-Id: <1392987473-19994-14-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1392987473-19994-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1392987473-19994-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes callbacks being called in wrong test case when current test
has already failed or timed out.
---
 android/android-tester.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 921204d..f539b87 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -43,6 +43,8 @@
 
 #include "utils.h"
 
+gint scheduled_cbacks_num = 0;
+
 struct priority_property {
 	bt_property_t prop;
 	int prio;
@@ -628,6 +630,8 @@ static gboolean adapter_state_changed(gpointer user_data)
 
 cleanup:
 	g_free(cb_data);
+
+	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 	return FALSE;
 }
 
@@ -637,6 +641,7 @@ static void adapter_state_changed_cb(bt_state_t state)
 
 	cb_data->state = state;
 
+	g_atomic_int_inc(&scheduled_cbacks_num);
 	g_idle_add(adapter_state_changed, cb_data);
 }
 
@@ -733,6 +738,7 @@ static gboolean discovery_state_changed(gpointer user_data)
 
 	g_free(cb_data);
 
+	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 	return FALSE;
 }
 
@@ -741,6 +747,7 @@ static void discovery_state_changed_cb(bt_discovery_state_t state)
 	struct bt_cb_data *cb_data = g_new0(struct bt_cb_data, 1);
 
 	cb_data->state = state;
+	g_atomic_int_inc(&scheduled_cbacks_num);
 	g_idle_add(discovery_state_changed, cb_data);
 }
 
@@ -919,6 +926,7 @@ static gboolean device_found(gpointer user_data)
 	free_properties(cb_data->num, cb_data->props);
 	g_free(cb_data);
 
+	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 	return FALSE;
 }
 
@@ -929,6 +937,7 @@ static void device_found_cb(int num_properties, bt_property_t *properties)
 	cb_data->num = num_properties;
 	cb_data->props = copy_properties(num_properties, properties);
 
+	g_atomic_int_inc(&scheduled_cbacks_num);
 	g_idle_add(device_found, cb_data);
 }
 
@@ -954,6 +963,7 @@ static gboolean adapter_properties(gpointer user_data)
 	free_properties(cb_data->num, cb_data->props);
 	g_free(cb_data);
 
+	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 	return FALSE;
 }
 
@@ -966,6 +976,7 @@ static void adapter_properties_cb(bt_status_t status, int num_properties,
 	cb_data->num = num_properties;
 	cb_data->props = copy_properties(num_properties, properties);
 
+	g_atomic_int_inc(&scheduled_cbacks_num);
 	g_idle_add(adapter_properties, cb_data);
 }
 
@@ -1017,6 +1028,7 @@ static gboolean remote_device_properties(gpointer user_data)
 	free_properties(cb_data->num, cb_data->props);
 	g_free(cb_data);
 
+	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 	return FALSE;
 }
 
@@ -1031,6 +1043,7 @@ static void remote_device_properties_cb(bt_status_t status,
 	cb_data->num = num_properties;
 	cb_data->props = copy_properties(num_properties, properties);
 
+	g_atomic_int_inc(&scheduled_cbacks_num);
 	g_idle_add(remote_device_properties, cb_data);
 }
 
@@ -2172,6 +2185,22 @@ static void setup_enabled_adapter(const void *test_data)
 		tester_setup_failed();
 }
 
+static gboolean check_callbacks_called(gpointer user_data)
+{
+	/*
+	 * Wait for all callbacks scheduled in current test context to execute
+	 * in main loop. This will avoid late callback calls after test case has
+	 * already failed or timed out.
+	 */
+
+	if (g_atomic_int_get(&scheduled_cbacks_num) == 0) {
+		tester_teardown_complete();
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
 static gboolean check_daemon_term(gpointer user_data)
 {
 	int status;
@@ -2185,7 +2214,7 @@ static gboolean check_daemon_term(gpointer user_data)
 		return TRUE;
 
 	if (WIFEXITED(status) && (WEXITSTATUS(status) == EXIT_SUCCESS)) {
-		tester_teardown_complete();
+		g_idle_add(check_callbacks_called, NULL);
 		return FALSE;
 	}
 
@@ -2825,6 +2854,7 @@ static gboolean adapter_socket_state_changed(gpointer user_data)
 
 	g_free(cb_data);
 
+	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 	return FALSE;
 }
 
@@ -2834,6 +2864,7 @@ static void adapter_socket_state_changed_cb(bt_state_t state)
 
 	cb_data->state = state;
 
+	g_atomic_int_inc(&scheduled_cbacks_num);
 	g_idle_add(adapter_socket_state_changed, cb_data);
 }
 
@@ -3256,6 +3287,8 @@ static gboolean hidhost_connection_state(gpointer user_data)
 								cb_data->state);
 
 	g_free(cb_data);
+
+	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 	return FALSE;
 }
 
@@ -3267,6 +3300,7 @@ static void hidhost_connection_state_cb(bt_bdaddr_t *bd_addr,
 	cb_data->state = state;
 	cb_data->bdaddr = *bd_addr;
 
+	g_atomic_int_inc(&scheduled_cbacks_num);
 	g_idle_add(hidhost_connection_state, cb_data);
 }
 
@@ -3283,6 +3317,8 @@ static gboolean hidhost_virual_unplug(gpointer user_data)
 							cb_data->status);
 
 	g_free(cb_data);
+
+	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 	return FALSE;
 }
 
@@ -3293,6 +3329,7 @@ static void hidhost_virual_unplug_cb(bt_bdaddr_t *bd_addr, bthh_status_t status)
 	cb_data->bdaddr = *bd_addr;
 	cb_data->status = status;
 
+	g_atomic_int_inc(&scheduled_cbacks_num);
 	g_idle_add(hidhost_virual_unplug, cb_data);
 }
 
@@ -3309,6 +3346,8 @@ static gboolean hidhost_hid_info(gpointer user_data)
 							cb_data->hid_info);
 
 	g_free(cb_data);
+
+	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 	return FALSE;
 }
 
@@ -3319,6 +3358,7 @@ static void hidhost_hid_info_cb(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid)
 	cb_data->bdaddr = *bd_addr;
 	cb_data->hid_info = hid;
 
+	g_atomic_int_inc(&scheduled_cbacks_num);
 	g_idle_add(hidhost_hid_info, cb_data);
 }
 
@@ -3335,6 +3375,8 @@ static gboolean hidhost_protocol_mode(gpointer user_data)
 						cb_data->status, cb_data->mode);
 
 	g_free(cb_data);
+
+	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 	return FALSE;
 }
 
@@ -3348,6 +3390,7 @@ static void hidhost_protocol_mode_cb(bt_bdaddr_t *bd_addr,
 	cb_data->status = status;
 	cb_data->mode = mode;
 
+	g_atomic_int_inc(&scheduled_cbacks_num);
 	g_idle_add(hidhost_protocol_mode, cb_data);
 }
 
@@ -3365,6 +3408,8 @@ static gboolean hidhost_get_report(gpointer user_data)
 
 	g_free(cb_data->report);
 	g_free(cb_data);
+
+	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 	return FALSE;
 }
 
@@ -3378,6 +3423,7 @@ static void hidhost_get_report_cb(bt_bdaddr_t *bd_addr, bthh_status_t status,
 	cb_data->report = g_memdup(report, size);
 	cb_data->size = size;
 
+	g_atomic_int_inc(&scheduled_cbacks_num);
 	g_idle_add(hidhost_get_report, cb_data);
 }
 
-- 
1.8.5.2

