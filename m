Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 2/4] android/client: Add code for handsfree callbacks
Date: Mon, 28 Oct 2013 12:39:01 +0100
Message-ID: <1382960343-10765-3-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1382960343-10765-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1382960343-10765-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds implementation for handsfree callbacks.
---
 android/client/if-hf.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/android/client/if-hf.c b/android/client/if-hf.c
index e4065df..43c7f47 100644
--- a/android/client/if-hf.c
+++ b/android/client/if-hf.c
@@ -106,6 +106,8 @@ ENDMAP
 
 /* Callbacks */
 
+static char last_addr[MAX_ADDR_STR_LEN];
+
 /*
  * Callback for connection state change.
  * state will have one of the values from BtHfConnectionState
@@ -113,6 +115,9 @@ ENDMAP
 static void connection_state_cb(bthf_connection_state_t state,
 							bt_bdaddr_t *bd_addr)
 {
+	haltest_info("%s: state=%s bd_addr=%s\n", __func__,
+					bthf_connection_state_t2str(state),
+					bt_bdaddr_t2str(bd_addr, last_addr));
 }
 
 /*
@@ -121,6 +126,9 @@ static void connection_state_cb(bthf_connection_state_t state,
  */
 static void audio_state_cb(bthf_audio_state_t state, bt_bdaddr_t *bd_addr)
 {
+	haltest_info("%s: state=%s bd_addr=%s\n", __func__,
+					bthf_audio_state_t2str(state),
+					bt_bdaddr_t2str(bd_addr, last_addr));
 }
 
 /*
@@ -129,16 +137,19 @@ static void audio_state_cb(bthf_audio_state_t state, bt_bdaddr_t *bd_addr)
  */
 static void vr_cmd_cb(bthf_vr_state_t state)
 {
+	haltest_info("%s: state=%s\n", __func__, bthf_vr_state_t2str(state));
 }
 
 /* Callback for answer incoming call (ATA) */
 static void answer_call_cmd_cb(void)
 {
+	haltest_info("%s\n", __func__);
 }
 
 /* Callback for disconnect call (AT+CHUP) */
 static void hangup_call_cmd_cb(void)
 {
+	haltest_info("%s\n", __func__);
 }
 
 /*
@@ -147,6 +158,8 @@ static void hangup_call_cmd_cb(void)
  */
 static void volume_cmd_cb(bthf_volume_type_t type, int volume)
 {
+	haltest_info("%s: type=%s volume=%d\n", __func__,
+					bthf_volume_type_t2str(type), volume);
 }
 
 /*
@@ -155,6 +168,7 @@ static void volume_cmd_cb(bthf_volume_type_t type, int volume)
  */
 static void dial_call_cmd_cb(char *number)
 {
+	haltest_info("%s: number=%s\n", __func__, number);
 }
 
 /*
@@ -163,6 +177,7 @@ static void dial_call_cmd_cb(char *number)
  */
 static void dtmf_cmd_cb(char tone)
 {
+	haltest_info("%s: tone=%d\n", __func__, tone);
 }
 
 /*
@@ -171,6 +186,7 @@ static void dtmf_cmd_cb(char tone)
  */
 static void nrec_cmd_cb(bthf_nrec_t nrec)
 {
+	haltest_info("%s: nrec=%s\n", __func__, bthf_nrec_t2str(nrec));
 }
 
 /*
@@ -179,26 +195,31 @@ static void nrec_cmd_cb(bthf_nrec_t nrec)
  */
 static void chld_cmd_cb(bthf_chld_type_t chld)
 {
+	haltest_info("%s: chld=%s\n", __func__, bthf_chld_type_t2str(chld));
 }
 
 /* Callback for CNUM (subscriber number) */
 static void cnum_cmd_cb(void)
 {
+	haltest_info("%s\n", __func__);
 }
 
 /* Callback for indicators (CIND) */
 static void cind_cmd_cb(void)
 {
+	haltest_info("%s\n", __func__);
 }
 
 /* Callback for operator selection (COPS) */
 static void cops_cmd_cb(void)
 {
+	haltest_info("%s\n", __func__);
 }
 
 /* Callback for call list (AT+CLCC) */
 static void clcc_cmd_cb(void)
 {
+	haltest_info("%s\n", __func__);
 }
 
 /*
@@ -207,11 +228,13 @@ static void clcc_cmd_cb(void)
  */
 static void unknown_at_cmd_cb(char *at_string)
 {
+	haltest_info("%s: at_string=%s\n", __func__, at_string);
 }
 
 /* Callback for keypressed (HSP) event. */
 static void key_pressed_cmd_cb(void)
 {
+	haltest_info("%s\n", __func__);
 }
 
 static bthf_callbacks_t hf_cbacks = {
-- 
1.7.9.5

