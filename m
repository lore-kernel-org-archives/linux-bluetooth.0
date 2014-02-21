Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/13] android/tester: Execute adapter state changed cbacks in main loop
Date: Fri, 21 Feb 2014 13:57:45 +0100
Message-Id: <1392987473-19994-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1392987473-19994-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1392987473-19994-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Execute generic adapter_state_changed_cb in tester's main loop.
---
 android/android-tester.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 3c4bf6c..a941e9f 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -599,19 +599,33 @@ static void disable_success_cb(bt_state_t state)
 	}
 }
 
-static void adapter_state_changed_cb(bt_state_t state)
+static gboolean adapter_state_changed(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
+	struct bt_cb_data *cb_data = user_data;
 
 	if (data->test_init_done &&
 			test->expected_hal_cb.adapter_state_changed_cb) {
-		test->expected_hal_cb.adapter_state_changed_cb(state);
-		return;
+		test->expected_hal_cb.adapter_state_changed_cb(cb_data->state);
+		goto cleanup;
 	}
 
-	if (!data->test_init_done && state == BT_STATE_ON)
+	if (!data->test_init_done && cb_data->state == BT_STATE_ON)
 		setup_powered_emulated_remote();
+
+cleanup:
+	g_free(cb_data);
+	return FALSE;
+}
+
+static void adapter_state_changed_cb(bt_state_t state)
+{
+	struct bt_cb_data *cb_data = g_new0(struct bt_cb_data, 1);
+
+	cb_data->state = state;
+
+	g_idle_add(adapter_state_changed, cb_data);
 }
 
 static void discovery_start_success_cb(bt_discovery_state_t state)
-- 
1.8.5.2

