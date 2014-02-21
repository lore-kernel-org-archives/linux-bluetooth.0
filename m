Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/13] android/tester: Execute socket cbacks in main loop
Date: Fri, 21 Feb 2014 13:57:46 +0100
Message-Id: <1392987473-19994-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1392987473-19994-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1392987473-19994-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Execute socket test's callbacks in tester's main loop.
---
 android/android-tester.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index a941e9f..c8496af 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -2778,9 +2778,11 @@ static void test_dev_setprop_disctimeout_fail(const void *test_data)
 }
 /* Test Socket HAL */
 
-static void adapter_socket_state_changed_cb(bt_state_t state)
+static gboolean adapter_socket_state_changed(gpointer user_data)
 {
-	switch (state) {
+	struct bt_cb_data *cb_data = user_data;
+
+	switch (cb_data->state) {
 	case BT_STATE_ON:
 		setup_powered_emulated_remote();
 		break;
@@ -2790,6 +2792,19 @@ static void adapter_socket_state_changed_cb(bt_state_t state)
 	default:
 		break;
 	}
+
+	g_free(cb_data);
+
+	return FALSE;
+}
+
+static void adapter_socket_state_changed_cb(bt_state_t state)
+{
+	struct bt_cb_data *cb_data = g_new0(struct bt_cb_data, 1);
+
+	cb_data->state = state;
+
+	g_idle_add(adapter_socket_state_changed, cb_data);
 }
 
 const bt_bdaddr_t bdaddr_dummy = {
-- 
1.8.5.2

