Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 02/11] android/tester: Execute discovery state cbacks in main loop
Date: Wed, 19 Feb 2014 11:25:40 +0100
Message-Id: <1392805549-28152-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1392805549-28152-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1392805549-28152-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Execute generic discovery_state_changed_cb in tester's main loop.
---
 android/android-tester.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index adde5ea..3693ec5 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -696,14 +696,27 @@ static void remote_setprop_disc_state_changed_cb(bt_discovery_state_t state)
 	}
 }
 
-static void discovery_state_changed_cb(bt_discovery_state_t state)
+static gboolean discovery_state_changed(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
+	struct generic_cb_data *cb_data = user_data;
 
-	if (test && test->expected_hal_cb.discovery_state_changed_cb) {
-		test->expected_hal_cb.discovery_state_changed_cb(state);
-	}
+	if (test && test->expected_hal_cb.discovery_state_changed_cb)
+		test->expected_hal_cb.discovery_state_changed_cb(
+								cb_data->state);
+
+	g_free(cb_data);
+
+	return FALSE;
+}
+
+static void discovery_state_changed_cb(bt_discovery_state_t state)
+{
+	struct generic_cb_data *cb_data = g_new0(struct generic_cb_data, 1);
+
+	cb_data->state = state;
+	g_idle_add(discovery_state_changed, cb_data);
 }
 
 static bt_property_t *copy_properties(int num_properties,
-- 
1.8.5.2

