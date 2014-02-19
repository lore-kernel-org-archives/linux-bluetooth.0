Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 01/11] android/tester: Execute device found cbacks in main loop
Date: Wed, 19 Feb 2014 11:25:39 +0100
Message-Id: <1392805549-28152-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1392805549-28152-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1392805549-28152-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Execute generic device_found_cb in tester's main loop.
---
 android/android-tester.c | 61 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 9605c4d..adde5ea 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -117,6 +117,17 @@ struct test_data {
 	uint16_t intr_cid;
 };
 
+struct generic_cb_data {
+	bt_state_t state;
+	bt_status_t status;
+
+	bt_bdaddr_t bdaddr;
+	bt_bdname_t bdname;
+
+	int num;
+	bt_property_t *props;
+};
+
 static char exec_dir[PATH_MAX + 1];
 
 static void mgmt_debug(const char *str, void *user_data)
@@ -695,6 +706,31 @@ static void discovery_state_changed_cb(bt_discovery_state_t state)
 	}
 }
 
+static bt_property_t *copy_properties(int num_properties,
+						bt_property_t *properties)
+{
+	int i;
+	bt_property_t *props = g_new0(bt_property_t, num_properties);
+
+	for (i = 0; i < num_properties; i++) {
+		props[i].type = properties[i].type;
+		props[i].len = properties[i].len;
+		props[i].val = g_memdup(properties[i].val, properties[i].len);
+	}
+
+	return props;
+}
+
+static void free_properties(int num_properties, bt_property_t *properties)
+{
+	int i;
+
+	for (i = 0; i < num_properties; i++)
+		g_free(properties[i].val);
+
+	g_free(properties);
+}
+
 static void discovery_device_found_cb(int num_properties,
 						bt_property_t *properties)
 {
@@ -832,15 +868,30 @@ static void remote_setprop_fail_device_found_cb(int num_properties,
 	check_expected_status(status);
 }
 
-static void device_found_cb(int num_properties, bt_property_t *properties)
+static gboolean device_found(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
+	struct generic_cb_data *cb_data = user_data;
 
-	if (data->test_init_done && test->expected_hal_cb.device_found_cb) {
-		test->expected_hal_cb.device_found_cb(num_properties,
-								properties);
-	}
+	if (data->test_init_done && test->expected_hal_cb.device_found_cb)
+		test->expected_hal_cb.device_found_cb(cb_data->num,
+								cb_data->props);
+
+	free_properties(cb_data->num, cb_data->props);
+	g_free(cb_data);
+
+	return FALSE;
+}
+
+static void device_found_cb(int num_properties, bt_property_t *properties)
+{
+	struct generic_cb_data *cb_data = g_new0(struct generic_cb_data, 1);
+
+	cb_data->num = num_properties;
+	cb_data->props = copy_properties(num_properties, properties);
+
+	g_idle_add(device_found, cb_data);
 }
 
 static void check_count_properties_cb(bt_status_t status, int num_properties,
-- 
1.8.5.2

