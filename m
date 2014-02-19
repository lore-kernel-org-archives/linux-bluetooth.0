Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 09/11] android/tester: Execute hh protocol mode cbacks in main loop
Date: Wed, 19 Feb 2014 14:55:00 +0100
Message-Id: <1392818102-19189-10-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1392818102-19189-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1392818102-19189-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Execute generic HIDHost protocol_mode_cb in tester's main loop.
---
 android/android-tester.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 116593d..4789844 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -3290,17 +3290,33 @@ static void hidhost_hid_info_cb(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid)
 	g_idle_add(hidhost_hid_info, cb_data);
 }
 
-static void hidhost_protocol_mode_cb(bt_bdaddr_t *bd_addr,
-						bthh_status_t status,
-						bthh_protocol_mode_t mode)
+static gboolean hidhost_protocol_mode(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct hidhost_generic_data *test = data->test_data;
+	struct hh_cb_data *cb_data = user_data;
 
 	data->cb_count++;
 
 	if (test && test->expected_hal_cb.protocol_mode_cb)
-		test->expected_hal_cb.protocol_mode_cb(bd_addr, status, mode);
+		test->expected_hal_cb.protocol_mode_cb(&cb_data->bdaddr,
+						cb_data->status, cb_data->mode);
+
+	g_free(cb_data);
+	return FALSE;
+}
+
+static void hidhost_protocol_mode_cb(bt_bdaddr_t *bd_addr,
+						bthh_status_t status,
+						bthh_protocol_mode_t mode)
+{
+	struct hh_cb_data *cb_data = g_new0(struct hh_cb_data, 1);
+
+	cb_data->bdaddr = *bd_addr;
+	cb_data->status = status;
+	cb_data->mode = mode;
+
+	g_idle_add(hidhost_protocol_mode, cb_data);
 }
 
 static void hidhost_get_report_cb(bt_bdaddr_t *bd_addr, bthh_status_t status,
-- 
1.8.5.2

