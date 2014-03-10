Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] android/gatt: Handle Register gatt client command
Date: Mon, 10 Mar 2014 12:19:03 +0100
Message-Id: <1394450344-32472-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds register gatt client app command handling.
---
 android/gatt.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index ce85af4..084ba7f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -31,20 +31,71 @@
 #include <glib.h>
 
 #include "ipc.h"
+#include "ipc-common.h"
 #include "lib/bluetooth.h"
 #include "gatt.h"
 #include "src/log.h"
 #include "hal-msg.h"
 
+struct gatt_clients {
+	int32_t client_if;
+	uint8_t uuid[16];
+};
+
 static struct ipc *hal_ipc = NULL;
 static bdaddr_t adapter_addr;
+static GSList *gatt_clients_list = NULL;
+
+static int find_client_uuid(gconstpointer data, gconstpointer user_data)
+{
+	const uint8_t *exp_uuid = user_data;
+	const struct gatt_clients *client = data;
+
+	return memcmp(exp_uuid, client->uuid, sizeof(client->uuid));
+}
 
 static void handle_client_register(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_register *cmd = buf;
+	struct hal_ev_gatt_client_register_client ev;
+	struct gatt_clients *client;
+	static int32_t client_if_counter = 1;
+	uint8_t status;
+
 	DBG("");
 
-	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_REGISTER,
-							HAL_STATUS_FAILED);
+	if (!cmd->uuid) {
+		error("gatt: no uuid received");
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	if (g_slist_find_custom(gatt_clients_list, &cmd->uuid,
+							find_client_uuid)) {
+		error("gatt: client uuid is already on list");
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	client = g_new0(struct gatt_clients, 1);
+	memcpy(client->uuid, cmd->uuid, sizeof(client->uuid));
+
+	client->client_if = client_if_counter++;
+
+	gatt_clients_list = g_slist_prepend(gatt_clients_list, client);
+
+	status = HAL_STATUS_SUCCESS;
+
+	ev.status = status;
+	ev.client_if = client->client_if;
+	memcpy(ev.app_uuid, client->uuid, sizeof(client->uuid));
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_CLIENT_REGISTER_CLIENT, sizeof(ev), &ev);
+
+failed:
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_REGISTER, status);
 }
 
 static void handle_client_unregister(const void *buf, uint16_t len)
-- 
1.8.5.2

