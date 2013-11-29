Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v5 5/6] android/pan: Implement the get local role method in daemon
Date: Fri, 29 Nov 2013 16:20:44 +0200
Message-Id: <1385734845-9725-6-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1385734845-9725-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1385734845-9725-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Returns local role of the device (NONE, PANU or NAP).
---
 android/pan.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 7093e4c..9ff14f3 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -278,9 +278,15 @@ static uint8_t bt_pan_enable(struct hal_cmd_pan_enable *cmd, uint16_t len)
 
 static uint8_t bt_pan_get_role(void *cmd, uint16_t len)
 {
-	DBG("Not Implemented");
+	struct hal_rsp_pan_get_role rsp;
 
-	return HAL_STATUS_FAILED;
+	DBG("");
+
+	rsp.local_role = local_role;
+	ipc_send_rsp_full(HAL_SERVICE_ID_PAN, HAL_OP_PAN_GET_ROLE, sizeof(rsp),
+								&rsp, -1);
+
+	return HAL_STATUS_SUCCESS;
 }
 
 void bt_pan_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
-- 
1.8.3.2

