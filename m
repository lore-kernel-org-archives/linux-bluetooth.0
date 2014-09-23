Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 5/5] android/client: Add handsfree client api calls
Date: Tue, 23 Sep 2014 08:49:40 +0200
Message-Id: <1411454980-27225-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1411454980-27225-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1411454980-27225-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-hf-client.c | 141 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/android/client/if-hf-client.c b/android/client/if-hf-client.c
index 12bc24c..07c09cd 100644
--- a/android/client/if-hf-client.c
+++ b/android/client/if-hf-client.c
@@ -123,6 +123,21 @@ SINTMAP(bthf_client_in_band_ring_state_t, -1, "(unknown)")
 	DELEMENT(BTHF_CLIENT_IN_BAND_RINGTONE_PROVIDED),
 ENDMAP
 
+SINTMAP(bthf_client_call_action_t, -1, "(unknown)")
+	DELEMENT(BTHF_CLIENT_CALL_ACTION_CHLD_0),
+	DELEMENT(BTHF_CLIENT_CALL_ACTION_CHLD_1),
+	DELEMENT(BTHF_CLIENT_CALL_ACTION_CHLD_2),
+	DELEMENT(BTHF_CLIENT_CALL_ACTION_CHLD_3),
+	DELEMENT(BTHF_CLIENT_CALL_ACTION_CHLD_4),
+	DELEMENT(BTHF_CLIENT_CALL_ACTION_CHLD_1x),
+	DELEMENT(BTHF_CLIENT_CALL_ACTION_CHLD_2x),
+	DELEMENT(BTHF_CLIENT_CALL_ACTION_ATA),
+	DELEMENT(BTHF_CLIENT_CALL_ACTION_CHUP),
+	DELEMENT(BTHF_CLIENT_CALL_ACTION_BTRH_0),
+	DELEMENT(BTHF_CLIENT_CALL_ACTION_BTRH_1),
+	DELEMENT(BTHF_CLIENT_CALL_ACTION_BTRH_2),
+ENDMAP
+
 /* Callbacks */
 
 static char features_str[512];
@@ -376,11 +391,21 @@ static void init_p(int argc, const char **argv)
 static void connect_c(int argc, const char **argv, enum_func *enum_func,
 								void **user)
 {
+	if (argc == 3) {
+		*user = NULL;
+		*enum_func = enum_devices;
+	}
 }
 
 /* connect to audio gateway */
 static void connect_p(int argc, const char **argv)
 {
+	bt_bdaddr_t addr;
+
+	RETURN_IF_NULL(if_hf_client);
+	VERIFY_ADDR_ARG(2, &addr);
+
+	EXEC(if_hf_client->connect, &addr);
 }
 
 /*
@@ -402,16 +427,32 @@ static void connected_addr_c(int argc, const char **argv, enum_func *enum_func,
 /* disconnect from audio gateway */
 static void disconnect_p(int argc, const char **argv)
 {
+	bt_bdaddr_t addr;
+
+	RETURN_IF_NULL(if_hf_client);
+	VERIFY_ADDR_ARG(2, &addr);
+
+	EXEC(if_hf_client->disconnect, &addr);
 }
 
 static void connect_audio_c(int argc, const char **argv, enum_func *enum_func,
 								void **user)
 {
+	if (argc == 3) {
+		*user = NULL;
+		*enum_func = enum_devices;
+	}
 }
 
 /* create an audio connection */
 static void connect_audio_p(int argc, const char **argv)
 {
+	bt_bdaddr_t addr;
+
+	RETURN_IF_NULL(if_hf_client);
+	VERIFY_ADDR_ARG(2, &addr);
+
+	EXEC(if_hf_client->connect_audio, &addr);
 }
 
 /* Map completion to connected_addr_c */
@@ -420,76 +461,176 @@ static void connect_audio_p(int argc, const char **argv)
 /* close the audio connection */
 static void disconnect_audio_p(int argc, const char **argv)
 {
+	bt_bdaddr_t addr;
+
+	RETURN_IF_NULL(if_hf_client);
+	VERIFY_ADDR_ARG(2, &addr);
+
+	EXEC(if_hf_client->disconnect_audio, &addr);
 }
 
 /* start voice recognition */
 static void start_voice_recognition_p(int argc, const char **argv)
 {
+	RETURN_IF_NULL(if_hf_client);
+
+	EXEC(if_hf_client->start_voice_recognition);
 }
 
 /* stop voice recognition */
 static void stop_voice_recognition_p(int argc, const char **argv)
 {
+	RETURN_IF_NULL(if_hf_client);
+
+	EXEC(if_hf_client->start_voice_recognition);
 }
 
 static void volume_control_c(int argc, const char **argv, enum_func *enum_func,
 								void **user)
 {
+	if (argc == 3) {
+		*user = TYPE_ENUM(bthf_client_volume_type_t);
+		*enum_func = enum_defines;
+	}
 }
 
 /* volume control */
 static void volume_control_p(int argc, const char **argv)
 {
+	bthf_client_volume_type_t type;
+	int volume;
+
+	RETURN_IF_NULL(if_hf_client);
+
+	/* volume type */
+	if (argc <= 2) {
+		haltest_error("No volume type specified\n");
+		return;
+	}
+	type = str2bthf_client_volume_type_t(argv[2]);
+
+	/* volume */
+	if (argc <= 3) {
+		haltest_error("No volume specified\n");
+		return;
+	}
+	volume = atoi(argv[3]);
+
+	EXEC(if_hf_client->volume_control, type, volume);
 }
 
 /* place a call with number a number */
 static void dial_p(int argc, const char **argv)
 {
+	RETURN_IF_NULL(if_hf_client);
+
+	/* number string */
+	if (argc <= 2) {
+		haltest_error("No number specified\n");
+		return;
+	}
+
+	EXEC(if_hf_client->dial, argv[2]);
 }
 
 /* place a call with number specified by location (speed dial) */
 static void dial_memory_p(int argc, const char **argv)
 {
+	RETURN_IF_NULL(if_hf_client);
+
+	/* memory index */
+	if (argc <= 2) {
+		haltest_error("No memory index specified\n");
+		return;
+	}
+
+	EXEC(if_hf_client->dial_memory, atoi(argv[2]));
 }
 
 static void handle_call_action_c(int argc, const char **argv,
 					enum_func *enum_func, void **user)
 {
+	if (argc == 3) {
+		*user = TYPE_ENUM(bthf_client_call_action_t);
+		*enum_func = enum_defines;
+	}
 }
 
 /* perform specified call related action */
 static void handle_call_action_p(int argc, const char **argv)
 {
+	bthf_client_call_action_t action;
+	int index = 0;
+
+	RETURN_IF_NULL(if_hf_client);
+
+	/* action */
+	if (argc <= 2) {
+		haltest_error("No action specified\n");
+		return;
+	}
+	action = str2bthf_client_call_action_t(argv[2]);
+
+	/* call index */
+	if (action == BTHF_CLIENT_CALL_ACTION_CHLD_1x ||
+				action == BTHF_CLIENT_CALL_ACTION_CHLD_2x) {
+		if (argc <= 3) {
+			haltest_error("No call index specified\n");
+			return;
+		}
+		index = atoi(argv[3]);
+	}
+
+	EXEC(if_hf_client->handle_call_action, action, index);
 }
 
 /* query list of current calls */
 static void query_current_calls_p(int argc, const char **argv)
 {
+	RETURN_IF_NULL(if_hf_client);
+
+	EXEC(if_hf_client->query_current_calls);
 }
 
 /* query name of current selected operator */
 static void query_current_operator_name_p(int argc, const char **argv)
 {
+	RETURN_IF_NULL(if_hf_client);
+
+	EXEC(if_hf_client->query_current_operator_name);
 }
 
 /* Retrieve subscriber information */
 static void retrieve_subscriber_info_p(int argc, const char **argv)
 {
+	RETURN_IF_NULL(if_hf_client);
+
+	EXEC(if_hf_client->retrieve_subscriber_info);
 }
 
 /* Send DTMF code*/
 static void send_dtmf_p(int argc, const char **argv)
 {
+	RETURN_IF_NULL(if_hf_client);
+
+	EXEC(if_hf_client->send_dtmf, *argv[2]);
 }
 
 /* Request a phone number from AG corresponding to last voice tag recorded */
 static void request_last_voice_tag_number_p(int argc, const char **argv)
 {
+	RETURN_IF_NULL(if_hf_client);
+
+	EXEC(if_hf_client->request_last_voice_tag_number);
 }
 
 /* Closes the interface. */
 static void cleanup_p(int argc, const char **argv)
 {
+	RETURN_IF_NULL(if_hf_client);
+
+	EXECV(if_hf_client->cleanup);
+	if_hf_client = NULL;
 }
 
 static struct method methods[] = {
-- 
1.9.1

