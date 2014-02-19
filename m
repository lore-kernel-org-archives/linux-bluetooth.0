Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 07/11] android/tester: Execute hh connection state cbacks in main loop
Date: Wed, 19 Feb 2014 14:54:58 +0100
Message-Id: <1392818102-19189-8-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1392818102-19189-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1392818102-19189-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Execute generic HIDHost connection_state_cb in tester's main loop.
---
 android/android-tester.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 71957ec..73b25a5 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -127,6 +127,18 @@ struct bt_cb_data {
 	bt_property_t *props;
 };
 
+struct hh_cb_data {
+	bt_bdaddr_t bdaddr;
+
+	bthh_status_t status;
+	bthh_hid_info_t hid_info;
+	bthh_protocol_mode_t mode;
+	bthh_connection_state_t state;
+
+	uint8_t *report;
+	int size;
+};
+
 static char exec_dir[PATH_MAX + 1];
 
 static void mgmt_debug(const char *str, void *user_data)
@@ -3211,19 +3223,34 @@ clean:
 		close(sock_fd);
 }
 
-static void hidhost_connection_state_cb(bt_bdaddr_t *bd_addr,
-						bthh_connection_state_t state)
+static gboolean hidhost_connection_state(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct hidhost_generic_data *test = data->test_data;
+	struct hh_cb_data *cb_data = user_data;
 
 	data->cb_count++;
 
-	if (state == BTHH_CONN_STATE_CONNECTED)
+	if (cb_data->state == BTHH_CONN_STATE_CONNECTED)
 		tester_setup_complete();
 
 	if (test && test->expected_hal_cb.connection_state_cb)
-		test->expected_hal_cb.connection_state_cb(bd_addr, state);
+		test->expected_hal_cb.connection_state_cb(&cb_data->bdaddr,
+								cb_data->state);
+
+	g_free(cb_data);
+	return FALSE;
+}
+
+static void hidhost_connection_state_cb(bt_bdaddr_t *bd_addr,
+						bthh_connection_state_t state)
+{
+	struct hh_cb_data *cb_data = g_new0(struct hh_cb_data, 1);
+
+	cb_data->state = state;
+	cb_data->bdaddr = *bd_addr;
+
+	g_idle_add(hidhost_connection_state, cb_data);
 }
 
 static void hidhost_virual_unplug_cb(bt_bdaddr_t *bd_addr, bthh_status_t status)
-- 
1.8.5.2

