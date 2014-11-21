Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] android/client: Print data from energy_info_cb
Date: Fri, 21 Nov 2014 12:16:42 +0100
Message-Id: <1416568603-3666-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1416568603-3666-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416568603-3666-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-bt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index f74a56a..4648f99 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -331,7 +331,12 @@ static void le_test_mode_cb(bt_status_t status, uint16_t num_packets)
 #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 static void energy_info_cb(bt_activity_energy_info *energy_info)
 {
-	haltest_info("%s\n", __func__);
+	haltest_info("%s status=%s\n, ctrl_state=0x%02X, tx_time=0x%jx,"
+			"rx_time=0x%jx, idle_time=0x%jx, energu_used=0x%jx\n",
+			__func__, bt_status_t2str(energy_info->status),
+			energy_info->ctrl_state, energy_info->tx_time,
+			energy_info->rx_time, energy_info->idle_time,
+			energy_info->energy_used);
 }
 #endif
 
-- 
1.9.3

