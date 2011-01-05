Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/10] telephony-ofono: make use of GetCalls method
Date: Wed,  5 Jan 2011 17:59:42 +0200
Message-Id: <1294243187-1849-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1294243187-1849-1-git-send-email-luiz.dentz@gmail.com>
References: <1294243187-1849-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 audio/telephony-ofono.c |  515 +++++++++++++++++++++++++----------------------
 1 files changed, 279 insertions(+), 236 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index b96c504..e1b6422 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -65,10 +65,11 @@ static GSList *calls = NULL;
 #define OFONO_VC_INTERFACE "org.ofono.VoiceCall"
 
 static guint registration_watch = 0;
-static guint voice_watch = 0;
 static guint device_watch = 0;
 static guint modem_added_watch = 0;
 static guint modem_removed_watch = 0;
+static guint call_added_watch = 0;
+static guint call_removed_watch = 0;
 
 /* HAL battery namespace key values */
 static int battchg_cur = -1;    /* "battery.charge_level.current" */
@@ -456,6 +457,219 @@ static gboolean iter_get_basic_args(DBusMessageIter *iter,
 	return type == DBUS_TYPE_INVALID ? TRUE : FALSE;
 }
 
+static void call_free(struct voice_call *vc)
+{
+	DBG("%s", vc->obj_path);
+
+	g_dbus_remove_watch(connection, vc->watch);
+	g_free(vc->obj_path);
+	g_free(vc->number);
+	g_free(vc);
+}
+
+static gboolean handle_vc_property_changed(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct voice_call *vc = data;
+	const char *obj_path = dbus_message_get_path(msg);
+	DBusMessageIter iter, sub;
+	const char *property, *state;
+
+	DBG("path %s", obj_path);
+
+	dbus_message_iter_init(msg, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING) {
+		error("Unexpected signature in vc PropertyChanged signal");
+		return TRUE;
+	}
+
+	dbus_message_iter_get_basic(&iter, &property);
+	DBG("property %s", property);
+
+	dbus_message_iter_next(&iter);
+	dbus_message_iter_recurse(&iter, &sub);
+	if (g_str_equal(property, "State")) {
+		dbus_message_iter_get_basic(&sub, &state);
+		DBG("State %s", state);
+		if (g_str_equal(state, "disconnected")) {
+			if (vc->status == CALL_STATUS_ACTIVE)
+				telephony_update_indicator(ofono_indicators,
+						"call", EV_CALL_INACTIVE);
+			else
+				telephony_update_indicator(ofono_indicators,
+					"callsetup", EV_CALLSETUP_INACTIVE);
+			if (vc->status == CALL_STATUS_INCOMING)
+				telephony_calling_stopped_ind();
+			calls = g_slist_remove(calls, vc);
+			call_free(vc);
+		} else if (g_str_equal(state, "active")) {
+			telephony_update_indicator(ofono_indicators,
+							"call", EV_CALL_ACTIVE);
+			telephony_update_indicator(ofono_indicators,
+							"callsetup",
+							EV_CALLSETUP_INACTIVE);
+			if (vc->status == CALL_STATUS_INCOMING)
+				telephony_calling_stopped_ind();
+			vc->status = CALL_STATUS_ACTIVE;
+		} else if (g_str_equal(state, "alerting")) {
+			telephony_update_indicator(ofono_indicators,
+					"callsetup", EV_CALLSETUP_ALERTING);
+			vc->status = CALL_STATUS_ALERTING;
+			vc->originating = TRUE;
+		} else if (g_str_equal(state, "incoming")) {
+			/* state change from waiting to incoming */
+			telephony_update_indicator(ofono_indicators,
+					"callsetup", EV_CALLSETUP_INCOMING);
+			telephony_incoming_call_ind(vc->number,
+						NUMBER_TYPE_TELEPHONY);
+			vc->status = CALL_STATUS_INCOMING;
+			vc->originating = FALSE;
+		}
+	}
+
+	return TRUE;
+}
+
+static struct voice_call *call_new(const char *path, DBusMessageIter *properties)
+{
+	struct voice_call *vc;
+
+	DBG("%s", path);
+
+	vc = g_new0(struct voice_call, 1);
+	vc->obj_path = g_strdup(path);
+	vc->watch = g_dbus_add_signal_watch(connection, NULL, path,
+					OFONO_VC_INTERFACE, "PropertyChanged",
+					handle_vc_property_changed, vc, NULL);
+
+	while (dbus_message_iter_get_arg_type(properties)
+						== DBUS_TYPE_DICT_ENTRY) {
+		DBusMessageIter entry, value;
+		const char *property, *cli, *state;
+
+		dbus_message_iter_recurse(properties, &entry);
+		dbus_message_iter_get_basic(&entry, &property);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		if (g_str_equal(property, "LineIdentification")) {
+			dbus_message_iter_get_basic(&value, &cli);
+			DBG("cli %s", cli);
+			vc->number = g_strdup(cli);
+		} else if (g_str_equal(property, "State")) {
+			dbus_message_iter_get_basic(&value, &state);
+			DBG("state %s", state);
+			if (g_str_equal(state, "incoming"))
+				vc->status = CALL_STATUS_INCOMING;
+			else if (g_str_equal(state, "dialing"))
+				vc->status = CALL_STATUS_DIALING;
+			else if (g_str_equal(state, "alerting"))
+				vc->status = CALL_STATUS_ALERTING;
+			else if (g_str_equal(state, "waiting"))
+				vc->status = CALL_STATUS_WAITING;
+		}
+
+		dbus_message_iter_next(properties);
+	}
+
+	switch (vc->status) {
+	case CALL_STATUS_INCOMING:
+		DBG("CALL_STATUS_INCOMING");
+		vc->originating = FALSE;
+		telephony_update_indicator(ofono_indicators, "callsetup",
+					EV_CALLSETUP_INCOMING);
+		telephony_incoming_call_ind(vc->number, NUMBER_TYPE_TELEPHONY);
+		break;
+	case CALL_STATUS_DIALING:
+		DBG("CALL_STATUS_DIALING");
+		vc->originating = TRUE;
+		g_free(last_dialed_number);
+		last_dialed_number = g_strdup(vc->number);
+		telephony_update_indicator(ofono_indicators, "callsetup",
+					EV_CALLSETUP_OUTGOING);
+		break;
+	case CALL_STATUS_ALERTING:
+		DBG("CALL_STATUS_ALERTING");
+		vc->originating = TRUE;
+		g_free(last_dialed_number);
+		last_dialed_number = g_strdup(vc->number);
+		telephony_update_indicator(ofono_indicators, "callsetup",
+					EV_CALLSETUP_ALERTING);
+		break;
+	case CALL_STATUS_WAITING:
+		DBG("CALL_STATUS_WAITING");
+		vc->originating = FALSE;
+		telephony_update_indicator(ofono_indicators, "callsetup",
+					EV_CALLSETUP_INCOMING);
+		telephony_call_waiting_ind(vc->number, NUMBER_TYPE_TELEPHONY);
+		break;
+	}
+
+	return vc;
+}
+
+static void call_added(const char *path, DBusMessageIter *properties)
+{
+	struct voice_call *vc;
+
+	DBG("%s", path);
+
+	vc = find_vc(path);
+	if (vc)
+		return;
+
+	vc = call_new(path, properties);
+	calls = g_slist_prepend(calls, vc);
+}
+
+static void get_calls_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusError err;
+	DBusMessage *reply;
+	DBusMessageIter iter, entry;
+
+	DBG("");
+	reply = dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&err);
+	if (dbus_set_error_from_message(&err, reply)) {
+		error("ofono replied with an error: %s, %s",
+				err.name, err.message);
+		dbus_error_free(&err);
+		goto done;
+	}
+
+	dbus_message_iter_init(reply, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
+		error("Unexpected signature");
+		goto done;
+	}
+
+	dbus_message_iter_recurse(&iter, &entry);
+
+	while (dbus_message_iter_get_arg_type(&entry)
+						== DBUS_TYPE_STRUCT) {
+		const char *path;
+		DBusMessageIter value, properties;
+
+		dbus_message_iter_recurse(&entry, &value);
+		dbus_message_iter_get_basic(&value, &path);
+
+		dbus_message_iter_next(&value);
+		dbus_message_iter_recurse(&value, &properties);
+
+		call_added(path, &properties);
+
+		dbus_message_iter_next(&entry);
+	}
+
+done:
+	dbus_message_unref(reply);
+}
+
 static void handle_network_property(const char *property, DBusMessageIter *variant)
 {
 	const char *status, *operator;
@@ -554,9 +768,18 @@ static void get_properties_reply(DBusPendingCall *call, void *user_data)
 	dbus_message_iter_recurse(&iter, &properties);
 
 	ret = parse_network_properties(&properties);
-	if (ret < 0)
+	if (ret < 0) {
 		error("Unable to parse %s.GetProperty reply",
 						OFONO_NETWORKREG_INTERFACE);
+		goto done;
+	}
+
+	ret = send_method_call(OFONO_BUS_NAME, modem_obj_path,
+				OFONO_VCMANAGER_INTERFACE, "GetCalls",
+				get_calls_reply, NULL, DBUS_TYPE_INVALID);
+	if (ret < 0)
+		error("Unable to send %s.GetCalls",
+						OFONO_VCMANAGER_INTERFACE);
 
 done:
 	dbus_message_unref(reply);
@@ -646,255 +869,68 @@ static gboolean handle_network_property_changed(DBusConnection *conn,
 	return TRUE;
 }
 
-static void vc_getproperties_reply(DBusPendingCall *call, void *user_data)
+static gboolean handle_vcmanager_call_added(DBusConnection *conn,
+						DBusMessage *msg, void *data)
 {
-	DBusMessage *reply;
-	DBusError err;
-	DBusMessageIter iter, iter_entry;
-	const char *path = user_data;
-	struct voice_call *vc;
-
-	DBG("in vc_getproperties_reply");
-
-	reply = dbus_pending_call_steal_reply(call);
-	dbus_error_init(&err);
-	if (dbus_set_error_from_message(&err, reply)) {
-		error("ofono replied with an error: %s, %s",
-				err.name, err.message);
-		dbus_error_free(&err);
-		goto done;
-	}
-
-	vc = find_vc(path);
-	if (!vc) {
-		error("in vc_getproperties_reply, vc is NULL");
-		goto done;
-	}
-
-	dbus_message_iter_init(reply, &iter);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
-		error("Unexpected signature in vc_getproperties_reply()");
-		goto done;
-	}
-
-	dbus_message_iter_recurse(&iter, &iter_entry);
-
-	if (dbus_message_iter_get_arg_type(&iter_entry)
-			!= DBUS_TYPE_DICT_ENTRY) {
-		error("Unexpected signature in vc_getproperties_reply()");
-		goto done;
-	}
-
-	while (dbus_message_iter_get_arg_type(&iter_entry)
-			!= DBUS_TYPE_INVALID) {
-		DBusMessageIter iter_property, sub;
-		char *property, *cli, *state;
-
-		dbus_message_iter_recurse(&iter_entry, &iter_property);
-		if (dbus_message_iter_get_arg_type(&iter_property)
-				!= DBUS_TYPE_STRING) {
-			error("Unexpected signature in"
-					" vc_getproperties_reply()");
-			goto done;
-		}
+	DBusMessageIter iter, properties;
+	const char *path = dbus_message_get_path(msg);
 
-		dbus_message_iter_get_basic(&iter_property, &property);
+	/* Ignore call if modem path doesn't math */
+	if (g_strcmp0(modem_obj_path, path) != 0)
+		return TRUE;
 
-		dbus_message_iter_next(&iter_property);
-		dbus_message_iter_recurse(&iter_property, &sub);
-		if (g_str_equal(property, "LineIdentification")) {
-			dbus_message_iter_get_basic(&sub, &cli);
-			DBG("in vc_getproperties_reply(), cli is %s", cli);
-			vc->number = g_strdup(cli);
-		} else if (g_str_equal(property, "State")) {
-			dbus_message_iter_get_basic(&sub, &state);
-			DBG("in vc_getproperties_reply(),"
-					" state is %s", state);
-			if (g_str_equal(state, "incoming"))
-				vc->status = CALL_STATUS_INCOMING;
-			else if (g_str_equal(state, "dialing"))
-				vc->status = CALL_STATUS_DIALING;
-			else if (g_str_equal(state, "alerting"))
-				vc->status = CALL_STATUS_ALERTING;
-			else if (g_str_equal(state, "waiting"))
-				vc->status = CALL_STATUS_WAITING;
-		}
+	dbus_message_iter_init(msg, &iter);
 
-		dbus_message_iter_next(&iter_entry);
+	if (dbus_message_iter_get_arg_type(&iter)
+						!= DBUS_TYPE_OBJECT_PATH) {
+		error("Unexpected signature in %s.%s signal",
+					dbus_message_get_interface(msg),
+					dbus_message_get_member(msg));
+		return TRUE;
 	}
 
-	switch (vc->status) {
-	case CALL_STATUS_INCOMING:
-		printf("in CALL_STATUS_INCOMING: case\n");
-		vc->originating = FALSE;
-		telephony_update_indicator(ofono_indicators, "callsetup",
-					EV_CALLSETUP_INCOMING);
-		telephony_incoming_call_ind(vc->number, NUMBER_TYPE_TELEPHONY);
-		break;
-	case CALL_STATUS_DIALING:
-		printf("in CALL_STATUS_DIALING: case\n");
-		vc->originating = TRUE;
-		g_free(last_dialed_number);
-		last_dialed_number = g_strdup(vc->number);
-		telephony_update_indicator(ofono_indicators, "callsetup",
-					EV_CALLSETUP_OUTGOING);
-		break;
-	case CALL_STATUS_ALERTING:
-		printf("in CALL_STATUS_ALERTING: case\n");
-		vc->originating = TRUE;
-		g_free(last_dialed_number);
-		last_dialed_number = g_strdup(vc->number);
-		telephony_update_indicator(ofono_indicators, "callsetup",
-					EV_CALLSETUP_ALERTING);
-		break;
-	case CALL_STATUS_WAITING:
-		DBG("in CALL_STATUS_WAITING: case");
-		vc->originating = FALSE;
-		telephony_update_indicator(ofono_indicators, "callsetup",
-					EV_CALLSETUP_INCOMING);
-		telephony_call_waiting_ind(vc->number, NUMBER_TYPE_TELEPHONY);
-		break;
-	}
-done:
-	dbus_message_unref(reply);
-}
+	dbus_message_iter_get_basic(&iter, &path);
+	dbus_message_iter_next(&iter);
+	dbus_message_iter_recurse(&iter, &properties);
 
-static void vc_free(struct voice_call *vc)
-{
-	if (!vc)
-		return;
+	call_added(path, &properties);
 
-	g_dbus_remove_watch(connection, vc->watch);
-	g_free(vc->obj_path);
-	g_free(vc->number);
-	g_free(vc);
+	return TRUE;
 }
 
-static gboolean handle_vc_property_changed(DBusConnection *conn,
-					DBusMessage *msg, void *data)
+static void call_removed(const char *path)
 {
-	struct voice_call *vc = data;
-	const char *obj_path = dbus_message_get_path(msg);
-	DBusMessageIter iter, sub;
-	const char *property, *state;
-
-	DBG("in handle_vc_property_changed, obj_path is %s", obj_path);
-
-	dbus_message_iter_init(msg, &iter);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING) {
-		error("Unexpected signature in vc PropertyChanged signal");
-		return TRUE;
-	}
+	struct voice_call *vc;
 
-	dbus_message_iter_get_basic(&iter, &property);
-	DBG("in handle_vc_property_changed(), the property is %s", property);
+	DBG("%s", path);
 
-	dbus_message_iter_next(&iter);
-	dbus_message_iter_recurse(&iter, &sub);
-	if (g_str_equal(property, "State")) {
-		dbus_message_iter_get_basic(&sub, &state);
-		DBG("in handle_vc_property_changed(), State is %s", state);
-		if (g_str_equal(state, "disconnected")) {
-			printf("in disconnected case\n");
-			if (vc->status == CALL_STATUS_ACTIVE)
-				telephony_update_indicator(ofono_indicators,
-						"call", EV_CALL_INACTIVE);
-			else
-				telephony_update_indicator(ofono_indicators,
-					"callsetup", EV_CALLSETUP_INACTIVE);
-			if (vc->status == CALL_STATUS_INCOMING)
-				telephony_calling_stopped_ind();
-			calls = g_slist_remove(calls, vc);
-			vc_free(vc);
-		} else if (g_str_equal(state, "active")) {
-			telephony_update_indicator(ofono_indicators,
-							"call", EV_CALL_ACTIVE);
-			telephony_update_indicator(ofono_indicators,
-							"callsetup",
-							EV_CALLSETUP_INACTIVE);
-			if (vc->status == CALL_STATUS_INCOMING)
-				telephony_calling_stopped_ind();
-			vc->status = CALL_STATUS_ACTIVE;
-			DBG("vc status is CALL_STATUS_ACTIVE");
-		} else if (g_str_equal(state, "alerting")) {
-			telephony_update_indicator(ofono_indicators,
-					"callsetup", EV_CALLSETUP_ALERTING);
-			vc->status = CALL_STATUS_ALERTING;
-			DBG("vc status is CALL_STATUS_ALERTING");
-			vc->originating = TRUE;
-		} else if (g_str_equal(state, "incoming")) {
-			/* state change from waiting to incoming */
-			telephony_update_indicator(ofono_indicators,
-					"callsetup", EV_CALLSETUP_INCOMING);
-			telephony_incoming_call_ind(vc->number,
-						NUMBER_TYPE_TELEPHONY);
-			vc->status = CALL_STATUS_INCOMING;
-			DBG("vc status is CALL_STATUS_INCOMING");
-			vc->originating = FALSE;
-		}
-	}
+	vc = find_vc(path);
+	if (vc == NULL)
+		return;
 
-	return TRUE;
+	calls = g_slist_remove(calls, vc);
+	call_free(vc);
 }
 
-static gboolean handle_vcmanager_property_changed(DBusConnection *conn,
+static gboolean handle_vcmanager_call_removed(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
-	DBusMessageIter iter, sub, array;
-	const char *property, *vc_obj_path = NULL;
-	struct voice_call *vc, *vc_new = NULL;
-
-	DBG("in handle_vcmanager_property_changed");
+	const char *path = dbus_message_get_path(msg);
 
-	dbus_message_iter_init(msg, &iter);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING) {
-		error("Unexpected signature in vcmanager"
-					" PropertyChanged signal");
+	/* Ignore call if modem path doesn't math */
+	if (g_strcmp0(modem_obj_path, path) != 0)
 		return TRUE;
-	}
 
-	dbus_message_iter_get_basic(&iter, &property);
-	DBG("in handle_vcmanager_property_changed(),"
-				" the property is %s", property);
-
-	dbus_message_iter_next(&iter);
-	dbus_message_iter_recurse(&iter, &sub);
-	if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_ARRAY) {
-		error("Unexpected signature in vcmanager"
-					" PropertyChanged signal");
+	if (!dbus_message_get_args(msg, NULL,
+				DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID)) {
+		error("Unexpected signature in %s.%s signal",
+					dbus_message_get_interface(msg),
+					dbus_message_get_member(msg));
 		return TRUE;
 	}
-	dbus_message_iter_recurse(&sub, &array);
-	while (dbus_message_iter_get_arg_type(&array) != DBUS_TYPE_INVALID) {
-		dbus_message_iter_get_basic(&array, &vc_obj_path);
-		vc = find_vc(vc_obj_path);
-		if (vc) {
-			DBG("in handle_vcmanager_property_changed,"
-					" found an existing vc");
-		} else {
-			vc_new = g_new0(struct voice_call, 1);
-			vc_new->obj_path = g_strdup(vc_obj_path);
-			calls = g_slist_append(calls, vc_new);
-			vc_new->watch = g_dbus_add_signal_watch(connection,
-					NULL, vc_obj_path,
-					OFONO_VC_INTERFACE,
-					"PropertyChanged",
-					handle_vc_property_changed,
-					vc_new, NULL);
-		}
-		dbus_message_iter_next(&array);
-	}
 
-	if (!vc_new)
-		return TRUE;
-
-	send_method_call(OFONO_BUS_NAME, vc_new->obj_path,
-				OFONO_VC_INTERFACE,
-				"GetProperties", vc_getproperties_reply,
-				vc_new->obj_path, DBUS_TYPE_INVALID);
+	call_removed(path);
 
 	return TRUE;
 }
@@ -933,7 +969,7 @@ static void modem_removed(const char *path)
 
 	DBG("%s", path);
 
-	g_slist_foreach(calls, (GFunc) vc_free, NULL);
+	g_slist_foreach(calls, (GFunc) call_free, NULL);
 	g_slist_free(calls);
 	calls = NULL;
 
@@ -1151,13 +1187,6 @@ int telephony_init(void)
 						handle_network_property_changed,
 						NULL, NULL);
 
-	voice_watch = g_dbus_add_signal_watch(connection,
-						OFONO_BUS_NAME, NULL,
-						OFONO_VCMANAGER_INTERFACE,
-						"PropertyChanged",
-						handle_vcmanager_property_changed,
-						NULL, NULL);
-
 	modem_added_watch = g_dbus_add_signal_watch(connection,
 						OFONO_BUS_NAME, NULL,
 						OFONO_MANAGER_INTERFACE,
@@ -1171,6 +1200,19 @@ int telephony_init(void)
 						"ModemRemoved",
 						handle_manager_modem_removed,
 						NULL, NULL);
+	call_added_watch = g_dbus_add_signal_watch(connection,
+						OFONO_BUS_NAME, NULL,
+						OFONO_VCMANAGER_INTERFACE,
+						"CallAdded",
+						handle_vcmanager_call_added,
+						NULL, NULL);
+
+	call_removed_watch = g_dbus_add_signal_watch(connection,
+						OFONO_BUS_NAME, NULL,
+						OFONO_VCMANAGER_INTERFACE,
+						"CallRemoved",
+						handle_vcmanager_call_removed,
+						NULL, NULL);
 
 	ret = send_method_call(OFONO_BUS_NAME, OFONO_PATH,
 				OFONO_MANAGER_INTERFACE, "GetModems",
@@ -1204,9 +1246,10 @@ void telephony_exit(void)
 		modem_removed(modem_obj_path);
 
 	g_dbus_remove_watch(connection, registration_watch);
-	g_dbus_remove_watch(connection, voice_watch);
 	g_dbus_remove_watch(connection, modem_added_watch);
 	g_dbus_remove_watch(connection, modem_removed_watch);
+	g_dbus_remove_watch(connection, call_added_watch);
+	g_dbus_remove_watch(connection, call_removed_watch);
 	g_dbus_remove_watch(connection, device_watch);
 
 	dbus_connection_unref(connection);
-- 
1.7.1

