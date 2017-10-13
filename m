Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH V2 BLueZ 3/3] android: Enable multiadvertising
To: linux-bluetooth@vger.kernel.org
From: Martin Fuzzey <mfuzzey@parkeon.com>
Date: Fri, 13 Oct 2017 16:02:10 +0200
Message-ID: <20171013140210.19524.48280.stgit@localhost>
In-Reply-To: <20171013140204.19524.68439.stgit@localhost>
References: <20171013140204.19524.68439.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is required for custom advertising data.

The HAL entry points related to multiadvertising are now implemented
and map to the mgmnt "add advertising" operation.
---
 android/Android.mk  |    1 
 android/bluetooth.c |  129 +++++++++++++++++++++
 android/bluetooth.h |   25 ++++
 android/gatt.c      |  309 +++++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 454 insertions(+), 10 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index 38ef4aa..76a826b 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -72,6 +72,7 @@ LOCAL_SRC_FILES := \
 	bluez/src/shared/crypto.c \
 	bluez/src/shared/uhid.c \
 	bluez/src/shared/att.c \
+	bluez/src/shared/ad.c \
 	bluez/src/sdpd-database.c \
 	bluez/src/sdpd-service.c \
 	bluez/src/sdpd-request.c \
diff --git a/android/bluetooth.c b/android/bluetooth.c
index b5a2eab..c8468e1 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -42,6 +42,7 @@
 #include "src/shared/util.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/queue.h"
+#include "src/shared/ad.h"
 #include "src/eir.h"
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
@@ -4019,6 +4020,134 @@ bool bt_le_set_advertising(bool advertising, bt_le_set_advertising_done cb,
 	return false;
 }
 
+struct addrm_adv_user_data {
+	bt_le_addrm_advertising_done cb;
+	void *user_data;
+};
+
+static void add_advertising_cb(uint8_t status, uint16_t length,
+			       const void *param, void *user_data)
+{
+	struct addrm_adv_user_data *data = user_data;
+
+	DBG("");
+
+	if (status)
+		error("Failed to add advertising %s (0x%02x))",
+				mgmt_errstr(status), status);
+
+	data->cb(status, data->user_data);
+}
+
+bool bt_le_add_advertising(struct adv_instance *adv,
+			   bt_le_addrm_advertising_done cb, void *user_data)
+{
+	struct mgmt_cp_add_advertising *cp;
+	struct addrm_adv_user_data *cb_data;
+	size_t len;
+	size_t adv_data_len = 0;
+	size_t sr_data_len = 0;
+	uint8_t *dst, *adv_data, *sr_data;
+	bool ok = false;
+
+	/* These accept NULL and return NULL */
+	adv_data = bt_ad_generate(adv->ad, &adv_data_len);
+	sr_data = bt_ad_generate(adv->sr, &sr_data_len);
+
+	len = sizeof(*cp) + adv_data_len + sr_data_len;
+	cp = malloc0(len);
+	if (!cp)
+		goto out;
+
+	cp->instance = adv->instance;
+	cp->timeout = adv->timeout;
+	/* XXX: how should we set duration? (kernel defaults to 2s) */
+
+	switch (adv->type) {
+	case ANDROID_ADVERTISING_EVENT_TYPE_CONNECTABLE:
+		cp->flags |= MGMT_ADV_FLAG_CONNECTABLE;
+		break;
+
+	case ANDROID_ADVERTISING_EVENT_TYPE_SCANNABLE:
+	case ANDROID_ADVERTISING_EVENT_TYPE_NON_CONNECTABLE:
+	default:
+		break;
+	}
+
+	if (adv->include_tx_power)
+		cp->flags |= MGMT_ADV_FLAG_TX_POWER;
+
+	dst = cp->data;
+	if (adv_data) {
+		cp->adv_data_len = adv_data_len;
+		memcpy(dst, adv_data, adv_data_len);
+		dst += adv_data_len;
+	}
+
+	if (sr_data) {
+		cp->scan_rsp_len = sr_data_len;
+		memcpy(dst, sr_data, sr_data_len);
+		dst += sr_data_len;
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
+out:
+	free(adv_data);
+	free(sr_data);
+	free(cp);
+
+	return ok;
+}
+
+static void remove_advertising_cb(uint8_t status, uint16_t length,
+				  const void *param, void *user_data)
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
+			      bt_le_addrm_advertising_done cb, void *user_data)
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
+			sizeof(cp), &cp,
+			remove_advertising_cb, cb_data, free) > 0);
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
index 4b17209..b139cb1 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -88,3 +88,28 @@ typedef void (*bt_paired_device_cb)(const bdaddr_t *addr);
 bool bt_paired_register(bt_paired_device_cb cb);
 void bt_paired_unregister(bt_paired_device_cb cb);
 bool bt_is_pairing(const bdaddr_t *addr);
+
+struct bt_ad;
+struct adv_instance {
+	uint8_t	instance;
+	int32_t timeout;
+	int32_t type;
+	struct bt_ad *ad;
+	struct bt_ad *sr;
+	unsigned include_tx_power:1;
+};
+
+/* Values below have no C API definition - only in Java (AdvertiseManager.java)
+ * and bluedroid
+ */
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
diff --git a/android/gatt.c b/android/gatt.c
index 28635ed..6b36985 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -46,6 +46,7 @@
 #include "src/shared/queue.h"
 #include "src/shared/att.h"
 #include "src/shared/gatt-db.h"
+#include "src/shared/ad.h"
 #include "attrib/gattrib.h"
 #include "attrib/att.h"
 #include "attrib/gatt.h"
@@ -110,6 +111,8 @@ struct gatt_app {
 	struct queue *notifications;
 
 	gatt_conn_cb_t func;
+
+	struct adv_instance *adv;
 };
 
 struct element_id {
@@ -192,6 +195,7 @@ static struct ipc *hal_ipc = NULL;
 static bdaddr_t adapter_addr;
 static bool scanning = false;
 static unsigned int advertising_cnt = 0;
+static uint32_t adv_inst_bits = 0;
 
 static struct queue *gatt_apps = NULL;
 static struct queue *gatt_devices = NULL;
@@ -650,6 +654,19 @@ static void connection_cleanup(struct gatt_device *device)
 		bt_auto_connect_remove(&device->bdaddr);
 }
 
+static void free_adv_instance(struct adv_instance *adv)
+{
+	if (!adv)
+		return;
+
+	if (adv->instance)
+		adv_inst_bits &= ~(1 << (adv->instance - 1));
+
+	bt_ad_unref(adv->ad);
+	bt_ad_unref(adv->sr);
+	free(adv);
+}
+
 static void destroy_gatt_app(void *data)
 {
 	struct gatt_app *app = data;
@@ -674,6 +691,8 @@ static void destroy_gatt_app(void *data)
 
 	queue_destroy(app->notifications, free);
 
+	free_adv_instance(app->adv);
+
 	free(app);
 }
 
@@ -5586,19 +5605,162 @@ static void handle_client_set_scan_param(const void *buf, uint16_t len)
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
+	for (i = 0; i < sizeof(adv_inst_bits) * 8; i++) {
+		uint32_t mask = 1 << i;
+
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
+/* Build advertising data object from a data buffer containing
+ * manufacturer_data, service_data, service uuids (in that order)
+ * The input data is raw with no TLV structure and the service uuids are 128 bit
+ */
+static struct bt_ad *build_adv_data(int32_t manufacturer_data_len,
+					int32_t service_data_len,
+					int32_t service_uuid_len,
+					const uint8_t *data_in)
+{
+	const int one_svc_uuid_len = 128 / 8;  /* Android uses 128bit UUIDs */
+	uint8_t *src = (uint8_t *)data_in;
+	struct bt_ad *ad;
+	unsigned num_svc_uuids, i;
+
+	ad = bt_ad_new();
+
+	if (manufacturer_data_len >= 2) { /* Includes manufacturer id */
+		uint16_t manufacturer_id;
+
+		manufacturer_id = bt_get_le16(src);
+		src += 2;
+
+		if (!bt_ad_add_manufacturer_data(ad,
+						 manufacturer_id,
+						 src,
+						 manufacturer_data_len - 2))
+			goto err;
+
+		src +=  manufacturer_data_len - 2;
+	}
+
+	if (service_data_len >= 2) { /* Includes service uuid (always 16 bit) */
+		bt_uuid_t bt_uuid;
+		uint16_t uuid16;
+
+		uuid16 = bt_get_le16(src);
+		src += 2;
+		bt_uuid16_create(&bt_uuid, uuid16);
+
+		if (!bt_ad_add_service_data(ad,
+					    &bt_uuid,
+					    src,
+					    service_data_len - 2))
+			goto err;
+
+		src += service_data_len - 2;
+	}
+
+	if (service_uuid_len % one_svc_uuid_len) {
+		error("Service UUIDs not multiple of %d bytes (%d)",
+			one_svc_uuid_len, service_uuid_len);
+		num_svc_uuids = 0;
+	} else {
+		num_svc_uuids = service_uuid_len / one_svc_uuid_len;
+	}
+
+	for (i = 0; i  < num_svc_uuids; i++) {
+		bt_uuid_t bt_uuid;
+
+		android2uuid(src, &bt_uuid);
+		src += one_svc_uuid_len;
+
+		if (!bt_ad_add_service_uuid(ad, &bt_uuid))
+			goto err;
+	}
+
+	return ad;
+
+err:
+	bt_ad_unref(ad);
+	return NULL;
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
+		bt_ad_unref(adv->sr);
+		adv->sr = NULL;
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
@@ -5612,30 +5774,157 @@ static void handle_client_update_multi_adv(const void *buf, uint16_t len)
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
+	struct bt_ad *adv_data;
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
+	adv_data = build_adv_data(cmd->manufacturer_data_len,
+				  cmd->service_data_len,
+				  cmd->service_uuid_len,
+				  cmd->data_service_uuid);
+	if (!adv_data)
+		goto out;
+
+	if (cmd->set_scan_rsp) {
+		bt_ad_unref(adv->sr);
+		adv->sr = adv_data;
+	} else {
+		bt_ad_unref(adv->ad);
+		adv->ad = adv_data;
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
+
+	app = find_app_by_id(cmd->client_if);
+	if (app)
+		app->adv = NULL;
 
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
@@ -5824,7 +6113,7 @@ static const struct ipc_handler cmd_handlers[] = {
 	{ handle_client_update_multi_adv, false,
 		sizeof(struct hal_cmd_gatt_client_update_multi_adv) },
 	/* HAL_OP_GATT_CLIENT_SETUP_MULTI_ADV_INST */
-	{ handle_client_setup_multi_adv_inst, false,
+	{ handle_client_setup_multi_adv_inst, true,
 		sizeof(struct hal_cmd_gatt_client_setup_multi_adv_inst) },
 	/* HAL_OP_GATT_CLIENT_DISABLE_MULTI_ADV_INST */
 	{ handle_client_disable_multi_adv_inst, false,

