Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 7/8] emulator: Add new function for running all hooks
Date: Sat, 20 Jul 2013 20:17:19 -0400
Message-Id: <1374365840-14651-8-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1374365840-14651-1-git-send-email-bruna.moreira@openbossa.org>
References: <1374365840-14651-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It was defined four hook types and they are run before/after the first
part of default command processing and send event. Note that hook return
will define if the emulator will process/send next events (calling the
default_cmd_completion() function or not).
---
 emulator/btdev.c |   34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 006db8c..cc63658 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -132,6 +132,17 @@ static int get_hook_index(struct btdev *btdev, enum btdev_hook_type type,
 	return -1;
 }
 
+static bool run_hooks(struct btdev *btdev, enum btdev_hook_type type,
+				uint16_t opcode, const void *data, uint16_t len)
+{
+	int index = get_hook_index(btdev, type, opcode);
+	if (index < 0)
+		return true;
+
+	return btdev->hook_list[index]->handler(data, len,
+					btdev->hook_list[index]->user_data);
+}
+
 static inline int add_btdev(struct btdev *btdev)
 {
 	int i, index = -1;
@@ -532,7 +543,8 @@ static void send_event(struct btdev *btdev, uint8_t event,
 	if (len > 0)
 		memcpy(pkt_data + 1 + sizeof(*hdr), data, len);
 
-	send_packet(btdev, pkt_data, pkt_len);
+	if (run_hooks(btdev, BTDEV_HOOK_POST_EVT, event, pkt_data, pkt_len))
+		send_packet(btdev, pkt_data, pkt_len);
 
 	free(pkt_data);
 }
@@ -564,7 +576,8 @@ static void cmd_complete(struct btdev *btdev, uint16_t opcode,
 	if (len > 0)
 		memcpy(pkt_data + 1 + sizeof(*hdr) + sizeof(*cc), data, len);
 
-	send_packet(btdev, pkt_data, pkt_len);
+	if (run_hooks(btdev, BTDEV_HOOK_POST_CMD, opcode, pkt_data, pkt_len))
+		send_packet(btdev, pkt_data, pkt_len);
 
 	free(pkt_data);
 }
@@ -593,7 +606,8 @@ static void cmd_status(struct btdev *btdev, uint8_t status, uint16_t opcode)
 	cs->ncmd = 0x01;
 	cs->opcode = cpu_to_le16(opcode);
 
-	send_packet(btdev, pkt_data, pkt_len);
+	if (run_hooks(btdev, BTDEV_HOOK_POST_CMD, opcode, pkt_data, pkt_len))
+		send_packet(btdev, pkt_data, pkt_len);
 
 	free(pkt_data);
 }
@@ -1730,8 +1744,15 @@ static void handler_callback(btdev_callback callback, uint8_t response,
 
 	switch (response) {
 	case BTDEV_RESPONSE_DEFAULT:
+		if (!run_hooks(btdev, BTDEV_HOOK_PRE_CMD, callback->opcode,
+						callback->data, callback->len))
+			return;
 		default_cmd(btdev, callback->opcode,
 					callback->data, callback->len);
+
+		if (!run_hooks(btdev, BTDEV_HOOK_PRE_EVT, callback->opcode,
+						callback->data, callback->len))
+			return;
 		default_cmd_completion(btdev, callback->opcode,
 					callback->data, callback->len);
 		break;
@@ -1767,8 +1788,15 @@ static void process_cmd(struct btdev *btdev, const void *data, uint16_t len)
 					callback.data, callback.len,
 					&callback, btdev->command_data);
 	else {
+		if (!run_hooks(btdev, BTDEV_HOOK_PRE_CMD, callback.opcode,
+						callback.data, callback.len))
+			return;
 		default_cmd(btdev, callback.opcode,
 					callback.data, callback.len);
+
+		if (!run_hooks(btdev, BTDEV_HOOK_PRE_EVT, callback.opcode,
+						callback.data, callback.len))
+			return;
 		default_cmd_completion(btdev, callback.opcode,
 					callback.data, callback.len);
 	}
-- 
1.7.9.5

