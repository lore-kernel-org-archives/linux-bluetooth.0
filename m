Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 15/15] android/hardware: Update bt_rc.h header
Date: Thu,  6 Nov 2014 17:06:00 +0200
Message-Id: <1415286360-26268-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hardware/bt_rc.h | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/android/hardware/bt_rc.h b/android/hardware/bt_rc.h
index d455543..c565c48 100644
--- a/android/hardware/bt_rc.h
+++ b/android/hardware/bt_rc.h
@@ -171,7 +171,7 @@ typedef void (* btrc_volume_change_callback) (uint8_t volume, uint8_t ctype);
 /** Callback for passthrough commands */
 typedef void (* btrc_passthrough_cmd_callback) (int id, int key_state);
 
-/** BT-RC callback structure. */
+/** BT-RC Target callback structure. */
 typedef struct {
     /** set to sizeof(BtRcCallbacks) */
     size_t      size;
@@ -189,7 +189,7 @@ typedef struct {
     btrc_passthrough_cmd_callback               passthrough_cmd_cb;
 } btrc_callbacks_t;
 
-/** Represents the standard BT-RC interface. */
+/** Represents the standard BT-RC AVRCP Target interface. */
 typedef struct {
 
     /** set to sizeof(BtRcInterface) */
@@ -261,6 +261,36 @@ typedef struct {
     void  (*cleanup)( void );
 } btrc_interface_t;
 
+
+typedef void (* btrc_passthrough_rsp_callback) (int id, int key_state);
+
+typedef void (* btrc_connection_state_callback) (bool state, bt_bdaddr_t *bd_addr);
+
+/** BT-RC Controller callback structure. */
+typedef struct {
+    /** set to sizeof(BtRcCallbacks) */
+    size_t      size;
+    btrc_passthrough_rsp_callback               passthrough_rsp_cb;
+    btrc_connection_state_callback              connection_state_cb;
+} btrc_ctrl_callbacks_t;
+
+/** Represents the standard BT-RC AVRCP Controller interface. */
+typedef struct {
+
+    /** set to sizeof(BtRcInterface) */
+    size_t          size;
+    /**
+     * Register the BtRc callbacks
+     */
+    bt_status_t (*init)( btrc_ctrl_callbacks_t* callbacks );
+
+    /** send pass through command to target */
+    bt_status_t (*send_pass_through_cmd) ( bt_bdaddr_t *bd_addr, uint8_t key_code, uint8_t key_state );
+
+    /** Closes the interface. */
+    void  (*cleanup)( void );
+} btrc_ctrl_interface_t;
+
 __END_DECLS
 
 #endif /* ANDROID_INCLUDE_BT_RC_H */
-- 
1.9.1

