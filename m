Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v3 1/8] emulator: add support for checking le scan state
Date: Wed,  2 Sep 2015 10:51:08 -0700
Message-Id: <1441216275-2954-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 emulator/btdev.c  | 5 +++++
 emulator/btdev.h  | 2 ++
 emulator/hciemu.c | 8 ++++++++
 emulator/hciemu.h | 2 ++
 4 files changed, 17 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index ceefd56..60e8e8c 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -669,6 +669,11 @@ uint8_t *btdev_get_features(struct btdev *btdev)
 	return btdev->features;
 }
 
+bool btdev_is_le_scan_enabled(struct btdev *btdev)
+{
+	return btdev->le_scan_enable;
+}
+
 static bool use_ssp(struct btdev *btdev1, struct btdev *btdev2)
 {
 	if (btdev1->auth_enable || btdev2->auth_enable)
diff --git a/emulator/btdev.h b/emulator/btdev.h
index 4b724a7..8b116e4 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -80,6 +80,8 @@ void btdev_destroy(struct btdev *btdev);
 const uint8_t *btdev_get_bdaddr(struct btdev *btdev);
 uint8_t *btdev_get_features(struct btdev *btdev);
 
+bool btdev_is_le_scan_enabled(struct btdev *btdev);
+
 void btdev_set_command_handler(struct btdev *btdev, btdev_command_func handler,
 							void *user_data);
 
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index 4881a24..c04aa6d 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -427,6 +427,14 @@ const uint8_t *hciemu_get_client_bdaddr(struct hciemu *hciemu)
 	return btdev_get_bdaddr(hciemu->client_dev);
 }
 
+const bool hciemu_is_master_le_scan_enabled(struct hciemu *hciemu)
+{
+	if (!hciemu || !hciemu->master_dev)
+		return NULL;
+
+	return btdev_is_le_scan_enabled(hciemu->master_dev);
+}
+
 bool hciemu_add_master_post_command_hook(struct hciemu *hciemu,
 			hciemu_command_func_t function, void *user_data)
 {
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index 41ca3fc..a526d8c 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -53,6 +53,8 @@ uint8_t *hciemu_get_features(struct hciemu *hciemu);
 const uint8_t *hciemu_get_master_bdaddr(struct hciemu *hciemu);
 const uint8_t *hciemu_get_client_bdaddr(struct hciemu *hciemu);
 
+const bool hciemu_is_master_le_scan_enabled(struct hciemu *hciemu);
+
 typedef void (*hciemu_command_func_t)(uint16_t opcode, const void *data,
 						uint8_t len, void *user_data);
 
-- 
2.1.4

