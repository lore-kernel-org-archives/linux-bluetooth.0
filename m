Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 07/15] android/hardware: Update bt_hf.h header
Date: Thu,  6 Nov 2014 17:05:52 +0200
Message-Id: <1415286360-26268-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hardware/bt_hf.h | 63 ++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/android/hardware/bt_hf.h b/android/hardware/bt_hf.h
index 6135ac4..7dcb40a 100644
--- a/android/hardware/bt_hf.h
+++ b/android/hardware/bt_hf.h
@@ -57,6 +57,14 @@ typedef enum
     BTHF_NREC_START
 } bthf_nrec_t;
 
+/* WBS codec setting */
+typedef enum
+{
+   BTHF_WBS_NONE,
+   BTHF_WBS_NO,
+   BTHF_WBS_YES
+}bthf_wbs_config_t;
+
 /* CHLD - Call held handling */
 typedef enum
 {
@@ -79,65 +87,70 @@ typedef void (* bthf_audio_state_callback)(bthf_audio_state_t state, bt_bdaddr_t
 /** Callback for VR connection state change.
  *  state will have one of the values from BtHfVRState
  */
-typedef void (* bthf_vr_cmd_callback)(bthf_vr_state_t state);
+typedef void (* bthf_vr_cmd_callback)(bthf_vr_state_t state, bt_bdaddr_t *bd_addr);
 
 /** Callback for answer incoming call (ATA)
  */
-typedef void (* bthf_answer_call_cmd_callback)();
+typedef void (* bthf_answer_call_cmd_callback)(bt_bdaddr_t *bd_addr);
 
 /** Callback for disconnect call (AT+CHUP)
  */
-typedef void (* bthf_hangup_call_cmd_callback)();
+typedef void (* bthf_hangup_call_cmd_callback)(bt_bdaddr_t *bd_addr);
 
 /** Callback for disconnect call (AT+CHUP)
  *  type will denote Speaker/Mic gain (BtHfVolumeControl).
  */
-typedef void (* bthf_volume_cmd_callback)(bthf_volume_type_t type, int volume);
+typedef void (* bthf_volume_cmd_callback)(bthf_volume_type_t type, int volume, bt_bdaddr_t *bd_addr);
 
 /** Callback for dialing an outgoing call
  *  If number is NULL, redial
  */
-typedef void (* bthf_dial_call_cmd_callback)(char *number);
+typedef void (* bthf_dial_call_cmd_callback)(char *number, bt_bdaddr_t *bd_addr);
 
 /** Callback for sending DTMF tones
  *  tone contains the dtmf character to be sent
  */
-typedef void (* bthf_dtmf_cmd_callback)(char tone);
+typedef void (* bthf_dtmf_cmd_callback)(char tone, bt_bdaddr_t *bd_addr);
 
 /** Callback for enabling/disabling noise reduction/echo cancellation
  *  value will be 1 to enable, 0 to disable
  */
-typedef void (* bthf_nrec_cmd_callback)(bthf_nrec_t nrec);
+typedef void (* bthf_nrec_cmd_callback)(bthf_nrec_t nrec, bt_bdaddr_t *bd_addr);
+
+/** Callback for AT+BCS and event from BAC
+ *  WBS enable, WBS disable
+ */
+typedef void (* bthf_wbs_callback)(bthf_wbs_config_t wbs, bt_bdaddr_t *bd_addr);
 
 /** Callback for call hold handling (AT+CHLD)
  *  value will contain the call hold command (0, 1, 2, 3)
  */
-typedef void (* bthf_chld_cmd_callback)(bthf_chld_type_t chld);
+typedef void (* bthf_chld_cmd_callback)(bthf_chld_type_t chld, bt_bdaddr_t *bd_addr);
 
 /** Callback for CNUM (subscriber number)
  */
-typedef void (* bthf_cnum_cmd_callback)();
+typedef void (* bthf_cnum_cmd_callback)(bt_bdaddr_t *bd_addr);
 
 /** Callback for indicators (CIND)
  */
-typedef void (* bthf_cind_cmd_callback)();
+typedef void (* bthf_cind_cmd_callback)(bt_bdaddr_t *bd_addr);
 
 /** Callback for operator selection (COPS)
  */
-typedef void (* bthf_cops_cmd_callback)();
+typedef void (* bthf_cops_cmd_callback)(bt_bdaddr_t *bd_addr);
 
 /** Callback for call list (AT+CLCC)
  */
-typedef void (* bthf_clcc_cmd_callback) ();
+typedef void (* bthf_clcc_cmd_callback) (bt_bdaddr_t *bd_addr);
 
 /** Callback for unknown AT command recd from HF
  *  at_string will contain the unparsed AT string
  */
-typedef void (* bthf_unknown_at_cmd_callback)(char *at_string);
+typedef void (* bthf_unknown_at_cmd_callback)(char *at_string, bt_bdaddr_t *bd_addr);
 
 /** Callback for keypressed (HSP) event.
  */
-typedef void (* bthf_key_pressed_cmd_callback)();
+typedef void (* bthf_key_pressed_cmd_callback)(bt_bdaddr_t *bd_addr);
 
 /** BT-HF callback structure. */
 typedef struct {
@@ -152,6 +165,7 @@ typedef struct {
     bthf_dial_call_cmd_callback     dial_call_cmd_cb;
     bthf_dtmf_cmd_callback          dtmf_cmd_cb;
     bthf_nrec_cmd_callback          nrec_cmd_cb;
+    bthf_wbs_callback               wbs_cb;
     bthf_chld_cmd_callback          chld_cmd_cb;
     bthf_cnum_cmd_callback          cnum_cmd_cb;
     bthf_cind_cmd_callback          cind_cmd_cb;
@@ -213,7 +227,7 @@ typedef struct {
     /**
      * Register the BtHf callbacks
      */
-    bt_status_t (*init)( bthf_callbacks_t* callbacks );
+    bt_status_t (*init)( bthf_callbacks_t* callbacks, int max_hf_clients);
 
     /** connect to headset */
     bt_status_t (*connect)( bt_bdaddr_t *bd_addr );
@@ -228,33 +242,33 @@ typedef struct {
     bt_status_t (*disconnect_audio)( bt_bdaddr_t *bd_addr );
 
     /** start voice recognition */
-    bt_status_t (*start_voice_recognition)();
+    bt_status_t (*start_voice_recognition)( bt_bdaddr_t *bd_addr );
 
     /** stop voice recognition */
-    bt_status_t (*stop_voice_recognition)();
+    bt_status_t (*stop_voice_recognition)( bt_bdaddr_t *bd_addr );
 
     /** volume control */
-    bt_status_t (*volume_control) (bthf_volume_type_t type, int volume);
+    bt_status_t (*volume_control) (bthf_volume_type_t type, int volume, bt_bdaddr_t *bd_addr );
 
     /** Combined device status change notification */
     bt_status_t (*device_status_notification)(bthf_network_state_t ntk_state, bthf_service_type_t svc_type, int signal,
                            int batt_chg);
 
     /** Response for COPS command */
-    bt_status_t (*cops_response)(const char *cops);
+    bt_status_t (*cops_response)(const char *cops, bt_bdaddr_t *bd_addr );
 
     /** Response for CIND command */
     bt_status_t (*cind_response)(int svc, int num_active, int num_held, bthf_call_state_t call_setup_state,
-                                 int signal, int roam, int batt_chg);
+                                 int signal, int roam, int batt_chg, bt_bdaddr_t *bd_addr );
 
     /** Pre-formatted AT response, typically in response to unknown AT cmd */
-    bt_status_t (*formatted_at_response)(const char *rsp);
+    bt_status_t (*formatted_at_response)(const char *rsp, bt_bdaddr_t *bd_addr );
 
     /** ok/error response
      *  ERROR (0)
      *  OK    (1)
      */
-    bt_status_t (*at_response) (bthf_at_response_t response_code, int error_code);
+    bt_status_t (*at_response) (bthf_at_response_t response_code, int error_code, bt_bdaddr_t *bd_addr );
 
     /** response for CLCC command 
      *  Can be iteratively called for each call index
@@ -263,7 +277,7 @@ typedef struct {
     bt_status_t (*clcc_response) (int index, bthf_call_direction_t dir,
                                 bthf_call_state_t state, bthf_call_mode_t mode,
                                 bthf_call_mpty_type_t mpty, const char *number,
-                                bthf_call_addrtype_t type);
+                                bthf_call_addrtype_t type, bt_bdaddr_t *bd_addr );
 
     /** notify of a call state change
      *  Each update notifies 
@@ -277,6 +291,9 @@ typedef struct {
 
     /** Closes the interface. */
     void  (*cleanup)( void );
+
+    /** configureation for the SCO codec */
+    bt_status_t (*configure_wbs)( bt_bdaddr_t *bd_addr ,bthf_wbs_config_t config );
 } bthf_interface_t;
 
 __END_DECLS
-- 
1.9.1

