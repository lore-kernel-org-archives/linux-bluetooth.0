Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 3/4] android/pan: Implement PAN enable HAL api at daemon side
Date: Mon,  6 Jan 2014 23:26:31 +0200
Message-Id: <1389043592-5616-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1389043592-5616-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1389043592-5616-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pan.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 87753a0..499702f 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -588,18 +588,38 @@ static void bt_pan_enable(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_pan_enable *cmd = buf;
 	uint8_t status;
+	int err;
+
+	DBG("");
+
+	if (local_role == cmd->local_role) {
+		status = HAL_STATUS_SUCCESS;
+		goto reply;
+	}
+
+	/* destroy existing server */
+	destroy_nap_device();
 
 	switch (cmd->local_role) {
 	case HAL_PAN_ROLE_PANU:
-	case HAL_PAN_ROLE_NAP:
-		DBG("Not Implemented");
-		status  = HAL_STATUS_FAILED;
-		break;
-	default:
 		status = HAL_STATUS_UNSUPPORTED;
-		break;
+		goto reply;
+	case HAL_PAN_ROLE_NONE:
+		status = HAL_STATUS_SUCCESS;
+		goto reply;
+	}
+
+	local_role = cmd->local_role;
+	err = register_nap_server();
+	if (err < 0) {
+		status = HAL_STATUS_FAILED;
+		destroy_nap_device();
+		goto reply;
 	}
 
+	status = HAL_STATUS_SUCCESS;
+
+reply:
 	ipc_send_rsp(HAL_SERVICE_ID_PAN, HAL_OP_PAN_ENABLE, status);
 }
 
-- 
1.8.3.2

