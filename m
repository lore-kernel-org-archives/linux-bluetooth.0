Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] android/bluetooth: Add support for get remote service record property cmd
Date: Wed, 13 Aug 2014 15:44:36 +0200
Message-Id: <1407937477-25402-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1407937477-25402-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1407937477-25402-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to get service record property by uuid of specified remote device.
---
 android/bluetooth.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 119 insertions(+), 3 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 699e880..8d27b0a 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -38,6 +38,7 @@
 #include "lib/bluetooth.h"
 #include "lib/sdp.h"
 #include "lib/mgmt.h"
+#include "lib/uuid.h"
 #include "src/shared/util.h"
 #include "src/shared/mgmt.h"
 #include "src/eir.h"
@@ -1067,6 +1068,117 @@ static uint8_t browse_remote_sdp(const bdaddr_t *addr)
 	return HAL_STATUS_SUCCESS;
 }
 
+static void send_remote_sdp_rec_notify(bt_uuid_t *uuid, int channel,
+					char *name, uint8_t name_len,
+					uint8_t status, bdaddr_t *bdaddr)
+{
+	struct hal_prop_device_service_rec *prop;
+	uint8_t buf[BASELEN_REMOTE_DEV_PROP + name_len + sizeof(*prop)];
+	struct hal_ev_remote_device_props *ev = (void *) buf;
+	int prop_len = sizeof(*prop) + name_len;
+
+	memset(buf, 0, sizeof(buf));
+
+	if (status == HAL_STATUS_SUCCESS) {
+		prop = malloc(sizeof(*prop) + name_len);
+		prop->name_len = name_len;
+		prop->channel = (uint16_t)channel;
+		memcpy(prop->name, name, name_len);
+		memcpy(prop->uuid, &uuid->value.u128, sizeof(prop->uuid));
+
+		memcpy(ev->props[0].val, prop, prop_len);
+
+		free(prop);
+	}
+
+	ev->num_props = 1;
+	ev->status = status;
+	ev->props[0].len = prop_len;
+	bdaddr2android(bdaddr, ev->bdaddr);
+	ev->props[0].type = HAL_PROP_DEVICE_SERVICE_REC;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
+						HAL_EV_REMOTE_DEVICE_PROPS,
+						sizeof(buf), buf);
+}
+
+static void find_remote_sdp_rec_cb(sdp_list_t *recs, int err,
+							gpointer user_data)
+{
+	uint8_t name_len = 0;
+	uint8_t status;
+	char name_buf[256];
+	int channel = 0;
+	bdaddr_t *addr = user_data;
+	bt_uuid_t uuid;
+	uuid_t uuid128_sdp;
+	sdp_list_t *protos;
+	sdp_record_t *sdp_rec;
+
+	if (err < 0) {
+		error("error while search remote sdp records");
+		status = HAL_STATUS_FAILED;
+		send_remote_sdp_rec_notify(NULL, 0, NULL, 0, status, addr);
+	}
+
+	for ( ; recs; recs = recs->next) {
+		sdp_rec = recs->data;
+
+		switch (sdp_rec->svclass.type) {
+		case SDP_UUID16:
+			sdp_uuid16_to_uuid128(&uuid128_sdp,
+							&sdp_rec->svclass);
+			break;
+		case SDP_UUID32:
+			sdp_uuid32_to_uuid128(&uuid128_sdp,
+							&sdp_rec->svclass);
+			break;
+		default:
+			break;
+		}
+
+		if (!sdp_get_access_protos(sdp_rec, &protos)) {
+			channel = sdp_get_proto_port(protos, L2CAP_UUID);
+			if (channel < 0)
+				error("wrong channel");
+		}
+
+		if (!sdp_get_service_name(sdp_rec, name_buf, sizeof(name_buf)))
+			name_len = (uint8_t)strlen(name_buf);
+
+		uuid.type = BT_UUID128;
+		memcpy(&uuid.value.u128, uuid128_sdp.value.uuid128.data,
+						sizeof(uuid.value.u128));
+		status = HAL_STATUS_SUCCESS;
+
+		send_remote_sdp_rec_notify(&uuid, channel, name_buf, name_len,
+								status, addr);
+	}
+
+	free(addr);
+}
+
+static uint8_t find_remote_sdp_rec(const bdaddr_t *addr,
+						const uint8_t *find_uuid)
+{
+	uuid_t uuid;
+	bdaddr_t *bdaddr;
+
+	/* from android we always get full 128bit length uuid */
+	sdp_uuid128_create(&uuid, find_uuid);
+
+	bdaddr = malloc(sizeof(*bdaddr));
+	memcpy(bdaddr, addr, sizeof(*bdaddr));
+
+	if (bt_search_service(&adapter.bdaddr, addr, &uuid,
+				find_remote_sdp_rec_cb, bdaddr, NULL, 0) < 0) {
+		free(bdaddr);
+		return HAL_STATUS_FAILED;
+	}
+
+	return HAL_STATUS_SUCCESS;
+}
+
 static void new_link_key_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -4746,12 +4858,16 @@ failed:
 
 static void handle_get_remote_service_rec_cmd(const void *buf, uint16_t len)
 {
-	/* TODO */
+	const struct hal_cmd_get_remote_service_rec *cmd = buf;
+	uint8_t status;
+	bdaddr_t addr;
+
+	android2bdaddr(&cmd->bdaddr, &addr);
 
-	error("get_remote_service_record not supported");
+	status = find_remote_sdp_rec(&addr, cmd->uuid);
 
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
-			HAL_OP_GET_REMOTE_SERVICE_REC, HAL_STATUS_FAILED);
+					HAL_OP_GET_REMOTE_SERVICE_REC, status);
 }
 
 static void handle_start_discovery_cmd(const void *buf, uint16_t len)
-- 
1.9.3

