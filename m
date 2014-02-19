Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 05/11] android/tester: Execute adapter state changed cbacks in main loop
Date: Wed, 19 Feb 2014 11:25:43 +0100
Message-Id: <1392805549-28152-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1392805549-28152-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1392805549-28152-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Execute generic adapter_state_changed_cb in tester's main loop.
---
 android/android-tester.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 334e7f3..50de998 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -600,19 +600,33 @@ static void disable_success_cb(bt_state_t state)
 	}
 }
 
-static void adapter_state_changed_cb(bt_state_t state)
+static gboolean adapter_state_changed(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
+	struct generic_cb_data *cb_data = user_data;
 
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
+	struct generic_cb_data *cb_data = g_new0(struct generic_cb_data, 1);
+
+	cb_data->state = state;
+
+	g_idle_add(adapter_state_changed, cb_data);
 }
 
 static void discovery_start_success_cb(bt_discovery_state_t state)
-- 
1.8.5.2

