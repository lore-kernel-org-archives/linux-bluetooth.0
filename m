Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/19] android/tester-bluetooth: Add initial test case
Date: Thu,  3 Jul 2014 18:00:07 +0200
Message-Id: <1404403222-26911-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This also adds handle of test steps in android tester framework like:
initializing, matching, verifyng and generic test action which
performes first step action.
---
 android/tester-bluetooth.c |  14 ++++++
 android/tester-main.c      | 117 ++++++++++++++++++++++++++++++++++++++++++++-
 android/tester-main.h      |   3 ++
 3 files changed, 132 insertions(+), 2 deletions(-)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index 9acf999..c912d7d 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -19,10 +19,24 @@
 
 static struct queue *list; /* List of bluetooth test cases */
 
+static struct step dummy_steps[] = {
+	{
+		.action = dummy_action,
+	},
+};
+static struct test_case bluetooth_init = {
+	.step = dummy_steps,
+	.title = "Bluetooth Init",
+	.step_num = get_test_case_step_num(dummy_steps),
+};
+
 struct queue *get_bluetooth_tests(void)
 {
 	list = queue_new();
 
+	if (!queue_push_tail(list, &bluetooth_init))
+		return NULL;
+
 	return list;
 }
 
diff --git a/android/tester-main.c b/android/tester-main.c
index 8f52286..51326f5 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -338,6 +338,85 @@ static void test_pre_setup(const void *test_data)
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
+static void init_test_steps(struct test_data *data)
+{
+	const struct test_case *test_steps = data->test_data;
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
+	const struct test_case *test_steps = data->test_data;
+	struct step *next_step;
+
+	tester_debug("tester: STEP[%d] check",
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
+	tester_debug("tester: STEP[%d] pass",
+			test_steps->step_num-queue_length(data->steps));
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
@@ -455,6 +534,33 @@ static void teardown(const void *test_data)
 		tester_teardown_complete();
 }
 
+void dummy_action(void)
+{
+	struct step step;
+
+	memset(&step, 0, sizeof(step));
+	step.action = dummy_action;
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
+	first_step->action();
+}
+
 #define test_bredr(data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -483,6 +589,14 @@ static void teardown(const void *test_data)
 
 static void tester_testcases_cleanup(void)
 {
+	remove_bluetooth_tests();
+}
+
+static void add_bluetooth_tests(void *data, void *user_data)
+{
+	struct test_case *tc = data;
+
+	test_bredrle(tc, setup, generic_test_function, teardown);
 }
 
 int main(int argc, char *argv[])
@@ -491,8 +605,7 @@ int main(int argc, char *argv[])
 
 	tester_init(&argc, &argv);
 
-	tester_add_full("Init", NULL, test_pre_setup, setup, NULL, teardown,
-					test_post_teardown, 0, NULL, NULL);
+	queue_foreach(get_bluetooth_tests(), add_bluetooth_tests, NULL);
 
 	if (tester_run())
 		return 1;
diff --git a/android/tester-main.h b/android/tester-main.h
index 8f10e9f..a4f2ed8 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -88,3 +88,6 @@ struct step {
 /* Get, remove test cases API */
 struct queue *get_bluetooth_tests(void);
 void remove_bluetooth_tests(void);
+
+/* Actions */
+void dummy_action(void);
-- 
1.9.3

