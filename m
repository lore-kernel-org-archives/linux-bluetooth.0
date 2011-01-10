Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] telephony-ofono: add support for Three Way Calling feature
Date: Mon, 10 Jan 2011 15:05:45 +0200
Message-Id: <1294664745-16487-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1294664745-16487-1-git-send-email-luiz.dentz@gmail.com>
References: <1294664745-16487-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

The Three Way Calling additionally support AT+CHLD values 0,3 and 4.
---
 audio/telephony-ofono.c |   62 +++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index fb32ca9..4e78801 100644
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
@@ -289,6 +290,33 @@ static int swap_calls(void)
 						NULL, NULL, DBUS_TYPE_INVALID);
 }
 
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
 	struct voice_call *call;
@@ -309,6 +337,8 @@ void telephony_terminate_call_req(void *telephony_device)
 	alerting = find_vc_with_status(CALL_STATUS_ALERTING);
 	if (call->status == CALL_STATUS_HELD && alerting)
 		err = release_call(alerting);
+	else if (call->conference)
+		err = release_conference();
 	else
 		err = release_call(call);
 
@@ -431,15 +461,19 @@ void telephony_list_current_calls_req(void *telephony_device)
 
 	for (l = calls, i = 1; l != NULL; l = l->next, i++) {
 		struct voice_call *vc = l->data;
-		int direction;
+		int direction, multiparty;
 
 		direction = vc->originating ?
 				CALL_DIR_OUTGOING : CALL_DIR_INCOMING;
 
-		DBG("call %s direction %d", vc->number, direction);
+		multiparty = vc->conference ?
+				CALL_MULTIPARTY_YES : CALL_MULTIPARTY_NO;
+
+		DBG("call %s direction %d multiparty %d", vc->number,
+							direction, multiparty);
 
 		telephony_list_current_call_ind(i, direction, vc->status,
-					CALL_MODE_VOICE, CALL_MULTIPARTY_NO,
+					CALL_MODE_VOICE, multiparty,
 					vc->number, number_type(vc->number));
 	}
 
@@ -515,6 +549,14 @@ void telephony_call_hold_req(void *telephony_device, const char *cmd)
 				err = swap_calls();
 		}
 		break;
+	case '3':
+		if (find_vc_with_status(CALL_STATUS_HELD) ||
+				find_vc_with_status(CALL_STATUS_WAITING))
+			err = create_conference();
+		break;
+	case '4':
+		err = call_transfer();
+		break;
 	default:
 		DBG("Unknown call hold request");
 		break;
@@ -679,6 +721,12 @@ static gboolean handle_vc_property_changed(DBusConnection *conn,
 							"callheld",
 							EV_CALLHELD_ON_HOLD);
 		}
+	} else if (g_str_equal(property, "Multiparty")) {
+		dbus_bool_t multiparty;
+
+		dbus_message_iter_get_basic(&sub, &multiparty);
+		DBG("Multiparty %s", multiparty ? "True" : "False");
+		vc->conference = multiparty;
 	}
 
 	return TRUE;
@@ -700,6 +748,7 @@ static struct voice_call *call_new(const char *path, DBusMessageIter *properties
 						== DBUS_TYPE_DICT_ENTRY) {
 		DBusMessageIter entry, value;
 		const char *property, *cli, *state;
+		dbus_bool_t multiparty;
 
 		dbus_message_iter_recurse(properties, &entry);
 		dbus_message_iter_get_basic(&entry, &property);
@@ -724,6 +773,10 @@ static struct voice_call *call_new(const char *path, DBusMessageIter *properties
 				vc->status = CALL_STATUS_WAITING;
 			else if (g_str_equal(state, "held"))
 				vc->status = CALL_STATUS_HELD;
+		} else if (g_str_equal(property, "Multiparty")) {
+			dbus_message_iter_get_basic(&value, &multiparty);
+			DBG("Multipary %s", multiparty ? "True" : "False");
+			vc->conference = multiparty;
 		}
 
 		dbus_message_iter_next(properties);
@@ -880,7 +933,8 @@ static int parse_network_properties(DBusMessageIter *properties)
 				AG_FEATURE_REJECT_A_CALL |
 				AG_FEATURE_ENHANCED_CALL_STATUS |
 				AG_FEATURE_ENHANCED_CALL_CONTROL |
-				AG_FEATURE_EXTENDED_ERROR_RESULT_CODES;
+				AG_FEATURE_EXTENDED_ERROR_RESULT_CODES |
+				AG_FEATURE_THREE_WAY_CALLING;
 
 	while (dbus_message_iter_get_arg_type(properties)
 						== DBUS_TYPE_DICT_ENTRY) {
-- 
1.7.1

