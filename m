Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/15] android/tester-ng: Add disable success test case
Date: Fri,  9 May 2014 16:42:39 +0200
Message-Id: <1399646568-20742-6-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1399646568-20742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1399646568-20742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/android-tester-ng.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/android/android-tester-ng.c b/android/android-tester-ng.c
index 3b295d8..95a38f6 100644
--- a/android/android-tester-ng.c
+++ b/android/android-tester-ng.c
@@ -701,6 +701,17 @@ static void bluetooth_enable_action(void)
 	verify_step(&step, NULL);
 }
 
+static void bluetooth_disable_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step step;
+
+	memset(&step, 0, sizeof(step));
+	step.action_result.status = data->if_bluetooth->disable();
+
+	verify_step(&step, NULL);
+}
+
 static void generic_test_function(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -751,6 +762,25 @@ static struct step bluetooth_enable_success2_steps[] = {
 	},
 };
 
+static struct step bluetooth_disable_success_steps[] = {
+	{
+	.action_result.status = BT_STATUS_SUCCESS,
+	.action = bluetooth_enable_action,
+	},
+	{
+	.callback = CB_BT_ADAPTER_STATE_CHANGED,
+	.callback_result.state = BT_STATE_ON,
+	},
+	{
+	.action_result.status = BT_STATUS_SUCCESS,
+	.action = bluetooth_disable_action,
+	},
+	{
+	.callback = CB_BT_ADAPTER_STATE_CHANGED,
+	.callback_result.state = BT_STATE_OFF,
+	},
+};
+
 #define TEST_DATA_CREATE(step_data) \
 	static struct test_steps step_data##_data = { \
 		.step_num = sizeof(step_data) / sizeof(struct step), \
@@ -803,5 +833,9 @@ int main(int argc, char *argv[])
 					bluetooth_enable_success2_steps, setup,
 					generic_test_function, teardown);
 
+	test_bredrle("Bluetooth Disable - Success",
+					bluetooth_disable_success_steps, setup,
+					generic_test_function, teardown);
+
 	return tester_run();
 }
-- 
1.9.2

