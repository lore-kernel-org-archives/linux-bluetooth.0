Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 1/5] android/hal: Add initial socket implementation
Date: Mon, 28 Oct 2013 13:30:05 +0100
Message-ID: <1382963409-1012-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added socket api opcodes and structures and its implementation
in hal-sock.c.
---
 android/hal-msg.h  | 20 ++++++++++++++++++++
 android/hal-sock.c | 28 ++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 677b00b..ec7d181 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -213,6 +213,26 @@ struct hal_cmd_le_test_mode {
 	uint8_t  data[0];
 } __attribute__((packed));
 
+/* Bluetooth Socket HAL api */
+
+#define HAL_OP_SOCK_LISTEN		0x01
+struct hal_op_sock_listen {
+	uint8_t type;
+	uint8_t name[256];
+	uint8_t uuid[16];
+	uint16_t channel;
+	uint8_t flags;
+} __attribute__((packed));
+
+#define HAL_OP_SOCK_CONNECT		0x02
+struct hal_op_sock_connect {
+	uint8_t bdaddr[6];
+	uint8_t type;
+	uint8_t uuid[16];
+	uint16_t channel;
+	uint8_t flags;
+} __attribute__((packed));
+
 #define HAL_OP_HID_CONNECT		0x01
 struct hal_cmd_hid_connect {
 	uint8_t bdaddr[6];
diff --git a/android/hal-sock.c b/android/hal-sock.c
index 7642ee3..131877a 100644
--- a/android/hal-sock.c
+++ b/android/hal-sock.c
@@ -15,18 +15,33 @@
  *
  */
 
+#include <stdbool.h>
+#include <stdint.h>
 #include <stdlib.h>
+#include <string.h>
 
+#include "hal-ipc.h"
 #include "hal-log.h"
+#include "hal-msg.h"
 #include "hal.h"
 
 static bt_status_t sock_listen_rfcomm(const char *service_name,
 					const uint8_t *uuid, int chan,
 					int *sock, int flags)
 {
+	struct hal_op_sock_listen cmd;
+
 	DBG("");
 
-	return BT_STATUS_UNSUPPORTED;
+	cmd.flags = flags;
+	cmd.type = BTSOCK_RFCOMM;
+	cmd.channel = chan;
+	memcpy(cmd.uuid, uuid, sizeof(cmd.uuid));
+	memset(cmd.name, 0, sizeof(cmd.name));
+	memcpy(cmd.name, service_name, strlen(service_name));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_LISTEN,
+				sizeof(cmd), &cmd, NULL, NULL, sock);
 }
 
 static bt_status_t sock_listen(btsock_type_t type, const char *service_name,
@@ -58,6 +73,8 @@ static bt_status_t sock_connect(const bt_bdaddr_t *bdaddr, btsock_type_t type,
 					const uint8_t *uuid, int chan,
 					int *sock, int flags)
 {
+	struct hal_op_sock_connect cmd;
+
 	if ((!uuid && chan <= 0) || !bdaddr || !sock) {
 		error("invalid params: bd_addr %p, uuid %p, chan %d, sock %p",
 					bdaddr, uuid, chan, sock);
@@ -66,7 +83,14 @@ static bt_status_t sock_connect(const bt_bdaddr_t *bdaddr, btsock_type_t type,
 
 	DBG("uuid %p chan %d sock %p type %d", uuid, chan, sock, type);
 
-	return BT_STATUS_UNSUPPORTED;
+	cmd.flags = flags;
+	cmd.type = type;
+	cmd.channel = chan;
+	memcpy(cmd.uuid, uuid, sizeof(cmd.uuid));
+	memcpy(cmd.bdaddr, bdaddr, sizeof(cmd.bdaddr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_CONNECT,
+					sizeof(cmd), &cmd, NULL, NULL, sock);
 }
 
 static btsock_interface_t sock_if = {
-- 
1.8.2.2

