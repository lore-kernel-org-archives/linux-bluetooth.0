Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCHv2 4/5] android: Initial implementation of get_remote_services
Date: Mon, 4 Nov 2013 08:30:33 +0100
Message-ID: <1383550234-14790-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1383550234-14790-1-git-send-email-marcin.kraglak@tieto.com>
References: <1383550234-14790-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

diff --git a/android/adapter.c b/android/adapter.c
index 8df59e6..689dd54 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -35,6 +35,10 @@
 #include "src/shared/mgmt.h"
 #include "src/glib-helper.h"
 #include "src/eir.h"
+#include "lib/sdp.h"
+#include "lib/sdp_lib.h"
+#include "lib/uuid.h"
+#include "src/sdp-client.h"
 #include "log.h"
 #include "hal-msg.h"
 #include "ipc.h"
@@ -45,6 +49,8 @@
 #define DEFAULT_IO_CAPABILITY 0x01
 
 static GIOChannel *notification_io = NULL;
+/* This list contains addresses which are asked for records */
+static GList *sdp_req_list;
 
 struct bt_adapter {
 	uint16_t index;
@@ -63,6 +69,20 @@ struct bt_adapter {
 	bool discovering;
 };
 
+struct browse_req {
+	bdaddr_t *bdaddr;
+	GSList *uuids;
+	int search_uuid;
+	int reconnect_attempt;
+};
+
+static const uint16_t uuid_list[] = {
+	L2CAP_UUID,
+	PNP_INFO_SVCLASS_ID,
+	PUBLIC_BROWSE_GROUP,
+	0
+};
+
 static struct bt_adapter *adapter;
 static GSList *found_devices = NULL;
 
@@ -1459,9 +1479,80 @@ static uint8_t ssp_reply(void *buf, uint16_t len)
 	return status;
 }
 
+static void browse_req_free(struct browse_req *req)
+{
+	g_free(req->bdaddr);
+	g_slist_free_full(req->uuids, g_free);
+	g_free(req);
+}
+
+static void update_records(struct browse_req *req, sdp_list_t *recs)
+{
+	/* TODO cache found uuids */
+}
+
+static void browse_cb(sdp_list_t *recs, int err, gpointer user_data)
+{
+	struct browse_req *req = user_data;
+	uuid_t uuid;
+
+	/* If we have a valid response and req->search_uuid == 2, then L2CAP
+	 * UUID & PNP searching was successful -- we are done */
+	if (err < 0 || req->search_uuid == 2) {
+		if (err == -ECONNRESET && req->reconnect_attempt < 1) {
+			req->search_uuid--;
+			req->reconnect_attempt++;
+		} else {
+			goto done;
+		}
+	}
+
+	update_records(req, recs);
+
+	/* Search for mandatory uuids */
+	if (uuid_list[req->search_uuid]) {
+		sdp_uuid16_create(&uuid, uuid_list[req->search_uuid++]);
+		bt_search_service(&adapter->bdaddr, req->bdaddr, &uuid,
+						browse_cb, user_data, NULL);
+		return;
+	}
+
+done:
+	sdp_req_list = g_list_remove(sdp_req_list, req->bdaddr);
+	browse_req_free(req);
+}
+
 static uint8_t get_remote_services(void *buf, uint16_t len)
 {
-	return HAL_STATUS_UNSUPPORTED;
+	struct hal_cmd_get_remote_services *cmd = buf;
+	struct browse_req *req;
+	bdaddr_t *addr;
+	uuid_t uuid;
+	int err;
+
+	addr = g_new0(bdaddr_t, 1);
+	android2bdaddr(&cmd->bdaddr, addr);
+
+	if (g_list_find_custom(sdp_req_list, addr, bdaddr_cmp)) {
+		g_free(addr);
+		return HAL_STATUS_DONE;
+	}
+
+	sdp_req_list = g_list_append(sdp_req_list, addr);
+
+	req = g_new0(struct browse_req, 1);
+	req->bdaddr = addr;
+	sdp_uuid16_create(&uuid, uuid_list[req->search_uuid++]);
+
+	err = bt_search_service(&adapter->bdaddr,
+			req->bdaddr, &uuid, browse_cb, req, NULL);
+	if (err) {
+		sdp_req_list = g_list_remove(sdp_req_list, req->bdaddr);
+		browse_req_free(req);
+		return HAL_STATUS_FAILED;
+	}
+
+	return HAL_STATUS_SUCCESS;
 }
 
 void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
-- 
1.8.4.1

