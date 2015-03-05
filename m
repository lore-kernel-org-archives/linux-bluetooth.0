Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/3] android/gatt: Add support for direct connect
Date: Thu,  5 Mar 2015 12:57:44 +0100
Message-Id: <1425556666-9868-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Don't use kernel auto connect if direct connect is requested by Android
Framework. This is required to be able to connect to non-bonded devices
that are using RPA.
---
 android/gatt.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index e6b0753..638786d 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1928,7 +1928,7 @@ static int connect_bredr(struct gatt_device *dev)
 	return 0;
 }
 
-static bool trigger_connection(struct app_connection *conn)
+static bool trigger_connection(struct app_connection *conn, bool direct)
 {
 	bool ret;
 
@@ -1942,8 +1942,11 @@ static bool trigger_connection(struct app_connection *conn)
 								BDADDR_BREDR)
 			return connect_bredr(conn->device) == 0;
 
-		/* For LE use auto connect feature */
-		ret = auto_connect_le(conn->device);
+		if (direct)
+			ret = connect_le(conn->device) == 0;
+		else
+			ret = auto_connect_le(conn->device);
+
 		if (ret)
 			device_set_state(conn->device, DEVICE_CONNECT_INIT);
 		break;
@@ -2103,7 +2106,7 @@ reply:
 					HAL_OP_GATT_CLIENT_UNREGISTER, status);
 }
 
-static uint8_t handle_connect(int32_t app_id, const bdaddr_t *addr)
+static uint8_t handle_connect(int32_t app_id, const bdaddr_t *addr, bool direct)
 {
 	struct app_connection conn_match;
 	struct app_connection *conn;
@@ -2134,7 +2137,7 @@ static uint8_t handle_connect(int32_t app_id, const bdaddr_t *addr)
 			return HAL_STATUS_NOMEM;
 	}
 
-	if (!trigger_connection(conn))
+	if (!trigger_connection(conn, direct))
 		return HAL_STATUS_FAILED;
 
 	return HAL_STATUS_SUCCESS;
@@ -2146,15 +2149,13 @@ static void handle_client_connect(const void *buf, uint16_t len)
 	uint8_t status;
 	bdaddr_t addr;
 
-	DBG("");
+	DBG("is_direct:%u transport:%u", cmd->is_direct, cmd->transport);
 
 	android2bdaddr(&cmd->bdaddr, &addr);
 
-	/* TODO handle is_direct flag */
-
 	/* TODO handle transport flag */
 
-	status = handle_connect(cmd->client_if, &addr);
+	status = handle_connect(cmd->client_if, &addr, cmd->is_direct);
 
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_CONNECT,
 								status);
@@ -4211,7 +4212,7 @@ static void handle_client_test_command(const void *buf, uint16_t len)
 		break;
 	case GATT_CLIENT_TEST_CMD_CONNECT:
 		/* TODO u1 holds device type, for now assume BLE */
-		status = handle_connect(test_client_if, &bdaddr);
+		status = handle_connect(test_client_if, &bdaddr, false);
 		break;
 	case GATT_CLIENT_TEST_CMD_DISCONNECT:
 		app = queue_find(gatt_apps, match_app_by_id,
@@ -4295,7 +4296,7 @@ static void handle_server_connect(const void *buf, uint16_t len)
 
 	/* TODO: Handle transport flag */
 
-	status = handle_connect(cmd->server_if, &addr);
+	status = handle_connect(cmd->server_if, &addr, cmd->is_direct);
 
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_SERVER_CONNECT,
 								status);
@@ -7350,7 +7351,7 @@ bool bt_gatt_connect_app(unsigned int id, const bdaddr_t *addr)
 {
 	uint8_t status;
 
-	status = handle_connect(id, addr);
+	status = handle_connect(id, addr, false);
 
 	return status != HAL_STATUS_FAILED;
 }
-- 
1.9.3

