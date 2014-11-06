Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 13/14] android/handsfree: Add support for new API for unknown_at_cmd_cb
Date: Thu,  6 Nov 2014 10:32:08 +0200
Message-Id: <1415262729-12573-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415262729-12573-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415262729-12573-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Unknown AT Command notification callback has new parameter bdaddr.
---
 android/hal-handsfree.c | 5 +++++
 android/hal-ipc-api.txt | 3 ++-
 android/hal-msg.h       | 1 +
 android/handsfree.c     | 2 ++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 83d9909..76e036a 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -228,7 +228,12 @@ static void handle_unknown_at(void *buf, uint16_t len, int fd)
 	}
 
 	if (cbs->unknown_at_cmd_cb)
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+		cbs->unknown_at_cmd_cb((char *) ev->buf,
+						(bt_bdaddr_t *) (ev->bdaddr));
+#else
 		cbs->unknown_at_cmd_cb((char *) ev->buf);
+#endif
 }
 
 static void handle_hsp_key_press(void *buf, uint16_t len, int fd)
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 9c9ac35..3e8a38c 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1076,7 +1076,8 @@ Notifications:
 
 	Opcode 0x8f - Unknown AT Command notification
 
-		Notification parameters: AT command (string)
+		Notification parameters: Remote address (6 octets)
+		                         AT command (string)
 
 	Opcode 0x90 - Key Pressed Command notification
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 9b9c2b0..f86e6b7 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1421,6 +1421,7 @@ struct hal_ev_handsfree_clcc {
 
 #define HAL_EV_HANDSFREE_UNKNOWN_AT	0x8F
 struct hal_ev_handsfree_unknown_at {
+	uint8_t bdaddr[6];
 	uint16_t len;
 	uint8_t buf[0];
 } __attribute__((packed));
diff --git a/android/handsfree.c b/android/handsfree.c
index 9eaf38f..d9cb929 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -329,6 +329,8 @@ static void at_cmd_unknown(const char *command, void *user_data)
 		return;
 	}
 
+	bdaddr2android(&dev->bdaddr, ev->bdaddr);
+
 	/* copy while string including terminating NULL */
 	ev->len = strlen(command) + 1;
 	memcpy(ev->buf, command, ev->len);
-- 
1.9.1

