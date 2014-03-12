Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/4] android/gatt: Use Core profile for LE scan
Date: Wed, 12 Mar 2014 15:43:55 +0100
Message-Id: <1394635435-26646-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1394635435-26646-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1394635435-26646-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes gatt capable of triggering LE scan using functionality
exposed by Core API. GATT registers its own callbacks for discovering
events.
---
 android/gatt.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 93 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index a874737..27cc98d 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -32,10 +32,12 @@
 
 #include "ipc.h"
 #include "ipc-common.h"
-#include "lib/bluetooth.h"
+#include "lib/sdp.h"
+#include "bluetooth.h"
 #include "gatt.h"
 #include "src/log.h"
 #include "hal-msg.h"
+#include "utils.h"
 #include "src/shared/util.h"
 
 struct gatt_client {
@@ -46,6 +48,7 @@ struct gatt_client {
 static struct ipc *hal_ipc = NULL;
 static bdaddr_t adapter_addr;
 static GSList *gatt_clients = NULL;
+static GSList *scan_clients = NULL;
 
 static int find_client_by_uuid(gconstpointer data, gconstpointer user_data)
 {
@@ -107,6 +110,50 @@ failed:
 					HAL_OP_GATT_CLIENT_REGISTER, status);
 }
 
+static bool set_client_scan(int32_t client_if, bool do_start)
+{
+	bool expected_on_scanlist = !do_start;
+	gpointer found_if;
+	bool is_registered = false;
+
+	/* TODO: Consider ignoring not registered clients unlike bluedroid. */
+	if (g_slist_find_custom(gatt_clients, INT_TO_PTR(client_if),
+							find_client_by_id))
+		is_registered = true;
+
+	/*
+	 * Ignore scan requests from already scanning interfaces, end ignore
+	 * stop requests from not scanning ones.
+	 */
+	found_if = g_slist_find(scan_clients, INT_TO_PTR(client_if));
+
+	if (!!found_if != expected_on_scanlist) {
+		error("gatt: Scan already %sed", do_start ? "start" : "stopp");
+		return true;
+	}
+
+	if (bt_write_le_scan(do_start)) {
+		/*
+		 * Keep track of registered clients only. We won't stop scanning
+		 * till all registered scanning clients requested to stop.
+		 */
+		if (!is_registered)
+			return true;
+
+		if (do_start)
+			scan_clients = g_slist_prepend(scan_clients,
+							INT_TO_PTR(client_if));
+		else
+			scan_clients = g_slist_remove(scan_clients,
+							INT_TO_PTR(client_if));
+
+		return true;
+	}
+
+	error("gatt: LE scan switch failed");
+	return false;
+}
+
 static void handle_client_unregister(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_unregister *cmd = buf;
@@ -124,6 +171,7 @@ static void handle_client_unregister(const void *buf, uint16_t len)
 	}
 
 	gatt_clients = g_slist_remove(gatt_clients, l->data);
+	set_client_scan(cmd->client_if, false);
 
 	status = HAL_STATUS_SUCCESS;
 
@@ -132,12 +180,49 @@ failed:
 					HAL_OP_GATT_CLIENT_UNREGISTER, status);
 }
 
+static void le_device_found_handler(bdaddr_t *addr, uint8_t addr_type, int rssi,
+						uint16_t len, const void *data)
+{
+	uint8_t buf[IPC_MTU];
+	struct hal_ev_gatt_client_scan_result *ev = (void *) buf;
+	char bda[18];
+
+	if (!g_slist_length(scan_clients))
+		return;
+
+	ba2str(addr, bda);
+	DBG("gatt: LE Device found: %s, rssi: %d, adv_data: %d", bda, rssi,
+							data ? true : false);
+
+	bdaddr2android(addr, ev->bda);
+	ev->rssi = rssi;
+	ev->len = len;
+
+	memcpy(ev->adv_data, data, ev->len);
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_CLIENT_SCAN_RESULT, sizeof(ev) + len, ev);
+}
+
+static void le_discovering_handler(uint8_t discovering)
+{
+	/* resume scanning if there are any clients left */
+	if (!discovering && g_slist_length(scan_clients))
+		bt_write_le_scan(true);
+}
+
 static void handle_client_scan(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_scan *cmd = buf;
+	uint8_t status;
+
 	DBG("");
 
+	status = set_client_scan(cmd->client_if, cmd->start) ?
+					HAL_STATUS_SUCCESS : HAL_STATUS_FAILED;
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_SCAN,
-							HAL_STATUS_FAILED);
+									status);
 }
 
 static void handle_client_connect(const void *buf, uint16_t len)
@@ -524,6 +609,9 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 	ipc_register(hal_ipc, HAL_SERVICE_ID_GATT, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 
+	bt_set_le_device_found_cb(le_device_found_handler);
+	bt_set_le_discovering_cb(le_discovering_handler);
+
 	return true;
 }
 
@@ -533,4 +621,7 @@ void bt_gatt_unregister(void)
 
 	ipc_unregister(hal_ipc, HAL_SERVICE_ID_GATT);
 	hal_ipc = NULL;
+
+	bt_set_le_device_found_cb(NULL);
+	bt_set_le_discovering_cb(NULL);
 }
-- 
1.9.0

