Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 1/4] android/client: Add skeleton for handsfree calls
Date: Mon, 28 Oct 2013 12:39:00 +0100
Message-ID: <1382960343-10765-2-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1382960343-10765-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1382960343-10765-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds skeleton for all methods of handsfree along with
all callbacks.
---
 Makefile.android         |    2 +
 android/Android.mk       |    1 +
 android/client/haltest.c |    1 +
 android/client/if-bt.c   |    2 +-
 android/client/if-hf.c   |  368 ++++++++++++++++++++++++++++++++++++++++++++++
 android/client/if-main.h |    2 +
 6 files changed, 375 insertions(+), 1 deletion(-)
 create mode 100644 android/client/if-hf.c

diff --git a/Makefile.android b/Makefile.android
index 01b3cea..fd8043c 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -51,6 +51,7 @@ android_haltest_SOURCES = android/client/haltest.c \
 				android/client/tabcompletion.c \
 				android/client/if-av.c \
 				android/client/if-bt.c \
+				android/client/if-hf.c \
 				android/client/if-hh.c \
 				android/client/if-pan.c \
 				android/client/if-sock.c \
@@ -81,6 +82,7 @@ EXTRA_DIST += android/client/terminal.c \
 		android/client/history.c \
 		android/client/if-av.c \
 		android/client/if-bt.c \
+		android/client/if-hf.c \
 		android/client/if-hh.c \
 		android/client/if-pan.c \
 		android/client/if-sock.c \
diff --git a/android/Android.mk b/android/Android.mk
index 56c43cb..22208e0 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -104,6 +104,7 @@ LOCAL_SRC_FILES := \
 	client/tabcompletion.c \
 	client/if-av.c \
 	client/if-bt.c \
+	client/if-hf.c \
 	client/if-hh.c \
 	client/if-pan.c \
 	client/if-sock.c \
diff --git a/android/client/haltest.c b/android/client/haltest.c
index 6b4030b..7fe0436 100644
--- a/android/client/haltest.c
+++ b/android/client/haltest.c
@@ -32,6 +32,7 @@
 const struct interface *interfaces[] = {
 	&bluetooth_if,
 	&av_if,
+	&hf_if,
 	&hh_if,
 	&pan_if,
 	&sock_if,
diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index dd5d12e..a20a7c6 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -811,7 +811,7 @@ static void get_profile_interface_p(int argc, const char **argv)
 	RETURN_IF_NULL(if_bluetooth);
 
 	if (strcmp(BT_PROFILE_HANDSFREE_ID, id) == 0)
-		pif = &dummy; /* TODO: change when if_hf is there */
+		pif = (const void **) &if_hf;
 	else if (strcmp(BT_PROFILE_ADVANCED_AUDIO_ID, id) == 0)
 		pif = (const void **) &if_av;
 	else if (strcmp(BT_PROFILE_HEALTH_ID, id) == 0)
diff --git a/android/client/if-hf.c b/android/client/if-hf.c
new file mode 100644
index 0000000..e4065df
--- /dev/null
+++ b/android/client/if-hf.c
@@ -0,0 +1,368 @@
+/*
+ * Copyright (C) 2013 Intel Corporation
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ *
+ */
+
+#include "if-main.h"
+
+const bthf_interface_t *if_hf = NULL;
+
+SINTMAP(bthf_at_response_t, -1, "(unknown)")
+	DELEMENT(BTHF_AT_RESPONSE_ERROR),
+	DELEMENT(BTHF_AT_RESPONSE_OK),
+ENDMAP
+
+SINTMAP(bthf_connection_state_t, -1, "(unknown)")
+	DELEMENT(BTHF_CONNECTION_STATE_DISCONNECTED),
+	DELEMENT(BTHF_CONNECTION_STATE_CONNECTING),
+	DELEMENT(BTHF_CONNECTION_STATE_CONNECTED),
+	DELEMENT(BTHF_CONNECTION_STATE_SLC_CONNECTED),
+	DELEMENT(BTHF_CONNECTION_STATE_DISCONNECTING),
+ENDMAP
+
+SINTMAP(bthf_audio_state_t, -1, "(unknown)")
+	DELEMENT(BTHF_AUDIO_STATE_DISCONNECTED),
+	DELEMENT(BTHF_AUDIO_STATE_CONNECTING),
+	DELEMENT(BTHF_AUDIO_STATE_CONNECTED),
+	DELEMENT(BTHF_AUDIO_STATE_DISCONNECTING),
+ENDMAP
+
+SINTMAP(bthf_vr_state_t, -1, "(unknown)")
+	DELEMENT(BTHF_VR_STATE_STOPPED),
+	DELEMENT(BTHF_VR_STATE_STARTED),
+ENDMAP
+
+SINTMAP(bthf_volume_type_t, -1, "(unknown)")
+	DELEMENT(BTHF_VOLUME_TYPE_SPK),
+	DELEMENT(BTHF_VOLUME_TYPE_MIC),
+ENDMAP
+
+SINTMAP(bthf_nrec_t, -1, "(unknown)")
+	DELEMENT(BTHF_NREC_STOP),
+	DELEMENT(BTHF_NREC_START),
+ENDMAP
+
+SINTMAP(bthf_chld_type_t, -1, "(unknown)")
+	DELEMENT(BTHF_CHLD_TYPE_RELEASEHELD),
+	DELEMENT(BTHF_CHLD_TYPE_RELEASEACTIVE_ACCEPTHELD),
+	DELEMENT(BTHF_CHLD_TYPE_HOLDACTIVE_ACCEPTHELD),
+	DELEMENT(BTHF_CHLD_TYPE_ADDHELDTOCONF),
+ENDMAP
+
+/* Network Status */
+SINTMAP(bthf_network_state_t, -1, "(unknown)")
+	DELEMENT(BTHF_NETWORK_STATE_NOT_AVAILABLE),
+	DELEMENT(BTHF_NETWORK_STATE_AVAILABLE),
+ENDMAP
+
+/* Service type */
+SINTMAP(bthf_service_type_t, -1, "(unknown)")
+	DELEMENT(BTHF_SERVICE_TYPE_HOME),
+	DELEMENT(BTHF_SERVICE_TYPE_ROAMING),
+ENDMAP
+
+SINTMAP(bthf_call_state_t, -1, "(unknown)")
+	DELEMENT(BTHF_CALL_STATE_ACTIVE),
+	DELEMENT(BTHF_CALL_STATE_HELD),
+	DELEMENT(BTHF_CALL_STATE_DIALING),
+	DELEMENT(BTHF_CALL_STATE_ALERTING),
+	DELEMENT(BTHF_CALL_STATE_INCOMING),
+	DELEMENT(BTHF_CALL_STATE_WAITING),
+	DELEMENT(BTHF_CALL_STATE_IDLE),
+ENDMAP
+
+SINTMAP(bthf_call_direction_t, -1, "(unknown)")
+	DELEMENT(BTHF_CALL_DIRECTION_OUTGOING),
+	DELEMENT(BTHF_CALL_DIRECTION_INCOMING),
+ENDMAP
+
+SINTMAP(bthf_call_mode_t, -1, "(unknown)")
+	DELEMENT(BTHF_CALL_TYPE_VOICE),
+	DELEMENT(BTHF_CALL_TYPE_DATA),
+	DELEMENT(BTHF_CALL_TYPE_FAX),
+ENDMAP
+
+SINTMAP(bthf_call_mpty_type_t, -1, "(unknown)")
+	DELEMENT(BTHF_CALL_MPTY_TYPE_SINGLE),
+	DELEMENT(BTHF_CALL_MPTY_TYPE_MULTI),
+ENDMAP
+
+SINTMAP(bthf_call_addrtype_t, -1, "(unknown)")
+	DELEMENT(BTHF_CALL_ADDRTYPE_UNKNOWN),
+	DELEMENT(BTHF_CALL_ADDRTYPE_INTERNATIONAL),
+ENDMAP
+
+/* Callbacks */
+
+/*
+ * Callback for connection state change.
+ * state will have one of the values from BtHfConnectionState
+ */
+static void connection_state_cb(bthf_connection_state_t state,
+							bt_bdaddr_t *bd_addr)
+{
+}
+
+/*
+ * Callback for audio connection state change.
+ * state will have one of the values from BtHfAudioState
+ */
+static void audio_state_cb(bthf_audio_state_t state, bt_bdaddr_t *bd_addr)
+{
+}
+
+/*
+ * Callback for VR connection state change.
+ * state will have one of the values from BtHfVRState
+ */
+static void vr_cmd_cb(bthf_vr_state_t state)
+{
+}
+
+/* Callback for answer incoming call (ATA) */
+static void answer_call_cmd_cb(void)
+{
+}
+
+/* Callback for disconnect call (AT+CHUP) */
+static void hangup_call_cmd_cb(void)
+{
+}
+
+/*
+ * Callback for disconnect call (AT+CHUP)
+ * type will denote Speaker/Mic gain (BtHfVolumeControl).
+ */
+static void volume_cmd_cb(bthf_volume_type_t type, int volume)
+{
+}
+
+/*
+ * Callback for dialing an outgoing call
+ * If number is NULL, redial
+ */
+static void dial_call_cmd_cb(char *number)
+{
+}
+
+/*
+ * Callback for sending DTMF tones
+ * tone contains the dtmf character to be sent
+ */
+static void dtmf_cmd_cb(char tone)
+{
+}
+
+/*
+ * Callback for enabling/disabling noise reduction/echo cancellation
+ * value will be 1 to enable, 0 to disable
+ */
+static void nrec_cmd_cb(bthf_nrec_t nrec)
+{
+}
+
+/*
+ * Callback for call hold handling (AT+CHLD)
+ * value will contain the call hold command (0, 1, 2, 3)
+ */
+static void chld_cmd_cb(bthf_chld_type_t chld)
+{
+}
+
+/* Callback for CNUM (subscriber number) */
+static void cnum_cmd_cb(void)
+{
+}
+
+/* Callback for indicators (CIND) */
+static void cind_cmd_cb(void)
+{
+}
+
+/* Callback for operator selection (COPS) */
+static void cops_cmd_cb(void)
+{
+}
+
+/* Callback for call list (AT+CLCC) */
+static void clcc_cmd_cb(void)
+{
+}
+
+/*
+ * Callback for unknown AT command recd from HF
+ * at_string will contain the unparsed AT string
+ */
+static void unknown_at_cmd_cb(char *at_string)
+{
+}
+
+/* Callback for keypressed (HSP) event. */
+static void key_pressed_cmd_cb(void)
+{
+}
+
+static bthf_callbacks_t hf_cbacks = {
+
+	.size = sizeof(hf_cbacks),
+	.connection_state_cb = connection_state_cb,
+	.audio_state_cb = audio_state_cb,
+	.vr_cmd_cb = vr_cmd_cb,
+	.answer_call_cmd_cb = answer_call_cmd_cb,
+	.hangup_call_cmd_cb = hangup_call_cmd_cb,
+	.volume_cmd_cb = volume_cmd_cb,
+	.dial_call_cmd_cb = dial_call_cmd_cb,
+	.dtmf_cmd_cb = dtmf_cmd_cb,
+	.nrec_cmd_cb = nrec_cmd_cb,
+	.chld_cmd_cb = chld_cmd_cb,
+	.cnum_cmd_cb = cnum_cmd_cb,
+	.cind_cmd_cb = cind_cmd_cb,
+	.cops_cmd_cb = cops_cmd_cb,
+	.clcc_cmd_cb = clcc_cmd_cb,
+	.unknown_at_cmd_cb = unknown_at_cmd_cb,
+	.key_pressed_cmd_cb = key_pressed_cmd_cb,
+};
+
+/* init */
+
+static void init_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_hf);
+
+	EXEC(if_hf->init, &hf_cbacks);
+}
+
+/* connect */
+
+
+static void connect_p(int argc, const char **argv)
+{
+}
+
+/* disconnect */
+
+static void disconnect_p(int argc, const char **argv)
+{
+}
+
+/* create an audio connection */
+
+static void connect_audio_p(int argc, const char **argv)
+{
+}
+
+/* close the audio connection */
+
+static void disconnect_audio_p(int argc, const char **argv)
+{
+}
+
+/* start voice recognition */
+
+static void start_voice_recognition_p(int argc, const char **argv)
+{
+}
+
+/* stop voice recognition */
+
+static void stop_voice_recognition_p(int argc, const char **argv)
+{
+}
+
+/* volume control */
+
+static void volume_control_p(int argc, const char **argv)
+{
+}
+
+/* Combined device status change notification */
+
+static void device_status_notification_p(int argc, const char **argv)
+{
+}
+
+/* Response for COPS command */
+
+static void cops_response_p(int argc, const char **argv)
+{
+}
+
+/* Response for CIND command */
+
+static void cind_response_p(int argc, const char **argv)
+{
+}
+
+/* Pre-formatted AT response, typically in response to unknown AT cmd */
+
+static void formatted_at_response_p(int argc, const char **argv)
+{
+}
+
+/* at_response */
+
+static void at_response_p(int argc, const char **argv)
+{
+}
+
+/* response for CLCC command */
+
+static void clcc_response_p(int argc, const char **argv)
+{
+}
+
+/* phone state change */
+static void phone_state_change_p(int argc, const char **argv)
+{
+}
+
+/* cleanup */
+
+static void cleanup_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_hf);
+
+	EXECV(if_hf->cleanup);
+	if_hf = NULL;
+}
+
+static struct method methods[] = {
+	STD_METHOD(init),
+	STD_METHODH(connect, "<addr>"),
+	STD_METHODH(disconnect, "<addr>"),
+	STD_METHODH(connect_audio, "<addr>"),
+	STD_METHODH(disconnect_audio, "<addr>"),
+	STD_METHOD(start_voice_recognition),
+	STD_METHOD(stop_voice_recognition),
+	STD_METHODH(volume_control, "<vol_type> <volume>"),
+	STD_METHODH(device_status_notification,
+			"<ntk_state> <svt_type> <signal> <batt_chg>"),
+	STD_METHODH(cops_response, "<cops string>"),
+	STD_METHODH(cind_response,
+			"<svc> <num_active> <num_held> <setup_state> <signal> <roam> <batt_chg>"),
+	STD_METHODH(formatted_at_response, "<at_response>"),
+	STD_METHODH(at_response, "<response_code> [<error_code>]"),
+	STD_METHODH(clcc_response,
+			"<index> <direction> <state> <mode> <mpty> <number> <type>"),
+	STD_METHODH(phone_state_change,
+			"<num_active> <num_held> <setup_state> <number> <type>"),
+	STD_METHOD(cleanup),
+	END_METHOD
+};
+
+const struct interface hf_if = {
+	.name = "handsfree",
+	.methods = methods
+};
diff --git a/android/client/if-main.h b/android/client/if-main.h
index eaee914..37086dd 100644
--- a/android/client/if-main.h
+++ b/android/client/if-main.h
@@ -45,6 +45,7 @@
 /* Interfaces from hal that can be populated during application lifetime */
 extern const bt_interface_t *if_bluetooth;
 extern const btav_interface_t *if_av;
+extern const bthf_interface_t *if_hf;
 extern const bthh_interface_t *if_hh;
 extern const btpan_interface_t *if_pan;
 extern const btsock_interface_t *if_sock;
@@ -62,6 +63,7 @@ extern const struct interface bluetooth_if;
 extern const struct interface av_if;
 extern const struct interface pan_if;
 extern const struct interface sock_if;
+extern const struct interface hf_if;
 extern const struct interface hh_if;
 
 /* Interfaces that will show up in tool (first part of command line) */
-- 
1.7.9.5

