Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 04/13] android: Pass command socket to services while registering
Date: Wed, 27 Nov 2013 12:54:56 +0100
Message-Id: <1385553305-5807-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385553305-5807-1-git-send-email-szymon.janc@tieto.com>
References: <1385553305-5807-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will be used to reply to commands from IPC handlers.
---
 android/a2dp.c      |  7 +++++--
 android/a2dp.h      |  2 +-
 android/bluetooth.c |  8 ++++++--
 android/bluetooth.h |  2 +-
 android/hidhost.c   |  8 ++++++--
 android/hidhost.h   |  2 +-
 android/main.c      | 13 +++++++------
 android/pan.c       |  8 ++++++--
 android/pan.h       |  2 +-
 android/socket.c    |  2 +-
 android/socket.h    |  2 +-
 11 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 2251001..87b1abb 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -49,6 +49,7 @@
 #define SVC_HINT_CAPTURING 0x08
 
 static int notification_sk = -1;
+static int command_sk = -1;
 static GIOChannel *server = NULL;
 static GSList *devices = NULL;
 static bdaddr_t adapter_addr;
@@ -350,7 +351,7 @@ static sdp_record_t *a2dp_record(void)
 	return record;
 }
 
-bool bt_a2dp_register(int sk, const bdaddr_t *addr)
+bool bt_a2dp_register(int cmd_sk, int notif_sk, const bdaddr_t *addr)
 {
 	GError *err = NULL;
 	sdp_record_t *rec;
@@ -384,7 +385,8 @@ bool bt_a2dp_register(int sk, const bdaddr_t *addr)
 	}
 	record_id = rec->handle;
 
-	notification_sk = sk;
+	notification_sk = notif_sk;
+	command_sk = cmd_sk;
 
 	return true;
 }
@@ -407,6 +409,7 @@ void bt_a2dp_unregister(void)
 	devices = NULL;
 
 	notification_sk = -1;
+	command_sk = -1;
 
 	bt_adapter_remove_record(record_id);
 	record_id = 0;
diff --git a/android/a2dp.h b/android/a2dp.h
index 3531618..720b681 100644
--- a/android/a2dp.h
+++ b/android/a2dp.h
@@ -23,5 +23,5 @@
 
 void bt_a2dp_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
 
-bool bt_a2dp_register(int sk, const bdaddr_t *addr);
+bool bt_a2dp_register(int cmd_sk, int notif_sk, const bdaddr_t *addr);
 void bt_a2dp_unregister(void);
diff --git a/android/bluetooth.c b/android/bluetooth.c
index 0e45131..700e5ce 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -60,6 +60,7 @@
 
 static uint16_t option_index = MGMT_INDEX_NONE;
 
+static int command_sk = -1;
 static int notification_sk = -1;
 
 #define BASELEN_REMOTE_DEV_PROP (sizeof(struct hal_ev_remote_device_props) \
@@ -2272,14 +2273,16 @@ error:
 	ipc_send_rsp(sk, HAL_SERVICE_ID_BLUETOOTH, opcode, status);
 }
 
-bool bt_bluetooth_register(int sk)
+bool bt_bluetooth_register(int cmd_sk, int notif_sk)
 {
 	DBG("");
 
 	if (notification_sk >= 0)
 		return false;
 
-	notification_sk = sk;
+	command_sk = cmd_sk;
+	notification_sk = notif_sk;
+
 
 	return true;
 }
@@ -2291,5 +2294,6 @@ void bt_bluetooth_unregister(void)
 	if (notification_sk < 0)
 		return;
 
+	command_sk = -1;
 	notification_sk = -1;
 }
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 44b8e9e..d104a5b 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -31,7 +31,7 @@ void bt_bluetooth_cleanup(void);
 
 void bt_bluetooth_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
 
-bool bt_bluetooth_register(int sk);
+bool bt_bluetooth_register(int cmd_sk, int notif_sk);
 void bt_bluetooth_unregister(void);
 
 int bt_adapter_add_record(sdp_record_t *rec, uint8_t svc_hint);
diff --git a/android/hidhost.c b/android/hidhost.c
index d50c5b8..d97af03 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -79,6 +79,8 @@
 static bdaddr_t adapter_addr;
 
 static int notification_sk = -1;
+static int command_sk = -1;
+
 static GIOChannel *ctrl_io = NULL;
 static GIOChannel *intr_io = NULL;
 static GSList *devices = NULL;
@@ -1190,7 +1192,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	}
 }
 
-bool bt_hid_register(int sk, const bdaddr_t *addr)
+bool bt_hid_register(int cmd_sk, int notif_sk, const bdaddr_t *addr)
 {
 	GError *err = NULL;
 
@@ -1224,7 +1226,8 @@ bool bt_hid_register(int sk, const bdaddr_t *addr)
 		return false;
 	}
 
-	notification_sk = sk;
+	command_sk = cmd_sk;
+	notification_sk = notif_sk;
 
 	return true;
 }
@@ -1246,6 +1249,7 @@ void bt_hid_unregister(void)
 
 	g_slist_foreach(devices, free_hid_devices, NULL);
 	devices = NULL;
+	command_sk = -1;
 	notification_sk = -1;
 
 	if (ctrl_io) {
diff --git a/android/hidhost.h b/android/hidhost.h
index 688086a..4486ee9 100644
--- a/android/hidhost.h
+++ b/android/hidhost.h
@@ -23,5 +23,5 @@
 
 void bt_hid_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
 
-bool bt_hid_register(int sk, const bdaddr_t *addr);
+bool bt_hid_register(int cmd_sk, int notif_sk, const bdaddr_t *addr);
 void bt_hid_unregister(void);
diff --git a/android/main.c b/android/main.c
index de19127..d005be1 100644
--- a/android/main.c
+++ b/android/main.c
@@ -77,7 +77,8 @@ static bool services[HAL_SERVICE_ID_MAX + 1] = { false };
 static void service_register(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_register_module *m = buf;
-	int sk = g_io_channel_unix_get_fd(hal_notif_io);
+	int cmd_sk = g_io_channel_unix_get_fd(hal_cmd_io);
+	int notif_sk = g_io_channel_unix_get_fd(hal_notif_io);
 	uint8_t status = HAL_STATUS_FAILED;
 
 	if (m->service_id > HAL_SERVICE_ID_MAX || services[m->service_id])
@@ -85,27 +86,27 @@ static void service_register(const void *buf, uint16_t len)
 
 	switch (m->service_id) {
 	case HAL_SERVICE_ID_BLUETOOTH:
-		if (!bt_bluetooth_register(sk))
+		if (!bt_bluetooth_register(cmd_sk, notif_sk))
 			goto failed;
 
 		break;
 	case HAL_SERVICE_ID_SOCK:
-		if (!bt_socket_register(sk, &adapter_bdaddr))
+		if (!bt_socket_register(cmd_sk, notif_sk, &adapter_bdaddr))
 			goto failed;
 
 		break;
 	case HAL_SERVICE_ID_HIDHOST:
-		if (!bt_hid_register(sk, &adapter_bdaddr))
+		if (!bt_hid_register(cmd_sk, notif_sk, &adapter_bdaddr))
 			goto failed;
 
 		break;
 	case HAL_SERVICE_ID_A2DP:
-		if (!bt_a2dp_register(sk, &adapter_bdaddr))
+		if (!bt_a2dp_register(cmd_sk, notif_sk, &adapter_bdaddr))
 			goto failed;
 
 		break;
 	case HAL_SERVICE_ID_PAN:
-		if (!bt_pan_register(sk, &adapter_bdaddr))
+		if (!bt_pan_register(cmd_sk, notif_sk, &adapter_bdaddr))
 			goto failed;
 
 		break;
diff --git a/android/pan.c b/android/pan.c
index ada458a..35d5608 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -36,6 +36,7 @@
 #include "ipc.h"
 
 static int notification_sk = -1;
+static int command_sk = -1;
 
 static uint8_t bt_pan_enable(struct hal_cmd_pan_enable *cmd, uint16_t len)
 {
@@ -91,14 +92,16 @@ void bt_pan_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 	ipc_send_rsp(sk, HAL_SERVICE_ID_PAN, opcode, status);
 }
 
-bool bt_pan_register(int sk, const bdaddr_t *addr)
+bool bt_pan_register(int cmd_sk, int notif_sk, const bdaddr_t *addr)
 {
 	DBG("");
 
 	if (notification_sk >= 0)
 		return false;
 
-	notification_sk = sk;
+	notification_sk = notif_sk;
+	command_sk = cmd_sk;
+
 
 	return true;
 }
@@ -111,4 +114,5 @@ void bt_pan_unregister(void)
 		return;
 
 	notification_sk = -1;
+	command_sk = -1;
 }
diff --git a/android/pan.h b/android/pan.h
index 2430378..9ceebe5 100644
--- a/android/pan.h
+++ b/android/pan.h
@@ -23,5 +23,5 @@
 
 void bt_pan_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
 
-bool bt_pan_register(int sk, const bdaddr_t *addr);
+bool bt_pan_register(int cmd_sk, int notif_sk, const bdaddr_t *addr);
 void bt_pan_unregister(void);
diff --git a/android/socket.c b/android/socket.c
index 1fb154d..47338e7 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -934,7 +934,7 @@ void bt_sock_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 	ipc_send_rsp(sk, HAL_SERVICE_ID_SOCK, opcode, HAL_STATUS_FAILED);
 }
 
-bool bt_socket_register(int sk, const bdaddr_t *addr)
+bool bt_socket_register(int cmd_sk, int notif_sk, const bdaddr_t *addr)
 {
 	DBG("");
 
diff --git a/android/socket.h b/android/socket.h
index ba56c9b..6caf44d 100644
--- a/android/socket.h
+++ b/android/socket.h
@@ -30,5 +30,5 @@ struct hal_sock_connect_signal {
 
 void bt_sock_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
 
-bool bt_socket_register(int sk, const bdaddr_t *addr);
+bool bt_socket_register(int cmd_sk, int notif_sk, const bdaddr_t *addr);
 void bt_socket_unregister(void);
-- 
1.8.3.2

