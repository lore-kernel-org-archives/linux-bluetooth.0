Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/8] obexd/client: Add UpdateVersion to PhonebookAccess
Date: Mon,  1 Dec 2014 10:47:17 +0200
Message-Id: <1417423638-29222-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1417423638-29222-1-git-send-email-luiz.dentz@gmail.com>
References: <1417423638-29222-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds UpdateVersion method to PhonebookAccess interface.
---
 doc/obex-api.txt    |  8 ++++----
 obexd/client/pbap.c | 23 ++++++++++++++++++++---
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index 32f9a79..0cd359b 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -433,12 +433,12 @@ Methods		void Select(string location, string phonebook)
 			Possible errors: org.bluez.obex.Error.Forbidden
 					 org.bluez.obex.Error.Failed
 
-		uint16, uint16 GetVersion()
+		void UpdateVersion()
 
-			Return the primary and secondary folder version counters
-			for the selected phonebook.
+			Attempt to update PrimaryCounter and SecondaryCounter.
 
-			Possible errors: org.bluez.obex.Error.Forbidden
+			Possible errors: org.bluez.obex.Error.NotSupported
+					 org.bluez.obex.Error.Forbidden
 					 org.bluez.obex.Error.Failed
 
 		array{string} ListFilterFields()
diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 2398071..812a7fb 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -383,9 +383,11 @@ static void phonebook_size_callback(struct obc_session *session,
 	read_return_apparam(transfer, request->pbap, &phone_book_size,
 							&new_missed_calls);
 
-	dbus_message_append_args(reply,
-			DBUS_TYPE_UINT16, &phone_book_size,
-			DBUS_TYPE_INVALID);
+	if (dbus_message_is_method_call(request->msg, PBAP_INTERFACE,
+								"GetSize"))
+		dbus_message_append_args(reply,
+					DBUS_TYPE_UINT16, &phone_book_size,
+					DBUS_TYPE_INVALID);
 
 send:
 	g_dbus_send_message(conn, reply);
@@ -1014,6 +1016,19 @@ static DBusMessage *pbap_list_filter_fields(DBusConnection *connection,
 	return reply;
 }
 
+static DBusMessage *pbap_update_version(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct pbap_data *pbap = user_data;
+
+	if (!(pbap->supported_features & FOLDER_VERSION_FEATURE))
+		return g_dbus_create_error(message,
+					ERROR_INTERFACE ".NotSupported",
+					"Operation is not supported");
+
+	return pbap_get_size(connection, message, user_data);
+}
+
 static const GDBusMethodTable pbap_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Select",
 			GDBUS_ARGS({ "location", "s" }, { "phonebook", "s" }),
@@ -1045,6 +1060,8 @@ static const GDBusMethodTable pbap_methods[] = {
 	{ GDBUS_METHOD("ListFilterFields",
 				NULL, GDBUS_ARGS({ "fields", "as" }),
 				pbap_list_filter_fields) },
+	{ GDBUS_ASYNC_METHOD("UpdateVersion", NULL, NULL,
+				pbap_update_version) },
 	{ }
 };
 
-- 
1.9.3

