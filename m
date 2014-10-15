Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/5] android/map-client: Add support for get remote MAS instances
Date: Wed, 15 Oct 2014 16:27:59 +0200
Message-Id: <1413383281-17292-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1413383281-17292-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1413383281-17292-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to get remote mas instances. In case of wrong sdp record
fail status will be returned in notification.
---
 android/map-client.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 1 deletion(-)

diff --git a/android/map-client.c b/android/map-client.c
index 142c680..12f600b 100644
--- a/android/map-client.c
+++ b/android/map-client.c
@@ -30,21 +30,150 @@
 #include <stdint.h>
 #include <glib.h>
 
+#include "lib/sdp.h"
+#include "lib/sdp_lib.h"
+#include "src/sdp-client.h"
+
 #include "ipc.h"
 #include "lib/bluetooth.h"
 #include "map-client.h"
 #include "src/log.h"
 #include "hal-msg.h"
+#include "ipc-common.h"
+#include "utils.h"
+#include "src/shared/util.h"
 
 static struct ipc *hal_ipc = NULL;
 static bdaddr_t adapter_addr;
 
+static int fill_mce_inst(void *buf, int32_t id, int32_t scn, int32_t msg_type,
+					const void *name, uint8_t name_len)
+{
+	struct hal_map_client_mas_instance *inst = buf;
+
+	inst->id = id;
+	inst->scn = scn;
+	inst->msg_types = msg_type;
+	inst->name_len = name_len;
+
+	if (name_len)
+		memcpy(inst->name, name, name_len);
+
+	return sizeof(*inst) + name_len;
+}
+
+static void map_client_sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
+{
+	uint8_t buf[IPC_MTU];
+	struct hal_ev_map_client_remote_mas_instances *ev = (void *) buf;
+	bdaddr_t *dst = data;
+	sdp_list_t *list, *protos;
+	uint8_t status;
+	int32_t id, scn, msg_type, name_len, num_instances = 0;
+	char *name;
+	size_t size;
+
+	size = sizeof(*ev);
+	bdaddr2android(dst, &ev->bdaddr);
+
+	if (err < 0) {
+		error("mce: Unable to get SDP record: %s", strerror(-err));
+		status = HAL_STATUS_FAILED;
+		goto fail;
+	}
+
+	for (list = recs; list != NULL; list = list->next) {
+		sdp_record_t *rec = list->data;
+		sdp_data_t *data;
+
+		data = sdp_data_get(rec, SDP_ATTR_MAS_INSTANCE_ID);
+		if (!data) {
+			error("mce: cannot get mas instance id");
+			continue;
+		}
+
+		id = data->val.uint8;
+
+		data = sdp_data_get(rec, SDP_ATTR_SVCNAME_PRIMARY);
+		if (!data) {
+			error("mce: cannot get mas instance name");
+			continue;
+		}
+
+		name = data->val.str;
+		name_len = data->unitSize;
+
+		data = sdp_data_get(rec, SDP_ATTR_SUPPORTED_MESSAGE_TYPES);
+		if (!data) {
+			error("mce: cannot get mas instance msg type");
+			continue;
+		}
+
+		msg_type = data->val.uint8;
+
+		if (sdp_get_access_protos(rec, &protos) < 0) {
+			error("mce: cannot get mas instance sdp protocol list");
+			continue;
+		}
+
+		scn = sdp_get_proto_port(protos, RFCOMM_UUID);
+
+		sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free, NULL);
+		sdp_list_free(protos, NULL);
+
+		if (!scn) {
+			error("mce: cannot get mas instance rfcomm channel");
+			continue;
+		}
+
+		size += fill_mce_inst(buf + size, id, scn, msg_type, name,
+								name_len);
+		num_instances++;
+	}
+
+	status = HAL_STATUS_SUCCESS;
+
+fail:
+	ev->num_instances = num_instances;
+	ev->status = status;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_MAP_CLIENT,
+			HAL_EV_MAP_CLIENT_REMOTE_MAS_INSTANCES, size, buf);
+
+	free(dst);
+}
+
 static void handle_get_instances(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_map_client_get_instances *cmd = buf;
+	uint8_t status;
+	bdaddr_t *dst;
+	uuid_t uuid;
+
 	DBG("");
 
+	dst = new0(bdaddr_t, 1);
+	if (!dst) {
+		error("mce: Fail to allocate cb data");
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	android2bdaddr(&cmd->bdaddr, dst);
+	sdp_uuid16_create(&uuid, MAP_MSE_SVCLASS_ID);
+
+	if (bt_search_service(&adapter_addr, dst, &uuid,
+				map_client_sdp_search_cb, dst, free, 0)) {
+		error("mce: Failed to search SDP details");
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_MAP_CLIENT,
-			HAL_OP_MAP_CLIENT_GET_INSTANCES, HAL_STATUS_FAILED);
+				HAL_OP_MAP_CLIENT_GET_INSTANCES, status);
 }
 
 static const struct ipc_handler cmd_handlers[] = {
-- 
1.9.3

