Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH] android/handsfree-client: Verify variable length data received from IPC
Date: Fri, 26 Sep 2014 12:04:15 +0200
Message-Id: <1411725855-6531-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dial uses variable length data, check if we received as much as was
declared. This fixes two negative ipc-tester cases for hfp-client dial
api call not passing.
---
 android/handsfree-client.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index be29952..773ef76 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -97,6 +97,15 @@ static void handle_volume_control(const void *buf, uint16_t len)
 
 static void handle_dial(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_hf_client_dial *cmd = buf;
+
+	if (len != sizeof(*cmd) + cmd->number_len) {
+		error("Malformed number data, size (%u bytes), terminating",
+									len);
+		raise(SIGTERM);
+		return;
+	}
+
 	DBG("Not Implemented");
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
 				HAL_OP_HF_CLIENT_DIAL, HAL_STATUS_UNSUPPORTED);
-- 
1.9.1

