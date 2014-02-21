Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/13] android/tester: Execute device properties cbacks in main loop
Date: Fri, 21 Feb 2014 13:57:43 +0100
Message-Id: <1392987473-19994-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1392987473-19994-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1392987473-19994-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Execute generic remote_device_properties_cb in tester's main loop.
---
 android/android-tester.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 0976081..35e375a 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -963,18 +963,36 @@ static void remote_setprop_device_properties_cb(bt_status_t status,
 	}
 }
 
-static void remote_device_properties_cb(bt_status_t status,
-				bt_bdaddr_t *bd_addr, int num_properties,
-				bt_property_t *properties)
+static gboolean remote_device_properties(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
+	struct bt_cb_data *cb_data = user_data;
 
 	if (data->test_init_done &&
-			test->expected_hal_cb.remote_device_properties_cb) {
-		test->expected_hal_cb.remote_device_properties_cb(status,
-					bd_addr, num_properties, properties);
-	}
+			test->expected_hal_cb.remote_device_properties_cb)
+		test->expected_hal_cb.remote_device_properties_cb(
+					cb_data->status, &cb_data->bdaddr,
+					cb_data->num, cb_data->props);
+
+	free_properties(cb_data->num, cb_data->props);
+	g_free(cb_data);
+
+	return FALSE;
+}
+
+static void remote_device_properties_cb(bt_status_t status,
+				bt_bdaddr_t *bd_addr, int num_properties,
+				bt_property_t *properties)
+{
+	struct bt_cb_data *cb_data = g_new0(struct bt_cb_data, 1);
+
+	cb_data->status = status;
+	cb_data->bdaddr = *bd_addr;
+	cb_data->num = num_properties;
+	cb_data->props = copy_properties(num_properties, properties);
+
+	g_idle_add(remote_device_properties, cb_data);
 }
 
 static bt_bdaddr_t enable_done_bdaddr_val = { {0x00} };
-- 
1.8.5.2

