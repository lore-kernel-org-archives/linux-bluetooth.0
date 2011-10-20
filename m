Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 8/8] Implement D-Bus get properties function
Date: Thu, 20 Oct 2011 11:46:51 +0200
Message-Id: <1319104011-27747-9-git-send-email-sancane@gmail.com>
In-Reply-To: <1319104011-27747-8-git-send-email-sancane@gmail.com>
References: <1319104011-27747-1-git-send-email-sancane@gmail.com>
 <1319104011-27747-2-git-send-email-sancane@gmail.com>
 <1319104011-27747-3-git-send-email-sancane@gmail.com>
 <1319104011-27747-4-git-send-email-sancane@gmail.com>
 <1319104011-27747-5-git-send-email-sancane@gmail.com>
 <1319104011-27747-6-git-send-email-sancane@gmail.com>
 <1319104011-27747-7-git-send-email-sancane@gmail.com>
 <1319104011-27747-8-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   32 +++++++++++++++++++++++++++++---
 1 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 4a2b9c8..99bfe43 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -452,9 +452,35 @@ static void configure_thermometer_cb(GSList *characteristics, guint8 status,
 static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
-	/* TODO: */
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".ThermometerError",
-						"Function not implemented.");
+	struct thermometer *t = data;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	DBusMessage *reply;
+
+	reply = dbus_message_new_method_return(msg);
+	if (reply == NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	dict_append_entry(&dict, "Intermediate", DBUS_TYPE_BOOLEAN,
+							&t->intermediate);
+
+	if (t->has_interval) {
+		dict_append_entry(&dict, "Interval", DBUS_TYPE_UINT16,
+								&t->interval);
+		dict_append_entry(&dict, "Maximum", DBUS_TYPE_UINT16, &t->max);
+		dict_append_entry(&dict, "Minimum", DBUS_TYPE_UINT16, &t->min);
+	}
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
 }
 
 static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
-- 
1.7.6.1

