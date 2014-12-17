Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/3] android/handsfree: Add support for configure WBS command
Date: Wed, 17 Dec 2014 15:53:32 +0100
Message-Id: <1418828013-12385-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1418828013-12385-1-git-send-email-szymon.janc@tieto.com>
References: <1418828013-12385-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to disable/enable WBS on specific headset.
---
 android/handsfree.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index da89623..f3ea770 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -2499,17 +2499,51 @@ failed:
 static void handle_configure_wbs(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_handsfree_configure_wbs *cmd = buf;
+	struct hf_device *dev;
+	bdaddr_t bdaddr;
 	uint8_t status;
 
+	if (!(hfp_ag_features & HFP_AG_FEAT_CODEC)) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	android2bdaddr(cmd->bdaddr, &bdaddr);
+
+	dev = find_device(&bdaddr);
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	if (dev->audio_state != HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED){
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
 	switch (cmd->config) {
-	case HAL_HANDSFREE_WBS_NONE:
 	case HAL_HANDSFREE_WBS_NO:
+		dev->codecs[MSBC_OFFSET].local_supported = false;
+		break;
 	case HAL_HANDSFREE_WBS_YES:
+		dev->codecs[MSBC_OFFSET].local_supported = true;
+		break;
+	case HAL_HANDSFREE_WBS_NONE:
+		/* TODO */
 	default:
 		status = HAL_STATUS_FAILED;
 		break;
 	}
 
+	/*
+	 * cleanup negotiated codec if WBS support was changed, it will be
+	 * renegotiated on next audio connection based on currently supported
+	 * codecs
+	 */
+	dev->negotiated_codec = 0;
+	status = HAL_STATUS_SUCCESS;
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
 					HAL_OP_HANDSFREE_CONFIGURE_WBS, status);
 }
-- 
1.9.1

