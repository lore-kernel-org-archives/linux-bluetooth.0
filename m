Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/2] android/tester: Simplify setup procedure
Date: Fri,  5 Sep 2014 13:12:16 +0200
Message-Id: <1409915537-22927-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Every profile test case must initialize bluetooth profile and start
bluetoothd, and it is now done in setup_generic(). Additionally
each profile can define its own init routine, which will be
called after initializing stack.
---
 android/tester-main.c | 185 ++++++++++++--------------------------------------
 android/tester-main.h |   1 +
 2 files changed, 45 insertions(+), 141 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 256d5c4..5d459b0 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1332,7 +1332,7 @@ static bool setup_base(struct test_data *data)
 	return true;
 }
 
-static void setup(const void *test_data)
+static void setup_generic(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	bt_status_t status;
@@ -1349,220 +1349,122 @@ static void setup(const void *test_data)
 		return;
 	}
 
-	tester_setup_complete();
+	if (!data->init_routine || data->init_routine() == BT_STATUS_SUCCESS)
+		tester_setup_complete();
+	else
+		tester_setup_failed();
 }
 
-static void setup_socket(const void *test_data)
+static int init_socket(void)
 {
 	struct test_data *data = tester_get_data();
-	bt_status_t status;
 	const void *sock;
 
-	if (!setup_base(data)) {
-		tester_setup_failed();
-		return;
-	}
-
-	status = data->if_bluetooth->init(&bt_callbacks);
-	if (status != BT_STATUS_SUCCESS) {
-		data->if_bluetooth = NULL;
-		tester_setup_failed();
-		return;
-	}
-
 	sock = data->if_bluetooth->get_profile_interface(BT_PROFILE_SOCKETS_ID);
-	if (!sock) {
-		tester_setup_failed();
-		return;
-	}
+	if (!sock)
+		return BT_STATUS_FAIL;
 
 	data->if_sock = sock;
 
-	tester_setup_complete();
+	return BT_STATUS_SUCCESS;
 }
 
-static void setup_hidhost(const void *test_data)
+static int init_hidhost(void)
 {
 	struct test_data *data = tester_get_data();
 	bt_status_t status;
 	const void *hid;
 
-	if (!setup_base(data)) {
-		tester_setup_failed();
-		return;
-	}
-
-	status = data->if_bluetooth->init(&bt_callbacks);
-	if (status != BT_STATUS_SUCCESS) {
-		data->if_bluetooth = NULL;
-		tester_setup_failed();
-		return;
-	}
-
 	hid = data->if_bluetooth->get_profile_interface(BT_PROFILE_HIDHOST_ID);
-	if (!hid) {
-		tester_setup_failed();
-		return;
-	}
+	if (!hid)
+		return BT_STATUS_FAIL;
 
 	data->if_hid = hid;
 
 	status = data->if_hid->init(&bthh_callbacks);
-	if (status != BT_STATUS_SUCCESS) {
+	if (status != BT_STATUS_SUCCESS)
 		data->if_hid = NULL;
-		tester_setup_failed();
-		return;
-	}
 
-	tester_setup_complete();
+	return status;
 }
 
-static void setup_pan(const void *test_data)
+static int init_pan(void)
 {
 	struct test_data *data = tester_get_data();
 	bt_status_t status;
 	const void *pan;
 
-	if (!setup_base(data)) {
-		tester_setup_failed();
-		return;
-	}
-
-	status = data->if_bluetooth->init(&bt_callbacks);
-	if (status != BT_STATUS_SUCCESS) {
-		data->if_bluetooth = NULL;
-		tester_setup_failed();
-		return;
-	}
-
 	pan = data->if_bluetooth->get_profile_interface(BT_PROFILE_PAN_ID);
-	if (!pan) {
-		tester_setup_failed();
-		return;
-	}
+	if (!pan)
+		return BT_STATUS_FAIL;
 
 	data->if_pan = pan;
 
 	status = data->if_pan->init(&btpan_callbacks);
-	if (status != BT_STATUS_SUCCESS) {
+	if (status != BT_STATUS_SUCCESS)
 		data->if_pan = NULL;
-		tester_setup_failed();
-		return;
-	}
 
-	tester_setup_complete();
+	return status;
 }
 
-static void setup_hdp(const void *test_data)
+static int init_hdp(void)
 {
 	struct test_data *data = tester_get_data();
 	bt_status_t status;
 	const void *hdp;
 
-	if (!setup_base(data)) {
-		tester_setup_failed();
-		return;
-	}
-
-	status = data->if_bluetooth->init(&bt_callbacks);
-	if (status != BT_STATUS_SUCCESS) {
-		data->if_bluetooth = NULL;
-		tester_setup_failed();
-		return;
-	}
-
 	hdp = data->if_bluetooth->get_profile_interface(BT_PROFILE_HEALTH_ID);
-	if (!hdp) {
-		tester_setup_failed();
-		return;
-	}
+	if (!hdp)
+		return BT_STATUS_FAIL;
 
 	data->if_hdp = hdp;
 
 	status = data->if_hdp->init(&bthl_callbacks);
-	if (status != BT_STATUS_SUCCESS) {
+	if (status != BT_STATUS_SUCCESS)
 		data->if_hdp = NULL;
-		tester_setup_failed();
-		return;
-	}
 
-	tester_setup_complete();
+	return status;
 }
 
-static void setup_a2dp(const void *test_data)
+static int init_a2dp(void)
 {
 	struct test_data *data = tester_get_data();
 	const bt_interface_t *if_bt;
 	bt_status_t status;
 	const void *a2dp;
 
-	if (!setup_base(data)) {
-		tester_setup_failed();
-		return;
-	}
-
 	if_bt = data->if_bluetooth;
 
-	status = if_bt->init(&bt_callbacks);
-	if (status != BT_STATUS_SUCCESS) {
-		data->if_bluetooth = NULL;
-		tester_setup_failed();
-		return;
-	}
-
 	a2dp = if_bt->get_profile_interface(BT_PROFILE_ADVANCED_AUDIO_ID);
-	if (!a2dp) {
-		tester_setup_failed();
-		return;
-	}
+	if (!a2dp)
+		return BT_STATUS_FAIL;
 
 	data->if_a2dp = a2dp;
 
 	status = data->if_a2dp->init(&bta2dp_callbacks);
-	if (status != BT_STATUS_SUCCESS) {
+	if (status != BT_STATUS_SUCCESS)
 		data->if_a2dp = NULL;
-		tester_setup_failed();
-		return;
-	}
 
-	tester_setup_complete();
+	return status;
 }
 
-static void setup_gatt(const void *test_data)
+static int init_gatt(void)
 {
 	struct test_data *data = tester_get_data();
 	bt_status_t status;
 	const void *gatt;
 
-	if (!setup_base(data)) {
-		tester_setup_failed();
-		return;
-	}
-
-	status = data->if_bluetooth->init(&bt_callbacks);
-	if (status != BT_STATUS_SUCCESS) {
-		data->if_bluetooth = NULL;
-		tester_setup_failed();
-		return;
-	}
-
 	gatt = data->if_bluetooth->get_profile_interface(BT_PROFILE_GATT_ID);
-	if (!gatt) {
-		tester_setup_failed();
-		return;
-	}
+	if (!gatt)
+		return BT_STATUS_FAIL;
 
 	data->if_gatt = gatt;
 
 	status = data->if_gatt->init(&btgatt_callbacks);
-	if (status != BT_STATUS_SUCCESS) {
+	if (status != BT_STATUS_SUCCESS)
 		data->if_gatt = NULL;
 
-		tester_setup_failed();
-		return;
-	}
-
-	tester_setup_complete();
+	return status;
 }
 
 static void teardown(const void *test_data)
@@ -2111,7 +2013,7 @@ static void generic_test_function(const void *test_data)
 	first_step->action();
 }
 
-#define test(data, test_setup, test, test_teardown) \
+#define test(data, init, test, test_teardown) \
 	do { \
 		struct test_data *user; \
 		user = g_malloc0(sizeof(struct test_data)); \
@@ -2119,8 +2021,9 @@ static void generic_test_function(const void *test_data)
 			break; \
 		user->hciemu_type = data->emu_type; \
 		user->test_data = data; \
+		user->init_routine = init; \
 		tester_add_full(data->title, data, test_pre_setup, \
-					test_setup, test, test_teardown, \
+					setup_generic, test, test_teardown, \
 					test_post_teardown, 3, user, g_free); \
 	} while (0)
 
@@ -2139,49 +2042,49 @@ static void add_bluetooth_tests(void *data, void *user_data)
 {
 	struct test_case *tc = data;
 
-	test(tc, setup, generic_test_function, teardown);
+	test(tc, NULL, generic_test_function, teardown);
 }
 
 static void add_socket_tests(void *data, void *user_data)
 {
 	struct test_case *tc = data;
 
-	test(tc, setup_socket, generic_test_function, teardown);
+	test(tc, init_socket, generic_test_function, teardown);
 }
 
 static void add_hidhost_tests(void *data, void *user_data)
 {
 	struct test_case *tc = data;
 
-	test(tc, setup_hidhost, generic_test_function, teardown);
+	test(tc, init_hidhost, generic_test_function, teardown);
 }
 
 static void add_pan_tests(void *data, void *user_data)
 {
 	struct test_case *tc = data;
 
-	test(tc, setup_pan, generic_test_function, teardown);
+	test(tc, init_pan, generic_test_function, teardown);
 }
 
 static void add_hdp_tests(void *data, void *user_data)
 {
 	struct test_case *tc = data;
 
-	test(tc, setup_hdp, generic_test_function, teardown);
+	test(tc, init_hdp, generic_test_function, teardown);
 }
 
 static void add_a2dp_tests(void *data, void *user_data)
 {
 	struct test_case *tc = data;
 
-	test(tc, setup_a2dp, generic_test_function, teardown);
+	test(tc, init_a2dp, generic_test_function, teardown);
 }
 
 static void add_gatt_tests(void *data, void *user_data)
 {
 	struct test_case *tc = data;
 
-	test(tc, setup_gatt, generic_test_function, teardown);
+	test(tc, init_gatt, generic_test_function, teardown);
 }
 
 int main(int argc, char *argv[])
diff --git a/android/tester-main.h b/android/tester-main.h
index 46aacce..92cbd13 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -313,6 +313,7 @@ struct test_data {
 	struct hw_device_t *device;
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
+	int (*init_routine)(void);
 
 	const bt_interface_t *if_bluetooth;
 	const btsock_interface_t *if_sock;
-- 
1.9.3

