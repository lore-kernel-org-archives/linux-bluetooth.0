Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3] android/bluetooth: Add support to read Le features by Android
Date: Wed, 10 Dec 2014 13:45:41 +0100
Message-Id: <1418215541-10478-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
*v3 Fix for setting Privacy Enable flag. 
 android/bluetooth.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-msg.h   |  1 +
 2 files changed, 49 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index f79ca37..48ca231 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -176,6 +176,13 @@ static struct {
 
 	char *name;
 
+	uint8_t max_advert_instance;
+	uint8_t rpa_offload_supported;
+	uint8_t max_irk_list_size;
+	uint8_t max_scan_filters_supported;
+	uint16_t scan_result_storage_size;
+	uint8_t activity_energy_info_supported;
+
 	uint32_t current_settings;
 	uint32_t supported_settings;
 
@@ -189,6 +196,12 @@ static struct {
 	.index = MGMT_INDEX_NONE,
 	.dev_class = 0,
 	.name = NULL,
+	.max_advert_instance = 0,
+	.rpa_offload_supported = 0,
+	.max_irk_list_size = 0,
+	.max_scan_filters_supported = 0,
+	.scan_result_storage_size = 0,
+	.activity_energy_info_supported = 0,
 	.current_settings = 0,
 	.supported_settings = 0,
 	.cur_discovery_type = SCAN_TYPE_NONE,
@@ -3784,6 +3797,31 @@ static uint8_t get_adapter_discoverable_timeout(void)
 	return HAL_STATUS_SUCCESS;
 }
 
+static void prepare_le_features(uint8_t *le_features)
+{
+	le_features[0] = !!(adapter.current_settings & MGMT_SETTING_PRIVACY);
+	le_features[1] = adapter.max_advert_instance;
+	le_features[2] = adapter.rpa_offload_supported;
+	le_features[3] = adapter.max_irk_list_size;
+	le_features[4] = adapter.max_scan_filters_supported;
+	/* lo byte */
+	le_features[5] = adapter.scan_result_storage_size;
+	/* hi byte */
+	le_features[6] = adapter.scan_result_storage_size >> 8;
+	le_features[7] = adapter.activity_energy_info_supported;
+}
+
+static uint8_t get_adapter_le_features(void)
+{
+	uint8_t le_features[8];
+
+	prepare_le_features(le_features);
+
+	send_adapter_property(HAL_PROP_ADAPTER_LOCAL_LE_FEAT,
+					sizeof(le_features), le_features);
+	return HAL_STATUS_SUCCESS;
+}
+
 static void handle_get_adapter_prop_cmd(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_get_adapter_prop *cmd = buf;
@@ -3817,6 +3855,9 @@ static void handle_get_adapter_prop_cmd(const void *buf, uint16_t len)
 	case HAL_PROP_ADAPTER_DISC_TIMEOUT:
 		status = get_adapter_discoverable_timeout();
 		break;
+	case HAL_PROP_ADAPTER_LOCAL_LE_FEAT:
+		status = get_adapter_le_features();
+		break;
 	default:
 		status = HAL_STATUS_FAILED;
 		break;
@@ -3837,6 +3878,7 @@ static void get_adapter_properties(void)
 	uint8_t bonded[g_slist_length(bonded_devices) * sizeof(bdaddr_t)];
 	uint128_t uuids[g_slist_length(adapter.uuids)];
 	uint8_t android_bdaddr[6];
+	uint8_t le_features[8];
 	uint8_t type, mode;
 	size_t size, i;
 	GSList *l;
@@ -3898,6 +3940,12 @@ static void get_adapter_properties(void)
 									uuids);
 	ev->num_props++;
 
+	prepare_le_features(le_features);
+	size += fill_hal_prop(buf + size, HAL_PROP_ADAPTER_LOCAL_LE_FEAT,
+					sizeof(le_features), le_features);
+
+	ev->num_props++;
+
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
 				HAL_EV_ADAPTER_PROPS_CHANGED, size, buf);
 }
diff --git a/android/hal-msg.h b/android/hal-msg.h
index e0be314..9d38a9f 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -142,6 +142,7 @@ struct hal_prop_device_info {
 	uint16_t manufacturer;
 } __attribute__((packed));
 
+#define HAL_PROP_ADAPTER_LOCAL_LE_FEAT		0x0d
 #define HAL_PROP_DEVICE_TIMESTAMP		0xFF
 
 #define HAL_ADAPTER_SCAN_MODE_NONE		0x00
-- 
1.8.4

