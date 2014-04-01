Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 2/5] android/gatt: Handle get descriptor client command
Date: Tue,  1 Apr 2014 17:19:24 +0200
Message-Id: <1396365567-17339-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1396365567-17339-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1396365567-17339-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds basic get characteristic descriptor command handling. In case
of no descriptor, proper notification with bad status is being sent.
---
 android/gatt.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 0e63df5..b496d8a 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -31,6 +31,7 @@
 #include <glib.h>
 #include <errno.h>
 #include <sys/socket.h>
+#include <assert.h>
 
 #include "ipc.h"
 #include "ipc-common.h"
@@ -1419,12 +1420,95 @@ done:
 				HAL_OP_GATT_CLIENT_GET_CHARACTERISTIC, status);
 }
 
+static void send_client_descr_notify(int32_t status, int32_t conn_id,
+					bool primary,
+					const struct element_id *srvc,
+					const struct element_id *ch,
+					const struct element_id *opt_descr)
+{
+	struct hal_ev_gatt_client_get_descriptor ev;
+
+	memset(&ev, 0, sizeof(ev));
+
+	ev.status = status;
+	ev.conn_id = conn_id;
+
+	element_id_to_hal_srvc_id(srvc, primary, &ev.srvc_id);
+	element_id_to_hal_gatt_id(ch, &ev.char_id);
+
+	if (opt_descr)
+		element_id_to_hal_gatt_id(opt_descr, &ev.descr_id);
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_CLIENT_GET_DESCRIPTOR, sizeof(ev), &ev);
+}
+
 static void handle_client_get_descriptor(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_get_descriptor *cmd = buf;
+	struct descriptor *descr = NULL;
+	struct characteristic *ch;
+	struct service *srvc;
+	struct element_id srvc_id;
+	struct element_id char_id;
+	struct gatt_device *dev;
+	int32_t conn_id;
+	uint8_t primary;
+	uint8_t status;
+
 	DBG("");
 
+	if (len != sizeof(*cmd) + cmd->number * sizeof(cmd->gatt_id[0])) {
+		error("gatt: Get descr. bad cmd size (%u b), terminating", len);
+
+		raise(SIGTERM);
+		return;
+	}
+
+	assert(cmd->number);
+
+	conn_id = cmd->conn_id;
+	primary = cmd->srvc_id.is_primary;
+
+	hal_srvc_id_to_element_id(&cmd->srvc_id, &srvc_id);
+	hal_gatt_id_to_element_id(&cmd->gatt_id[0], &char_id);
+
+	if (!find_service(conn_id, &srvc_id, &dev, &srvc)) {
+		error("gatt: Get descr. could not find service.");
+
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	ch = queue_find(srvc->chars, match_char_by_element_id, &char_id);
+	if (!ch) {
+		error("gatt: Get descr. could not find characteristic.");
+
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+
+	if (queue_isempty(ch->descriptors)) {
+		/* TODO: Build the cache */
+
+		ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_GET_DESCRIPTOR,
+					HAL_STATUS_FAILED);
+		return;
+	}
+
+	status = HAL_STATUS_FAILED;
+
+	/* TODO: Send from cache */
+
+failed:
+	send_client_descr_notify(descr ? GATT_SUCCESS : GATT_FAILURE, conn_id,
+						primary, &srvc_id, &char_id,
+						&descr->id);
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_CLIENT_GET_DESCRIPTOR, HAL_STATUS_FAILED);
+				HAL_OP_GATT_CLIENT_GET_DESCRIPTOR, status);
 }
 
 struct read_char_data {
-- 
1.9.0

