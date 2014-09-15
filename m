Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 03/11] android: Add support for configuration command
Date: Mon, 15 Sep 2014 16:49:07 +0200
Message-Id: <1410792555-24765-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1410792555-24765-1-git-send-email-szymon.janc@tieto.com>
References: <1410792555-24765-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/main.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/android/main.c b/android/main.c
index b03a2df..005f24b 100644
--- a/android/main.c
+++ b/android/main.c
@@ -45,6 +45,7 @@
 
 #include "src/log.h"
 #include "src/sdpd.h"
+#include "src/shared/util.h"
 
 #include "lib/bluetooth.h"
 
@@ -64,6 +65,10 @@
 #define STARTUP_GRACE_SECONDS 5
 #define SHUTDOWN_GRACE_SECONDS 10
 
+static char *config_vendor = NULL;
+static char *config_model = NULL;
+static char *config_name = NULL;
+
 static guint bluetooth_start_timeout = 0;
 
 static bdaddr_t adapter_bdaddr;
@@ -221,11 +226,67 @@ failed:
 								status);
 }
 
+static char *get_prop(char *prop, uint16_t len, const uint8_t *val)
+{
+	/* TODO should fail if set more than once ? */
+	free(prop);
+
+	prop = malloc0(len);
+	if (!prop)
+		return NULL;
+
+	memcpy(prop, val, len);
+	prop[len - 1] = '\0';
+
+	return prop;
+}
+
+static void configuration(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_configuration *cmd = buf;
+	unsigned int i;
+
+	if (len != sizeof(*cmd) + cmd->num * sizeof(cmd->props[0])) {
+		error("Invalid configuration command, terminating");
+		raise(SIGTERM);
+		return;
+	}
+
+	for (i = 0; i < cmd->num; i++) {
+		switch (cmd->props[i].type) {
+		case HAL_CONFIG_VENDOR:
+			config_vendor = get_prop(config_vendor,
+							HAL_CONFIG_MAX_LEN,
+							cmd->props[i].val);
+			break;
+		case HAL_CONFIG_NAME:
+			config_name = get_prop(config_name, HAL_CONFIG_MAX_LEN,
+							cmd->props[i].val);
+			break;
+		case HAL_CONFIG_MODEL:
+			config_model = get_prop(config_model,
+							HAL_CONFIG_MAX_LEN,
+							cmd->props[i].val);
+			break;
+		default:
+			error("Invalid configuration option (%u), terminating",
+							cmd->props[i].type);
+			raise(SIGTERM);
+			return;
+		}
+	}
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_CORE, HAL_OP_CONFIGURATION,
+							HAL_STATUS_SUCCESS);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_REGISTER_MODULE */
 	{ service_register, false, sizeof(struct hal_cmd_register_module) },
 	/* HAL_OP_UNREGISTER_MODULE */
 	{ service_unregister, false, sizeof(struct hal_cmd_unregister_module) },
+	/* HAL_OP_CONFIGURATION */
+	{ configuration, true, sizeof(struct hal_cmd_configuration) },
 };
 
 static void bluetooth_stopped(void)
@@ -558,5 +619,9 @@ int main(int argc, char *argv[])
 
 	__btd_log_cleanup();
 
+	free(config_vendor);
+	free(config_model);
+	free(config_name);
+
 	return EXIT_SUCCESS;
 }
-- 
1.9.3

