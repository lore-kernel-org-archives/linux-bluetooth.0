Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <andrei.emeltchenko@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: Fix compilation error for Android 4.2.2
Date: Tue, 22 Oct 2013 13:10:00 +0300
Message-Id: <1382436600-8598-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-bt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 5447e0c..330a3fa 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -364,11 +364,13 @@ static void dut_mode_recv_cb(uint16_t opcode, uint8_t *buf, uint8_t len)
 	haltest_info("%s\n", __func__);
 }
 
+#if PLATFORM_SDK_VERSION > 17
 static void le_test_mode_cb(bt_status_t status, uint16_t num_packets)
 {
 	haltest_info("%s %s %d\n", __func__, bt_state_t2str(status),
 								num_packets);
 }
+#endif
 
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
-- 
1.8.1.2

