Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] telephony-ofono: add proper support for AT+CHLD and AT+CKPD
Date: Mon, 10 Jan 2011 15:05:43 +0200
Message-Id: <1294664745-16487-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1294664745-16487-1-git-send-email-luiz.dentz@gmail.com>
References: <1294664745-16487-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 audio/telephony-ofono.c |  194 ++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 165 insertions(+), 29 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 3f76bc7..7687434 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -127,6 +127,20 @@ static struct voice_call *find_vc_with_status(int status)
 	return NULL;
 }
 
+static struct voice_call *find_vc_without_status(int status)
+{
+	GSList *l;
+
+	for (l = calls; l != NULL; l = l->next) {
+		struct voice_call *call = l->data;
+
+		if (call->status != status)
+			return call;
+	}
+
+	return NULL;
+}
+
 static int number_type(const char *number)
 {
 	if (number == NULL)
@@ -228,36 +242,77 @@ static int send_method_call(const char *dest, const char *path,
 	return 0;
 }
 
+static int answer_call(struct voice_call *vc)
+{
+	DBG("%s", vc->number);
+	return send_method_call(OFONO_BUS_NAME, vc->obj_path,
+						OFONO_VC_INTERFACE, "Answer",
+						NULL, NULL, DBUS_TYPE_INVALID);
+}
+
+static int release_call(struct voice_call *vc)
+{
+	DBG("%s", vc->number);
+	return send_method_call(OFONO_BUS_NAME, vc->obj_path,
+						OFONO_VC_INTERFACE, "Hangup",
+						NULL, NULL, DBUS_TYPE_INVALID);
+}
+
+static int release_answer_calls()
+{
+	DBG("");
+	return send_method_call(OFONO_BUS_NAME, modem_obj_path,
+						OFONO_VCMANAGER_INTERFACE,
+						"ReleaseAndAnswer",
+						NULL, NULL, DBUS_TYPE_INVALID);
+}
+
+static int swap_calls(void)
+{
+	DBG("");
+	return send_method_call(OFONO_BUS_NAME, modem_obj_path,
+						OFONO_VCMANAGER_INTERFACE,
+						"SwapCalls",
+						NULL, NULL, DBUS_TYPE_INVALID);
+}
+
+static int call_transfer(void)
+{
+	DBG("");
+	return send_method_call(OFONO_BUS_NAME, modem_obj_path,
+						OFONO_VCMANAGER_INTERFACE,
+						"Transfer",
+						NULL, NULL, DBUS_TYPE_INVALID);
+}
+
 void telephony_terminate_call_req(void *telephony_device)
 {
-	struct voice_call *vc;
-	int ret;
+	struct voice_call *call;
+	struct voice_call *alerting;
+	int err;
 
-	if ((vc = find_vc_with_status(CALL_STATUS_ACTIVE))) {
-	} else if ((vc = find_vc_with_status(CALL_STATUS_DIALING))) {
-	} else if ((vc = find_vc_with_status(CALL_STATUS_ALERTING))) {
-	} else if ((vc = find_vc_with_status(CALL_STATUS_INCOMING))) {
-	}
+	call = find_vc_with_status(CALL_STATUS_ACTIVE);
+	if (!call)
+		call = calls->data;
 
-	if (!vc) {
-		error("in telephony_terminate_call_req, no active call");
+	if (!call) {
+		error("No active call");
 		telephony_terminate_call_rsp(telephony_device,
-					CME_ERROR_NOT_ALLOWED);
+						CME_ERROR_NOT_ALLOWED);
 		return;
 	}
 
-	ret = send_method_call(OFONO_BUS_NAME, vc->obj_path,
-					OFONO_VC_INTERFACE,
-					"Hangup", NULL,
-					NULL, DBUS_TYPE_INVALID);
-
-	if (ret < 0) {
-		telephony_answer_call_rsp(telephony_device,
-					CME_ERROR_AG_FAILURE);
-		return;
-	}
+	alerting = find_vc_with_status(CALL_STATUS_ALERTING);
+	if (call->status == CALL_STATUS_HELD && alerting)
+		err = release_call(alerting);
+	else
+		err = release_call(call);
 
-	telephony_answer_call_rsp(telephony_device, CME_ERROR_NONE);
+	if (err < 0)
+		telephony_terminate_call_rsp(telephony_device,
+						CME_ERROR_AG_FAILURE);
+	else
+		telephony_terminate_call_rsp(telephony_device, CME_ERROR_NONE);
 }
 
 void telephony_answer_call_req(void *telephony_device)
@@ -278,11 +333,7 @@ void telephony_answer_call_req(void *telephony_device)
 		return;
 	}
 
-	ret = send_method_call(OFONO_BUS_NAME, vc->obj_path,
-			OFONO_VC_INTERFACE,
-			"Answer", NULL,
-			NULL, DBUS_TYPE_INVALID);
-
+	ret = answer_call(vc);
 	if (ret < 0) {
 		telephony_answer_call_rsp(telephony_device,
 					CME_ERROR_AG_FAILURE);
@@ -381,10 +432,13 @@ void telephony_list_current_calls_req(void *telephony_device)
 		direction = vc->originating ?
 				CALL_DIR_OUTGOING : CALL_DIR_INCOMING;
 
+		DBG("call %s direction %d", vc->number, direction);
+
 		telephony_list_current_call_ind(i, direction, vc->status,
 					CALL_MODE_VOICE, CALL_MULTIPARTY_NO,
-					vc->number, NUMBER_TYPE_TELEPHONY);
+					vc->number, number_type(vc->number));
 	}
+
 	telephony_list_current_calls_rsp(telephony_device, CME_ERROR_NONE);
 }
 
@@ -397,10 +451,58 @@ void telephony_operator_selection_req(void *telephony_device)
 	telephony_operator_selection_rsp(telephony_device, CME_ERROR_NONE);
 }
 
+static void foreach_vc_with_status(int status,
+					int (*func)(struct voice_call *vc))
+{
+	GSList *l;
+
+	for (l = calls; l != NULL; l = l->next) {
+		struct voice_call *call = l->data;
+
+		if (call->status == status)
+			func(call);
+	}
+}
+
 void telephony_call_hold_req(void *telephony_device, const char *cmd)
 {
+	struct voice_call *call;
+	int err = 0;
+
 	DBG("telephony-ofono: got call hold request %s", cmd);
-	telephony_call_hold_rsp(telephony_device, CME_ERROR_NONE);
+
+	switch (cmd[0]) {
+	case '0':
+		if (find_vc_with_status(CALL_STATUS_WAITING))
+			foreach_vc_with_status(CALL_STATUS_WAITING,
+								release_call);
+		else
+			foreach_vc_with_status(CALL_STATUS_HELD, release_call);
+		break;
+	case '1':
+		err = release_answer_calls();
+		break;
+	case '2':
+		call = find_vc_with_status(CALL_STATUS_WAITING);
+
+		if (call)
+			err = answer_call(call);
+		else
+			err = swap_calls();
+		break;
+	case '4':
+		err = call_transfer();
+		break;
+	default:
+		DBG("Unknown call hold request");
+		break;
+	}
+
+	if (err)
+		telephony_call_hold_rsp(telephony_device,
+					CME_ERROR_AG_FAILURE);
+	else
+		telephony_call_hold_rsp(telephony_device, CME_ERROR_NONE);
 }
 
 void telephony_nr_and_ec_req(void *telephony_device, gboolean enable)
@@ -413,8 +515,29 @@ void telephony_nr_and_ec_req(void *telephony_device, gboolean enable)
 
 void telephony_key_press_req(void *telephony_device, const char *keys)
 {
+	struct voice_call *active, *waiting;
+	int err;
+
 	DBG("telephony-ofono: got key press request for %s", keys);
-	telephony_key_press_rsp(telephony_device, CME_ERROR_NONE);
+
+	waiting = find_vc_with_status(CALL_STATUS_INCOMING);
+	if (!waiting)
+		waiting = find_vc_with_status(CALL_STATUS_DIALING);
+
+	active = find_vc_with_status(CALL_STATUS_ACTIVE);
+
+	if (waiting)
+		err = answer_call(waiting);
+	else if (active)
+		err = release_call(active);
+	else
+		err = 0;
+
+	if (err < 0)
+		telephony_key_press_rsp(telephony_device,
+							CME_ERROR_AG_FAILURE);
+	else
+		telephony_key_press_rsp(telephony_device, CME_ERROR_NONE);
 }
 
 void telephony_voice_dial_req(void *telephony_device, gboolean enable)
@@ -523,6 +646,16 @@ static gboolean handle_vc_property_changed(DBusConnection *conn,
 						NUMBER_TYPE_TELEPHONY);
 			vc->status = CALL_STATUS_INCOMING;
 			vc->originating = FALSE;
+		} else if (g_str_equal(state, "held")) {
+			vc->status = CALL_STATUS_HELD;
+			if (find_vc_without_status(CALL_STATUS_HELD))
+				telephony_update_indicator(ofono_indicators,
+							"callheld",
+							EV_CALLHELD_MULTIPLE);
+			else
+				telephony_update_indicator(ofono_indicators,
+							"callheld",
+							EV_CALLHELD_ON_HOLD);
 		}
 	}
 
@@ -567,6 +700,8 @@ static struct voice_call *call_new(const char *path, DBusMessageIter *properties
 				vc->status = CALL_STATUS_ALERTING;
 			else if (g_str_equal(state, "waiting"))
 				vc->status = CALL_STATUS_WAITING;
+			else if (g_str_equal(state, "held"))
+				vc->status = CALL_STATUS_HELD;
 		}
 
 		dbus_message_iter_next(properties);
@@ -722,6 +857,7 @@ static int parse_network_properties(DBusMessageIter *properties)
 				AG_FEATURE_INBAND_RINGTONE |
 				AG_FEATURE_REJECT_A_CALL |
 				AG_FEATURE_ENHANCED_CALL_STATUS |
+				AG_FEATURE_ENHANCED_CALL_CONTROL |
 				AG_FEATURE_EXTENDED_ERROR_RESULT_CODES;
 
 	while (dbus_message_iter_get_arg_type(properties)
-- 
1.7.1

