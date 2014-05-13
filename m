Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 2/6] android: Add support for configuration command
Date: Tue, 13 May 2014 19:09:17 +0200
Message-Id: <1400000961-24376-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1400000961-24376-1-git-send-email-szymon.janc@tieto.com>
References: <1400000961-24376-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/main.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/android/main.c b/android/main.c
index 0a0c150..e85f696 100644
--- a/android/main.c
+++ b/android/main.c
@@ -45,6 +45,7 @@
 
 #include "src/log.h"
 #include "src/sdpd.h"
+#include "src/shared/util.h"
 
 #include "lib/bluetooth.h"
 
@@ -64,6 +65,11 @@
 #define STARTUP_GRACE_SECONDS 5
 #define SHUTDOWN_GRACE_SECONDS 10
 
+static char *config_manufacturer = NULL;
+static char *config_system_id = NULL;
+static char *config_model = NULL;
+static char *config_serial = NULL;
+
 static guint bluetooth_start_timeout = 0;
 
 static bdaddr_t adapter_bdaddr;
@@ -221,11 +227,65 @@ failed:
 								status);
 }
 
+static char *get_prop(char *prop, const uint8_t *buf)
+{
+	if (!prop)
+		prop = malloc0(HAL_CONFIG_PROP_LEN);
+
+	if (!prop)
+		return NULL;
+
+	memcpy(prop, buf, HAL_CONFIG_PROP_LEN);
+	prop[HAL_CONFIG_PROP_LEN - 1] = '\0';
+
+	return prop;
+}
+
+static void configuration(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_configuration *cmd = buf;
+	unsigned int i;
+
+	if (len != sizeof(*cmd) + (cmd->num * sizeof(cmd->props[0]))) {
+		error("Invalid configuration command, terminating");
+		raise(SIGTERM);
+		return;
+	}
+
+	for (i = 0; i < cmd->num; i++) {
+		switch (cmd->props[i].type) {
+		case HAL_CONFIG_MANUFACTURER_NAME:
+			config_manufacturer = get_prop(config_manufacturer,
+							cmd->props[i].buf);
+			break;
+		case HAL_CONFIG_SYSTEM_ID:
+			config_system_id = get_prop(config_system_id,
+							cmd->props[i].buf);
+			break;
+		case HAL_CONFIG_MODEL_NUMBER:
+			config_model = get_prop(config_model,
+							cmd->props[i].buf);
+			break;
+		case HAL_CONFIG_SERIAL_NUMBER:
+			config_serial = get_prop(config_serial,
+							cmd->props[i].buf);
+			break;
+		default:
+			break;
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
-- 
1.9.1

