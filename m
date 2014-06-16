Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] android/health: Verify register_app command correctness
Date: Mon, 16 Jun 2014 15:27:36 +0200
Message-Id: <1402925256-9096-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1402925256-9096-1-git-send-email-szymon.janc@tieto.com>
References: <1402925256-9096-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make sure that offsets are correct as those will be used to access
command buffer.
---
 android/health.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/android/health.c b/android/health.c
index 655d9f9..8279f87 100644
--- a/android/health.c
+++ b/android/health.c
@@ -48,6 +48,18 @@ static struct ipc *hal_ipc = NULL;
 
 static void bt_health_register_app(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_health_reg_app *cmd = buf;
+
+	if (len != sizeof(*cmd) + cmd->len ||
+			cmd->app_name_off > cmd->provider_name_off ||
+			cmd->provider_name_off > cmd->service_name_off ||
+			cmd->service_name_off > cmd->service_descr_off ||
+			cmd->service_descr_off > cmd->len) {
+		error("health: Invalid register app command, terminating");
+		raise(SIGTERM);
+		return;
+	}
+
 	DBG("Not implemented");
 
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_REG_APP,
-- 
1.9.1

