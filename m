Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 3/3] android/bluetooth: Make possible to start BlueZ in a single mode
Date: Wed, 23 Apr 2014 18:53:27 +0200
Message-Id: <1398272007-15338-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398272007-15338-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398272007-15338-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds possibility to start BlueZ in LE or BR/EDR mode
when having dual mode chip below.
---
 android/README          |  4 ++++
 android/bluetooth.c     | 40 ++++++++++++++++++++++++++++++++++++++--
 android/bluetooth.h     |  2 +-
 android/hal-bluetooth.c | 19 ++++++++++++++++++-
 android/hal-msg.h       |  2 ++
 android/main.c          |  5 ++++-
 6 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/android/README b/android/README
index 6254d34..08c4413 100644
--- a/android/README
+++ b/android/README
@@ -166,6 +166,10 @@ options.
 
 Property	Value		Description
 -------------------------------------------
+mode		bredr		Enable BlueZ in BR/EDR mode
+		le		Enable BlueZ in LE mode
+		<none>		Enable BlueZ in default mode - enable BR/EDR/LE
+				if available.
 handsfree	hfp		Enable Handsfree Profile (HFP) with narrowband
 				speech only
 		hfp_wbs		Enable Handsfree Profile (HFP) with narrowband
diff --git a/android/bluetooth.c b/android/bluetooth.c
index 476339e..fadea83 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -3892,14 +3892,50 @@ static const struct ipc_handler cmd_handlers[] = {
 	{ handle_le_test_mode_cmd, true, sizeof(struct hal_cmd_le_test_mode) },
 };
 
-void bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
+bool bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
 {
-	DBG("");
+	DBG("mode 0x%x", mode);
 
 	hal_ipc = ipc;
 
+	switch (mode) {
+	case HAL_MODE_DEFAULT:
+		if (!(adapter.current_settings & MGMT_SETTING_LE) &&
+			(adapter.supported_settings & MGMT_SETTING_LE))
+			set_mode(MGMT_OP_SET_LE, 0x01);
+		break;
+	case HAL_MODE_LE:
+		/* Fail if controller does not support LE */
+		if (!(adapter.supported_settings & MGMT_SETTING_LE)) {
+			error("LE Mode not supported by controller");
+			return false;
+		}
+
+		/* If LE it is not yet enabled then enable it */
+		if (!(adapter.current_settings & MGMT_SETTING_LE))
+			set_mode(MGMT_OP_SET_LE, 0x01);
+
+		/* Disable BR/EDR if it is enabled */
+		if ((adapter.current_settings & MGMT_SETTING_BREDR))
+			set_mode(MGMT_OP_SET_BREDR, 0x00);
+		break;
+	case HAL_MODE_BREDR:
+		/* BR/EDR Should be enabled on start, if it is not that means
+		 *  there is LE controller only and we should fail */
+		if (!(adapter.current_settings & MGMT_SETTING_BREDR)) {
+			error("BR/EDR Mode not supported");
+			return false;
+		}
+		break;
+	default:
+		error("Uknown mode 0x%x", mode);
+		return false;
+	}
+
 	ipc_register(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
+
+	return true;
 }
 
 void bt_bluetooth_unregister(void)
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 3eddf16..634458f 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -29,7 +29,7 @@ bool bt_bluetooth_stop(bt_bluetooth_stopped cb);
 
 void bt_bluetooth_cleanup(void);
 
-void bt_bluetooth_register(struct ipc *ipc, uint8_t mode);
+bool bt_bluetooth_register(struct ipc *ipc, uint8_t mode);
 void bt_bluetooth_unregister(void);
 
 int bt_adapter_add_record(sdp_record_t *rec, uint8_t svc_hint);
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 48d5ea2..1fa10e0 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -29,6 +29,8 @@
 #include "hal-ipc.h"
 #include "hal-utils.h"
 
+#define MODE_PROPERTY_NAME "persist.sys.bluetooth.mode"
+
 static const bt_callbacks_t *bt_hal_cbacks = NULL;
 
 #define enum_prop_to_hal(prop, hal_prop, type) do { \
@@ -412,6 +414,21 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	}
 };
 
+static uint8_t get_mode(void)
+{
+	char value[PROPERTY_VALUE_MAX];
+
+	if (property_get(MODE_PROPERTY_NAME, value, "") > 0 &&
+					(!strcasecmp(value, "bredr")))
+		return HAL_MODE_BREDR;
+
+	if (property_get(MODE_PROPERTY_NAME, value, "") > 0 &&
+					(!strcasecmp(value, "le")))
+		return HAL_MODE_LE;
+
+	return HAL_MODE_DEFAULT;
+}
+
 static int init(bt_callbacks_t *callbacks)
 {
 	struct hal_cmd_register_module cmd;
@@ -433,7 +450,7 @@ static int init(bt_callbacks_t *callbacks)
 	}
 
 	cmd.service_id = HAL_SERVICE_ID_BLUETOOTH;
-	cmd.mode = HAL_MODE_DEFAULT;
+	cmd.mode = get_mode();
 
 	status = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
diff --git a/android/hal-msg.h b/android/hal-msg.h
index ed0a67a..ee708cb 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -55,6 +55,8 @@ static const char BLUEZ_HAL_SK_PATH[] = "\0bluez_hal_socket";
 #define HAL_OP_STATUS			IPC_OP_STATUS
 
 #define HAL_MODE_DEFAULT		0x00
+#define HAL_MODE_BREDR			0x01
+#define HAL_MODE_LE			0x02
 
 #define HAL_OP_REGISTER_MODULE		0x01
 struct hal_cmd_register_module {
diff --git a/android/main.c b/android/main.c
index 99ab376..a9565a6 100644
--- a/android/main.c
+++ b/android/main.c
@@ -86,7 +86,10 @@ static void service_register(const void *buf, uint16_t len)
 
 	switch (m->service_id) {
 	case HAL_SERVICE_ID_BLUETOOTH:
-		bt_bluetooth_register(hal_ipc, m->mode);
+		if (!bt_bluetooth_register(hal_ipc, m->mode)) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
 
 		break;
 	case HAL_SERVICE_ID_SOCKET:
-- 
1.8.4

