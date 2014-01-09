Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] android/tester: Add test case state handling
Date: Thu,  9 Jan 2014 12:01:34 +0100
Message-Id: <1389265295-3344-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1389265295-3344-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1389265295-3344-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch make test state handling more stable by avoiding errors like
i.e. double free of memory in teardown phase. Double state set is
undesirable for test case and may cause errors. Now after every
condition change, test state is checked if it can set test state to pass.
In some places of test fail, returns are added to avoid furhter code
execution.
---
 android/android-tester.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index a63d836..a29c982 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -147,10 +147,10 @@ static void check_cb_count(void)
 	if (!data->test_init_done)
 		return;
 
-	if (data->cb_count == 0)
+	if (data->cb_count == 0) {
 		data->cb_count_checked = true;
-
-	test_update_state();
+		test_update_state();
+	}
 }
 
 static void expected_cb_count_init(struct test_data *data)
@@ -205,12 +205,11 @@ static void check_expected_status(uint8_t status)
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test_data = data->test_data;
 
-	if (test_data->expected_adapter_status == status)
+	if (test_data->expected_adapter_status == status) {
 		data->status_checked = true;
-	else
+		test_update_state();
+	} else
 		tester_test_failed();
-
-	test_update_state();
 }
 
 static bool check_test_property(bt_property_t received_prop,
@@ -467,6 +466,7 @@ static void enable_success_cb(bt_state_t state)
 	if (state == BT_STATE_ON) {
 		setup_powered_emulated_remote();
 		data->cb_count--;
+		check_cb_count();
 	}
 }
 
@@ -474,8 +474,10 @@ static void disable_success_cb(bt_state_t state)
 {
 	struct test_data *data = tester_get_data();
 
-	if (state == BT_STATE_OFF)
+	if (state == BT_STATE_OFF) {
 		data->cb_count--;
+		check_cb_count();
+	}
 }
 
 static void adapter_state_changed_cb(bt_state_t state)
@@ -486,7 +488,6 @@ static void adapter_state_changed_cb(bt_state_t state)
 	if (data->test_init_done &&
 			test->expected_hal_cb.adapter_state_changed_cb) {
 		test->expected_hal_cb.adapter_state_changed_cb(state);
-		check_cb_count();
 		return;
 	}
 
@@ -498,8 +499,10 @@ static void discovery_start_success_cb(bt_discovery_state_t state)
 {
 	struct test_data *data = tester_get_data();
 
-	if (state == BT_DISCOVERY_STARTED)
+	if (state == BT_DISCOVERY_STARTED) {
 		data->cb_count--;
+		check_cb_count();
+	}
 }
 
 static void discovery_start_done_cb(bt_discovery_state_t state)
@@ -509,6 +512,8 @@ static void discovery_start_done_cb(bt_discovery_state_t state)
 
 	status = data->if_bluetooth->start_discovery();
 	data->cb_count--;
+
+	check_cb_count();
 	check_expected_status(status);
 }
 
@@ -523,8 +528,10 @@ static void discovery_stop_success_cb(bt_discovery_state_t state)
 		data->cb_count--;
 		return;
 	}
-	if (state == BT_DISCOVERY_STOPPED && data->cb_count == 1)
+	if (state == BT_DISCOVERY_STOPPED && data->cb_count == 1) {
 		data->cb_count--;
+		check_cb_count();
+	}
 }
 
 static void discovery_device_found_state_changed_cb(bt_discovery_state_t state)
@@ -535,8 +542,10 @@ static void discovery_device_found_state_changed_cb(bt_discovery_state_t state)
 		data->cb_count--;
 		return;
 	}
-	if (state == BT_DISCOVERY_STOPPED && data->cb_count == 1)
+	if (state == BT_DISCOVERY_STOPPED && data->cb_count == 1) {
 		data->cb_count--;
+		check_cb_count();
+	}
 }
 
 static void discovery_state_changed_cb(bt_discovery_state_t state)
@@ -546,7 +555,6 @@ static void discovery_state_changed_cb(bt_discovery_state_t state)
 
 	if (test && test->expected_hal_cb.discovery_state_changed_cb) {
 		test->expected_hal_cb.discovery_state_changed_cb(state);
-		check_cb_count();
 	}
 }
 
@@ -564,9 +572,12 @@ static void discovery_device_found_cb(int num_properties,
 	bt_property_t received_prop;
 
 	data->cb_count--;
+	check_cb_count();
 
-	if (num_properties < 1)
+	if (num_properties < 1) {
 		tester_test_failed();
+		return;
+	}
 
 	bdaddr2android((const bdaddr_t *) remote_bdaddr, &emu_remote_bdaddr);
 
@@ -599,8 +610,10 @@ static void discovery_device_found_cb(int num_properties,
 			break;
 		}
 
-		if (!check_test_property(received_prop, expected_prop))
+		if (!check_test_property(received_prop, expected_prop)) {
 			tester_test_failed();
+			return;
+		}
 	}
 }
 
-- 
1.8.5.2

