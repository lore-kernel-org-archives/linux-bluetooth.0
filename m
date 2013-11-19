Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH] android/hal-a2dp: Fix expected size of hal_ev_a2dp conn_state and audio_state
Date: Tue, 19 Nov 2013 22:59:23 +0200
Message-Id: <1384894763-3925-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-a2dp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/hal-a2dp.c b/android/hal-a2dp.c
index 7d91151..cf39ba2 100644
--- a/android/hal-a2dp.c
+++ b/android/hal-a2dp.c
@@ -54,12 +54,12 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	{	/* HAL_EV_A2DP_CONN_STATE */
 		.handler = handle_conn_state,
 		.var_len = false,
-		.data_len = sizeof(struct hal_ev_pan_conn_state),
+		.data_len = sizeof(struct hal_ev_a2dp_conn_state),
 	},
 	{	/* HAL_EV_A2DP_AUDIO_STATE */
 		.handler = handle_audio_state,
 		.var_len = false,
-		.data_len = sizeof(struct hal_ev_pan_ctrl_state),
+		.data_len = sizeof(struct hal_ev_a2dp_audio_state),
 	},
 };
 
-- 
1.8.3.2

