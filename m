Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] android/gatt: Add support for new parameter for connect
Date: Wed,  5 Nov 2014 11:53:36 +0200
Message-Id: <1415181217-16510-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415181217-16510-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415181217-16510-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add support for new parameter in gatt client connect() for new Android
API.
---
 android/gatt.c          |  2 ++
 android/hal-gatt.c      | 20 ++++++++++++++++++--
 android/hal-ipc-api.txt |  1 +
 android/hal-msg.h       |  1 +
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 5a531d9..e930b5a 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2066,6 +2066,8 @@ static void handle_client_connect(const void *buf, uint16_t len)
 
 	/* TODO handle is_direct flag */
 
+	/* TODO handle transport flag */
+
 	status = handle_connect(cmd->client_if, &addr);
 
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_CONNECT,
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index 080852a..82093fa 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -621,8 +621,8 @@ static bt_status_t scan(int client_if, bool start)
 }
 #endif
 
-static bt_status_t connect(int client_if, const bt_bdaddr_t *bd_addr,
-								bool is_direct)
+static bt_status_t connect_real(int client_if, const bt_bdaddr_t *bd_addr,
+						bool is_direct, int transport)
 {
 	struct hal_cmd_gatt_client_connect cmd;
 
@@ -631,6 +631,7 @@ static bt_status_t connect(int client_if, const bt_bdaddr_t *bd_addr,
 
 	cmd.client_if = client_if;
 	cmd.is_direct = is_direct;
+	cmd.transport = transport;
 
 	memcpy(cmd.bdaddr, bd_addr, sizeof(*bd_addr));
 
@@ -638,6 +639,21 @@ static bt_status_t connect(int client_if, const bt_bdaddr_t *bd_addr,
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+static bt_status_t connect(int client_if, const bt_bdaddr_t *bd_addr,
+						bool is_direct, int transport)
+{
+	return connect_real(client_if, bd_addr, is_direct, transport);
+}
+#else
+static bt_status_t connect(int client_if, const bt_bdaddr_t *bd_addr,
+								bool is_direct)
+{
+	return connect_real(client_if, bd_addr, is_direct,
+							BT_TRANSPORT_UNKNOWN);
+}
+#endif
+
 static bt_status_t disconnect(int client_if, const bt_bdaddr_t *bd_addr,
 								int conn_id)
 {
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 3a3ae92..d6e68f1 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1522,6 +1522,7 @@ Commands and responses:
 		Command parameters: Client Interface (4 octets)
 		                    Remote address (6 octets)
 		                    Is Direct (1 octet)
+		                    Transport (4 octets)
 		Response parameters: <none>
 
 		In case of an error, the error response will be returned.
diff --git a/android/hal-msg.h b/android/hal-msg.h
index bcb73b2..8dd00a0 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -721,6 +721,7 @@ struct hal_cmd_gatt_client_connect {
 	int32_t client_if;
 	uint8_t bdaddr[6];
 	uint8_t is_direct;
+	int32_t transport;
 } __attribute__((packed));
 
 #define HAL_OP_GATT_CLIENT_DISCONNECT		0x05
-- 
1.9.1

