Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4] android/tester: Setup bluetooth module in separate thread
Date: Fri, 26 Sep 2014 11:24:59 +0200
Message-Id: <1411723499-15190-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In some cases, bluetooth->init blocks mainloop and bluetoothd
cannot properly initialize controller, because HCI frames are
not serviced in hciemu.
Because pthread_join() is blocking, it is added to mainloop
from thread right before pthread_exit() is called. Therefore
this time is extremely short.
---
 android/tester-main.c | 289 ++++++++++++++++++++++----------------------------
 1 file changed, 129 insertions(+), 160 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index b65029a..bf6e55b 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -15,8 +15,10 @@
  *
  */
 #include <stdbool.h>
+#include <pthread.h>
 
 #include "emulator/bthost.h"
+#include "src/shared/util.h"
 #include "tester-main.h"
 
 #include "monitor/bt.h"
@@ -28,6 +30,8 @@ static gint scheduled_cbacks_num;
 #define EMULATOR_SIGNAL_TIMEOUT 2 /* in seconds */
 #define EMULATOR_SIGNAL "emulator_started"
 
+static pthread_t thread;
+
 static gboolean check_callbacks_called(gpointer user_data)
 {
 	/*
@@ -1474,242 +1478,216 @@ static bool setup_base(struct test_data *data)
 	return true;
 }
 
-static void setup(const void *test_data)
+static gboolean join_init_thread(gpointer user_data)
 {
-	struct test_data *data = tester_get_data();
-	bt_status_t status;
+	int (*init_func)(void) = user_data;
+	int status;
+	void *ret;
 
-	if (!setup_base(data)) {
+	/*
+	 * Note that pthread_join is blocking mainloop,
+	 * therefore thread we want to join must
+	 * exit immediately. This is done in init_thread()
+	 */
+	status = pthread_join(thread, &ret);
+	if (status != 0) {
+		tester_warn("Failed to join init thread, status %d", status);
 		tester_setup_failed();
-		return;
+		return FALSE;
 	}
 
-	status = data->if_bluetooth->init(&bt_callbacks);
-	if (status != BT_STATUS_SUCCESS) {
-		data->if_bluetooth = NULL;
+	if (PTR_TO_INT(ret) != BT_STATUS_SUCCESS) {
 		tester_setup_failed();
-		return;
+		return FALSE;
 	}
 
-	tester_setup_complete();
+	if (!init_func || init_func() == BT_STATUS_SUCCESS)
+		tester_setup_complete();
+	else
+		tester_setup_failed();
+
+	return FALSE;
 }
 
-static void setup_socket(const void *test_data)
+static void *init_thread(void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	int status;
+
+	status = data->if_bluetooth->init(&bt_callbacks);
+
+	g_idle_add(join_init_thread, user_data);
+
+	pthread_exit(INT_TO_PTR(status));
+}
+
+static bool start_init_thread(int (*init)(void))
+{
+	if (pthread_create(&thread, NULL, init_thread, init) != 0)
+		return false;
+
+	return true;
+}
+
+static void setup_generic(int (*init)(void))
 {
 	struct test_data *data = tester_get_data();
-	bt_status_t status;
-	const void *sock;
 
 	if (!setup_base(data)) {
 		tester_setup_failed();
 		return;
 	}
 
-	status = data->if_bluetooth->init(&bt_callbacks);
-	if (status != BT_STATUS_SUCCESS) {
-		data->if_bluetooth = NULL;
+	if (!start_init_thread(init))
 		tester_setup_failed();
-		return;
-	}
+}
+
+static void setup(const void *test_data)
+{
+	setup_generic(NULL);
+}
+
+static int init_socket(void)
+{
+	struct test_data *data = tester_get_data();
+	const void *sock;
 
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
+static void setup_socket(const void *test_data)
+{
+	setup_generic(init_socket);
+}
+
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
+static void setup_hidhost(const void *test_data)
+{
+	setup_generic(init_hidhost);
+}
+
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
+static void setup_pan(const void *test_data)
+{
+	setup_generic(init_pan);
+}
+
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
+static void setup_hdp(const void *test_data)
+{
+	setup_generic(init_hdp);
+}
+
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
 
-static void setup_avrcp(const void *test_data)
+static void setup_a2dp(const void *test_data)
+{
+	setup_generic(init_a2dp);
+}
+
+static int init_avrcp(void)
 {
 	struct test_data *data = tester_get_data();
-	const bt_interface_t *if_bt;
+	const bt_interface_t *if_bt = data->if_bluetooth;
 	bt_status_t status;
 	const void *a2dp, *avrcp;
 
-	if (!setup_base(data)) {
-		tester_setup_failed();
-		return;
-	}
-
-	if_bt = data->if_bluetooth;
-
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
 	if (status != BT_STATUS_SUCCESS) {
 		data->if_a2dp = NULL;
-		tester_setup_failed();
-		return;
+		return status;
 	}
 
 	avrcp = if_bt->get_profile_interface(BT_PROFILE_AV_RC_ID);
 	if (!avrcp) {
-		tester_setup_failed();
-		return;
+		data->if_a2dp = NULL;
+		return BT_STATUS_FAIL;
 	}
 
 	data->if_avrcp = avrcp;
@@ -1717,48 +1695,39 @@ static void setup_avrcp(const void *test_data)
 	status = data->if_avrcp->init(&btavrcp_callbacks);
 	if (status != BT_STATUS_SUCCESS) {
 		data->if_avrcp = NULL;
-		tester_setup_failed();
-		return;
+		data->if_a2dp = NULL;
 	}
 
-	tester_setup_complete();
+	return status;
 }
 
-static void setup_gatt(const void *test_data)
+static void setup_avrcp(const void *test_data)
+{
+	setup_generic(init_avrcp);
+}
+
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
+	return status;
+}
 
-	tester_setup_complete();
+static void setup_gatt(const void *test_data)
+{
+	setup_generic(init_gatt);
 }
 
 static void teardown(const void *test_data)
-- 
1.9.3

