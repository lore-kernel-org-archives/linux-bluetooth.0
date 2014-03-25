Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/gatt: Add support for fake read RSSI
Date: Tue, 25 Mar 2014 12:35:30 +0100
Message-Id: <1395747330-22919-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will ease testing until kernel support is added.
---
 android/gatt.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 0414c4f..f488e17 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -943,10 +943,35 @@ static void handle_client_deregister_for_notification(const void *buf,
 
 static void handle_client_read_remote_rssi(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_read_remote_rssi *cmd = buf;
+	struct hal_ev_gatt_client_read_remote_rssi ev;
+	static int32_t fake_rssi = -71;
+	uint8_t status;
+
 	DBG("");
 
+	if (!queue_find(gatt_clients, match_client_by_id,
+						INT_TO_PTR(cmd->client_if))) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	/* TODO fake RSSI until kernel support is added */
+	ev.client_if = cmd->client_if;
+	memcpy(ev.address, cmd->bdaddr, sizeof(ev.address));
+	ev.status = HAL_STATUS_SUCCESS;
+	ev.rssi = fake_rssi;
+
+	fake_rssi = fake_rssi == -71 ? -83 : -71;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_CLIENT_READ_REMOTE_RSSI, sizeof(ev), &ev);
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_CLIENT_READ_REMOTE_RSSI, HAL_STATUS_FAILED);
+			HAL_OP_GATT_CLIENT_READ_REMOTE_RSSI, status);
 }
 
 static void handle_client_get_device_type(const void *buf, uint16_t len)
-- 
1.8.5.3

