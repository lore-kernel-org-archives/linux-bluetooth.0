Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 3/4] android/client: Add code for handsfree methods
Date: Mon, 28 Oct 2013 12:39:02 +0100
Message-ID: <1382960343-10765-4-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1382960343-10765-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1382960343-10765-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds implementation of handsfree methods to haltest.
---
 android/client/if-hf.c |  289 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 289 insertions(+)

diff --git a/android/client/if-hf.c b/android/client/if-hf.c
index 43c7f47..585a569 100644
--- a/android/client/if-hf.c
+++ b/android/client/if-hf.c
@@ -272,83 +272,372 @@ static void init_p(int argc, const char **argv)
 
 static void connect_p(int argc, const char **argv)
 {
+	bt_bdaddr_t addr;
+
+	RETURN_IF_NULL(if_hf);
+	VERIFY_ADDR_ARG(2, &addr);
+
+	EXEC(if_hf->connect, &addr);
 }
 
 /* disconnect */
 
 static void disconnect_p(int argc, const char **argv)
 {
+	bt_bdaddr_t addr;
+
+	RETURN_IF_NULL(if_hf);
+	VERIFY_ADDR_ARG(2, &addr);
+
+	EXEC(if_hf->disconnect, &addr);
 }
 
 /* create an audio connection */
 
 static void connect_audio_p(int argc, const char **argv)
 {
+	bt_bdaddr_t addr;
+
+	RETURN_IF_NULL(if_hf);
+	VERIFY_ADDR_ARG(2, &addr);
+
+	EXEC(if_hf->connect_audio, &addr);
 }
 
 /* close the audio connection */
 
 static void disconnect_audio_p(int argc, const char **argv)
 {
+	bt_bdaddr_t addr;
+
+	RETURN_IF_NULL(if_hf);
+	VERIFY_ADDR_ARG(2, &addr);
+
+	EXEC(if_hf->disconnect_audio, &addr);
 }
 
 /* start voice recognition */
 
 static void start_voice_recognition_p(int argc, const char **argv)
 {
+	RETURN_IF_NULL(if_hf);
+
+	EXEC(if_hf->start_voice_recognition);
 }
 
 /* stop voice recognition */
 
 static void stop_voice_recognition_p(int argc, const char **argv)
 {
+	RETURN_IF_NULL(if_hf);
+
+	EXEC(if_hf->stop_voice_recognition);
 }
 
 /* volume control */
 
 static void volume_control_p(int argc, const char **argv)
 {
+	bthf_volume_type_t type;
+	int volume;
+
+	RETURN_IF_NULL(if_hf);
+
+	/* volume type */
+	if (argc <= 2) {
+		haltest_error("No volume type specified\n");
+		return;
+	}
+	type = str2bthf_volume_type_t(argv[2]);
+
+	/* volume */
+	if (argc <= 3) {
+		haltest_error("No volume specified\n");
+		return;
+	}
+	volume = atoi(argv[3]);
+
+	EXEC(if_hf->volume_control, type, volume);
 }
 
 /* Combined device status change notification */
 
 static void device_status_notification_p(int argc, const char **argv)
 {
+	bthf_network_state_t ntk_state;
+	bthf_service_type_t svc_type;
+	int signal;
+	int batt_chg;
+
+	RETURN_IF_NULL(if_hf);
+
+	/* network state */
+	if (argc <= 2) {
+		haltest_error("No network state specified\n");
+		return;
+	}
+	ntk_state = str2bthf_network_state_t(argv[2]);
+
+	/* service type */
+	if (argc <= 3) {
+		haltest_error("No service type specified\n");
+		return;
+	}
+	svc_type = str2bthf_service_type_t(argv[3]);
+
+	/* signal */
+	if (argc <= 4) {
+		haltest_error("No signal specified\n");
+		return;
+	}
+	signal = atoi(argv[4]);
+
+	/* batt_chg */
+	if (argc <= 5) {
+		haltest_error("No batt_chg specified\n");
+		return;
+	}
+	batt_chg = atoi(argv[5]);
+
+	EXEC(if_hf->device_status_notification, ntk_state, svc_type, signal,
+								batt_chg);
 }
 
 /* Response for COPS command */
 
 static void cops_response_p(int argc, const char **argv)
 {
+	RETURN_IF_NULL(if_hf);
+
+	/* response */
+	if (argc <= 2) {
+		haltest_error("No cops specified\n");
+		return;
+	}
+
+	EXEC(if_hf->cops_response, argv[2]);
 }
 
 /* Response for CIND command */
 
 static void cind_response_p(int argc, const char **argv)
 {
+	int svc;
+	int num_active;
+	int num_held;
+	bthf_call_state_t call_setup_state;
+	int signal;
+	int roam;
+	int batt_chg;
+
+	RETURN_IF_NULL(if_hf);
+
+	/* svc */
+	if (argc <= 2) {
+		haltest_error("No service specified\n");
+		return;
+	}
+	svc = atoi(argv[2]);
+
+	/* num active */
+	if (argc <= 3) {
+		haltest_error("No num active specified\n");
+		return;
+	}
+	num_active = atoi(argv[3]);
+
+	/* num held */
+	if (argc <= 4) {
+		haltest_error("No num held specified\n");
+		return;
+	}
+	num_held = atoi(argv[4]);
+
+	/* call setup state */
+	if (argc <= 5) {
+		haltest_error("No call setup state specified\n");
+		return;
+	}
+	call_setup_state = str2bthf_call_state_t(argv[5]);
+
+	/* signal */
+	if (argc <= 6) {
+		haltest_error("No signal specified\n");
+		return;
+	}
+	signal = atoi(argv[6]);
+
+	/* roam */
+	if (argc <= 7) {
+		haltest_error("No roam specified\n");
+		return;
+	}
+	roam = atoi(argv[7]);
+
+	/* batt_chg */
+	if (argc <= 8) {
+		haltest_error("No batt_chg specified\n");
+		return;
+	}
+	batt_chg = atoi(argv[8]);
+
+	EXEC(if_hf->cind_response, svc, num_active, num_held, call_setup_state,
+							signal, roam, batt_chg);
 }
 
 /* Pre-formatted AT response, typically in response to unknown AT cmd */
 
 static void formatted_at_response_p(int argc, const char **argv)
 {
+	RETURN_IF_NULL(if_hf);
+
+	/* response */
+	if (argc <= 2) {
+		haltest_error("No response specified\n");
+		return;
+	}
+
+	EXEC(if_hf->formatted_at_response, argv[2]);
 }
 
 /* at_response */
 
 static void at_response_p(int argc, const char **argv)
 {
+	bthf_at_response_t response_code;
+	int error_code = 0;
+
+	RETURN_IF_NULL(if_hf);
+
+	/* response type */
+	if (argc <= 2) {
+		haltest_error("No response specified\n");
+		return;
+	}
+	response_code = str2bthf_at_response_t(argv[2]);
+
+	/* error code */
+	if (argc >= 3)
+		error_code = atoi(argv[3]);
+
+	EXEC(if_hf->at_response, response_code, error_code);
 }
 
 /* response for CLCC command */
 
 static void clcc_response_p(int argc, const char **argv)
 {
+	int index;
+	bthf_call_direction_t dir;
+	bthf_call_state_t state;
+	bthf_call_mode_t mode;
+	bthf_call_mpty_type_t mpty;
+	const char *number;
+	bthf_call_addrtype_t type;
+
+	RETURN_IF_NULL(if_hf);
+
+	/* index */
+	if (argc <= 2) {
+		haltest_error("No index specified\n");
+		return;
+	}
+	index = atoi(argv[2]);
+
+	/* direction */
+	if (argc <= 3) {
+		haltest_error("No direction specified\n");
+		return;
+	}
+	dir = str2bthf_call_direction_t(argv[3]);
+
+	/* call state */
+	if (argc <= 4) {
+		haltest_error("No call state specified\n");
+		return;
+	}
+	state = str2bthf_call_state_t(argv[4]);
+
+	/* call mode */
+	if (argc <= 5) {
+		haltest_error("No mode specified\n");
+		return;
+	}
+	mode = str2bthf_call_mode_t(argv[5]);
+
+	/* call mpty type */
+	if (argc <= 6) {
+		haltest_error("No mpty type specified\n");
+		return;
+	}
+	mpty = str2bthf_call_mpty_type_t(argv[6]);
+
+	/* number */
+	if (argc <= 7) {
+		haltest_error("No number specified\n");
+		return;
+	}
+	number = argv[7];
+
+	/* call mpty type */
+	if (argc <= 8) {
+		haltest_error("No address type specified\n");
+		return;
+	}
+	type = str2bthf_call_addrtype_t(argv[8]);
+
+	EXEC(if_hf->clcc_response, index, dir, state, mode, mpty, number,
+									type);
 }
 
 /* phone state change */
 static void phone_state_change_p(int argc, const char **argv)
 {
+	int num_active;
+	int num_held;
+	bthf_call_state_t call_setup_state;
+	const char *number;
+	bthf_call_addrtype_t type;
+
+	RETURN_IF_NULL(if_hf);
+
+	/* num_active */
+	if (argc <= 2) {
+		haltest_error("No num_active specified\n");
+		return;
+	}
+	num_active = atoi(argv[2]);
+
+	/* num_held */
+	if (argc <= 3) {
+		haltest_error("No num_held specified\n");
+		return;
+	}
+	num_held = atoi(argv[3]);
+
+	/* setup state */
+	if (argc <= 4) {
+		haltest_error("No call setup state specified\n");
+		return;
+	}
+	call_setup_state = str2bthf_call_state_t(argv[4]);
+
+	/* number */
+	if (argc <= 5) {
+		haltest_error("No number specified\n");
+		return;
+	}
+	number = argv[5];
+
+	/* call mpty type */
+	if (argc <= 6) {
+		haltest_error("No address type specified\n");
+		return;
+	}
+	type = str2bthf_call_addrtype_t(argv[6]);
+
+	EXEC(if_hf->phone_state_change, num_active, num_held, call_setup_state,
+								number, type);
 }
 
 /* cleanup */
-- 
1.7.9.5

