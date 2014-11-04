Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 21/47] android/client: Add new API support for handsfree client
Date: Tue,  4 Nov 2014 10:18:44 +0200
Message-Id: <1415089150-18798-22-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add support for handsfree client new API by adding missing parameters
to functions and callbacks.
---
 android/client/if-hf.c | 209 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 208 insertions(+), 1 deletion(-)

diff --git a/android/client/if-hf.c b/android/client/if-hf.c
index 77216df..0f77d28 100644
--- a/android/client/if-hf.c
+++ b/android/client/if-hf.c
@@ -136,110 +136,226 @@ static void audio_state_cb(bthf_audio_state_t state, bt_bdaddr_t *bd_addr)
  * Callback for VR connection state change.
  * state will have one of the values from BtHfVRState
  */
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static void vr_cmd_cb(bthf_vr_state_t state, bt_bdaddr_t *bd_addr)
+{
+	haltest_info("%s: state=%s bd_addr=%s\n", __func__,
+					bthf_vr_state_t2str(state),
+					bt_bdaddr_t2str(bd_addr, last_addr));
+}
+#else
 static void vr_cmd_cb(bthf_vr_state_t state)
 {
 	haltest_info("%s: state=%s\n", __func__, bthf_vr_state_t2str(state));
 }
+#endif
 
 /* Callback for answer incoming call (ATA) */
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static void answer_call_cmd_cb(bt_bdaddr_t *bd_addr)
+{
+	haltest_info("%s: bd_addr=%s\n", __func__,
+					bt_bdaddr_t2str(bd_addr, last_addr));
+}
+#else
 static void answer_call_cmd_cb(void)
 {
 	haltest_info("%s\n", __func__);
 }
+#endif
 
 /* Callback for disconnect call (AT+CHUP) */
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static void hangup_call_cmd_cb(bt_bdaddr_t *bd_addr)
+{
+	haltest_info("%s: bd_addr=%s\n", __func__,
+					bt_bdaddr_t2str(bd_addr, last_addr));
+}
+#else
 static void hangup_call_cmd_cb(void)
 {
 	haltest_info("%s\n", __func__);
 }
+#endif
 
 /*
  * Callback for disconnect call (AT+CHUP)
  * type will denote Speaker/Mic gain (BtHfVolumeControl).
  */
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static void volume_cmd_cb(bthf_volume_type_t type, int volume,
+							bt_bdaddr_t *bd_addr)
+{
+	haltest_info("%s: type=%s volume=%d bd_addr=%s\n", __func__,
+					bthf_volume_type_t2str(type), volume,
+					bt_bdaddr_t2str(bd_addr, last_addr));
+}
+#else
 static void volume_cmd_cb(bthf_volume_type_t type, int volume)
 {
 	haltest_info("%s: type=%s volume=%d\n", __func__,
 					bthf_volume_type_t2str(type), volume);
 }
+#endif
 
 /*
  * Callback for dialing an outgoing call
  * If number is NULL, redial
  */
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static void dial_call_cmd_cb(char *number, bt_bdaddr_t *bd_addr)
+{
+	haltest_info("%s: number=%s bd_addr=%s\n", __func__, number,
+					bt_bdaddr_t2str(bd_addr, last_addr));
+}
+#else
 static void dial_call_cmd_cb(char *number)
 {
 	haltest_info("%s: number=%s\n", __func__, number);
 }
+#endif
 
 /*
  * Callback for sending DTMF tones
  * tone contains the dtmf character to be sent
  */
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static void dtmf_cmd_cb(char tone, bt_bdaddr_t *bd_addr)
+{
+	haltest_info("%s: tone=%d bd_addr=%s\n", __func__, tone,
+					bt_bdaddr_t2str(bd_addr, last_addr));
+}
+#else
 static void dtmf_cmd_cb(char tone)
 {
 	haltest_info("%s: tone=%d\n", __func__, tone);
 }
+#endif
 
 /*
  * Callback for enabling/disabling noise reduction/echo cancellation
  * value will be 1 to enable, 0 to disable
  */
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static void nrec_cmd_cb(bthf_nrec_t nrec, bt_bdaddr_t *bd_addr)
+{
+	haltest_info("%s: nrec=%s bd_addr=%s\n", __func__,
+					bthf_nrec_t2str(nrec),
+					bt_bdaddr_t2str(bd_addr, last_addr));
+}
+#else
 static void nrec_cmd_cb(bthf_nrec_t nrec)
 {
 	haltest_info("%s: nrec=%s\n", __func__, bthf_nrec_t2str(nrec));
 }
+#endif
 
 /*
  * Callback for call hold handling (AT+CHLD)
  * value will contain the call hold command (0, 1, 2, 3)
  */
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static void chld_cmd_cb(bthf_chld_type_t chld, bt_bdaddr_t *bd_addr)
+{
+	haltest_info("%s: chld=%s bd_addr=%s\n", __func__,
+					bthf_chld_type_t2str(chld),
+					bt_bdaddr_t2str(bd_addr, last_addr));
+}
+#else
 static void chld_cmd_cb(bthf_chld_type_t chld)
 {
 	haltest_info("%s: chld=%s\n", __func__, bthf_chld_type_t2str(chld));
 }
+#endif
 
 /* Callback for CNUM (subscriber number) */
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static void cnum_cmd_cb(bt_bdaddr_t *bd_addr)
+{
+	haltest_info("%s: bd_addr=%s\n", __func__,
+					bt_bdaddr_t2str(bd_addr, last_addr));
+}
+#else
 static void cnum_cmd_cb(void)
 {
 	haltest_info("%s\n", __func__);
 }
+#endif
 
 /* Callback for indicators (CIND) */
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static void cind_cmd_cb(bt_bdaddr_t *bd_addr)
+{
+	haltest_info("%s: bd_addr=%s\n", __func__,
+					bt_bdaddr_t2str(bd_addr, last_addr));
+}
+#else
 static void cind_cmd_cb(void)
 {
 	haltest_info("%s\n", __func__);
 }
+#endif
 
 /* Callback for operator selection (COPS) */
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static void cops_cmd_cb(bt_bdaddr_t *bd_addr)
+{
+	haltest_info("%s: bd_addr=%s\n", __func__,
+					bt_bdaddr_t2str(bd_addr, last_addr));
+}
+#else
 static void cops_cmd_cb(void)
 {
 	haltest_info("%s\n", __func__);
 }
+#endif
 
 /* Callback for call list (AT+CLCC) */
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static void clcc_cmd_cb(bt_bdaddr_t *bd_addr)
+{
+	haltest_info("%s: bd_addr=%s\n", __func__,
+					bt_bdaddr_t2str(bd_addr, last_addr));
+}
+#else
 static void clcc_cmd_cb(void)
 {
 	haltest_info("%s\n", __func__);
 }
+#endif
 
 /*
  * Callback for unknown AT command recd from HF
  * at_string will contain the unparsed AT string
  */
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static void unknown_at_cmd_cb(char *at_string, bt_bdaddr_t *bd_addr)
+{
+	haltest_info("%s: at_string=%s bd_addr=%s\n", __func__, at_string,
+					bt_bdaddr_t2str(bd_addr, last_addr));
+}
+#else
 static void unknown_at_cmd_cb(char *at_string)
 {
 	haltest_info("%s: at_string=%s\n", __func__, at_string);
 }
+#endif
 
 /* Callback for keypressed (HSP) event. */
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static void key_pressed_cmd_cb(bt_bdaddr_t *bd_addr)
+{
+	haltest_info("%s: bd_addr=%s\n", __func__,
+					bt_bdaddr_t2str(bd_addr, last_addr));
+}
+#else
 static void key_pressed_cmd_cb(void)
 {
 	haltest_info("%s\n", __func__);
 }
+#endif
 
 static bthf_callbacks_t hf_cbacks = {
-
 	.size = sizeof(hf_cbacks),
 	.connection_state_cb = connection_state_cb,
 	.audio_state_cb = audio_state_cb,
@@ -263,9 +379,22 @@ static bthf_callbacks_t hf_cbacks = {
 
 static void init_p(int argc, const char **argv)
 {
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	int max_hf_clients;
+#endif
+
 	RETURN_IF_NULL(if_hf);
 
+#if ANDROID_VERSION <= PLATFORM_VER(4, 4, 4)
 	EXEC(if_hf->init, &hf_cbacks);
+#else
+	if (argc < 2)
+		max_hf_clients = 1;
+	else
+		max_hf_clients = atoi(argv[2]);
+
+	EXEC(if_hf->init, &hf_cbacks, max_hf_clients);
+#endif
 }
 
 /* connect */
@@ -351,18 +480,38 @@ static void disconnect_audio_p(int argc, const char **argv)
 
 static void start_voice_recognition_p(int argc, const char **argv)
 {
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	bt_bdaddr_t addr;
+#endif
+
 	RETURN_IF_NULL(if_hf);
 
+#if ANDROID_VERSION <= PLATFORM_VER(4, 4, 4)
 	EXEC(if_hf->start_voice_recognition);
+#else
+	VERIFY_ADDR_ARG(2, &addr);
+
+	EXEC(if_hf->start_voice_recognition, &addr);
+#endif
 }
 
 /* stop voice recognition */
 
 static void stop_voice_recognition_p(int argc, const char **argv)
 {
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	bt_bdaddr_t addr;
+#endif
+
 	RETURN_IF_NULL(if_hf);
 
+#if ANDROID_VERSION <= PLATFORM_VER(4, 4, 4)
 	EXEC(if_hf->stop_voice_recognition);
+#else
+	VERIFY_ADDR_ARG(2, &addr);
+
+	EXEC(if_hf->stop_voice_recognition, &addr);
+#endif
 }
 
 /* volume control */
@@ -380,6 +529,9 @@ static void volume_control_p(int argc, const char **argv)
 {
 	bthf_volume_type_t type;
 	int volume;
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	bt_bdaddr_t addr;
+#endif
 
 	RETURN_IF_NULL(if_hf);
 
@@ -397,7 +549,13 @@ static void volume_control_p(int argc, const char **argv)
 	}
 	volume = atoi(argv[3]);
 
+#if ANDROID_VERSION <= PLATFORM_VER(4, 4, 4)
 	EXEC(if_hf->volume_control, type, volume);
+#else
+	VERIFY_ADDR_ARG(4, &addr);
+
+	EXEC(if_hf->volume_control, type, volume, &addr);
+#endif
 }
 
 /* Combined device status change notification */
@@ -460,6 +618,10 @@ static void device_status_notification_p(int argc, const char **argv)
 
 static void cops_response_p(int argc, const char **argv)
 {
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	bt_bdaddr_t addr;
+#endif
+
 	RETURN_IF_NULL(if_hf);
 
 	/* response */
@@ -468,7 +630,13 @@ static void cops_response_p(int argc, const char **argv)
 		return;
 	}
 
+#if ANDROID_VERSION <= PLATFORM_VER(4, 4, 4)
 	EXEC(if_hf->cops_response, argv[2]);
+#else
+	VERIFY_ADDR_ARG(3, &addr);
+
+	EXEC(if_hf->cops_response, argv[2], &addr);
+#endif
 }
 
 /* Response for CIND command */
@@ -491,6 +659,9 @@ static void cind_response_p(int argc, const char **argv)
 	int signal;
 	int roam;
 	int batt_chg;
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	bt_bdaddr_t addr;
+#endif
 
 	RETURN_IF_NULL(if_hf);
 
@@ -543,14 +714,25 @@ static void cind_response_p(int argc, const char **argv)
 	}
 	batt_chg = atoi(argv[8]);
 
+#if ANDROID_VERSION <= PLATFORM_VER(4, 4, 4)
 	EXEC(if_hf->cind_response, svc, num_active, num_held, call_setup_state,
 							signal, roam, batt_chg);
+#else
+	VERIFY_ADDR_ARG(9, &addr);
+
+	EXEC(if_hf->cind_response, svc, num_active, num_held, call_setup_state,
+						signal, roam, batt_chg, &addr);
+#endif
 }
 
 /* Pre-formatted AT response, typically in response to unknown AT cmd */
 
 static void formatted_at_response_p(int argc, const char **argv)
 {
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	bt_bdaddr_t addr;
+#endif
+
 	RETURN_IF_NULL(if_hf);
 
 	/* response */
@@ -559,7 +741,13 @@ static void formatted_at_response_p(int argc, const char **argv)
 		return;
 	}
 
+#if ANDROID_VERSION <= PLATFORM_VER(4, 4, 4)
 	EXEC(if_hf->formatted_at_response, argv[2]);
+#else
+	VERIFY_ADDR_ARG(3, &addr);
+
+	EXEC(if_hf->formatted_at_response, argv[2], &addr);
+#endif
 }
 
 /* at_response */
@@ -577,6 +765,9 @@ static void at_response_p(int argc, const char **argv)
 {
 	bthf_at_response_t response_code;
 	int error_code;
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	bt_bdaddr_t addr;
+#endif
 
 	RETURN_IF_NULL(if_hf);
 
@@ -593,7 +784,13 @@ static void at_response_p(int argc, const char **argv)
 	else
 		error_code = atoi(argv[3]);
 
+#if ANDROID_VERSION <= PLATFORM_VER(4, 4, 4)
 	EXEC(if_hf->at_response, response_code, error_code);
+#else
+	VERIFY_ADDR_ARG(4, &addr);
+
+	EXEC(if_hf->at_response, response_code, error_code, &addr);
+#endif
 }
 
 /* response for CLCC command */
@@ -628,6 +825,9 @@ static void clcc_response_p(int argc, const char **argv)
 	bthf_call_mpty_type_t mpty;
 	const char *number;
 	bthf_call_addrtype_t type;
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	bt_bdaddr_t addr;
+#endif
 
 	RETURN_IF_NULL(if_hf);
 
@@ -680,8 +880,15 @@ static void clcc_response_p(int argc, const char **argv)
 	}
 	type = str2bthf_call_addrtype_t(argv[8]);
 
+#if ANDROID_VERSION <= PLATFORM_VER(4, 4, 4)
 	EXEC(if_hf->clcc_response, index, dir, state, mode, mpty, number,
 									type);
+#else
+	VERIFY_ADDR_ARG(9, &addr);
+
+	EXEC(if_hf->clcc_response, index, dir, state, mode, mpty, number,
+								type, &addr);
+#endif
 }
 
 /* phone state change */
-- 
1.9.1

