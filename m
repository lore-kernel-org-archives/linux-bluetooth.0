Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 10/12] android: Add support for FW and HW revision config options
Date: Tue, 30 Sep 2014 13:06:25 +0200
Message-Id: <1412075187-5518-11-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1412075187-5518-1-git-send-email-szymon.janc@tieto.com>
References: <1412075187-5518-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c          |  6 ++----
 android/hal-bluetooth.c | 10 ++++++++++
 android/hal-ipc-api.txt |  2 ++
 android/hal-msg.h       |  2 ++
 android/main.c          | 24 ++++++++++++++++++++++++
 android/utils.h         |  2 ++
 6 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 425f6a5..ad20a71 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6524,8 +6524,7 @@ static void register_device_info_service(void)
 						NULL, NULL);
 	}
 
-	/* TODO */
-	data = NULL;
+	data = bt_config_get_fw_rev();
 	if (data) {
 		bt_uuid16_create(&uuid, GATT_CHARAC_FIRMWARE_REVISION_STRING);
 		gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid,
@@ -6535,8 +6534,7 @@ static void register_device_info_service(void)
 						(void *) data);
 	}
 
-	/* TODO */
-	data = NULL;
+	data = bt_config_get_hw_rev();
 	if (data) {
 		bt_uuid16_create(&uuid, GATT_CHARAC_HARDWARE_REVISION_STRING);
 		gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid,
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index f7db416..6754279 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -453,6 +453,16 @@ static int send_configuration(void)
 		cmd->num++;
 	}
 
+	if (get_config("fwrev", prop, "ro.build.version.release") > 0) {
+		len += add_prop(prop, HAL_CONFIG_FW_REV, buf + len);
+		cmd->num++;
+	}
+
+	if (get_config("hwrev", prop, "ro.board.platform") > 0) {
+		len += add_prop(prop, HAL_CONFIG_HW_REV, buf + len);
+		cmd->num++;
+	}
+
 	return hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_CONFIGURATION, len, cmd,
 							NULL, NULL, NULL);
 }
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 82067f2..739fdbf 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -161,6 +161,8 @@ Core Service (ID 0)
 		                              0x03 = Serial Number
 		                              0x04 = System ID
 		                              0x05 = PnP ID
+		                              0x06 = Firmware Rev
+		                              0x07 = Hardware Rev
 
 		In case of an error, the error response will be returned.
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 9ae8c24..71969b5 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -76,6 +76,8 @@ struct hal_cmd_unregister_module {
 #define HAL_CONFIG_SERIAL_NUMBER	0x03
 #define HAL_CONFIG_SYSTEM_ID		0x04
 #define HAL_CONFIG_PNP_ID		0x05
+#define HAL_CONFIG_FW_REV		0x06
+#define HAL_CONFIG_HW_REV		0x07
 
 struct hal_config_prop {
 	uint8_t type;
diff --git a/android/main.c b/android/main.c
index 014b763..4f3a6bf 100644
--- a/android/main.c
+++ b/android/main.c
@@ -75,6 +75,8 @@ static char *config_vendor = NULL;
 static char *config_model = NULL;
 static char *config_name = NULL;
 static char *config_serial = NULL;
+static char *config_fw_rev = NULL;
+static char *config_hw_rev = NULL;
 static uint64_t config_system_id = 0;
 static uint16_t config_pnp_source = 0x0002;	/* USB */
 static uint16_t config_pnp_vendor = 0x1d6b;	/* Linux Foundation */
@@ -120,6 +122,16 @@ const char *bt_config_get_serial(void)
 	return config_serial;
 }
 
+const char *bt_config_get_fw_rev(void)
+{
+	return config_fw_rev;
+}
+
+const char *bt_config_get_hw_rev(void)
+{
+	return config_hw_rev;
+}
+
 uint64_t bt_config_get_system_id(void)
 {
 	return config_system_id;
@@ -420,6 +432,16 @@ static void configuration(const void *buf, uint16_t len)
 		case HAL_CONFIG_PNP_ID:
 			parse_pnp_id(prop->len, prop->val);
 			break;
+		case HAL_CONFIG_FW_REV:
+			config_fw_rev = get_prop(config_fw_rev, prop->len,
+								prop->val);
+			DBG("fw_rev %s", config_fw_rev);
+			break;
+		case HAL_CONFIG_HW_REV:
+			config_hw_rev = get_prop(config_hw_rev, prop->len,
+								prop->val);
+			DBG("hw_rev %s", config_hw_rev);
+			break;
 		default:
 			error("Invalid configuration option (%u), terminating",
 								prop->type);
@@ -760,6 +782,8 @@ int main(int argc, char *argv[])
 	free(config_model);
 	free(config_name);
 	free(config_serial);
+	free(config_fw_rev);
+	free(config_hw_rev);
 
 	return EXIT_SUCCESS;
 }
diff --git a/android/utils.h b/android/utils.h
index 9bf2195..7adc2da 100644
--- a/android/utils.h
+++ b/android/utils.h
@@ -35,6 +35,8 @@ const char *bt_config_get_vendor(void);
 const char *bt_config_get_model(void);
 const char *bt_config_get_name(void);
 const char *bt_config_get_serial(void);
+const char *bt_config_get_fw_rev(void);
+const char *bt_config_get_hw_rev(void);
 uint64_t bt_config_get_system_id(void);
 uint16_t bt_config_get_pnp_source(void);
 uint16_t bt_config_get_pnp_vendor(void);
-- 
1.9.1

