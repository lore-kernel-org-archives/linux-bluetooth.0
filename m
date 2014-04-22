Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android/bluetooth: Make possible to start BlueZ in LE mode only
Date: Wed, 23 Apr 2014 00:16:31 +0200
Message-Id: <1398204991-5165-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds possibility to start BlueZ only in LE mode only.

It is useful for testing purpose, when you want test BlueZ in
peripheral mode against any dual mode device.
---
 android/README          |  3 +++
 android/bluetooth.c     |  7 ++++++-
 android/hal-bluetooth.c | 15 ++++++++++++++-
 android/hal-msg.h       |  1 +
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/android/README b/android/README
index 6254d34..9b08610 100644
--- a/android/README
+++ b/android/README
@@ -166,6 +166,9 @@ options.
 
 Property	Value		Description
 -------------------------------------------
+mode		le_only		Enable BlueZ in Low Energy mode only.
+		<none>		Enable BlueZ in default mode - enable br/edr/le
+				if possible.
 handsfree	hfp		Enable Handsfree Profile (HFP) with narrowband
 				speech only
 		hfp_wbs		Enable Handsfree Profile (HFP) with narrowband
diff --git a/android/bluetooth.c b/android/bluetooth.c
index 93c7935..923285c 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -3894,10 +3894,15 @@ static const struct ipc_handler cmd_handlers[] = {
 
 void bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
 {
-	DBG("");
+	DBG("mode 0x%x", mode);
 
 	hal_ipc = ipc;
 
+	if ((mode == HAL_MODE_LE_ONLY) &&
+			(adapter.current_settings & MGMT_SETTING_LE) &&
+			(adapter.current_settings & MGMT_SETTING_BREDR))
+		set_mode(MGMT_OP_SET_BREDR, 0x00);
+
 	ipc_register(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 }
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 48d5ea2..69009ff 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -29,6 +29,8 @@
 #include "hal-ipc.h"
 #include "hal-utils.h"
 
+#define MODE_PROPERTY_NAME "persist.sys.bluetooth.mode"
+
 static const bt_callbacks_t *bt_hal_cbacks = NULL;
 
 #define enum_prop_to_hal(prop, hal_prop, type) do { \
@@ -412,6 +414,17 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	}
 };
 
+static uint8_t get_mode(void)
+{
+	char value[PROPERTY_VALUE_MAX];
+
+	if (property_get(MODE_PROPERTY_NAME, value, "") > 0 &&
+					(!strcasecmp(value, "le_only")))
+		return HAL_MODE_LE_ONLY;
+
+	return HAL_MODE_DEFAULT;
+}
+
 static int init(bt_callbacks_t *callbacks)
 {
 	struct hal_cmd_register_module cmd;
@@ -433,7 +446,7 @@ static int init(bt_callbacks_t *callbacks)
 	}
 
 	cmd.service_id = HAL_SERVICE_ID_BLUETOOTH;
-	cmd.mode = HAL_MODE_DEFAULT;
+	cmd.mode = get_mode();
 
 	status = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
diff --git a/android/hal-msg.h b/android/hal-msg.h
index ed0a67a..db21870 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -55,6 +55,7 @@ static const char BLUEZ_HAL_SK_PATH[] = "\0bluez_hal_socket";
 #define HAL_OP_STATUS			IPC_OP_STATUS
 
 #define HAL_MODE_DEFAULT		0x00
+#define HAL_MODE_LE_ONLY		0x01
 
 #define HAL_OP_REGISTER_MODULE		0x01
 struct hal_cmd_register_module {
-- 
1.8.4

