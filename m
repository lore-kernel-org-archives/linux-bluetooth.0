Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 08/12] android/client: Fix incorrect usage of bt_state_t2str()
Date: Fri,  3 Jan 2014 21:55:24 -0400
Message-Id: <1388800528-10699-9-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixes clang error:

android/client/if-bt.c:313:54: error: implicit conversion from
enumeration type 'bt_status_t' to different enumeration type
'bt_state_t' [-Werror,-Wenum-conversion]
---
 android/client/if-bt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 10b79f1..6771df4 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -310,7 +310,7 @@ static void dut_mode_recv_cb(uint16_t opcode, uint8_t *buf, uint8_t len)
 #if PLATFORM_SDK_VERSION > 17
 static void le_test_mode_cb(bt_status_t status, uint16_t num_packets)
 {
-	haltest_info("%s %s %d\n", __func__, bt_state_t2str(status),
+	haltest_info("%s %s %d\n", __func__, bt_status_t2str(status),
 								num_packets);
 }
 #endif
-- 
1.8.3.2

