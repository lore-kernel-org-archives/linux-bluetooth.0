Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 06/19] android/tester-ng: Add callback mechanism
Date: Thu,  3 Jul 2014 18:00:09 +0200
Message-Id: <1404403222-26911-7-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>

This patch adds bt_cb_data to be used for passing callback data from
asynchronous call to tester's main loop. As for now this struct contains
only state but will be extended to handle various callbacks.
---
 android/tester-bluetooth.c |  4 ++++
 android/tester-main.c      | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 android/tester-main.h      | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index 0f55d9e..d9f26a8 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -35,6 +35,10 @@ static struct step bluetooth_enable_success_steps[] = {
 		.action_result.status = BT_STATUS_SUCCESS,
 		.action = bluetooth_enable_action,
 	},
+	{
+		.callback = CB_BT_ADAPTER_STATE_CHANGED,
+		.callback_result.state = BT_STATE_ON,
+	},
 };
 static struct test_case bluetooth_enable_success_tc = {
 	.step = bluetooth_enable_success_steps,
diff --git a/android/tester-main.c b/android/tester-main.c
index f49ce82..326853a 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -417,9 +417,52 @@ static void verify_step(struct step *step, queue_destroy_func_t cleanup_cb)
 		next_step->action();
 }
 
+/*
+ * NOTICE:
+ * Its mandatory for callback to set proper step.callback value so that
+ * step verification could pass and move to next test step
+ */
+
+static void destroy_callback_step(void *data)
+{
+	struct step *step = data;
+
+	g_free(step);
+	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
+}
+
+static gboolean verify_callback(gpointer user_data)
+{
+	struct step *step = user_data;
+
+	/*
+	 * TODO: This may call action from next step before callback data
+	 * from previous step was freed.
+	 */
+	verify_step(step, destroy_callback_step);
+
+	return FALSE;
+}
+
+static void schedule_callback_call(struct step *step)
+{
+	g_atomic_int_inc(&scheduled_cbacks_num);
+	g_idle_add(verify_callback, step);
+}
+
+static void adapter_state_changed_cb(bt_state_t state)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback_result.state = state;
+	step->callback = CB_BT_ADAPTER_STATE_CHANGED;
+
+	schedule_callback_call(step);
+}
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
-	.adapter_state_changed_cb = NULL,
+	.adapter_state_changed_cb = adapter_state_changed_cb,
 	.adapter_properties_cb = NULL,
 	.remote_device_properties_cb = NULL,
 	.device_found_cb = NULL,
diff --git a/android/tester-main.h b/android/tester-main.h
index d79e4c5..6ea9603 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -47,6 +47,26 @@
 
 #define get_test_case_step_num(tc) (sizeof(tc) / sizeof(struct step))
 
+/*
+ * NOTICE:
+ * Callback enum sections should be
+ * updated while adding new HAL to tester.
+ */
+typedef enum {
+	CB_BT_ADAPTER_STATE_CHANGED = 1,
+	CB_BT_ADAPTER_PROPERTIES,
+	CB_BT_REMOTE_DEVICE_PROPERTIES,
+	CB_BT_DEVICE_FOUND,
+	CB_BT_DISCOVERY_STATE_CHANGED,
+	CB_BT_PIN_REQUEST,
+	CB_BT_SSP_REQUEST,
+	CB_BT_BOND_STATE_CHANGED,
+	CB_BT_ACL_STATE_CHANGED,
+	CB_BT_THREAD_EVT,
+	CB_BT_DUT_MODE_RECV,
+	CB_BT_LE_TEST_MODE,
+} expected_bt_callback_t;
+
 struct test_data {
 	struct mgmt *mgmt;
 	struct hw_device_t *device;
@@ -77,12 +97,24 @@ struct bt_action_data {
 };
 
 /*
+ * Callback data structure should be enhanced with data
+ * returned by callbacks. It's used for test case step
+ * matching with expected step data.
+ */
+struct bt_callback_data {
+	bt_state_t state;
+};
+
+/*
  * Step structure contains expected step data and step
  * action, which should be performed before step check.
  */
 struct step {
 	void (*action)(void);
 	struct bt_action_data action_result;
+
+	expected_bt_callback_t callback;
+	struct bt_callback_data callback_result;
 };
 
 /* Get, remove test cases API */
-- 
1.9.3

