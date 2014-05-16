Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 4/4] android/gatt: Add proper read_remote_rssi implementation
Date: Fri, 16 May 2014 17:19:14 +0200
Message-ID: <1400253554-31574-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1400253554-31574-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1400253554-31574-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 9d90f3a..a01257f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3194,11 +3194,35 @@ failed:
 			HAL_OP_GATT_CLIENT_DEREGISTER_FOR_NOTIFICATION, status);
 }
 
+static void send_client_remote_rssi_notify(int32_t client_if,
+						const bdaddr_t *addr,
+						int32_t rssi, int32_t status)
+{
+	struct hal_ev_gatt_client_read_remote_rssi ev;
+
+	ev.client_if = client_if;
+	bdaddr2android(addr, &ev.address);
+	ev.rssi = rssi;
+	ev.status = status;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_CLIENT_READ_REMOTE_RSSI, sizeof(ev), &ev);
+}
+
+static void read_remote_rssi_cb(uint8_t status, const bdaddr_t *addr,
+						int8_t rssi, void *user_data)
+{
+	int32_t client_if = PTR_TO_INT(user_data);
+	int32_t gatt_status = status ? GATT_FAILURE : GATT_SUCCESS;
+
+	send_client_remote_rssi_notify(client_if, addr, rssi, gatt_status);
+}
+
 static void handle_client_read_remote_rssi(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_read_remote_rssi *cmd = buf;
-	struct hal_ev_gatt_client_read_remote_rssi ev;
 	uint8_t status;
+	bdaddr_t bdaddr;
 
 	DBG("");
 
@@ -3207,20 +3231,23 @@ static void handle_client_read_remote_rssi(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	/* TODO fake RSSI until kernel support is added */
-	ev.client_if = cmd->client_if;
-	memcpy(ev.address, cmd->bdaddr, sizeof(ev.address));
-	ev.status = HAL_STATUS_SUCCESS;
-	ev.rssi = -50 - (rand() % 40);
-
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_EV_GATT_CLIENT_READ_REMOTE_RSSI, sizeof(ev), &ev);
+	android2bdaddr(cmd->bdaddr, &bdaddr);
+	if (!bt_read_device_rssi(&bdaddr, read_remote_rssi_cb,
+						INT_TO_PTR(cmd->client_if))) {
+		error("gatt: Could not read RSSI");
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
 
 	status = HAL_STATUS_SUCCESS;
 
 failed:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 			HAL_OP_GATT_CLIENT_READ_REMOTE_RSSI, status);
+
+	if (status != HAL_STATUS_SUCCESS)
+		send_client_remote_rssi_notify(cmd->client_if, &bdaddr, 0,
+								GATT_FAILURE);
 }
 
 static void handle_client_get_device_type(const void *buf, uint16_t len)
-- 
1.9.3

