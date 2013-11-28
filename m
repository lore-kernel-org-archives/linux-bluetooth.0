Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 10/10] android: Don't pass notification socket on services register
Date: Thu, 28 Nov 2013 15:15:30 +0100
Message-Id: <1385648130-12808-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385648130-12808-1-git-send-email-szymon.janc@tieto.com>
References: <1385648130-12808-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is no longer needed as proper socket is use by IPC helpers.
---
 android/a2dp.c      | 13 +------------
 android/a2dp.h      |  2 +-
 android/bluetooth.c | 16 +---------------
 android/bluetooth.h |  2 +-
 android/hidhost.c   | 12 +-----------
 android/hidhost.h   |  2 +-
 android/main.c      | 13 +++++--------
 android/pan.c       | 14 +-------------
 android/pan.h       |  2 +-
 android/socket.c    |  4 +---
 android/socket.h    |  2 +-
 11 files changed, 15 insertions(+), 67 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 92c359e..99aa14d 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -48,7 +48,6 @@
 #define L2CAP_PSM_AVDTP 0x19
 #define SVC_HINT_CAPTURING 0x08
 
-static int notification_sk = -1;
 static GIOChannel *server = NULL;
 static GSList *devices = NULL;
 static bdaddr_t adapter_addr;
@@ -350,16 +349,13 @@ static sdp_record_t *a2dp_record(void)
 	return record;
 }
 
-bool bt_a2dp_register(int sk, const bdaddr_t *addr)
+bool bt_a2dp_register(const bdaddr_t *addr)
 {
 	GError *err = NULL;
 	sdp_record_t *rec;
 
 	DBG("");
 
-	if (notification_sk >= 0)
-		return false;
-
 	bacpy(&adapter_addr, addr);
 
 	server = bt_io_listen(connect_cb, NULL, NULL, NULL, &err,
@@ -384,8 +380,6 @@ bool bt_a2dp_register(int sk, const bdaddr_t *addr)
 	}
 	record_id = rec->handle;
 
-	notification_sk = sk;
-
 	return true;
 }
 
@@ -400,14 +394,9 @@ void bt_a2dp_unregister(void)
 {
 	DBG("");
 
-	if (notification_sk < 0)
-		return;
-
 	g_slist_foreach(devices, a2dp_device_disconnected, NULL);
 	devices = NULL;
 
-	notification_sk = -1;
-
 	bt_adapter_remove_record(record_id);
 	record_id = 0;
 
diff --git a/android/a2dp.h b/android/a2dp.h
index 3531618..2a1eb3c 100644
--- a/android/a2dp.h
+++ b/android/a2dp.h
@@ -23,5 +23,5 @@
 
 void bt_a2dp_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
 
-bool bt_a2dp_register(int sk, const bdaddr_t *addr);
+bool bt_a2dp_register(const bdaddr_t *addr);
 void bt_a2dp_unregister(void);
diff --git a/android/bluetooth.c b/android/bluetooth.c
index fdafb81..8a1d444 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -60,8 +60,6 @@
 
 static uint16_t option_index = MGMT_INDEX_NONE;
 
-static int notification_sk = -1;
-
 #define BASELEN_REMOTE_DEV_PROP (sizeof(struct hal_ev_remote_device_props) \
 					+ sizeof(struct hal_property))
 /* This list contains addresses which are asked for records */
@@ -2267,24 +2265,12 @@ error:
 	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, opcode, status);
 }
 
-bool bt_bluetooth_register(int sk)
+void bt_bluetooth_register(void)
 {
 	DBG("");
-
-	if (notification_sk >= 0)
-		return false;
-
-	notification_sk = sk;
-
-	return true;
 }
 
 void bt_bluetooth_unregister(void)
 {
 	DBG("");
-
-	if (notification_sk < 0)
-		return;
-
-	notification_sk = -1;
 }
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 44b8e9e..86872ee 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -31,7 +31,7 @@ void bt_bluetooth_cleanup(void);
 
 void bt_bluetooth_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
 
-bool bt_bluetooth_register(int sk);
+void bt_bluetooth_register(void);
 void bt_bluetooth_unregister(void);
 
 int bt_adapter_add_record(sdp_record_t *rec, uint8_t svc_hint);
diff --git a/android/hidhost.c b/android/hidhost.c
index 09c71f4..50ac50d 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -78,7 +78,6 @@
 
 static bdaddr_t adapter_addr;
 
-static int notification_sk = -1;
 static GIOChannel *ctrl_io = NULL;
 static GIOChannel *intr_io = NULL;
 static GSList *devices = NULL;
@@ -1190,15 +1189,12 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	}
 }
 
-bool bt_hid_register(int sk, const bdaddr_t *addr)
+bool bt_hid_register(const bdaddr_t *addr)
 {
 	GError *err = NULL;
 
 	DBG("");
 
-	if (notification_sk >= 0)
-		return false;
-
 	bacpy(&adapter_addr, addr);
 
 	ctrl_io = bt_io_listen(connect_cb, NULL, NULL, NULL, &err,
@@ -1224,8 +1220,6 @@ bool bt_hid_register(int sk, const bdaddr_t *addr)
 		return false;
 	}
 
-	notification_sk = sk;
-
 	return true;
 }
 
@@ -1241,12 +1235,8 @@ void bt_hid_unregister(void)
 {
 	DBG("");
 
-	if (notification_sk < 0)
-		return;
-
 	g_slist_foreach(devices, free_hid_devices, NULL);
 	devices = NULL;
-	notification_sk = -1;
 
 	if (ctrl_io) {
 		g_io_channel_shutdown(ctrl_io, TRUE, NULL);
diff --git a/android/hidhost.h b/android/hidhost.h
index 688086a..b5545fb 100644
--- a/android/hidhost.h
+++ b/android/hidhost.h
@@ -23,5 +23,5 @@
 
 void bt_hid_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
 
-bool bt_hid_register(int sk, const bdaddr_t *addr);
+bool bt_hid_register(const bdaddr_t *addr);
 void bt_hid_unregister(void);
diff --git a/android/main.c b/android/main.c
index 211503b..fb16503 100644
--- a/android/main.c
+++ b/android/main.c
@@ -77,34 +77,31 @@ static bool services[HAL_SERVICE_ID_MAX + 1] = { false };
 static void service_register(void *buf, uint16_t len)
 {
 	struct hal_cmd_register_module *m = buf;
-	int sk = g_io_channel_unix_get_fd(hal_notif_io);
 
 	if (m->service_id > HAL_SERVICE_ID_MAX || services[m->service_id])
 		goto failed;
 
 	switch (m->service_id) {
 	case HAL_SERVICE_ID_BLUETOOTH:
-		if (!bt_bluetooth_register(sk))
-			goto failed;
+		bt_bluetooth_register();
 
 		break;
 	case HAL_SERVICE_ID_SOCK:
-		if (!bt_socket_register(sk, &adapter_bdaddr))
-			goto failed;
+		bt_socket_register(&adapter_bdaddr);
 
 		break;
 	case HAL_SERVICE_ID_HIDHOST:
-		if (!bt_hid_register(sk, &adapter_bdaddr))
+		if (!bt_hid_register(&adapter_bdaddr))
 			goto failed;
 
 		break;
 	case HAL_SERVICE_ID_A2DP:
-		if (!bt_a2dp_register(sk, &adapter_bdaddr))
+		if (!bt_a2dp_register(&adapter_bdaddr))
 			goto failed;
 
 		break;
 	case HAL_SERVICE_ID_PAN:
-		if (!bt_pan_register(sk, &adapter_bdaddr))
+		if (!bt_pan_register(&adapter_bdaddr))
 			goto failed;
 
 		break;
diff --git a/android/pan.c b/android/pan.c
index 29f1007..ea15637 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -35,8 +35,6 @@
 #include "hal-msg.h"
 #include "ipc.h"
 
-static int notification_sk = -1;
-
 static uint8_t bt_pan_enable(struct hal_cmd_pan_enable *cmd, uint16_t len)
 {
 	DBG("Not Implemented");
@@ -91,24 +89,14 @@ void bt_pan_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 	ipc_send_rsp(HAL_SERVICE_ID_PAN, opcode, status);
 }
 
-bool bt_pan_register(int sk, const bdaddr_t *addr)
+bool bt_pan_register(const bdaddr_t *addr)
 {
 	DBG("");
 
-	if (notification_sk >= 0)
-		return false;
-
-	notification_sk = sk;
-
 	return true;
 }
 
 void bt_pan_unregister(void)
 {
 	DBG("");
-
-	if (notification_sk < 0)
-		return;
-
-	notification_sk = -1;
 }
diff --git a/android/pan.h b/android/pan.h
index 2430378..dd18f68 100644
--- a/android/pan.h
+++ b/android/pan.h
@@ -23,5 +23,5 @@
 
 void bt_pan_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
 
-bool bt_pan_register(int sk, const bdaddr_t *addr);
+bool bt_pan_register(const bdaddr_t *addr);
 void bt_pan_unregister(void);
diff --git a/android/socket.c b/android/socket.c
index 6a5f4e8..4550dc8 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -934,13 +934,11 @@ void bt_sock_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 	ipc_send_rsp(HAL_SERVICE_ID_SOCK, opcode, HAL_STATUS_FAILED);
 }
 
-bool bt_socket_register(int sk, const bdaddr_t *addr)
+void bt_socket_register(const bdaddr_t *addr)
 {
 	DBG("");
 
 	bacpy(&adapter_addr, addr);
-
-	return true;
 }
 
 void bt_socket_unregister(void)
diff --git a/android/socket.h b/android/socket.h
index ba56c9b..5150b89 100644
--- a/android/socket.h
+++ b/android/socket.h
@@ -30,5 +30,5 @@ struct hal_sock_connect_signal {
 
 void bt_sock_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
 
-bool bt_socket_register(int sk, const bdaddr_t *addr);
+void bt_socket_register(const bdaddr_t *addr);
 void bt_socket_unregister(void);
-- 
1.8.3.2

