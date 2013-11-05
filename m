Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCHv2 1/6] android: Initial implementation of get_remote_services
Date: Tue, 5 Nov 2013 14:21:35 +0100
Message-ID: <1383657700-22313-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1383657700-22313-1-git-send-email-marcin.kraglak@tieto.com>
References: <1383657700-22313-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements method to retrieve remote device sdp records.
Caching struct is implemented for adding fetched uuids to list.
sdp_req_list will contain list of devices which are asked for records.
Function get_remote_services will check if device is on list, and will
start sdp procedure.

---
 android/adapter.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/android/adapter.c b/android/adapter.c
index 074fc68..40fb89d 100644
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
+static GSList *browse_reqs;
 
 struct bt_adapter {
 	uint16_t index;
@@ -63,6 +69,20 @@ struct bt_adapter {
 	bool discovering;
 };
 
+struct browse_req {
+	bdaddr_t bdaddr;
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
 
@@ -262,6 +282,79 @@ static void send_bond_state_change(const bdaddr_t *addr, uint8_t status,
 			HAL_EV_BOND_STATE_CHANGED, sizeof(ev), &ev, -1);
 }
 
+static void browse_req_free(struct browse_req *req)
+{
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
+		bt_search_service(&adapter->bdaddr, &req->bdaddr, &uuid,
+						browse_cb, user_data, NULL);
+		return;
+	}
+
+done:
+	browse_reqs = g_slist_remove(browse_reqs, req);
+	browse_req_free(req);
+}
+
+static int req_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct browse_req *req = a;
+	const bdaddr_t *bdaddr = b;
+
+	return bacmp(&req->bdaddr, bdaddr);
+}
+
+static uint8_t browse_remote_sdp(const bdaddr_t *addr)
+{
+	struct browse_req *req;
+	uuid_t uuid;
+
+	if (g_slist_find_custom(browse_reqs, addr, req_cmp))
+		return HAL_STATUS_DONE;
+
+	req = g_new0(struct browse_req, 1);
+	bacpy(&req->bdaddr, addr);
+	sdp_uuid16_create(&uuid, uuid_list[req->search_uuid++]);
+
+	if (bt_search_service(&adapter->bdaddr,
+			&req->bdaddr, &uuid, browse_cb, req, NULL) < 0) {
+		browse_req_free(req);
+		return false;
+	}
+
+	browse_reqs = g_slist_append(browse_reqs, req);
+
+	return HAL_STATUS_SUCCESS;
+}
+
 static void new_link_key_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -1482,7 +1575,12 @@ static uint8_t ssp_reply(void *buf, uint16_t len)
 
 static uint8_t get_remote_services(void *buf, uint16_t len)
 {
-	return HAL_STATUS_UNSUPPORTED;
+	struct hal_cmd_get_remote_services *cmd = buf;
+	bdaddr_t addr;
+
+	android2bdaddr(&cmd->bdaddr, &addr);
+
+	return browse_remote_sdp(&addr);
 }
 
 void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
-- 
1.8.4.1

