Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 5/9] android/gatt: Handle get descriptor client command
Date: Fri, 28 Mar 2014 19:54:41 +0100
Message-Id: <1396032885-32077-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1396032885-32077-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1396032885-32077-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds basic get characteristic descriptor command handling.
In case of no descriptor proper notification with bad status is being
sent.
---
 android/gatt.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index be38f66..fec55d4 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -31,6 +31,7 @@
 #include <glib.h>
 #include <errno.h>
 #include <sys/socket.h>
+#include <assert.h>
 
 #include "ipc.h"
 #include "ipc-common.h"
@@ -1395,12 +1396,87 @@ done:
 				HAL_OP_GATT_CLIENT_GET_CHARACTERISTIC, status);
 }
 
+static void send_client_descr_notify(int32_t status, int32_t conn_id,
+						const struct descriptor *descr,
+						const struct service *srvc,
+						const struct characteristic *ch)
+{
+	struct hal_ev_gatt_client_get_descriptor ev;
+
+	memset(&ev, 0, sizeof(ev));
+
+	ev.status = status;
+	ev.conn_id = conn_id;
+
+	if (descr) {
+		ev.descr_id.inst_id = descr->id.instance;
+		uuid2android(&descr->id.uuid, ev.descr_id.uuid);
+	}
+
+	if (srvc) {
+		/* TODO: handle included services */
+		ev.srvc_id.is_primary = 1;
+		ev.srvc_id.inst_id = srvc->id.instance;
+		uuid2android(&srvc->id.uuid, ev.srvc_id.uuid);
+	}
+
+	if (ch) {
+		ev.char_id.inst_id = ch->id.instance;
+		uuid2android(&ch->id.uuid, ev.char_id.uuid);
+	}
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_EV_GATT_CLIENT_GET_DESCRIPTOR,
+					sizeof(ev), &ev);
+}
+
 static void handle_client_get_descriptor(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_get_descriptor *cmd = buf;
+	struct characteristic *ch = NULL;
+	struct descriptor *descr = NULL;
+	struct service *srvc = NULL;
+	struct element_id match_id;
+	struct gatt_device *dev;
+	int32_t conn_id = 0;
+	uint8_t status;
+
 	DBG("");
 
+	assert(cmd->number);
+
+	if (len != sizeof(*cmd) + cmd->number * sizeof(cmd->gatt_id[0])) {
+		error("gatt: Get descr. bad cmd size (%u b), terminating", len);
+		raise(SIGTERM);
+		return;
+	}
+
+	hal_srvc_id_to_element_id(&cmd->srvc_id, &match_id);
+	if (!find_service(cmd->conn_id, &match_id, &dev, &srvc)) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	conn_id = dev->conn_id;
+
+	hal_gatt_id_to_element_id(&cmd->gatt_id[0], &match_id);
+	ch = queue_find(srvc->chars, match_char_by_element_id, &match_id);
+	if (!ch) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	if (queue_isempty(ch->descriptors)) {
+		/* TODO: Cache descriptors */
+	}
+
+	/* TODO: Send from cache */
+	send_client_descr_notify(GATT_FAILURE, conn_id, descr, srvc, ch);
+
+	status = HAL_STATUS_SUCCESS;
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_CLIENT_GET_DESCRIPTOR, HAL_STATUS_FAILED);
+				HAL_OP_GATT_CLIENT_GET_DESCRIPTOR, status);
 }
 
 struct read_char_data {
-- 
1.9.0

