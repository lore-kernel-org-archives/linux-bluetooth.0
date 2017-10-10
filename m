Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [BlueZ PATCH 3/3] android: Enable multiadvertising
To: linux-bluetooth@vger.kernel.org
From: Martin Fuzzey <mfuzzey@parkeon.com>
Date: Tue, 10 Oct 2017 11:27:55 +0200
Message-ID: <20171010092755.30705.97375.stgit@localhost>
In-Reply-To: <20171010092748.30705.23283.stgit@localhost>
References: <20171010092748.30705.23283.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is required for custom advertising data.

The HAL entry points related to multiadvertising are now implemented and
map to the mgmnt "add advertising" operation.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 android/bluetooth.c |  124 +++++++++++++++++
 android/bluetooth.h |   32 ++++
 android/gatt.c      |  370 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 516 insertions(+), 10 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index ba8f405..b610b6c 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -4027,6 +4027,130 @@ bool bt_le_set_advertising(bool advertising, bt_le_set_advertising_done cb,
 	return false;
 }
 
+struct addrm_adv_user_data {
+	bt_le_addrm_advertising_done cb;
+	void *user_data;
+};
+
+static void add_advertising_cb(uint8_t status, uint16_t length,
+			const void *param, void *user_data)
+{
+	struct addrm_adv_user_data *data = user_data;
+
+	DBG("");
+
+	if (status)
+		error("Failed to add advertising %s (0x%02x))",
+						mgmt_errstr(status), status);
+
+	data->cb(status, data->user_data);
+}
+
+bool bt_le_add_advertising(struct adv_instance *adv,
+		bt_le_addrm_advertising_done cb, void *user_data)
+{
+	struct mgmt_cp_add_advertising *cp;
+	struct addrm_adv_user_data *cb_data;
+	size_t len = sizeof(*cp);
+	uint8_t *dst;
+	bool ok;
+
+	if (adv->adv_data)
+		len += adv->adv_data->len;
+	if (adv->sr_data)
+		len += adv->sr_data->len;
+
+	cp = malloc0(len);
+	if (!cp)
+		return false;
+
+	cp->instance = adv->instance;
+	cp->timeout = adv->timeout;
+	/* XXX: how should we set duration? (kernel will default to 2s as not set) */
+
+	switch(adv->type) {
+	case ANDROID_ADVERTISING_EVENT_TYPE_CONNECTABLE:
+		cp->flags |= MGMT_ADV_FLAG_CONNECTABLE;
+		break;
+
+	defualt:
+		break;
+	}
+
+	if (adv->include_tx_power)
+		cp->flags |= MGMT_ADV_FLAG_TX_POWER;
+
+	dst = cp->data;
+	if (adv->adv_data) {
+		cp->adv_data_len = adv->adv_data->len;
+		if (cp->adv_data_len) {
+			memcpy(dst, adv->adv_data->data, cp->adv_data_len);
+			dst += cp->adv_data_len;
+		}
+	}
+
+	if (adv->sr_data) {
+		cp->scan_rsp_len = adv->sr_data->len;
+		if (cp->scan_rsp_len) {
+			memcpy(dst, adv->sr_data->data, cp->scan_rsp_len);
+			dst += cp->scan_rsp_len;
+		}
+	}
+
+	DBG("lens: adv=%d sr=%d total=%d",
+		cp->adv_data_len, cp->scan_rsp_len, len);
+
+	cb_data = new0(typeof(*cb_data), 1);
+	cb_data->cb = cb;
+	cb_data->user_data = user_data;
+
+	ok = (mgmt_send(mgmt_if, MGMT_OP_ADD_ADVERTISING, adapter.index,
+			len, cp, add_advertising_cb, cb_data, free) > 0);
+
+	if (!ok)
+		free(cb_data);
+
+	free(cp);
+
+	return ok;
+}
+
+static void remove_advertising_cb(uint8_t status, uint16_t length,
+			const void *param, void *user_data)
+{
+	struct addrm_adv_user_data *data = user_data;
+
+	DBG("");
+
+	if (status)
+		error("Failed to remove advertising %s (0x%02x))",
+						mgmt_errstr(status), status);
+
+	data->cb(status, data->user_data);
+}
+
+bool bt_le_remove_advertising(struct adv_instance *adv,
+				bt_le_addrm_advertising_done cb, void *user_data)
+{
+	struct mgmt_cp_remove_advertising cp = {
+		.instance = adv->instance,
+	};
+	struct addrm_adv_user_data *cb_data;
+	bool ok;
+
+	cb_data = new0(typeof(*cb_data), 1);
+	cb_data->cb = cb;
+	cb_data->user_data = user_data;
+
+	ok = (mgmt_send(mgmt_if, MGMT_OP_REMOVE_ADVERTISING, adapter.index,
+			sizeof(cp), &cp, remove_advertising_cb, cb_data, free) > 0);
+
+	if (!ok)
+		free(cb_data);
+
+	return ok;
+}
+
 bool bt_le_register(bt_le_device_found cb)
 {
 	if (gatt_device_found_cb)
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 4b17209..d3e9214 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -88,3 +88,35 @@ typedef void (*bt_paired_device_cb)(const bdaddr_t *addr);
 bool bt_paired_register(bt_paired_device_cb cb);
 void bt_paired_unregister(bt_paired_device_cb cb);
 bool bt_is_pairing(const bdaddr_t *addr);
+
+/* Advertising data (for AD and SRD packets)
+ * In binary format including GAP headers (length, type)
+ */
+struct adv_data {
+	uint8_t len;
+	uint8_t data[0];	/* 0-N GAP records */
+};
+
+struct adv_instance {
+	uint8_t	instance;
+	int32_t timeout;
+	int32_t type;
+	struct adv_data	*adv_data;
+	struct adv_data *sr_data;
+	unsigned include_tx_power:1;
+};
+
+/* Values below have no C API definition - only in Java (AdvertiseManager.java) and bluedroid */
+enum android_adv_type {
+	ANDROID_ADVERTISING_EVENT_TYPE_CONNECTABLE = 0,
+	ANDROID_ADVERTISING_EVENT_TYPE_SCANNABLE = 2,
+	ANDROID_ADVERTISING_EVENT_TYPE_NON_CONNECTABLE = 3,
+};
+
+typedef void (*bt_le_addrm_advertising_done)(uint8_t status, void *user_data);
+bool bt_le_add_advertising(struct adv_instance *adv,
+		bt_le_addrm_advertising_done cb, void *user_data);
+bool bt_le_remove_advertising(struct adv_instance *adv,
+		bt_le_addrm_advertising_done cb, void *user_data);
+
+
diff --git a/android/gatt.c b/android/gatt.c
index 28635ed..46dfc82 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -110,6 +110,8 @@ struct gatt_app {
 	struct queue *notifications;
 
 	gatt_conn_cb_t func;
+
+	struct adv_instance *adv;
 };
 
 struct element_id {
@@ -192,6 +194,7 @@ static struct ipc *hal_ipc = NULL;
 static bdaddr_t adapter_addr;
 static bool scanning = false;
 static unsigned int advertising_cnt = 0;
+static uint32_t adv_inst_bits = 0;
 
 static struct queue *gatt_apps = NULL;
 static struct queue *gatt_devices = NULL;
@@ -650,6 +653,13 @@ static void connection_cleanup(struct gatt_device *device)
 		bt_auto_connect_remove(&device->bdaddr);
 }
 
+static void free_adv_instance(struct adv_instance *adv)
+{
+	if (adv->instance)
+		adv_inst_bits &= ~(1 << (adv->instance - 1));
+	free(adv);
+}
+
 static void destroy_gatt_app(void *data)
 {
 	struct gatt_app *app = data;
@@ -674,6 +684,9 @@ static void destroy_gatt_app(void *data)
 
 	queue_destroy(app->notifications, free);
 
+	if (app->adv)
+		free_adv_instance(app->adv);
+
 	free(app);
 }
 
@@ -5586,19 +5599,228 @@ static void handle_client_set_scan_param(const void *buf, uint16_t len)
 					HAL_STATUS_UNSUPPORTED);
 }
 
+static struct adv_instance *find_adv_instance(uint32_t client_if)
+{
+	struct gatt_app *app;
+	struct adv_instance *adv;
+	uint8_t inst = 0;
+	unsigned int i;
+
+	app = find_app_by_id(client_if);
+	if (!app)
+		return NULL;
+
+	if (app->adv)
+		return app->adv;
+
+	/* Assume that kernel supports <= 32 advertising instances (5 today)
+	 * We have already indicated the number to the android framework layers
+	 * via the LE features so we don't check again here.
+	 * The kernel will detect the error if needed
+	 */
+	for (i=0; i < sizeof(adv_inst_bits) * 8; i++) {
+		uint32_t mask = 1 << i;
+		if (!(adv_inst_bits & mask)) {
+			inst = i + 1;
+			adv_inst_bits |= mask;
+			break;
+		}
+	}
+	if (!inst)
+		return NULL;
+
+	adv = new0(typeof(*adv), 1);
+	adv->instance = inst;
+	app->adv = adv;
+
+	DBG("Assigned advertising instance %d for client %d", inst, client_if);
+
+	return adv;
+};
+
+/* Add UUIDS of requested size, converting from android 128 to appropriate format */
+static uint8_t *add_adv_svc_uuids(
+	uint8_t *dst, const uint8_t *src,
+	int selected_uuids, int total_uuids, unsigned type)
+{
+	int i;
+
+	if (!selected_uuids)
+		return dst;
+
+	/* Add TL header for complete list */
+	switch(type) {
+		case BT_UUID16:
+			*dst++ = (selected_uuids * 2) + 1;
+			*dst++ = 0x3;  /* complete list of 16 bit service uuids */
+			break;
+
+		case BT_UUID128:
+			*dst++ = (selected_uuids * 16) + 1;
+			*dst++ = 0x7;  /* complete list of 128 bit service uuids */
+			break;
+	}
+
+	for (i = 0; i  < total_uuids; i++) {
+		bt_uuid_t bt_uuid;
+
+		android2uuid(src, &bt_uuid);
+
+		if (bt_uuid.type != type)
+			continue;
+
+		bt_uuid_to_le(&bt_uuid, dst);
+		dst += bt_uuid_len(&bt_uuid);
+		src += 16;
+	}
+
+	return dst;
+}
+
+/* Build advertising data in TLV format from a data buffer containing
+ * manufacturer_data, service_data, service uuids (in that order)
+ * The input data is raw with no TLV structure and the service uuids are 128 bit
+ */
+static struct adv_data *build_adv_data(
+	int32_t manufacturer_data_len,
+	int32_t service_data_len,
+	int32_t service_uuid_len,
+	const uint8_t *data_in)
+{
+	const int one_svc_uuid_len = 128 / 8;  /* Android always sends 128bit UUIDs */
+	struct adv_data *adv;
+	uint32_t len = 0;
+	uint8_t *dst;
+	const uint8_t *src;
+	unsigned num_svc_uuids, i, num_uuid16 = 0, num_uuid128 = 0;
+
+	if (manufacturer_data_len > 0)
+		len += (manufacturer_data_len + 2);
+
+	if (service_data_len > 0)
+		len += (service_data_len + 2);
+
+	if (service_uuid_len % one_svc_uuid_len) {
+		error("Service UUIDs not multiple of %d bytes (%d)",
+			one_svc_uuid_len, service_uuid_len);
+		num_svc_uuids = 0;
+	} else {
+		num_svc_uuids = service_uuid_len / one_svc_uuid_len;
+	}
+
+	src = data_in + manufacturer_data_len + service_data_len;
+	for (i = 0; i  < num_svc_uuids; i++) {
+		bt_uuid_t bt_uuid;
+
+		android2uuid(src, &bt_uuid);
+
+		switch (bt_uuid.type) {
+		case BT_UUID16:
+			num_uuid16++;
+			len += 2;
+			break;
+
+		case BT_UUID128:
+			num_uuid128++;
+			len += 16;
+			break;
+
+		default:
+			error("Unsupported UUID length");
+			break;
+		}
+
+		src += one_svc_uuid_len;
+	}
+
+	DBG("num svc uuids: 16bit=%d 128bit=%d total=%d\n",
+		num_uuid16, num_uuid128, num_svc_uuids);
+
+	/* UUIDs of same size are grouped with 2 byte GAP header per list */
+	if (num_uuid16)
+		len +=2;
+	if (num_uuid128)
+		len += 2;
+
+	DBG("adv data size = %d", len);
+
+	if (len > 0xff) { /* Kernel limit is lower but it will complain if so */
+		error("Advertising data too big");
+		return NULL;
+	}
+
+	adv = malloc0(sizeof(*adv) + len);
+	if (!adv)
+		return NULL;
+
+	adv->len = len;
+	dst = &adv->data[0];
+	src = data_in;
+	if (manufacturer_data_len > 0) {
+		*dst++ = manufacturer_data_len + 1;
+		*dst++ = 0xff;
+		memcpy(dst, src, manufacturer_data_len);
+		dst += manufacturer_data_len;
+		src += manufacturer_data_len;
+	}
+
+	if (service_data_len > 0) {
+		*dst++ = service_data_len + 1;
+		*dst++ = 0x16; /* Service data, 16 bit UUID */
+		memcpy(dst, src, service_data_len);
+		dst += service_data_len;
+		src += service_data_len;
+	}
+
+	dst = add_adv_svc_uuids(dst, src, num_uuid16, num_svc_uuids, BT_UUID16);
+	dst = add_adv_svc_uuids(dst, src, num_uuid128, num_svc_uuids, BT_UUID128);
+
+	return adv;
+}
+
+
 static void handle_client_setup_multi_adv(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_setup_multi_adv *cmd = buf;
+	struct hal_ev_gatt_client_multi_adv_enable ev;
+	struct adv_instance *adv;
+	uint8_t status;
 
-	DBG("client_if %d", cmd->client_if);
+	DBG("client_if %d min_interval=%d max_interval=%d type=%d channel_map=0x%x tx_power=%d timeout=%d",
+		cmd->client_if,
+		cmd->min_interval,
+		cmd->max_interval,
+		cmd->type,
+		cmd->channel_map,
+		cmd->tx_power,
+		cmd->timeout);
+
+	adv = find_adv_instance(cmd->client_if);
+	if (!adv) {
+		status = HAL_STATUS_FAILED;
+		goto out;
+	}
 
-	/* TODO */
+	status = HAL_STATUS_SUCCESS;
+	adv->timeout = cmd->timeout;
+	adv->type = cmd->type;
+	if (adv->type != ANDROID_ADVERTISING_EVENT_TYPE_SCANNABLE) {
+		free(adv->sr_data);
+		adv->sr_data = NULL;
+	}
 
+out:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_CLIENT_SETUP_MULTI_ADV,
-					HAL_STATUS_UNSUPPORTED);
+					status);
+
+	ev.client_if = cmd->client_if;
+	ev.status = status;
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_CLIENT_MULTI_ADV_ENABLE, sizeof(ev), &ev);
 }
 
+/* This is not currently called by Android 5.1 */
 static void handle_client_update_multi_adv(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_update_multi_adv *cmd = buf;
@@ -5612,30 +5834,158 @@ static void handle_client_update_multi_adv(const void *buf, uint16_t len)
 					HAL_STATUS_UNSUPPORTED);
 }
 
+struct addrm_adv_cb_data {
+	int32_t client_if;
+	struct adv_instance *adv;
+};
+
+static void add_advertising_cb(uint8_t status, void *user_data)
+{
+	struct addrm_adv_cb_data *cb_data = user_data;
+	struct hal_ev_gatt_client_multi_adv_data ev = {
+		.status = status,
+		.client_if = cb_data->client_if,
+	};
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+				HAL_EV_GATT_CLIENT_MULTI_ADV_DATA,
+				sizeof(ev), &ev);
+
+	free(cb_data);
+}
+
 static void handle_client_setup_multi_adv_inst(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_setup_multi_adv_inst *cmd = buf;
+	struct adv_instance *adv;
+	struct adv_data *adv_data;
+	struct addrm_adv_cb_data *cb_data = NULL;
+	uint8_t status = HAL_STATUS_FAILED;
+
+	DBG("client_if %d set_scan_rsp=%d include_name=%d include_tx_power=%d appearance=%d manuf_data_len=%d svc_data_len=%d svc_uuid_len=%d",
+		cmd->client_if,
+		cmd->set_scan_rsp,
+		cmd->include_name,
+		cmd->include_tx_power,
+		cmd->appearance,
+		cmd->manufacturer_data_len,
+		cmd->service_data_len,
+		cmd->service_uuid_len
+	);
+
+	adv = find_adv_instance(cmd->client_if);
+	if (!adv)
+		goto out;
+
+	adv->include_tx_power = cmd->include_tx_power ? 1 : 0;
+
+	adv_data = build_adv_data(
+			cmd->manufacturer_data_len,
+			cmd->service_data_len,
+			cmd->service_uuid_len,
+			cmd->data_service_uuid);
+	if (!adv_data)
+		goto out;
+
+	if (cmd->set_scan_rsp) {
+		free(adv->sr_data);
+		adv->sr_data = adv_data;
+	} else {
+		free(adv->adv_data);
+		adv->adv_data = adv_data;
+	}
 
-	DBG("client_if %d", cmd->client_if);
+	cb_data = new0(typeof(*cb_data), 1);
+	cb_data->client_if = cmd->client_if;
+	cb_data->adv = adv;
 
-	/* TODO */
+	if (!bt_le_add_advertising(adv, add_advertising_cb, cb_data)) {
+		error("gatt: Could not add advertising");
+		free(cb_data);
+		goto out;
+	}
 
+	status = HAL_STATUS_SUCCESS;
+
+out:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-					HAL_OP_GATT_CLIENT_SETUP_MULTI_ADV_INST,
-					HAL_STATUS_UNSUPPORTED);
+				HAL_OP_GATT_CLIENT_SETUP_MULTI_ADV_INST,
+				status);
+
+	if (status != HAL_STATUS_SUCCESS) {
+		struct hal_ev_gatt_client_multi_adv_data ev = {
+			.status = status,
+			.client_if = cmd->client_if,
+		};
+
+		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+				HAL_EV_GATT_CLIENT_MULTI_ADV_DATA,
+				sizeof(ev), &ev);
+	}
+}
+
+static void remove_advertising_cb(uint8_t status, void *user_data)
+{
+	struct addrm_adv_cb_data *cb_data = user_data;
+	struct hal_ev_gatt_client_multi_adv_data ev = {
+		.status = status,
+		.client_if = cb_data->client_if,
+	};
+
+	free_adv_instance(cb_data->adv);
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+				HAL_EV_GATT_CLIENT_MULTI_ADV_DISABLE,
+				sizeof(ev), &ev);
+
+	free(cb_data);
 }
 
 static void handle_client_disable_multi_adv_inst(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_disable_multi_adv_inst *cmd = buf;
+	struct adv_instance *adv;
+	struct gatt_app *app;
+	struct addrm_adv_cb_data *cb_data = NULL;
+	uint8_t status = HAL_STATUS_FAILED;
 
 	DBG("client_if %d", cmd->client_if);
 
-	/* TODO */
+	adv = find_adv_instance(cmd->client_if);
+	if (!adv)
+		goto out;
+
+	cb_data = new0(typeof(*cb_data), 1);
+	cb_data->client_if = cmd->client_if;
+	cb_data->adv = adv;
+
+	if (!bt_le_remove_advertising(adv, remove_advertising_cb, cb_data)) {
+		error("gatt: Could not remove advertising");
+		free(cb_data);
+		goto out;
+	}
 
+	app = find_app_by_id(cmd->client_if);
+	if (app)
+		app->adv = NULL;
+
+	status = HAL_STATUS_SUCCESS;
+
+out:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 				HAL_OP_GATT_CLIENT_DISABLE_MULTI_ADV_INST,
-				HAL_STATUS_UNSUPPORTED);
+				status);
+
+	if (status != HAL_STATUS_SUCCESS) {
+		struct hal_ev_gatt_client_multi_adv_data ev = {
+			.status = status,
+			.client_if = cmd->client_if,
+		};
+
+		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+				HAL_EV_GATT_CLIENT_MULTI_ADV_DISABLE,
+				sizeof(ev), &ev);
+	}
 }
 
 static void handle_client_configure_batchscan(const void *buf, uint16_t len)
@@ -5824,7 +6174,7 @@ static const struct ipc_handler cmd_handlers[] = {
 	{ handle_client_update_multi_adv, false,
 		sizeof(struct hal_cmd_gatt_client_update_multi_adv) },
 	/* HAL_OP_GATT_CLIENT_SETUP_MULTI_ADV_INST */
-	{ handle_client_setup_multi_adv_inst, false,
+	{ handle_client_setup_multi_adv_inst, true,
 		sizeof(struct hal_cmd_gatt_client_setup_multi_adv_inst) },
 	/* HAL_OP_GATT_CLIENT_DISABLE_MULTI_ADV_INST */
 	{ handle_client_disable_multi_adv_inst, false,

