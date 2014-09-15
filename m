Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 07/11] android/hal-bluetooth: Add support for sending configuration
Date: Mon, 15 Sep 2014 16:49:11 +0200
Message-Id: <1410792555-24765-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1410792555-24765-1-git-send-email-szymon.janc@tieto.com>
References: <1410792555-24765-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-bluetooth.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 44eddbd..275ea52 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -31,6 +31,10 @@
 
 #define MODE_PROPERTY_NAME "persist.sys.bluetooth.mode"
 
+#define CONFIG_PROP_VENDOR "ro.product.manufacturer"
+#define CONFIG_PROP_NAME "ro.product.name"
+#define CONFIG_PROP_MODEL "ro.product.model"
+
 static const bt_callbacks_t *bt_hal_cbacks = NULL;
 
 #define enum_prop_to_hal(prop, hal_prop, type) do { \
@@ -405,6 +409,37 @@ static uint8_t get_mode(void)
 	return HAL_MODE_DEFAULT;
 }
 
+static int send_configuration(void)
+{
+	char buf[IPC_MTU];
+	struct hal_cmd_configuration *cmd = (void *) buf;
+	char prop[PROPERTY_VALUE_MAX];
+
+	cmd->num = 0;
+
+	if (property_get(CONFIG_PROP_VENDOR, prop, NULL) > 0) {
+		strcpy((char *) cmd->props[cmd->num].val, prop);
+		cmd->props[cmd->num].type = HAL_CONFIG_VENDOR;
+		cmd->num++;
+	}
+
+	if (property_get(CONFIG_PROP_NAME, prop, NULL) > 0) {
+		strcpy((char *) cmd->props[cmd->num].val, prop);
+		cmd->props[cmd->num].type = HAL_CONFIG_NAME;
+		cmd->num++;
+	}
+
+	if (property_get(CONFIG_PROP_MODEL, prop, NULL) > 0) {
+		strcpy((char *) cmd->props[cmd->num].val, prop);
+		cmd->props[cmd->num].type = HAL_CONFIG_MODEL;
+		cmd->num++;
+	}
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_CONFIGURATION,
+				sizeof(*cmd) + cmd->num * sizeof(cmd->props[0]),
+				cmd, NULL, NULL, NULL);
+}
+
 static int init(bt_callbacks_t *callbacks)
 {
 	struct hal_cmd_register_module cmd;
@@ -437,6 +472,12 @@ static int init(bt_callbacks_t *callbacks)
 		return BT_STATUS_FAIL;
 	}
 
+	status = send_configuration();
+	if (status != BT_STATUS_SUCCESS) {
+		error("Failed to send configuration");
+		goto fail;
+	}
+
 	cmd.service_id = HAL_SERVICE_ID_BLUETOOTH;
 	cmd.mode = get_mode();
 
-- 
1.9.3

