Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 14/47] android/gatt: Add support for new parameter for connect
Date: Tue,  4 Nov 2014 10:18:37 +0200
Message-Id: <1415089150-18798-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add support for new parameter in gatt client connect() for new Android
API.
---
 android/gatt.c     | 2 ++
 android/hal-gatt.c | 8 ++++++++
 android/hal-msg.h  | 1 +
 3 files changed, 11 insertions(+)

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
index d0e9184..9379192 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -617,8 +617,13 @@ static bt_status_t scan(int client_if, bool start)
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static bt_status_t connect(int client_if, const bt_bdaddr_t *bd_addr,
+						bool is_direct, int transport)
+#else
 static bt_status_t connect(int client_if, const bt_bdaddr_t *bd_addr,
 								bool is_direct)
+#endif
 {
 	struct hal_cmd_gatt_client_connect cmd;
 
@@ -627,6 +632,9 @@ static bt_status_t connect(int client_if, const bt_bdaddr_t *bd_addr,
 
 	cmd.client_if = client_if;
 	cmd.is_direct = is_direct;
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	cmd.transport = transport;
+#endif
 
 	memcpy(cmd.bdaddr, bd_addr, sizeof(*bd_addr));
 
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

