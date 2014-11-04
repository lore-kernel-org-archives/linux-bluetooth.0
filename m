Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 15/47] android/gatt: Add support for new parameter in srv connect()
Date: Tue,  4 Nov 2014 10:18:38 +0200
Message-Id: <1415089150-18798-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Support transport parameter in new Android API.
---
 android/gatt.c     | 2 ++
 android/hal-gatt.c | 8 ++++++++
 android/hal-msg.h  | 1 +
 3 files changed, 11 insertions(+)

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
index 9379192..d525603 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -1124,8 +1124,13 @@ static bt_status_t unregister_server(int server_if)
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static bt_status_t server_connect(int server_if, const bt_bdaddr_t *bd_addr,
+						bool is_direct, int transport)
+#else
 static bt_status_t server_connect(int server_if, const bt_bdaddr_t *bd_addr,
 								bool is_direct)
+#endif
 {
 	struct hal_cmd_gatt_server_connect cmd;
 
@@ -1134,6 +1139,9 @@ static bt_status_t server_connect(int server_if, const bt_bdaddr_t *bd_addr,
 
 	cmd.server_if = server_if;
 	cmd.is_direct = is_direct;
+#if  ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	cmd.transport = transport;
+#endif
 
 	memcpy(cmd.bdaddr, bd_addr, sizeof(*bd_addr));
 
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

