Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 05/10] android/tester: Fix handling inquiry by android tester
Date: Thu, 20 Mar 2014 10:49:27 +0100
Message-ID: <1395308972-4320-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1395308972-4320-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1395308972-4320-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously btdev sent inquiry_complete in one mainloop iteration. Due to
new way of handling it we need to make sure cancel_discovery is called
if start_discovery has been used.
There is also no need to hook before inquiry_complete_event in case of
test for cancel_discovery.

Conflicts:
	android/android-tester.c
---
 android/android-tester.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index bab92a1..375f30d 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -941,10 +941,13 @@ static void discovery_device_found_cb(int num_properties,
 		}
 
 		if (!check_test_property(received_prop, expected_prop)) {
+			data->if_bluetooth->cancel_discovery();
 			tester_test_failed();
 			return;
 		}
 	}
+
+	data->if_bluetooth->cancel_discovery();
 }
 
 static void remote_getprops_device_found_cb(int num_properties,
@@ -959,6 +962,7 @@ static void remote_getprops_device_found_cb(int num_properties,
 	if (data->cb_count == 2)
 		data->cb_count--;
 
+	data->if_bluetooth->cancel_discovery();
 	data->if_bluetooth->get_remote_device_properties(&remote_addr);
 }
 
@@ -978,6 +982,7 @@ static void remote_get_property_device_found_cb(int num_properties,
 	if (data->cb_count == 2)
 		data->cb_count--;
 
+	data->if_bluetooth->cancel_discovery();
 	status = data->if_bluetooth->get_remote_device_property(&remote_addr,
 								prop.type);
 	check_expected_status(status);
@@ -999,6 +1004,7 @@ static void remote_setprop_device_found_cb(int num_properties,
 	if (data->cb_count == 3)
 		data->cb_count--;
 
+	data->if_bluetooth->cancel_discovery();
 	status = data->if_bluetooth->set_remote_device_property(&remote_addr,
 									&prop);
 	check_expected_status(status);
@@ -1020,6 +1026,7 @@ static void remote_setprop_fail_device_found_cb(int num_properties,
 	if (data->cb_count == 2)
 		data->cb_count--;
 
+	data->if_bluetooth->cancel_discovery();
 	status = data->if_bluetooth->set_remote_device_property(&remote_addr,
 									&prop);
 	check_expected_status(status);
@@ -2970,26 +2977,12 @@ static void test_discovery_stop_done(const void *test_data)
 	check_expected_status(status);
 }
 
-static bool pre_inq_compl_hook(const void *dummy, uint16_t len, void *user_data)
-{
-	struct test_data *data = tester_get_data();
-
-	/* Make sure Inquiry Command Complete is not called */
-
-	hciemu_del_hook(data->hciemu, HCIEMU_HOOK_PRE_EVT, BT_HCI_CMD_INQUIRY);
-
-	return false;
-}
-
 static void test_discovery_stop_success(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
 	init_test_conditions(data);
 
-	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_EVT, BT_HCI_CMD_INQUIRY,
-					pre_inq_compl_hook, data);
-
 	data->if_bluetooth->start_discovery();
 }
 
@@ -2999,9 +2992,6 @@ static void test_discovery_start_done(const void *test_data)
 
 	init_test_conditions(data);
 
-	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_EVT, BT_HCI_CMD_INQUIRY,
-					pre_inq_compl_hook, data);
-
 	data->if_bluetooth->start_discovery();
 }
 
-- 
1.8.4

