Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 08/11] android/tester: Execute hh info cbacks in main loop
Date: Wed, 19 Feb 2014 11:25:46 +0100
Message-Id: <1392805549-28152-9-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1392805549-28152-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1392805549-28152-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Execute generic HIDHost hid_info_cb in tester's main loop.
---
 android/android-tester.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 664f381..77fa437 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -126,6 +126,8 @@ struct generic_cb_data {
 
 	int num;
 	bt_property_t *props;
+
+	bthh_hid_info_t hid_info;
 };
 
 static char exec_dir[PATH_MAX + 1];
@@ -3253,15 +3255,30 @@ static void hidhost_virual_unplug_cb(bt_bdaddr_t *bd_addr, bthh_status_t status)
 		test->expected_hal_cb.virtual_unplug_cb(bd_addr, status);
 }
 
-static void hidhost_hid_info_cb(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid)
+static gboolean hidhost_hid_info(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct hidhost_generic_data *test = data->test_data;
+	struct generic_cb_data *cb_data = user_data;
 
 	data->cb_count++;
 
 	if (test && test->expected_hal_cb.hid_info_cb)
-		test->expected_hal_cb.hid_info_cb(bd_addr, hid);
+		test->expected_hal_cb.hid_info_cb(&cb_data->bdaddr,
+							cb_data->hid_info);
+
+	g_free(cb_data);
+	return FALSE;
+}
+
+static void hidhost_hid_info_cb(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid)
+{
+	struct generic_cb_data *cb_data = g_new0(struct generic_cb_data, 1);
+
+	cb_data->bdaddr = *bd_addr;
+	cb_data->hid_info = hid;
+
+	g_idle_add(hidhost_hid_info, cb_data);
 }
 
 static void hidhost_protocol_mode_cb(bt_bdaddr_t *bd_addr,
-- 
1.8.5.2

