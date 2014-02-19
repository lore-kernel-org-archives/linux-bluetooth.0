Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 04/11]  android/tester: Execute adapter props cbacks in main loop
Date: Wed, 19 Feb 2014 14:54:55 +0100
Message-Id: <1392818102-19189-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1392818102-19189-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1392818102-19189-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Execute generic adapter_properties_cb in tester's main loop.
---
 android/android-tester.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index d909390..b542a1f 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -915,19 +915,32 @@ static void check_count_properties_cb(bt_status_t status, int num_properties,
 		check_expected_property(properties[i]);
 }
 
+static gboolean adapter_properties(gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	struct bt_cb_data *cb_data = user_data;
+
+	if (data->test_init_done && test->expected_hal_cb.adapter_properties_cb)
+		test->expected_hal_cb.adapter_properties_cb(cb_data->status,
+						cb_data->num, cb_data->props);
+
+	free_properties(cb_data->num, cb_data->props);
+	g_free(cb_data);
+
+	return FALSE;
+}
 
 static void adapter_properties_cb(bt_status_t status, int num_properties,
 						bt_property_t *properties)
 {
-	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
+	struct bt_cb_data *cb_data = g_new0(struct bt_cb_data, 1);
 
-	if (data->test_init_done &&
-				test->expected_hal_cb.adapter_properties_cb) {
-		test->expected_hal_cb.adapter_properties_cb(
-							status, num_properties,
-							properties);
-	}
+	cb_data->status = status;
+	cb_data->num = num_properties;
+	cb_data->props = copy_properties(num_properties, properties);
+
+	g_idle_add(adapter_properties, cb_data);
 }
 
 static void remote_test_device_properties_cb(bt_status_t status,
-- 
1.8.5.2

