Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 01/16] android/hal-gatt: Implement Android 5 callbacks
Date: Mon, 17 Nov 2014 23:27:53 +0100
Message-Id: <1416263288-30530-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds IPC handlers for new GATT notifications and implementes
requiured callbacks.
---
 android/hal-gatt.c | 193 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 android/hal-msg.h  | 113 +++++++++++++++++++++++++++++++
 2 files changed, 305 insertions(+), 1 deletion(-)

diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index 50364f5..15ab357 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -470,6 +470,147 @@ static void handle_response_confirmation(void *buf, uint16_t len, int fd)
 		cbs->server->response_confirmation_cb(ev->status, ev->handle);
 }
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+static void handle_configure_mtu(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_gatt_client_configure_mtu *ev = buf;
+
+	if (cbs->client->configure_mtu_cb)
+		cbs->client->configure_mtu_cb(ev->conn_id, ev->status, ev->mtu);
+}
+
+static void handle_filter_config(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_gatt_client_filter_config *ev = buf;
+
+	if (cbs->client->scan_filter_cfg_cb)
+		cbs->client->scan_filter_cfg_cb(ev->action, ev->client_if,
+						ev->status, ev->type,
+						ev->space);
+}
+
+static void handle_filter_params(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_gatt_client_filter_params *ev = buf;
+
+	if (cbs->client->scan_filter_param_cb)
+		cbs->client->scan_filter_param_cb(ev->action, ev->client_if,
+							ev->status, ev->space);
+}
+
+static void handle_filter_status(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_gatt_client_filter_status *ev = buf;
+
+	if (cbs->client->scan_filter_status_cb)
+		cbs->client->scan_filter_status_cb(ev->enable, ev->client_if,
+								ev->status);
+}
+
+static void handle__multi_adv_enable(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_gatt_client_multi_adv_enable *ev = buf;
+
+	if (cbs->client->multi_adv_enable_cb)
+		cbs->client->multi_adv_enable_cb(ev->client_if, ev->status);
+}
+
+static void handle_multi_adv_update(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_gatt_client_multi_adv_update *ev = buf;
+
+	if (cbs->client->multi_adv_update_cb)
+		cbs->client->multi_adv_update_cb(ev->client_if, ev->status);
+}
+
+static void handle_multi_adv_data(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_gatt_client_multi_adv_data *ev = buf;
+
+	if (cbs->client->multi_adv_data_cb)
+		cbs->client->multi_adv_data_cb(ev->client_if, ev->status);
+}
+
+static void handle_multi_adv_disable(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_gatt_client_multi_adv_disable *ev = buf;
+
+	if (cbs->client->multi_adv_disable_cb)
+		cbs->client->multi_adv_disable_cb(ev->client_if, ev->status);
+}
+
+static void handle_client_congestion(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_gatt_client_congestion *ev = buf;
+
+	if (cbs->client->congestion_cb)
+		cbs->client->congestion_cb(ev->conn_id, ev->congested);
+}
+
+static void handle_config_batchscan(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_gatt_client_config_batchscan *ev = buf;
+
+	if (cbs->client->batchscan_cfg_storage_cb)
+		cbs->client->batchscan_cfg_storage_cb(ev->client_if,
+								ev->status);
+}
+
+static void handle_enable_batchscan(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_gatt_client_enable_batchscan *ev = buf;
+
+	if (cbs->client->batchscan_enb_disable_cb)
+		cbs->client->batchscan_enb_disable_cb(ev->action, ev->client_if,
+								ev->status);
+}
+
+static void handle_client_batchscan_reports(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_gatt_client_batchscan_reports *ev = buf;
+
+	if (cbs->client->batchscan_reports_cb)
+		cbs->client->batchscan_reports_cb(ev->client_if, ev->status,
+							ev->format, ev->num,
+							ev->data_len, ev->data);
+}
+
+static void handle_batchscan_threshold(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_gatt_client_batchscan_threshold *ev = buf;
+
+	if (cbs->client->batchscan_threshold_cb)
+		cbs->client->batchscan_threshold_cb(ev->client_if);
+}
+
+static void handle_track_adv(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_gatt_client_track_adv *ev = buf;
+
+	if (cbs->client->track_adv_event_cb)
+		cbs->client->track_adv_event_cb(ev->client_if, ev->filetr_index,
+						ev->address_type,
+						(bt_bdaddr_t *) ev->address,
+						ev->state);
+}
+
+static void handle_indication_send(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_gatt_server_indication_sent *ev = buf;
+
+	if (cbs->server->indication_sent_cb)
+		cbs->server->indication_sent_cb(ev->conn_id, ev->status);
+}
+
+static void handle_server_congestion(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_gatt_server_congestion *ev = buf;
+
+	if (cbs->server->congestion_cb)
+		cbs->server->congestion_cb(ev->conn_id, ev->congested);
+}
+#endif
+
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -565,7 +706,57 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/* HAL_EV_GATT_SERVER_RSP_CONFIRMATION */
 	{ handle_response_confirmation, false,
 		sizeof(struct hal_ev_gatt_server_rsp_confirmation) },
-};
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	/* HAL_EV_GATT_CLIENT_CONFIGURE_MTU */
+	{ handle_configure_mtu, false,
+		sizeof(struct hal_ev_gatt_client_configure_mtu) },
+	/* HAL_EV_GATT_CLIENT_FILTER_CONFIG */
+	{ handle_filter_config, false,
+		sizeof(struct hal_ev_gatt_client_filter_config) },
+	/* HAL_EV_GATT_CLIENT_FILTER_PARAMS */
+	{ handle_filter_params, false,
+		sizeof(struct hal_ev_gatt_client_filter_params) },
+	/* HAL_EV_GATT_CLIENT_FILTER_STATUS */
+	{ handle_filter_status, false,
+		sizeof(struct hal_ev_gatt_client_filter_status) },
+	/* HAL_EV_GATT_CLIENT_MULTI_ADV_ENABLE */
+	{ handle__multi_adv_enable, false,
+		sizeof(struct hal_ev_gatt_client_multi_adv_enable) },
+	/* HAL_EV_GATT_CLIENT_MULTI_ADV_UPDATE */
+	{ handle_multi_adv_update, false,
+		sizeof(struct hal_ev_gatt_client_multi_adv_update) },
+	/* HAL_EV_GATT_CLIENT_MULTI_ADV_DATA */
+	{ handle_multi_adv_data, false,
+		sizeof(struct hal_ev_gatt_client_multi_adv_data) },
+	/* HAL_EV_GATT_CLIENT_MULTI_ADV_DISABLE */
+	{ handle_multi_adv_disable, false,
+		sizeof(struct hal_ev_gatt_client_multi_adv_disable) },
+	/* HAL_EV_GATT_CLIENT_CONGESTION */
+	{ handle_client_congestion, false,
+		sizeof(struct hal_ev_gatt_client_congestion) },
+	/* HAL_EV_GATT_CLIENT_CONFIG_BATCHSCAN */
+	{ handle_config_batchscan, false,
+		sizeof(struct hal_ev_gatt_client_config_batchscan) },
+	/* HAL_EV_GATT_CLIENT_ENABLE_BATCHSCAN */
+	{ handle_enable_batchscan, false,
+		sizeof(struct hal_ev_gatt_client_enable_batchscan) },
+	/* HAL_EV_GATT_CLIENT_BATCHSCAN_REPORTS */
+	{ handle_client_batchscan_reports, true,
+		sizeof(struct hal_ev_gatt_client_batchscan_reports) },
+	/* HAL_EV_GATT_CLIENT_BATCHSCAN_THRESHOLD */
+	{ handle_batchscan_threshold, false,
+		sizeof(struct hal_ev_gatt_client_batchscan_threshold) },
+	/* HAL_EV_GATT_CLIENT_TRACK_ADV */
+	{ handle_track_adv, false,
+		sizeof(struct hal_ev_gatt_client_track_adv) },
+	/* HAL_EV_GATT_SERVER_INDICATION_SENT */
+	{ handle_indication_send, false,
+		sizeof(struct hal_ev_gatt_server_indication_sent) },
+	/* HAL_EV_GATT_SERVER_CONGESTION */
+	{ handle_server_congestion, false,
+		sizeof(struct hal_ev_gatt_server_congestion) },
+#endif
+	};
 
 /* Client API */
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index c86b0a6..438fa7b 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1782,6 +1782,119 @@ struct hal_ev_gatt_server_rsp_confirmation {
 	int32_t handle;
 } __attribute__((packed));
 
+#define HAL_EV_GATT_CLIENT_CONFIGURE_MTU	0xa0
+struct hal_ev_gatt_client_configure_mtu {
+	int32_t conn_id;
+	int32_t status;
+	int32_t mtu;
+} __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_FILTER_CONFIG	0xa1
+struct hal_ev_gatt_client_filter_config {
+	int32_t action;
+	int32_t client_if;
+	int32_t status;
+	int32_t type;
+	int32_t space;
+}  __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_FILTER_PARAMS	0xa2
+struct hal_ev_gatt_client_filter_params {
+	int32_t action;
+	int32_t client_if;
+	int32_t status;
+	int32_t space;
+}  __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_FILTER_STATUS	0xa3
+struct hal_ev_gatt_client_filter_status {
+	int32_t enable;
+	int32_t client_if;
+	int32_t status;
+}  __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_MULTI_ADV_ENABLE	0xa4
+struct hal_ev_gatt_client_multi_adv_enable {
+	int32_t client_if;
+	int32_t status;
+} __attribute__((packed));
+
+
+#define HAL_EV_GATT_CLIENT_MULTI_ADV_UPDATE	0xa5
+struct hal_ev_gatt_client_multi_adv_update {
+	int32_t client_if;
+	int32_t status;
+} __attribute__((packed));
+
+
+#define HAL_EV_GATT_CLIENT_MULTI_ADV_DATA	0xa6
+struct hal_ev_gatt_client_multi_adv_data {
+	int32_t client_if;
+	int32_t status;
+} __attribute__((packed));
+
+
+#define HAL_EV_GATT_CLIENT_MULTI_ADV_DISABLE	0xa7
+struct hal_ev_gatt_client_multi_adv_disable {
+	int32_t client_if;
+	int32_t status;
+} __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_CONGESTION		0xa8
+struct hal_ev_gatt_client_congestion {
+	int32_t conn_id;
+	uint8_t congested;
+} __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_CONFIG_BATCHSCAN	0xa9
+struct hal_ev_gatt_client_config_batchscan {
+	int32_t client_if;
+	int32_t status;
+} __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_ENABLE_BATCHSCAN	0xaa
+struct hal_ev_gatt_client_enable_batchscan {
+	int32_t action;
+	int32_t client_if;
+	int32_t status;
+} __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_BATCHSCAN_REPORTS	0xab
+struct hal_ev_gatt_client_batchscan_reports {
+	int32_t client_if;
+	int32_t status;
+	int32_t format;
+	int32_t num;
+	int32_t data_len;
+	uint8_t data[0];
+} __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_BATCHSCAN_THRESHOLD	0xac
+struct hal_ev_gatt_client_batchscan_threshold {
+	int32_t client_if;
+} __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_TRACK_ADV		0xad
+struct hal_ev_gatt_client_track_adv {
+	int32_t client_if;
+	int32_t filetr_index;
+	int32_t address_type;
+	uint8_t address[6];
+	int32_t state;
+} __attribute__((packed));
+
+#define HAL_EV_GATT_SERVER_INDICATION_SENT	0xae
+struct hal_ev_gatt_server_indication_sent {
+	int32_t conn_id;
+	int32_t status;
+} __attribute__((packed));
+
+#define HAL_EV_GATT_SERVER_CONGESTION		0xaf
+struct hal_ev_gatt_server_congestion {
+	int32_t conn_id;
+	uint8_t congested;
+} __attribute__((packed));
+
 #define HAL_GATT_PERMISSION_READ			0x0001
 #define HAL_GATT_PERMISSION_READ_ENCRYPTED		0x0002
 #define HAL_GATT_PERMISSION_READ_ENCRYPTED_MITM		0x0004
-- 
1.9.3

