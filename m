Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 20/20] android/handsfree: Add comment for AT+VGS/AT+VGM result code
Date: Sat,  8 Mar 2014 01:20:04 +0100
Message-Id: <1394238004-15691-21-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
References: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/handsfree.c b/android/handsfree.c
index 2a081ef..6b414d3 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -221,6 +221,7 @@ static void at_cmd_vgs_vgm(struct hfp_gw_result *result,
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
 				HAL_EV_HANDSFREE_VOLUME, sizeof(ev), &ev);
 
+		/* Framework is not replying with result for AT+VGS/AT+VGM */
 		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
 
 		return;
-- 
1.8.5.3

