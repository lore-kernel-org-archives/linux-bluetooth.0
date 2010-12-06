Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/9] Add btd_error_not_available()
Date: Mon,  6 Dec 2010 17:10:45 -0200
Message-Id: <1291662648-10651-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291662648-10651-5-git-send-email-padovan@profusion.mobi>
References: <1291662648-10651-1-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-2-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-3-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-4-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-5-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/headset.c   |    9 +++------
 plugins/service.c |   16 +++-------------
 src/error.c       |    7 +++++++
 src/error.h       |    1 +
 4 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index c3d7f82..0413588 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1792,8 +1792,7 @@ static DBusMessage *hs_play(DBusConnection *conn, DBusMessage *msg,
 	if (sco_hci) {
 		error("Refusing Headset.Play() because SCO HCI routing "
 				"is enabled");
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAvailable",
-						"Operation not Available");
+		return btd_error_not_available(msg);
 	}
 
 	switch (hs->state) {
@@ -1838,8 +1837,7 @@ static DBusMessage *hs_get_speaker_gain(DBusConnection *conn,
 	dbus_uint16_t gain;
 
 	if (hs->state < HEADSET_STATE_CONNECTED)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAvailable",
-						"Operation not Available");
+		return btd_error_not_available(msg);
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
@@ -1864,8 +1862,7 @@ static DBusMessage *hs_get_mic_gain(DBusConnection *conn,
 	dbus_uint16_t gain;
 
 	if (hs->state < HEADSET_STATE_CONNECTED || slc == NULL)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAvailable",
-						"Operation not Available");
+		return btd_error_not_available(msg);
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
diff --git a/plugins/service.c b/plugins/service.c
index 12e05c1..a71540c 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -337,12 +337,6 @@ static void exit_callback(DBusConnection *conn, void *user_data)
 	g_free(user_record);
 }
 
-static inline DBusMessage *not_available(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAvailable",
-							"Not Available");
-}
-
 static inline DBusMessage *failed(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed", "Failed");
@@ -417,9 +411,7 @@ static DBusMessage *update_record(DBusConnection *conn, DBusMessage *msg,
 
 	if (remove_record_from_server(handle) < 0) {
 		sdp_record_free(sdp_record);
-		return g_dbus_create_error(msg,
-				ERROR_INTERFACE ".NotAvailable",
-				"Not Available");
+		return btd_error_not_available(msg);
 	}
 
 	if (serv_adapter->adapter)
@@ -463,9 +455,7 @@ static DBusMessage *update_xml_record(DBusConnection *conn,
 	user_record = find_record(serv_adapter, handle,
 				dbus_message_get_sender(msg));
 	if (!user_record)
-		return g_dbus_create_error(msg,
-				ERROR_INTERFACE ".NotAvailable",
-				"Not Available");
+		return btd_error_not_available(msg);
 
 	sdp_record = sdp_xml_parse_record(record, len);
 	if (!sdp_record) {
@@ -550,7 +540,7 @@ static DBusMessage *remove_service_record(DBusConnection *conn,
 	sender = dbus_message_get_sender(msg);
 
 	if (remove_record(conn, sender, serv_adapter, handle) < 0)
-		return not_available(msg);
+		return btd_error_not_available(msg);
 
 	return dbus_message_new_method_return(msg);
 }
diff --git a/src/error.c b/src/error.c
index 9b18842..3f9acd9 100644
--- a/src/error.c
+++ b/src/error.c
@@ -83,3 +83,10 @@ DBusMessage *btd_error_in_progress(DBusMessage *msg)
 					".InProgress",
 					"In Progress");
 }
+
+DBusMessage *btd_error_not_available(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE
+					".NotAvailable",
+					"Operation currently not available");
+}
diff --git a/src/error.h b/src/error.h
index b8066ce..623860e 100644
--- a/src/error.h
+++ b/src/error.h
@@ -34,4 +34,5 @@ DBusMessage *btd_error_invalid_args(DBusMessage *msg);
 DBusMessage *btd_error_already_exists(DBusMessage *msg);
 DBusMessage *btd_error_not_supported(DBusMessage *msg);
 DBusMessage *btd_error_not_connected(DBusMessage *msg);
+DBusMessage *btd_error_not_available(DBusMessage *msg);
 DBusMessage *btd_error_in_progress(DBusMessage *msg);
-- 
1.7.3.2

