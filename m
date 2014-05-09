Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/15] android/tester-ng: Add state machine handling mechanism and simple tester
Date: Fri,  9 May 2014 16:42:36 +0200
Message-Id: <1399646568-20742-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1399646568-20742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1399646568-20742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds simple test and state machine handling for test cases.
---
 android/android-tester-ng.c | 193 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 182 insertions(+), 11 deletions(-)

diff --git a/android/android-tester-ng.c b/android/android-tester-ng.c
index 272414d..f97da81 100644
--- a/android/android-tester-ng.c
+++ b/android/android-tester-ng.c
@@ -34,10 +34,33 @@
 #include "src/shared/tester.h"
 #include "src/shared/hciemu.h"
 #include "src/shared/mgmt.h"
+#include "src/shared/queue.h"
 
 #include <hardware/hardware.h>
 #include <hardware/bluetooth.h>
 
+/*
+ * Struct of data to check within step action.
+ */
+struct bt_action_data {
+	uint8_t status;
+};
+
+/*
+ * Step structure contains expected step data and step
+ * action, which should be performed before step check.
+ */
+struct step {
+	void (*action)(void);
+	struct bt_action_data action_result;
+
+};
+
+struct test_steps {
+	struct step *step;
+	uint16_t step_num;
+};
+
 struct test_data {
 	struct mgmt *mgmt;
 	struct hw_device_t *device;
@@ -47,6 +70,7 @@ struct test_data {
 	const bt_interface_t *if_bluetooth;
 
 	const void *test_data;
+	struct queue *steps;
 
 	guint signalfd;
 	uint16_t mgmt_index;
@@ -374,6 +398,85 @@ static void test_pre_setup(const void *test_data)
 				NULL, read_index_list_callback, NULL, NULL);
 }
 
+/*
+ * Check each test case step if test case expected
+ * data is set and match it with expected result.
+ */
+static bool match_data(struct step *step)
+{
+	struct test_data *data = tester_get_data();
+	const struct step *exp;
+
+	exp = queue_peek_head(data->steps);
+
+	if (!exp) {
+		/* Can occure while test passed already */
+		tester_debug("Cannot get step to match");
+		return false;
+	}
+
+	if (exp->action_result.status && (exp->action_result.status !=
+						step->action_result.status)) {
+		tester_debug("Action status don't match");
+		return false;
+	}
+	return true;
+}
+
+/*
+ * Steps are initialized before test case run.
+ */
+static void init_test_steps(struct test_data *data)
+{
+	const struct test_steps *test_steps = data->test_data;
+	int i = 0;
+
+	for (i = 0; i < test_steps->step_num; i++)
+		queue_push_tail(data->steps, &(test_steps->step[i]));
+
+	tester_print("tester: Number of test steps=%d",
+						queue_length(data->steps));
+}
+
+/*
+ * Each test case step should be verified, if match with
+ * expected result tester should go to next test step.
+ */
+static void verify_step(struct step *step, queue_destroy_func_t cleanup_cb)
+{
+	struct test_data *data = tester_get_data();
+	const struct test_steps *test_steps = data->test_data;
+	struct step *next_step;
+
+	tester_debug("tester: STEP[%d]",
+			test_steps->step_num-queue_length(data->steps) + 1);
+
+	if (step && !match_data(step)) {
+		if (cleanup_cb)
+			cleanup_cb(step);
+
+		return;
+	}
+
+	queue_pop_head(data->steps);
+
+	if (cleanup_cb)
+		cleanup_cb(step);
+
+	if (queue_isempty(data->steps)) {
+		tester_print("tester: All steps done, passing");
+		tester_test_passed();
+
+		return;
+	}
+
+	/* goto next step action if declared in step */
+	next_step = queue_peek_head(data->steps);
+
+	if (next_step->action)
+		next_step->action();
+}
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = NULL,
@@ -446,6 +549,10 @@ static bool setup_base(struct test_data *data)
 	if (!data->if_bluetooth)
 		return false;
 
+	if (!(data->steps = queue_new()))
+		return false;
+
+
 	return true;
 }
 
@@ -473,6 +580,9 @@ static void teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
+	queue_destroy(data->steps, NULL);
+	data->steps = NULL;
+
 	if (data->if_bluetooth) {
 		data->if_bluetooth->cleanup();
 		data->if_bluetooth = NULL;
@@ -484,35 +594,92 @@ static void teardown(const void *test_data)
 		tester_teardown_complete();
 }
 
-static void test_dummy(const void *test_data)
+static void dummy_action(void)
+{
+	struct step step;
+
+	memset(&step, 0, sizeof(step));
+	step.action = dummy_action;
+
+	verify_step(&step, NULL);
+}
+
+static void bluetooth_enable_action(void)
 {
-	tester_test_passed();
+	struct test_data *data = tester_get_data();
+	struct step step;
+
+	memset(&step, 0, sizeof(step));
+	step.action_result.status = data->if_bluetooth->enable();
+
+	verify_step(&step, NULL);
+}
+
+static void generic_test_function(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct step *first_step;
+
+	init_test_steps(data);
+
+	/* first step action */
+	first_step = queue_peek_head(data->steps);
+	if (!first_step->action) {
+		tester_print("tester: No initial action declared");
+		tester_test_failed();
+		return;
+	}
+
+	first_step->action();
 }
 
+static struct step dummy_steps[] = {
+	{
+	.action = dummy_action,
+	},
+};
+
+static struct step bluetooth_enable_steps[] = {
+	{
+	.action_result.status = BT_STATUS_SUCCESS,
+	.action = bluetooth_enable_action,
+	},
+};
+
+#define TEST_DATA_CREATE(step_data) \
+	static struct test_steps step_data##_data = { \
+		.step_num = sizeof(step_data) / sizeof(struct step), \
+		.step = step_data, \
+	}
+
+#define TEST_DATA_GET(step_data) step_data##_data
+
 #define test_bredr(name, data, test_setup, test, test_teardown) \
 	do { \
+		TEST_DATA_CREATE(data); \
 		struct test_data *user; \
 		user = g_malloc0(sizeof(struct test_data)); \
 		if (!user) \
 			break; \
 		user->hciemu_type = HCIEMU_TYPE_BREDR; \
-		user->test_data = data; \
-		tester_add_full(name, data, test_pre_setup, test_setup, \
-				test, test_teardown, test_post_teardown, \
-							3, user, g_free); \
+		user->test_data = &TEST_DATA_GET(data); \
+		tester_add_full(name, &TEST_DATA_GET(data), test_pre_setup, \
+					test_setup, test, test_teardown, \
+					test_post_teardown, 3, user, g_free); \
 	} while (0)
 
 #define test_bredrle(name, data, test_setup, test, test_teardown) \
 	do { \
+		TEST_DATA_CREATE(data); \
 		struct test_data *user; \
 		user = g_malloc0(sizeof(struct test_data)); \
 		if (!user) \
 			break; \
 		user->hciemu_type = HCIEMU_TYPE_BREDRLE; \
-		user->test_data = data; \
-		tester_add_full(name, data, test_pre_setup, test_setup, \
-				test, test_teardown, test_post_teardown, \
-							3, user, g_free); \
+		user->test_data = &TEST_DATA_GET(data); \
+		tester_add_full(name, &TEST_DATA_GET(data), test_pre_setup, \
+					test_setup, test, test_teardown, \
+					test_post_teardown, 3, user, g_free); \
 	} while (0)
 
 int main(int argc, char *argv[])
@@ -521,7 +688,11 @@ int main(int argc, char *argv[])
 
 	tester_init(&argc, &argv);
 
-	test_bredrle("Bluetooth Init", NULL, setup, test_dummy, teardown);
+	test_bredr("Bluetooth Init", dummy_steps, setup, generic_test_function,
+								teardown);
+
+	test_bredrle("Bluetooth Enable", bluetooth_enable_steps, setup,
+					generic_test_function, teardown);
 
 	return tester_run();
 }
-- 
1.9.2

