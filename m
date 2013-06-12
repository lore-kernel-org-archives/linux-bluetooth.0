Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [RFC BlueZ 15/35] emulator: Export command and event hooks for hciemu user
Date: Wed, 12 Jun 2013 08:57:01 -0400
Message-Id: <1371041841-21793-16-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

---
 src/shared/hciemu.c |   30 ++++++++++++++++++++++++++++++
 src/shared/hciemu.h |   15 ++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/src/shared/hciemu.c b/src/shared/hciemu.c
index 7ff651e..4ebeff6 100644
--- a/src/shared/hciemu.c
+++ b/src/shared/hciemu.c
@@ -405,3 +405,33 @@ bool hciemu_add_master_post_command_hook(struct hciemu *hciemu,
 
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
index dc7cc1f..13575de 100644
--- a/src/shared/hciemu.h
+++ b/src/shared/hciemu.h
@@ -32,8 +32,14 @@ enum hciemu_type {
 	HCIEMU_TYPE_LE,
 };
 
-struct hciemu *hciemu_new(enum hciemu_type type);
+enum hciemu_hook_type {
+	HCIEMU_HOOK_PRE_CMD,
+	HCIEMU_HOOK_POST_CMD,
+	HCIEMU_HOOK_PRE_EVT,
+	HCIEMU_HOOK_POST_EVT,
+};
 
+struct hciemu *hciemu_new(enum hciemu_type type);
 struct hciemu *hciemu_ref(struct hciemu *hciemu);
 void hciemu_unref(struct hciemu *hciemu);
 
@@ -47,5 +53,12 @@ const uint8_t *hciemu_get_client_bdaddr(struct hciemu *hciemu);
 typedef bool (*hciemu_command_func_t)(uint16_t opcode, const void *data,
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

