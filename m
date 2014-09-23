Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/5] android/client: Handle more callbacks for the handsfree client
Date: Tue, 23 Sep 2014 08:49:39 +0200
Message-Id: <1411454980-27225-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1411454980-27225-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1411454980-27225-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-hf-client.c | 137 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 119 insertions(+), 18 deletions(-)

diff --git a/android/client/if-hf-client.c b/android/client/if-hf-client.c
index df40112..12bc24c 100644
--- a/android/client/if-hf-client.c
+++ b/android/client/if-hf-client.c
@@ -37,6 +37,92 @@ SINTMAP(bthf_client_audio_state_t, -1, "(unknown)")
 	DELEMENT(BTHF_CLIENT_AUDIO_STATE_CONNECTED_MSBC),
 ENDMAP
 
+SINTMAP(bthf_client_vr_state_t, -1, "(unknown)")
+	DELEMENT(BTHF_CLIENT_VR_STATE_STOPPED),
+	DELEMENT(BTHF_CLIENT_VR_STATE_STARTED),
+ENDMAP
+
+SINTMAP(bthf_client_network_state_t, -1, "(unknown)")
+	DELEMENT(BTHF_CLIENT_NETWORK_STATE_NOT_AVAILABLE),
+	DELEMENT(BTHF_CLIENT_NETWORK_STATE_AVAILABLE),
+ENDMAP
+
+SINTMAP(bthf_client_service_type_t, -1, "(unknown)")
+	DELEMENT(BTHF_CLIENT_SERVICE_TYPE_HOME),
+	DELEMENT(BTHF_CLIENT_SERVICE_TYPE_ROAMING),
+ENDMAP
+
+SINTMAP(bthf_client_call_t, -1, "(unknown)")
+	DELEMENT(BTHF_CLIENT_CALL_NO_CALLS_IN_PROGRESS),
+	DELEMENT(BTHF_CLIENT_CALL_CALLS_IN_PROGRESS),
+ENDMAP
+
+SINTMAP(bthf_client_callsetup_t, -1, "(unknown)")
+	DELEMENT(BTHF_CLIENT_CALLSETUP_NONE),
+	DELEMENT(BTHF_CLIENT_CALLSETUP_INCOMING),
+	DELEMENT(BTHF_CLIENT_CALLSETUP_OUTGOING),
+	DELEMENT(BTHF_CLIENT_CALLSETUP_ALERTING),
+ENDMAP
+
+SINTMAP(bthf_client_callheld_t, -1, "(unknown)")
+	DELEMENT(BTHF_CLIENT_CALLHELD_NONE),
+	DELEMENT(BTHF_CLIENT_CALLHELD_HOLD_AND_ACTIVE),
+	DELEMENT(BTHF_CLIENT_CALLHELD_HOLD),
+ENDMAP
+
+SINTMAP(bthf_client_resp_and_hold_t, -1, "(unknown)")
+	DELEMENT(BTHF_CLIENT_RESP_AND_HOLD_HELD),
+	DELEMENT(BTRH_CLIENT_RESP_AND_HOLD_ACCEPT),
+	DELEMENT(BTRH_CLIENT_RESP_AND_HOLD_REJECT),
+ENDMAP
+
+SINTMAP(bthf_client_call_direction_t, -1, "(unknown)")
+	DELEMENT(BTHF_CLIENT_CALL_DIRECTION_OUTGOING),
+	DELEMENT(BTHF_CLIENT_CALL_DIRECTION_INCOMING),
+ENDMAP
+
+SINTMAP(bthf_client_call_state_t, -1, "(unknown)")
+	DELEMENT(BTHF_CLIENT_CALL_STATE_ACTIVE),
+	DELEMENT(BTHF_CLIENT_CALL_STATE_HELD),
+	DELEMENT(BTHF_CLIENT_CALL_STATE_DIALING),
+	DELEMENT(BTHF_CLIENT_CALL_STATE_ALERTING),
+	DELEMENT(BTHF_CLIENT_CALL_STATE_INCOMING),
+	DELEMENT(BTHF_CLIENT_CALL_STATE_WAITING),
+	DELEMENT(BTHF_CLIENT_CALL_STATE_HELD_BY_RESP_HOLD),
+ENDMAP
+
+SINTMAP(bthf_client_call_mpty_type_t, -1, "(unknown)")
+	DELEMENT(BTHF_CLIENT_CALL_MPTY_TYPE_SINGLE),
+	DELEMENT(BTHF_CLIENT_CALL_MPTY_TYPE_MULTI),
+ENDMAP
+
+SINTMAP(bthf_client_volume_type_t, -1, "(unknown)")
+	DELEMENT(BTHF_CLIENT_VOLUME_TYPE_SPK),
+	DELEMENT(BTHF_CLIENT_VOLUME_TYPE_MIC),
+ENDMAP
+
+SINTMAP(bthf_client_cmd_complete_t, -1, "(unknown)")
+	DELEMENT(BTHF_CLIENT_CMD_COMPLETE_OK),
+	DELEMENT(BTHF_CLIENT_CMD_COMPLETE_ERROR),
+	DELEMENT(BTHF_CLIENT_CMD_COMPLETE_ERROR_NO_CARRIER),
+	DELEMENT(BTHF_CLIENT_CMD_COMPLETE_ERROR_BUSY),
+	DELEMENT(BTHF_CLIENT_CMD_COMPLETE_ERROR_NO_ANSWER),
+	DELEMENT(BTHF_CLIENT_CMD_COMPLETE_ERROR_DELAYED),
+	DELEMENT(BTHF_CLIENT_CMD_COMPLETE_ERROR_BLACKLISTED),
+	DELEMENT(BTHF_CLIENT_CMD_COMPLETE_ERROR_CME),
+ENDMAP
+
+SINTMAP(bthf_client_subscriber_service_type_t, -1, "(unknown)")
+	DELEMENT(BTHF_CLIENT_SERVICE_UNKNOWN),
+	DELEMENT(BTHF_CLIENT_SERVICE_VOICE),
+	DELEMENT(BTHF_CLIENT_SERVICE_FAX),
+ENDMAP
+
+SINTMAP(bthf_client_in_band_ring_state_t, -1, "(unknown)")
+	DELEMENT(BTHF_CLIENT_IN_BAND_RINGTONE_NOT_PROVIDED),
+	DELEMENT(BTHF_CLIENT_IN_BAND_RINGTONE_PROVIDED),
+ENDMAP
+
 /* Callbacks */
 
 static char features_str[512];
@@ -118,74 +204,81 @@ static void hf_client_audio_state_callback(bthf_client_audio_state_t state,
 /* Callback for VR connection state change. */
 static void hf_client_vr_cmd_callback(bthf_client_vr_state_t state)
 {
-	haltest_info("%s\n", __func__);
+	haltest_info("%s: vr_state=%s\n", __func__,
+					bthf_client_vr_state_t2str(state));
 }
 
 /* Callback for network state change */
 static void hf_client_network_state_callback(bthf_client_network_state_t state)
 {
-	haltest_info("%s\n", __func__);
+	haltest_info("%s: network_state=%s\n", __func__,
+					bthf_client_network_state_t2str(state));
 }
 
 /* Callback for network roaming status change */
 static void hf_client_network_roaming_callback(bthf_client_service_type_t type)
 {
-	haltest_info("%s\n", __func__);
+	haltest_info("%s: service_type=%s\n", __func__,
+					bthf_client_service_type_t2str(type));
 }
 
 /* Callback for signal strength indication */
 static void hf_client_network_signal_callback(int signal_strength)
 {
-	haltest_info("%s\n", __func__);
+	haltest_info("%s: signal strength=%d\n", __func__, signal_strength);
 }
 
 /* Callback for battery level indication */
 static void hf_client_battery_level_callback(int battery_level)
 {
-	haltest_info("%s\n", __func__);
+	haltest_info("%s: battery_lvl=%d\n", __func__, battery_level);
 }
 
 /* Callback for current operator name */
 static void hf_client_current_operator_callback(const char *name)
 {
-	haltest_info("%s\n", __func__);
+	haltest_info("%s: operator_name=%s\n", __func__, name);
 }
 
 /* Callback for call indicator */
 static void hf_client_call_callback(bthf_client_call_t call)
 {
-	haltest_info("%s\n", __func__);
+	haltest_info("%s: call_state=%s\n", __func__,
+						bthf_client_call_t2str(call));
 }
 
 /* Callback for callsetup indicator */
 static void hf_client_callsetup_callback(bthf_client_callsetup_t callsetup)
 {
-	haltest_info("%s\n", __func__);
+	haltest_info("%s: callsetup=%s\n", __func__,
+					bthf_client_callsetup_t2str(callsetup));
 }
 
 /* Callback for callheld indicator */
 static void hf_client_callheld_callback(bthf_client_callheld_t callheld)
 {
-	haltest_info("%s\n", __func__);
+	haltest_info("%s: callheld=%s\n", __func__,
+					bthf_client_callheld_t2str(callheld));
 }
 
 /* Callback for response and hold */
 static void hf_client_resp_and_hold_callback(
 				bthf_client_resp_and_hold_t resp_and_hold)
 {
-	haltest_info("%s\n", __func__);
+	haltest_info("%s: resp_and_hold=%s\n", __func__,
+				bthf_client_resp_and_hold_t2str(resp_and_hold));
 }
 
 /* Callback for Calling Line Identification notification */
 static void hf_client_clip_callback(const char *number)
 {
-	haltest_info("%s\n", __func__);
+	haltest_info("%s: number=%s\n", __func__, number);
 }
 
 /* Callback for Call Waiting notification */
 static void hf_client_call_waiting_callback(const char *number)
 {
-	haltest_info("%s\n", __func__);
+	haltest_info("%s: number=%s\n", __func__, number);
 }
 
 /* Callback for listing current calls. Can be called multiple time. */
@@ -195,41 +288,49 @@ static void hf_client_current_calls_callback(int index,
 					bthf_client_call_mpty_type_t mpty,
 					const char *number)
 {
-	haltest_info("%s\n", __func__);
+	haltest_info("%s: index=%d, direction=%s, state=%s, m_party=%s\n",
+					__func__, index,
+					bthf_client_call_direction_t2str(dir),
+					bthf_client_call_state_t2str(state),
+					bthf_client_call_mpty_type_t2str(mpty));
 }
 
 /* Callback for audio volume change */
 static void hf_client_volume_change_callback(bthf_client_volume_type_t type,
 								int volume)
 {
-	haltest_info("%s\n", __func__);
+	haltest_info("%s: vol_type=%s, value=%d\n", __func__,
+				bthf_client_volume_type_t2str(type), volume);
 }
 
 /* Callback for command complete event */
 static void hf_client_cmd_complete_callback(bthf_client_cmd_complete_t type,
 									int cme)
 {
-	haltest_info("%s\n", __func__);
+	haltest_info("%s: type=%s, cme=%d\n", __func__,
+				bthf_client_cmd_complete_t2str(type), cme);
 }
 
 /* Callback for subscriber information */
 static void hf_client_subscriber_info_callback(const char *name,
 				bthf_client_subscriber_service_type_t type)
 {
-	haltest_info("%s\n", __func__);
+	haltest_info("%s: name=%s, type=%s\n", __func__, name,
+			bthf_client_subscriber_service_type_t2str(type));
 }
 
 /* Callback for in-band ring tone settings */
 static void hf_client_in_band_ring_tone_callback(
 				bthf_client_in_band_ring_state_t state)
 {
-	haltest_info("%s\n", __func__);
+	haltest_info("%s: state=%s\n", __func__,
+				bthf_client_in_band_ring_state_t2str(state));
 }
 
 /* Callback for requested number from AG */
 static void hf_client_last_voice_tag_number_callback(const char *number)
 {
-	haltest_info("%s\n", __func__);
+	haltest_info("%s: number=%s\n", __func__, number);
 }
 
 /* Callback for sending ring indication to app */
-- 
1.9.1

