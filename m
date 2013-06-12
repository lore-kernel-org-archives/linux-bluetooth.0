Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [RFC BlueZ 16/35] emulator: Add support for delete a hook
Date: Wed, 12 Jun 2013 08:57:02 -0400
Message-Id: <1371041841-21793-17-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

---
 emulator/btdev.c    |   25 +++++++++++++++++++++++++
 emulator/btdev.h    |    3 +++
 src/shared/hciemu.c |   28 ++++++++++++++++++++++++++++
 src/shared/hciemu.h |    3 +++
 4 files changed, 59 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 1006e03..13f99bc 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1893,3 +1893,28 @@ int btdev_add_hook(struct btdev *btdev, enum btdev_hook_type type,
 
 	return -1;
 }
+
+bool btdev_del_hook(struct btdev *btdev, enum btdev_hook_type type,
+								uint16_t opcode)
+{
+	int i;
+
+	if (!btdev)
+		return false;
+
+	for (i = 0; i < MAX_HOOK_ENTRIES; i++) {
+		if (btdev->hook_list[i] == NULL)
+			continue;
+
+		if (btdev->hook_list[i]->type != type ||
+					btdev->hook_list[i]->opcode != opcode)
+			continue;
+
+		free(btdev->hook_list[i]);
+		btdev->hook_list[i] = NULL;
+
+		return true;
+	}
+
+	return false;
+}
diff --git a/emulator/btdev.h b/emulator/btdev.h
index 085093f..5118a4a 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -89,3 +89,6 @@ void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len);
 int btdev_add_hook(struct btdev *btdev, enum btdev_hook_type type,
 				uint16_t opcode, btdev_hook_func handler,
 				void *user_data);
+
+bool btdev_del_hook(struct btdev *btdev, enum btdev_hook_type type,
+							uint16_t opcode);
diff --git a/src/shared/hciemu.c b/src/shared/hciemu.c
index 4ebeff6..0bbaa09 100644
--- a/src/shared/hciemu.c
+++ b/src/shared/hciemu.c
@@ -435,3 +435,31 @@ int hciemu_add_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
 	return btdev_add_hook(hciemu->master_dev, hook_type, opcode, function,
 								user_data);
 }
+
+bool hciemu_del_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
+								uint16_t opcode)
+{
+	enum btdev_hook_type hook_type;
+
+	if (!hciemu)
+		return false;
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
+		return false;
+	}
+
+	return btdev_del_hook(hciemu->master_dev, hook_type, opcode);
+}
diff --git a/src/shared/hciemu.h b/src/shared/hciemu.h
index 13575de..2abf404 100644
--- a/src/shared/hciemu.h
+++ b/src/shared/hciemu.h
@@ -62,3 +62,6 @@ bool hciemu_add_master_post_command_hook(struct hciemu *hciemu,
 int hciemu_add_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
 				uint16_t opcode, hciemu_hook_func_t function,
 				void *user_data);
+
+bool hciemu_del_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
+							uint16_t opcode);
-- 
1.7.9.5

