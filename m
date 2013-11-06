Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 08/14] android: Remove not needed buf len from Core service functions
Date: Wed, 6 Nov 2013 15:09:24 +0100
Message-ID: <1383746970-25906-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
References: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Message correctness is verified upon reception and handling functions
can simply make assumption that data in buffer is correct.
---
 android/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/android/main.c b/android/main.c
index 85ea270..d7e77a2 100644
--- a/android/main.c
+++ b/android/main.c
@@ -76,7 +76,7 @@ static GIOChannel *hal_notif_io = NULL;
 
 static bool services[HAL_SERVICE_ID_MAX + 1] = { false };
 
-static void service_register(void *buf, uint16_t len)
+static void service_register(void *buf)
 {
 	struct hal_cmd_register_module *m = buf;
 	const bdaddr_t *adapter_bdaddr = bt_adapter_get_address();
@@ -126,7 +126,7 @@ failed:
 	ipc_send_rsp(hal_cmd_io, HAL_SERVICE_ID_CORE, HAL_STATUS_FAILED);
 }
 
-static void service_unregister(void *buf, uint16_t len)
+static void service_unregister(void *buf)
 {
 	struct hal_cmd_unregister_module *m = buf;
 
@@ -167,14 +167,14 @@ failed:
 	ipc_send_rsp(hal_cmd_io, HAL_SERVICE_ID_CORE, HAL_STATUS_FAILED);
 }
 
-static void handle_service_core(uint8_t opcode, void *buf, uint16_t len)
+static void handle_service_core(uint8_t opcode, void *buf)
 {
 	switch (opcode) {
 	case HAL_OP_REGISTER_MODULE:
-		service_register(buf, len);
+		service_register(buf);
 		break;
 	case HAL_OP_UNREGISTER_MODULE:
-		service_unregister(buf, len);
+		service_unregister(buf);
 		break;
 	default:
 		ipc_send_rsp(hal_cmd_io, HAL_SERVICE_ID_CORE,
@@ -246,7 +246,7 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 
 	switch (msg->service_id) {
 	case HAL_SERVICE_ID_CORE:
-		handle_service_core(msg->opcode, buf + sizeof(*msg), msg->len);
+		handle_service_core(msg->opcode, buf + sizeof(*msg));
 		break;
 	case HAL_SERVICE_ID_BLUETOOTH:
 		bt_adapter_handle_cmd(hal_cmd_io, msg->opcode, msg->payload,
-- 
1.8.4.2

