Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH BlueZ 1/8] emulator: Add support for pre/post command/event hooks
Date: Sat, 20 Jul 2013 20:17:13 -0400
Message-Id: <1374365840-14651-2-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1374365840-14651-1-git-send-email-bruna.moreira@openbossa.org>
References: <1374365840-14651-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

Now who use emulator can add hooks to manipulate hci packets before
and after process commands and send events.
---
 emulator/btdev.c |   37 +++++++++++++++++++++++++++++++++++++
 emulator/btdev.h |   15 +++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 79d2f0e..52b58ce 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -42,6 +42,15 @@
 #define has_bredr(btdev)	(!((btdev)->features[4] & 0x20))
 #define has_le(btdev)		(!!((btdev)->features[4] & 0x40))
 
+struct hook {
+	btdev_hook_func handler;
+	void *user_data;
+	enum btdev_hook_type type;
+	uint16_t opcode;
+};
+
+#define MAX_HOOK_ENTRIES 16
+
 struct btdev {
 	enum btdev_type type;
 
@@ -53,6 +62,8 @@ struct btdev {
 	btdev_send_func send_handler;
 	void *send_data;
 
+	struct hook *hook_list[MAX_HOOK_ENTRIES];
+
         uint16_t manufacturer;
         uint8_t  version;
 	uint16_t revision;
@@ -1689,3 +1700,29 @@ void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len)
 		break;
 	}
 }
+
+int btdev_add_hook(struct btdev *btdev, enum btdev_hook_type type,
+				uint16_t opcode, btdev_hook_func handler,
+				void *user_data)
+{
+	int i;
+
+	if (!btdev)
+		return -1;
+
+	for (i = 0; i < MAX_HOOK_ENTRIES; i++) {
+		if (btdev->hook_list[i] == NULL) {
+			btdev->hook_list[i] = malloc(sizeof(struct hook));
+			if (btdev->hook_list[i] == NULL)
+				return -1;
+
+			btdev->hook_list[i]->handler = handler;
+			btdev->hook_list[i]->user_data = user_data;
+			btdev->hook_list[i]->opcode = opcode;
+			btdev->hook_list[i]->type = type;
+			return i;
+		}
+	}
+
+	return -1;
+}
diff --git a/emulator/btdev.h b/emulator/btdev.h
index 9fb023c..085093f 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -23,6 +23,7 @@
  */
 
 #include <stdint.h>
+#include <stdbool.h>
 
 #define BTDEV_RESPONSE_DEFAULT		0
 #define BTDEV_RESPONSE_COMMAND_STATUS	1
@@ -53,6 +54,9 @@ typedef void (*btdev_command_func) (uint16_t opcode,
 typedef void (*btdev_send_func) (const void *data, uint16_t len,
 							void *user_data);
 
+typedef bool (*btdev_hook_func) (const void *data, uint16_t len,
+							void *user_data);
+
 enum btdev_type {
 	BTDEV_TYPE_BREDRLE,
 	BTDEV_TYPE_BREDR,
@@ -60,6 +64,13 @@ enum btdev_type {
 	BTDEV_TYPE_AMP,
 };
 
+enum btdev_hook_type {
+	BTDEV_HOOK_PRE_CMD,
+	BTDEV_HOOK_POST_CMD,
+	BTDEV_HOOK_PRE_EVT,
+	BTDEV_HOOK_POST_EVT,
+};
+
 struct btdev;
 
 struct btdev *btdev_create(enum btdev_type type, uint16_t id);
@@ -74,3 +85,7 @@ void btdev_set_send_handler(struct btdev *btdev, btdev_send_func handler,
 							void *user_data);
 
 void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len);
+
+int btdev_add_hook(struct btdev *btdev, enum btdev_hook_type type,
+				uint16_t opcode, btdev_hook_func handler,
+				void *user_data);
-- 
1.7.9.5

