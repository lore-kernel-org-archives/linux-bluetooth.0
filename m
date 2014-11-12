Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 03/14] android/handsfree-client: Add handling dial command
Date: Wed, 12 Nov 2014 11:49:26 +0100
Message-Id: <1415789377-20458-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1415789377-20458-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415789377-20458-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree-client.c | 66 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 9 deletions(-)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index e498f89..4dfe9fb 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -429,24 +429,72 @@ done:
 static void handle_dial(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_hf_client_dial *cmd = buf;
+	struct device *dev;
+	uint8_t status;
+	bool ret;
 
-	if (len != sizeof(*cmd) + cmd->number_len) {
-		error("Malformed number data, size (%u bytes), terminating",
-									len);
-		raise(SIGTERM);
-		return;
+	DBG("");
+
+	if (len != sizeof(*cmd) + cmd->number_len)
+		goto failed;
+
+	dev = find_default_device();
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto done;
 	}
 
-	DBG("Not Implemented");
+	if (cmd->number_len > 0) {
+		if (cmd->number[cmd->number_len - 1] != '\0')
+			goto failed;
+
+		DBG("Dialing %s", cmd->number);
+
+		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
+							"ATD%s;", cmd->number);
+	} else {
+		DBG("Redialing");
+
+		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
+								"AT+BLDN");
+	}
+
+	status =  ret ? HAL_STATUS_SUCCESS : HAL_STATUS_FAILED;
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
-				HAL_OP_HF_CLIENT_DIAL, HAL_STATUS_UNSUPPORTED);
+						HAL_OP_HF_CLIENT_DIAL, status);
+
+	return;
+
+failed:
+	error("Malformed number data, size (%u bytes), terminating", len);
+	raise(SIGTERM);
 }
 
 static void handle_dial_memory(const void *buf, uint16_t len)
 {
-	DBG("Not Implemented");
+	const struct hal_cmd_hf_client_dial_memory *cmd = buf;
+	struct device *dev;
+	uint8_t status;
+
+	DBG("");
+
+	dev = find_default_device();
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	if (hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL , "ATD>%d;",
+								cmd->location))
+		status = HAL_STATUS_SUCCESS;
+	else
+		status = HAL_STATUS_FAILED;
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
-			HAL_OP_HF_CLIENT_DIAL_MEMORY, HAL_STATUS_UNSUPPORTED);
+					HAL_OP_HF_CLIENT_DIAL_MEMORY, status);
 }
 
 static void handle_call_action(const void *buf, uint16_t len)
-- 
1.8.4

