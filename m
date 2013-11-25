Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 4/4] android/pan: Implement the get local role method in daemon
Date: Mon, 25 Nov 2013 15:49:29 +0200
Message-Id: <1385387369-3015-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1385387369-3015-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1385387369-3015-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Returns local role of the device (NONE, PANU or NAP).
---
 android/pan.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 74c27c0..b443b3e 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -364,11 +364,17 @@ static uint8_t bt_pan_enable(struct hal_cmd_pan_enable *cmd, uint16_t len)
 	return HAL_STATUS_FAILED;
 }
 
-static uint8_t bt_pan_get_role(void *cmd, uint16_t len)
+static uint8_t bt_pan_get_role(int sk, void *cmd, uint16_t len)
 {
-	DBG("Not Implemented");
+	struct hal_rsp_pan_get_role rsp;
 
-	return HAL_STATUS_FAILED;
+	DBG("");
+
+	rsp.local_role = local_role;
+	ipc_send(sk, HAL_SERVICE_ID_PAN, HAL_OP_PAN_GET_ROLE, sizeof(rsp),
+								&rsp, -1);
+
+	return HAL_STATUS_SUCCESS;
 }
 
 void bt_pan_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
@@ -380,7 +386,7 @@ void bt_pan_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 		status = bt_pan_enable(buf, len);
 		break;
 	case HAL_OP_PAN_GET_ROLE:
-		status = bt_pan_get_role(buf, len);
+		status = bt_pan_get_role(sk, buf, len);
 		break;
 	case HAL_OP_PAN_CONNECT:
 		status = bt_pan_connect(buf, len);
-- 
1.8.3.2

