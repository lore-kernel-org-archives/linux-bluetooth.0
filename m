Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] android/gatt: Add support for new parameter in srv connect()
Date: Wed,  5 Nov 2014 11:53:37 +0200
Message-Id: <1415181217-16510-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415181217-16510-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415181217-16510-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Support transport parameter in new Android API.
---
 android/gatt.c          |  2 ++
 android/hal-gatt.c      | 21 +++++++++++++++++++--
 android/hal-ipc-api.txt |  1 +
 android/hal-msg.h       |  1 +
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index e930b5a..7cf612f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4184,6 +4184,8 @@ static void handle_server_connect(const void *buf, uint16_t len)
 
 	android2bdaddr(&cmd->bdaddr, &addr);
 
+	/* TODO: Handle transport flag */
+
 	status = handle_connect(cmd->server_if, &addr);
 
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_SERVER_CONNECT,
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index 82093fa..a324009 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -1136,8 +1136,9 @@ static bt_status_t unregister_server(int server_if)
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
-static bt_status_t server_connect(int server_if, const bt_bdaddr_t *bd_addr,
-								bool is_direct)
+static bt_status_t server_connect_real(int server_if,
+						const bt_bdaddr_t *bd_addr,
+						bool is_direct, int transport)
 {
 	struct hal_cmd_gatt_server_connect cmd;
 
@@ -1146,6 +1147,7 @@ static bt_status_t server_connect(int server_if, const bt_bdaddr_t *bd_addr,
 
 	cmd.server_if = server_if;
 	cmd.is_direct = is_direct;
+	cmd.transport = transport;
 
 	memcpy(cmd.bdaddr, bd_addr, sizeof(*bd_addr));
 
@@ -1153,6 +1155,21 @@ static bt_status_t server_connect(int server_if, const bt_bdaddr_t *bd_addr,
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+static bt_status_t server_connect(int server_if, const bt_bdaddr_t *bd_addr,
+						bool is_direct, int transport)
+{
+	return server_connect_real(server_if, bd_addr, is_direct, transport);
+}
+#else
+static bt_status_t server_connect(int server_if, const bt_bdaddr_t *bd_addr,
+								bool is_direct)
+{
+	return server_connect_real(server_if, bd_addr, is_direct,
+							BT_TRANSPORT_UNKNOWN);
+}
+#endif
+
 static bt_status_t server_disconnect(int server_if, const bt_bdaddr_t *bd_addr,
 								int conn_id)
 {
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index d6e68f1..1bb591a 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1756,6 +1756,7 @@ Commands and responses:
 		Command parameters: Server (4 octets)
 		                    Remote address (6 octes)
 		                    Is Direct (1 octet)
+		                    Transport (4 octets)
 		Response parameters: <none>
 
 		In case of an error, the error response will be returned.
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 8dd00a0..1876d6b 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -919,6 +919,7 @@ struct hal_cmd_gatt_server_connect {
 	int32_t server_if;
 	uint8_t bdaddr[6];
 	uint8_t is_direct;
+	int32_t transport;
 } __attribute__((packed));
 
 #define HAL_OP_GATT_SERVER_DISCONNECT		0x1a
-- 
1.9.1

