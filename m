Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 1/3] emulator: Add getter function for device address in btdev
Date: Thu, 11 Apr 2013 11:24:42 -0400
Message-Id: <1365693884-15423-2-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1365693884-15423-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1365693884-15423-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This helper function returns bdaddr field from btdev.
---
 emulator/btdev.c | 5 +++++
 emulator/btdev.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index b74442e..41d0e0e 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -319,6 +319,11 @@ void btdev_set_bdaddr(struct btdev *btdev, uint8_t *bdaddr)
 	memcpy(btdev->bdaddr, bdaddr, 6);
 }
 
+const uint8_t *btdev_get_bdaddr(struct btdev *btdev)
+{
+	return btdev->bdaddr;
+}
+
 void btdev_set_command_handler(struct btdev *btdev, btdev_command_func handler,
 							void *user_data)
 {
diff --git a/emulator/btdev.h b/emulator/btdev.h
index ef71a9b..fb4df66 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -66,6 +66,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id);
 void btdev_destroy(struct btdev *btdev);
 
 void btdev_set_bdaddr(struct btdev *btdev, uint8_t *bdaddr);
+const uint8_t *btdev_get_bdaddr(struct btdev *btdev);
 
 void btdev_set_command_handler(struct btdev *btdev, btdev_command_func handler,
 							void *user_data);
-- 
1.8.2

