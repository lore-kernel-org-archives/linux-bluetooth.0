Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 11/11] android/tester: Execute hh virtual unplug cbacks in main loop
Date: Wed, 19 Feb 2014 14:55:02 +0100
Message-Id: <1392818102-19189-12-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1392818102-19189-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1392818102-19189-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Execute generic HIDHost virtual_unplug_cb in tester's main loop.
---
 android/android-tester.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index feddd8f..0cd130d 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -3253,15 +3253,30 @@ static void hidhost_connection_state_cb(bt_bdaddr_t *bd_addr,
 	g_idle_add(hidhost_connection_state, cb_data);
 }
 
-static void hidhost_virual_unplug_cb(bt_bdaddr_t *bd_addr, bthh_status_t status)
+static gboolean hidhost_virual_unplug(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct hidhost_generic_data *test = data->test_data;
+	struct hh_cb_data *cb_data = user_data;
 
 	data->cb_count++;
 
 	if (test && test->expected_hal_cb.virtual_unplug_cb)
-		test->expected_hal_cb.virtual_unplug_cb(bd_addr, status);
+		test->expected_hal_cb.virtual_unplug_cb(&cb_data->bdaddr,
+							cb_data->status);
+
+	g_free(cb_data);
+	return FALSE;
+}
+
+static void hidhost_virual_unplug_cb(bt_bdaddr_t *bd_addr, bthh_status_t status)
+{
+	struct hh_cb_data *cb_data = g_new0(struct hh_cb_data, 1);
+
+	cb_data->bdaddr = *bd_addr;
+	cb_data->status = status;
+
+	g_idle_add(hidhost_virual_unplug, cb_data);
 }
 
 static gboolean hidhost_hid_info(gpointer user_data)
-- 
1.8.5.2

