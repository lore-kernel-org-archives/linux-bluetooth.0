Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 04/15] android/tester-ng: Add callback mechanism
Date: Fri,  9 May 2014 16:42:37 +0200
Message-Id: <1399646568-20742-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1399646568-20742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1399646568-20742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>

This patch adds bt_cb_data to be used for passing callback data from
asynchronous call to tester's main loop. As for now this struct contains
only state but will be extended to handle various callbacks.
---
 android/android-tester-ng.c | 92 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/android/android-tester-ng.c b/android/android-tester-ng.c
index f97da81..a5aa611 100644
--- a/android/android-tester-ng.c
+++ b/android/android-tester-ng.c
@@ -40,6 +40,35 @@
 #include <hardware/bluetooth.h>
 
 /*
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
+	CB_BT_LE_TEST_MODE
+} expected_bt_callback_t;
+
+/*
+ * Callback data structure should be enhanced with data
+ * returned by callbacks. It's used for test case step
+ * matching with expected step data.
+ */
+struct bt_callback_data {
+	bt_state_t state;
+};
+
+/*
  * Struct of data to check within step action.
  */
 struct bt_action_data {
@@ -54,6 +83,8 @@ struct step {
 	void (*action)(void);
 	struct bt_action_data action_result;
 
+	expected_bt_callback_t callback;
+	struct bt_callback_data callback_result;
 };
 
 struct test_steps {
@@ -420,6 +451,18 @@ static bool match_data(struct step *step)
 		tester_debug("Action status don't match");
 		return false;
 	}
+
+	if (exp->callback && (exp->callback != step->callback)) {
+		tester_debug("Callback type don't match");
+		return false;
+	}
+
+	if (exp->callback_result.state && (exp->callback_result.state !=
+						step->callback_result.state)) {
+		tester_debug("Callback state don't match");
+		return false;
+	}
+
 	return true;
 }
 
@@ -477,9 +520,52 @@ static void verify_step(struct step *step, queue_destroy_func_t cleanup_cb)
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
@@ -644,6 +730,10 @@ static struct step bluetooth_enable_steps[] = {
 	.action_result.status = BT_STATUS_SUCCESS,
 	.action = bluetooth_enable_action,
 	},
+	{
+	.callback = CB_BT_ADAPTER_STATE_CHANGED,
+	.callback_result.state = BT_STATE_ON,
+	},
 };
 
 #define TEST_DATA_CREATE(step_data) \
-- 
1.9.2

