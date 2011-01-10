Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] telephony-ofono: add support for multiparty calls
Date: Mon, 10 Jan 2011 13:42:12 +0200
Message-Id: <1294659732-31556-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 audio/telephony-ofono.c |  279 +++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 247 insertions(+), 32 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index ae8f56a..1b6a290 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -48,6 +48,7 @@ struct voice_call {
 	char *obj_path;
 	int status;
 	gboolean originating;
+	gboolean conference;
 	char *number;
 	guint watch;
 };
@@ -127,6 +128,20 @@ static struct voice_call *find_vc_with_status(int status)
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
@@ -228,36 +243,110 @@ static int send_method_call(const char *dest, const char *path,
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
+static int split_call(struct voice_call *call)
+{
+	DBG("%s", call->number);
+	return send_method_call(OFONO_BUS_NAME, modem_obj_path,
+						OFONO_VCMANAGER_INTERFACE,
+						"PrivateChat",
+						NULL, NULL,
+						DBUS_TYPE_OBJECT_PATH,
+						call->obj_path,
+						DBUS_TYPE_INVALID);
+	return -1;
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
+static int create_conference(void)
+{
+	DBG("");
+	return send_method_call(OFONO_BUS_NAME, modem_obj_path,
+						OFONO_VCMANAGER_INTERFACE,
+						"CreateMultiparty",
+						NULL, NULL, DBUS_TYPE_INVALID);
+}
+
+static int release_conference(void)
+{
+	DBG("");
+	return send_method_call(OFONO_BUS_NAME, modem_obj_path,
+						OFONO_VCMANAGER_INTERFACE,
+						"HangupMultiparty",
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
+	else if (call->conference)
+		err = release_conference();
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
@@ -278,11 +367,7 @@ void telephony_answer_call_req(void *telephony_device)
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
@@ -376,15 +461,22 @@ void telephony_list_current_calls_req(void *telephony_device)
 
 	for (l = calls, i = 1; l != NULL; l = l->next, i++) {
 		struct voice_call *vc = l->data;
-		int direction;
+		int direction, multiparty;
 
 		direction = vc->originating ?
 				CALL_DIR_OUTGOING : CALL_DIR_INCOMING;
 
+		multiparty = vc->conference ?
+				CALL_MULTIPARTY_YES : CALL_MULTIPARTY_NO;
+
+		DBG("call %s direction %d multiparty %d", vc->number,
+							direction, multiparty);
+
 		telephony_list_current_call_ind(i, direction, vc->status,
-					CALL_MODE_VOICE, CALL_MULTIPARTY_NO,
-					vc->number, NUMBER_TYPE_TELEPHONY);
+					CALL_MODE_VOICE, multiparty,
+					vc->number, number_type(vc->number));
 	}
+
 	telephony_list_current_calls_rsp(telephony_device, CME_ERROR_NONE);
 }
 
@@ -397,10 +489,86 @@ void telephony_operator_selection_req(void *telephony_device)
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
+	const char *idx;
+	struct voice_call *call;
+	int err = 0;
+
 	DBG("telephony-ofono: got call hold request %s", cmd);
-	telephony_call_hold_rsp(telephony_device, CME_ERROR_NONE);
+
+	if (strlen(cmd) > 1)
+		idx = &cmd[1];
+	else
+		idx = NULL;
+
+	if (idx)
+		call = g_slist_nth_data(calls, strtol(idx, NULL, 0) - 1);
+	else
+		call = NULL;
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
+		if (idx) {
+			if (call)
+				err = release_call(call);
+			break;
+		}
+		err = release_answer_calls();
+		break;
+	case '2':
+		if (idx) {
+			if (call)
+				err = split_call(call);
+		} else {
+			struct voice_call *wait;
+
+			wait = find_vc_with_status(CALL_STATUS_WAITING);
+
+			if (wait)
+				err = answer_call(call);
+			else
+				err = swap_calls();
+		}
+		break;
+	case '3':
+		if (find_vc_with_status(CALL_STATUS_HELD) ||
+				find_vc_with_status(CALL_STATUS_WAITING))
+			err = create_conference();
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
@@ -413,8 +581,29 @@ void telephony_nr_and_ec_req(void *telephony_device, gboolean enable)
 
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
@@ -523,7 +712,23 @@ static gboolean handle_vc_property_changed(DBusConnection *conn,
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
+	} else if (g_str_equal(property, "Multiparty")) {
+		dbus_bool_t multiparty;
+
+		dbus_message_iter_get_basic(&sub, &multiparty);
+		DBG("Multiparty %s", multiparty ? "True" : "False");
+		vc->conference = multiparty;
 	}
 
 	return TRUE;
@@ -545,6 +750,7 @@ static struct voice_call *call_new(const char *path, DBusMessageIter *properties
 						== DBUS_TYPE_DICT_ENTRY) {
 		DBusMessageIter entry, value;
 		const char *property, *cli, *state;
+		dbus_bool_t multiparty;
 
 		dbus_message_iter_recurse(properties, &entry);
 		dbus_message_iter_get_basic(&entry, &property);
@@ -567,6 +773,12 @@ static struct voice_call *call_new(const char *path, DBusMessageIter *properties
 				vc->status = CALL_STATUS_ALERTING;
 			else if (g_str_equal(state, "waiting"))
 				vc->status = CALL_STATUS_WAITING;
+			else if (g_str_equal(state, "held"))
+				vc->status = CALL_STATUS_HELD;
+		} else if (g_str_equal(property, "Multiparty")) {
+			dbus_message_iter_get_basic(&value, &multiparty);
+			DBG("Multipary %s", multiparty ? "True" : "False");
+			vc->conference = multiparty;
 		}
 
 		dbus_message_iter_next(properties);
@@ -719,9 +931,12 @@ static void handle_network_property(const char *property, DBusMessageIter *varia
 static int parse_network_properties(DBusMessageIter *properties)
 {
 	uint32_t features = AG_FEATURE_EC_ANDOR_NR |
+				AG_FEATURE_INBAND_RINGTONE |
 				AG_FEATURE_REJECT_A_CALL |
 				AG_FEATURE_ENHANCED_CALL_STATUS |
-				AG_FEATURE_EXTENDED_ERROR_RESULT_CODES;
+				AG_FEATURE_ENHANCED_CALL_CONTROL |
+				AG_FEATURE_EXTENDED_ERROR_RESULT_CODES |
+				AG_FEATURE_THREE_WAY_CALLING;
 
 	while (dbus_message_iter_get_arg_type(properties)
 						== DBUS_TYPE_DICT_ENTRY) {
-- 
1.7.1

