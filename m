Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 10/11] android/tester: Execute hh report cbacks in main loop
Date: Wed, 19 Feb 2014 14:55:01 +0100
Message-Id: <1392818102-19189-11-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1392818102-19189-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1392818102-19189-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Execute HIDHost generic get_report_cb in tester's main loop.
---
 android/android-tester.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 4789844..feddd8f 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -3319,17 +3319,34 @@ static void hidhost_protocol_mode_cb(bt_bdaddr_t *bd_addr,
 	g_idle_add(hidhost_protocol_mode, cb_data);
 }
 
-static void hidhost_get_report_cb(bt_bdaddr_t *bd_addr, bthh_status_t status,
-						uint8_t *report, int size)
+static gboolean hidhost_get_report(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct hidhost_generic_data *test = data->test_data;
+	struct hh_cb_data *cb_data = user_data;
 
 	data->cb_count++;
 
 	if (test && test->expected_hal_cb.get_report_cb)
-		test->expected_hal_cb.get_report_cb(bd_addr, status, report,
-									size);
+		test->expected_hal_cb.get_report_cb(&cb_data->bdaddr,
+			cb_data->status, cb_data->report, cb_data->size);
+
+	g_free(cb_data->report);
+	g_free(cb_data);
+	return FALSE;
+}
+
+static void hidhost_get_report_cb(bt_bdaddr_t *bd_addr, bthh_status_t status,
+						uint8_t *report, int size)
+{
+	struct hh_cb_data *cb_data = g_new0(struct hh_cb_data, 1);
+
+	cb_data->bdaddr = *bd_addr;
+	cb_data->status = status;
+	cb_data->report = g_memdup(report, size);
+	cb_data->size = size;
+
+	g_idle_add(hidhost_get_report, cb_data);
 }
 
 static bthh_callbacks_t bthh_callbacks = {
-- 
1.8.5.2

