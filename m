Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH BlueZ 3/8] emulator: Export command and event hooks for hciemu user
Date: Sat, 20 Jul 2013 20:17:15 -0400
Message-Id: <1374365840-14651-4-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1374365840-14651-1-git-send-email-bruna.moreira@openbossa.org>
References: <1374365840-14651-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

---
 src/shared/hciemu.c |   30 ++++++++++++++++++++++++++++++
 src/shared/hciemu.h |   14 ++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/src/shared/hciemu.c b/src/shared/hciemu.c
index a0b347c..76fd449 100644
--- a/src/shared/hciemu.c
+++ b/src/shared/hciemu.c
@@ -389,3 +389,33 @@ bool hciemu_add_master_post_command_hook(struct hciemu *hciemu,
 
 	return true;
 }
+
+int hciemu_add_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
+				uint16_t opcode, hciemu_hook_func_t function,
+				void *user_data)
+{
+	enum btdev_hook_type hook_type;
+
+	if (!hciemu)
+		return -1;
+
+	switch (type) {
+	case HCIEMU_HOOK_PRE_CMD:
+		hook_type = BTDEV_HOOK_PRE_CMD;
+		break;
+	case HCIEMU_HOOK_POST_CMD:
+		hook_type = BTDEV_HOOK_POST_CMD;
+		break;
+	case HCIEMU_HOOK_PRE_EVT:
+		hook_type = BTDEV_HOOK_PRE_EVT;
+		break;
+	case HCIEMU_HOOK_POST_EVT:
+		hook_type = BTDEV_HOOK_POST_EVT;
+		break;
+	default:
+		return -1;
+	}
+
+	return btdev_add_hook(hciemu->master_dev, hook_type, opcode, function,
+								user_data);
+}
diff --git a/src/shared/hciemu.h b/src/shared/hciemu.h
index a473c0e..899acb0 100644
--- a/src/shared/hciemu.h
+++ b/src/shared/hciemu.h
@@ -32,6 +32,13 @@ enum hciemu_type {
 	HCIEMU_TYPE_LE,
 };
 
+enum hciemu_hook_type {
+	HCIEMU_HOOK_PRE_CMD,
+	HCIEMU_HOOK_POST_CMD,
+	HCIEMU_HOOK_PRE_EVT,
+	HCIEMU_HOOK_POST_EVT,
+};
+
 struct hciemu *hciemu_new(enum hciemu_type type);
 
 struct hciemu *hciemu_ref(struct hciemu *hciemu);
@@ -47,5 +54,12 @@ const uint8_t *hciemu_get_client_bdaddr(struct hciemu *hciemu);
 typedef void (*hciemu_command_func_t)(uint16_t opcode, const void *data,
 						uint8_t len, void *user_data);
 
+typedef bool (*hciemu_hook_func_t)(const void *data, uint16_t len,
+							void *user_data);
+
 bool hciemu_add_master_post_command_hook(struct hciemu *hciemu,
 			hciemu_command_func_t function, void *user_data);
+
+int hciemu_add_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
+				uint16_t opcode, hciemu_hook_func_t function,
+				void *user_data);
-- 
1.7.9.5

