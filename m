Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 1/3] android/socket: Make channel int32_t in IPC specification
Date: Sat,  4 Jan 2014 21:16:12 +0100
Message-Id: <1388866574-20158-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This match IPC type with type in socket HAL API. This allows to pass
data directly from HAL library and will allow to reduce logic in it.
---
 android/hal-msg.h | 20 ++++++++++----------
 android/socket.c  |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index c351501..bbbb99c 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -233,20 +233,20 @@ struct hal_cmd_le_test_mode {
 
 #define HAL_OP_SOCK_LISTEN		0x01
 struct hal_cmd_sock_listen {
-	uint8_t  type;
-	uint8_t  name[256];
-	uint8_t  uuid[16];
-	uint16_t channel;
-	uint8_t  flags;
+	uint8_t type;
+	uint8_t name[256];
+	uint8_t uuid[16];
+	int32_t channel;
+	uint8_t flags;
 } __attribute__((packed));
 
 #define HAL_OP_SOCK_CONNECT		0x02
 struct hal_cmd_sock_connect {
-	uint8_t  bdaddr[6];
-	uint8_t  type;
-	uint8_t  uuid[16];
-	uint16_t channel;
-	uint8_t  flags;
+	uint8_t bdaddr[6];
+	uint8_t type;
+	uint8_t uuid[16];
+	int32_t channel;
+	uint8_t flags;
 } __attribute__((packed));
 
 /* Bluetooth HID Host HAL API */
diff --git a/android/socket.c b/android/socket.c
index 11d64f8..f68fbf0 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -804,7 +804,7 @@ static void handle_listen(const void *buf, uint16_t len)
 
 	profile = get_profile_by_uuid(cmd->uuid);
 	if (!profile) {
-		if (!cmd->channel)
+		if (cmd->channel <= 0)
 			goto failed;
 
 		chan = cmd->channel;
-- 
1.8.5.2

