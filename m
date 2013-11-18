Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 1/2] android: Improve IPC helper to not send invalid status response
Date: Mon, 18 Nov 2013 13:58:39 +0100
Message-Id: <1384779520-2104-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix issue with sending invalid success response from several
places where ipc_send_rsp was used for reporting success. Instead of
using using ipc_send for success response, make helper handle that.
---
V2: fixed hardcoded service id in ipc_send_rsp

 android/a2dp.c      |  2 +-
 android/bluetooth.c |  2 +-
 android/hidhost.c   |  2 +-
 android/ipc.c       |  7 ++++++-
 android/ipc.h       |  2 +-
 android/main.c      | 12 ++++++++----
 android/pan.c       |  2 +-
 android/socket.c    |  2 +-
 8 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 936c28e..bb55e41 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -226,7 +226,7 @@ void bt_a2dp_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 		break;
 	}
 
-	ipc_send_rsp(sk, HAL_SERVICE_ID_A2DP, status);
+	ipc_send_rsp(sk, HAL_SERVICE_ID_A2DP, opcode, status);
 }
 
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
diff --git a/android/bluetooth.c b/android/bluetooth.c
index 5c5c61e..7dc2ec3 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2268,7 +2268,7 @@ void bt_bluetooth_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 error:
 	error("Error handling command 0x%02x status %u", opcode, status);
 
-	ipc_send_rsp(sk, HAL_SERVICE_ID_BLUETOOTH, status);
+	ipc_send_rsp(sk, HAL_SERVICE_ID_BLUETOOTH, opcode, status);
 }
 
 bool bt_bluetooth_register(int sk)
diff --git a/android/hidhost.c b/android/hidhost.c
index f5a607c..842b8ad 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -1109,7 +1109,7 @@ void bt_hid_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 		break;
 	}
 
-	ipc_send_rsp(sk, HAL_SERVICE_ID_HIDHOST, status);
+	ipc_send_rsp(sk, HAL_SERVICE_ID_HIDHOST, opcode, status);
 }
 
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
diff --git a/android/ipc.c b/android/ipc.c
index 729f157..8467b28 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -80,10 +80,15 @@ void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 	}
 }
 
-void ipc_send_rsp(int sk, uint8_t service_id, uint8_t status)
+void ipc_send_rsp(int sk, uint8_t service_id, uint8_t opcode, uint8_t status)
 {
 	struct hal_status s;
 
+	if (status == HAL_STATUS_SUCCESS) {
+		ipc_send(sk, service_id, opcode, 0, NULL, -1);
+		return;
+	}
+
 	s.code = status;
 
 	ipc_send(sk, service_id, HAL_OP_STATUS, sizeof(s), &s, -1);
diff --git a/android/ipc.h b/android/ipc.h
index cf0f3d6..ad4a2d2 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -23,4 +23,4 @@
 
 void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 							void *param, int fd);
-void ipc_send_rsp(int sk, uint8_t service_id, uint8_t status);
+void ipc_send_rsp(int sk, uint8_t service_id, uint8_t opcode, uint8_t status);
diff --git a/android/main.c b/android/main.c
index a4f5e84..c9733f3 100644
--- a/android/main.c
+++ b/android/main.c
@@ -122,7 +122,8 @@ static void service_register(void *buf, uint16_t len)
 	return;
 failed:
 	ipc_send_rsp(g_io_channel_unix_get_fd(hal_cmd_io),
-				HAL_SERVICE_ID_CORE, HAL_STATUS_FAILED);
+				HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
+				HAL_STATUS_FAILED);
 }
 
 static void service_unregister(void *buf, uint16_t len)
@@ -164,7 +165,8 @@ static void service_unregister(void *buf, uint16_t len)
 	return;
 failed:
 	ipc_send_rsp(g_io_channel_unix_get_fd(hal_cmd_io),
-				HAL_SERVICE_ID_CORE, HAL_STATUS_FAILED);
+				HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
+				HAL_STATUS_FAILED);
 }
 
 static void handle_service_core(uint8_t opcode, void *buf, uint16_t len)
@@ -178,7 +180,8 @@ static void handle_service_core(uint8_t opcode, void *buf, uint16_t len)
 		break;
 	default:
 		ipc_send_rsp(g_io_channel_unix_get_fd(hal_cmd_io),
-				HAL_SERVICE_ID_CORE, HAL_STATUS_FAILED);
+						HAL_SERVICE_ID_CORE, opcode,
+						HAL_STATUS_FAILED);
 		break;
 	}
 }
@@ -274,7 +277,8 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 		bt_pan_handle_cmd(fd, msg->opcode, msg->payload, msg->len);
 		break;
 	default:
-		ipc_send_rsp(fd, msg->service_id, HAL_STATUS_FAILED);
+		ipc_send_rsp(fd, msg->service_id, msg->opcode,
+							HAL_STATUS_FAILED);
 		break;
 	}
 
diff --git a/android/pan.c b/android/pan.c
index 46b3700..2a11f46 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -87,7 +87,7 @@ void bt_pan_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 		break;
 	}
 
-	ipc_send_rsp(sk, HAL_SERVICE_ID_PAN, status);
+	ipc_send_rsp(sk, HAL_SERVICE_ID_PAN, opcode, status);
 }
 
 bool bt_pan_register(int sk, const bdaddr_t *addr)
diff --git a/android/socket.c b/android/socket.c
index e580036..04bb7d1 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -75,7 +75,7 @@ void bt_sock_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 		break;
 	}
 
-	ipc_send_rsp(sk, HAL_SERVICE_ID_SOCK, HAL_STATUS_FAILED);
+	ipc_send_rsp(sk, HAL_SERVICE_ID_SOCK, opcode, HAL_STATUS_FAILED);
 }
 
 bool bt_socket_register(int sk, const bdaddr_t *addr)
-- 
1.8.4.2

