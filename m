Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 02/10] android: Remove socket parameter from ipc_send_rsp
Date: Thu, 28 Nov 2013 15:15:22 +0100
Message-Id: <1385648130-12808-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385648130-12808-1-git-send-email-szymon.janc@tieto.com>
References: <1385648130-12808-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use command socket provided to IPC on init.
---
 android/a2dp.c      |  2 +-
 android/bluetooth.c |  2 +-
 android/hidhost.c   |  2 +-
 android/ipc.c       |  6 +++---
 android/ipc.h       |  2 +-
 android/main.c      | 17 ++++++-----------
 android/pan.c       |  2 +-
 android/socket.c    |  2 +-
 8 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 2251001..14f34ad 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -251,7 +251,7 @@ void bt_a2dp_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 		break;
 	}
 
-	ipc_send_rsp(sk, HAL_SERVICE_ID_A2DP, opcode, status);
+	ipc_send_rsp(HAL_SERVICE_ID_A2DP, opcode, status);
 }
 
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
diff --git a/android/bluetooth.c b/android/bluetooth.c
index 0e45131..716c0eb 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2269,7 +2269,7 @@ void bt_bluetooth_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 error:
 	error("Error handling command 0x%02x status %u", opcode, status);
 
-	ipc_send_rsp(sk, HAL_SERVICE_ID_BLUETOOTH, opcode, status);
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, opcode, status);
 }
 
 bool bt_bluetooth_register(int sk)
diff --git a/android/hidhost.c b/android/hidhost.c
index d50c5b8..80957e8 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -1115,7 +1115,7 @@ void bt_hid_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 		break;
 	}
 
-	ipc_send_rsp(sk, HAL_SERVICE_ID_HIDHOST, opcode, status);
+	ipc_send_rsp(HAL_SERVICE_ID_HIDHOST, opcode, status);
 }
 
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
diff --git a/android/ipc.c b/android/ipc.c
index 028d4ad..51734e3 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -96,16 +96,16 @@ void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 	}
 }
 
-void ipc_send_rsp(int sk, uint8_t service_id, uint8_t opcode, uint8_t status)
+void ipc_send_rsp(uint8_t service_id, uint8_t opcode, uint8_t status)
 {
 	struct hal_status s;
 
 	if (status == HAL_STATUS_SUCCESS) {
-		ipc_send(sk, service_id, opcode, 0, NULL, -1);
+		ipc_send(cmd_sk, service_id, opcode, 0, NULL, -1);
 		return;
 	}
 
 	s.code = status;
 
-	ipc_send(sk, service_id, HAL_OP_STATUS, sizeof(s), &s, -1);
+	ipc_send(cmd_sk, service_id, HAL_OP_STATUS, sizeof(s), &s, -1);
 }
diff --git a/android/ipc.h b/android/ipc.h
index 5786d2d..873f715 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -26,4 +26,4 @@ void ipc_cleanup(void);
 
 void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 							void *param, int fd);
-void ipc_send_rsp(int sk, uint8_t service_id, uint8_t opcode, uint8_t status);
+void ipc_send_rsp(uint8_t service_id, uint8_t opcode, uint8_t status);
diff --git a/android/main.c b/android/main.c
index 4e6ad38..6fe0d1c 100644
--- a/android/main.c
+++ b/android/main.c
@@ -121,9 +121,8 @@ static void service_register(void *buf, uint16_t len)
 	info("Service ID=%u registered", m->service_id);
 	return;
 failed:
-	ipc_send_rsp(g_io_channel_unix_get_fd(hal_cmd_io),
-				HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
-				HAL_STATUS_FAILED);
+	ipc_send_rsp(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
+							HAL_STATUS_FAILED);
 }
 
 static void service_unregister(void *buf, uint16_t len)
@@ -164,9 +163,8 @@ static void service_unregister(void *buf, uint16_t len)
 	info("Service ID=%u unregistered", m->service_id);
 	return;
 failed:
-	ipc_send_rsp(g_io_channel_unix_get_fd(hal_cmd_io),
-				HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
-				HAL_STATUS_FAILED);
+	ipc_send_rsp(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
+							HAL_STATUS_FAILED);
 }
 
 static void handle_service_core(uint8_t opcode, void *buf, uint16_t len)
@@ -179,9 +177,7 @@ static void handle_service_core(uint8_t opcode, void *buf, uint16_t len)
 		service_unregister(buf, len);
 		break;
 	default:
-		ipc_send_rsp(g_io_channel_unix_get_fd(hal_cmd_io),
-						HAL_SERVICE_ID_CORE, opcode,
-						HAL_STATUS_FAILED);
+		ipc_send_rsp(HAL_SERVICE_ID_CORE, opcode, HAL_STATUS_FAILED);
 		break;
 	}
 }
@@ -277,8 +273,7 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 		bt_pan_handle_cmd(fd, msg->opcode, msg->payload, msg->len);
 		break;
 	default:
-		ipc_send_rsp(fd, msg->service_id, msg->opcode,
-							HAL_STATUS_FAILED);
+		ipc_send_rsp(msg->service_id, msg->opcode, HAL_STATUS_FAILED);
 		break;
 	}
 
diff --git a/android/pan.c b/android/pan.c
index ada458a..29f1007 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -88,7 +88,7 @@ void bt_pan_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 		break;
 	}
 
-	ipc_send_rsp(sk, HAL_SERVICE_ID_PAN, opcode, status);
+	ipc_send_rsp(HAL_SERVICE_ID_PAN, opcode, status);
 }
 
 bool bt_pan_register(int sk, const bdaddr_t *addr)
diff --git a/android/socket.c b/android/socket.c
index 1fb154d..c2212d9 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -931,7 +931,7 @@ void bt_sock_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 		break;
 	}
 
-	ipc_send_rsp(sk, HAL_SERVICE_ID_SOCK, opcode, HAL_STATUS_FAILED);
+	ipc_send_rsp(HAL_SERVICE_ID_SOCK, opcode, HAL_STATUS_FAILED);
 }
 
 bool bt_socket_register(int sk, const bdaddr_t *addr)
-- 
1.8.3.2

