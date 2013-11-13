Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 1/3] android: Fix opcode parameter type from uint16_t to uint8_t
Date: Wed, 13 Nov 2013 11:25:25 +0200
Message-Id: <1384334727-25940-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-a2dp.c      | 2 +-
 android/hal-bluetooth.c | 2 +-
 android/hal-hidhost.c   | 2 +-
 android/hal.h           | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/android/hal-a2dp.c b/android/hal-a2dp.c
index f0c301e..4fe7c20 100644
--- a/android/hal-a2dp.c
+++ b/android/hal-a2dp.c
@@ -49,7 +49,7 @@ static void handle_audio_state(void *buf)
 }
 
 /* will be called from notification thread context */
-void bt_notify_a2dp(uint16_t opcode, void *buf, uint16_t len)
+void bt_notify_a2dp(uint8_t opcode, void *buf, uint16_t len)
 {
 	if (!interface_ready())
 		return;
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 3e5d41f..1cfd994 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -281,7 +281,7 @@ static void handle_acl_state_changed(void *buf)
 }
 
 /* will be called from notification thread context */
-void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len)
+void bt_notify_adapter(uint8_t opcode, void *buf, uint16_t len)
 {
 	if (!interface_ready())
 		return;
diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index 97a1aa0..2ce17a3 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -88,7 +88,7 @@ static void handle_virtual_unplug(void *buf)
 }
 
 /* will be called from notification thread context */
-void bt_notify_hidhost(uint16_t opcode, void *buf, uint16_t len)
+void bt_notify_hidhost(uint8_t opcode, void *buf, uint16_t len)
 {
 	if (!interface_ready())
 		return;
diff --git a/android/hal.h b/android/hal.h
index 2ce7932..baa4754 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -26,8 +26,8 @@ bthh_interface_t *bt_get_hidhost_interface(void);
 btpan_interface_t *bt_get_pan_interface(void);
 btav_interface_t *bt_get_a2dp_interface(void);
 
-void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len);
+void bt_notify_adapter(uint8_t opcode, void *buf, uint16_t len);
 void bt_thread_associate(void);
 void bt_thread_disassociate(void);
-void bt_notify_hidhost(uint16_t opcode, void *buf, uint16_t len);
-void bt_notify_a2dp(uint16_t opcode, void *buf, uint16_t len);
+void bt_notify_hidhost(uint8_t opcode, void *buf, uint16_t len);
+void bt_notify_a2dp(uint8_t opcode, void *buf, uint16_t len);
-- 
1.8.3.2

