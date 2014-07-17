Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 6/9] android/tester-ng: Add cancel discovery cases
Date: Thu, 17 Jul 2014 10:29:53 +0200
Message-Id: <1405585796-12301-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405585796-12301-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405585796-12301-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-bluetooth.c | 21 +++++++++++++++++++++
 android/tester-main.c      | 11 +++++++++++
 android/tester-main.h      |  1 +
 3 files changed, 33 insertions(+)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index ea59a57..fd5837d 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -344,6 +344,27 @@ static struct test_case test_cases[] = {
 							BT_DISCOVERY_STARTED),
 		ACTION_SUCCESS(bt_start_discovery_action, NULL),
 	),
+	TEST_CASE("Bluetooth BR/EDR Discovery Stop - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+	),
+	TEST_CASE("Bluetooth BR/EDR Discovery Stop - Done",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STOPPED),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+	),
 };
 
 struct queue *get_bluetooth_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index eb588d1..7e2cc09 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -953,6 +953,17 @@ void bt_start_discovery_action(void)
 	verify_step(&step, NULL);
 }
 
+void bt_cancel_discovery_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step step;
+
+	memset(&step, 0, sizeof(step));
+	step.action_result.status = data->if_bluetooth->cancel_discovery();
+
+	verify_step(&step, NULL);
+}
+
 static void generic_test_function(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
diff --git a/android/tester-main.h b/android/tester-main.h
index 9e40907..1e1dd51 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -218,3 +218,4 @@ void bluetooth_disable_action(void);
 void bt_set_property_action(void);
 void bt_get_property_action(void);
 void bt_start_discovery_action(void);
+void bt_cancel_discovery_action(void);
-- 
1.9.1

