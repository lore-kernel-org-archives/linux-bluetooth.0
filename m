Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 02/15] android/hardware: Update bt_hf_client.h header
Date: Thu,  6 Nov 2014 17:05:47 +0200
Message-Id: <1415286360-26268-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hardware/bt_hf_client.h | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/android/hardware/bt_hf_client.h b/android/hardware/bt_hf_client.h
index b9c351c..8acf1b2 100644
--- a/android/hardware/bt_hf_client.h
+++ b/android/hardware/bt_hf_client.h
@@ -1,7 +1,5 @@
 /*
- * Copyright (c) 2013, The Linux Foundation. All rights reserved.
- * Not a Contribution
- * Copyright (C) 2012 The Android Open Source Project
+ * Copyright (C) 2012-2014 The Android Open Source Project
  *
  * Licensed under the Apache License, Version 2.0 (the "License");
  * you may not use this file except in compliance with the License.
@@ -154,23 +152,31 @@ typedef enum {
 
 /* Peer call handling features masks */
 #define BTHF_CLIENT_CHLD_FEAT_REL           0x00000001  /* 0  Release waiting call or held calls */
-#define BTHF_CLIENT_CHLD_FEAT_REL_ACC       0x00000002  /* 1  Release active calls and accept other (waiting or held) cal */
+#define BTHF_CLIENT_CHLD_FEAT_REL_ACC       0x00000002  /* 1  Release active calls and accept other
+                                                              (waiting or held) cal */
 #define BTHF_CLIENT_CHLD_FEAT_REL_X         0x00000004  /* 1x Release specified active call only */
-#define BTHF_CLIENT_CHLD_FEAT_HOLD_ACC      0x00000008  /* 2  Active calls on hold and accept other (waiting or held) call */
-#define BTHF_CLIENT_CHLD_FEAT_PRIV_X        0x00000010  /* 2x Request private mode with specified call (put the rest on hold) */
+#define BTHF_CLIENT_CHLD_FEAT_HOLD_ACC      0x00000008  /* 2  Active calls on hold and accept other
+                                                              (waiting or held) call */
+#define BTHF_CLIENT_CHLD_FEAT_PRIV_X        0x00000010  /* 2x Request private mode with specified
+                                                              call (put the rest on hold) */
 #define BTHF_CLIENT_CHLD_FEAT_MERGE         0x00000020  /* 3  Add held call to multiparty */
-#define BTHF_CLIENT_CHLD_FEAT_MERGE_DETACH  0x00000040  /* 4  Connect two calls and leave (disconnect from) multiparty */
+#define BTHF_CLIENT_CHLD_FEAT_MERGE_DETACH  0x00000040  /* 4  Connect two calls and leave
+                                                              (disconnect from) multiparty */
 
 /** Callback for connection state change.
  *  state will have one of the values from BtHfConnectionState
  *  peer/chld_features are valid only for BTHF_CLIENT_CONNECTION_STATE_SLC_CONNECTED state
  */
-typedef void (* bthf_client_connection_state_callback)(bthf_client_connection_state_t state, unsigned int peer_feat, unsigned int chld_feat, bt_bdaddr_t *bd_addr);
+typedef void (* bthf_client_connection_state_callback)(bthf_client_connection_state_t state,
+                                                       unsigned int peer_feat,
+                                                       unsigned int chld_feat,
+                                                       bt_bdaddr_t *bd_addr);
 
 /** Callback for audio connection state change.
  *  state will have one of the values from BtHfAudioState
  */
-typedef void (* bthf_client_audio_state_callback)(bthf_client_audio_state_t state, bt_bdaddr_t *bd_addr);
+typedef void (* bthf_client_audio_state_callback)(bthf_client_audio_state_t state,
+                                                  bt_bdaddr_t *bd_addr);
 
 /** Callback for VR connection state change.
  *  state will have one of the values from BtHfVRState
@@ -243,7 +249,8 @@ typedef void (*bthf_client_cmd_complete_callback) (bthf_client_cmd_complete_t ty
 
 /** Callback for subscriber information
  */
-typedef void (* bthf_client_subscriber_info_callback) (const char *name, bthf_client_subscriber_service_type_t type);
+typedef void (* bthf_client_subscriber_info_callback) (const char *name,
+                                                       bthf_client_subscriber_service_type_t type);
 
 /** Callback for in-band ring tone settings
  */
@@ -346,6 +353,9 @@ typedef struct {
 
     /** Closes the interface. */
     void (*cleanup)(void);
+
+    /** Send AT Command. */
+    bt_status_t (*send_at_cmd) (int cmd, int val1, int val2, const char *arg);
 } bthf_client_interface_t;
 
 __END_DECLS
-- 
1.9.1

