Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 6/6] android/client: Add energy_info_callback print
Date: Tue,  4 Nov 2014 14:24:50 +0200
Message-Id: <1415103890-24375-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415103890-24375-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415103890-24375-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-bt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index a25d7bc..3fd04a3 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -328,6 +328,11 @@ static void le_test_mode_cb(bt_status_t status, uint16_t num_packets)
 								num_packets);
 }
 
+static void energy_info_cb(bt_activity_energy_info *energy_info)
+{
+	haltest_info("%s\n", __func__);
+}
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -341,7 +346,8 @@ static bt_callbacks_t bt_callbacks = {
 	.acl_state_changed_cb = acl_state_changed_cb,
 	.thread_evt_cb = thread_evt_cb,
 	.dut_mode_recv_cb = dut_mode_recv_cb,
-	.le_test_mode_cb = le_test_mode_cb
+	.le_test_mode_cb = le_test_mode_cb,
+	.energy_info_cb = energy_info_cb,
 };
 
 static void init_p(int argc, const char **argv)
-- 
1.9.1

