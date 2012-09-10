Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/7 v4] client: Add filters to PhonebookAccess.Pull
Date: Mon, 10 Sep 2012 11:02:54 +0300
Message-Id: <1347264179-31477-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1347264179-31477-1-git-send-email-luiz.dentz@gmail.com>
References: <1347264179-31477-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This avoid D-Bus round trips and is more aligned with what has been
proposed for MessageAccess interface.
---
 client/pbap.c | 78 +++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 26 deletions(-)

diff --git a/client/pbap.c b/client/pbap.c
index b41412c..3f182df 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -804,43 +804,25 @@ static DBusMessage *pbap_pull_all(DBusConnection *connection,
 	return obc_transfer_create_dbus_reply(transfer, message);
 }
 
-static DBusMessage *pbap_pull_vcard(DBusConnection *connection,
-					DBusMessage *message, void *user_data)
+static DBusMessage *pull_vcard(struct pbap_data *pbap, DBusMessage *message,
+				const char *name, const char *targetfile,
+				GObexApparam *apparam)
 {
-	struct pbap_data *pbap = user_data;
 	struct obc_transfer *transfer;
-	GObexApparam *apparam;
-	guint8 buf[32];
-	gsize len;
-	const char *name, *targetfile;
 	DBusMessage *reply;
 	GError *err = NULL;
+	guint8 buf[32];
+	gsize len;
 
-	if (!pbap->path)
-		return g_dbus_create_error(message,
-				ERROR_INTERFACE ".Forbidden",
-				"Call Select first of all");
-
-	if (dbus_message_get_args(message, NULL,
-			DBUS_TYPE_STRING, &name,
-			DBUS_TYPE_STRING, &targetfile,
-			DBUS_TYPE_INVALID) == FALSE)
-		return g_dbus_create_error(message,
-				ERROR_INTERFACE ".InvalidArguments", NULL);
+	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
+	g_obex_apparam_free(apparam);
 
 	transfer = obc_transfer_get("x-bt/vcard", name, targetfile, &err);
 	if (transfer == NULL)
 		goto fail;
 
-	apparam = g_obex_apparam_set_uint64(NULL, FILTER_TAG, pbap->filter);
-	apparam = g_obex_apparam_set_uint8(apparam, FORMAT_TAG, pbap->format);
-
-	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
-
 	obc_transfer_set_params(transfer, buf, len);
 
-	g_obex_apparam_free(apparam);
-
 	if (!obc_session_queue(pbap->session, transfer, NULL, NULL, &err))
 		goto fail;
 
@@ -853,6 +835,49 @@ fail:
 	return reply;
 }
 
+static DBusMessage *pbap_pull_vcard(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct pbap_data *pbap = user_data;
+	GObexApparam *apparam;
+	const char *name, *targetfile;
+	DBusMessageIter args;
+
+	if (!pbap->path)
+		return g_dbus_create_error(message,
+				ERROR_INTERFACE ".Forbidden",
+				"Call Select first of all");
+
+	dbus_message_iter_init(message, &args);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_STRING)
+		return g_dbus_create_error(message,
+				ERROR_INTERFACE ".InvalidArguments", NULL);
+
+	dbus_message_iter_get_basic(&args, &name);
+	dbus_message_iter_next(&args);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_STRING)
+		return g_dbus_create_error(message,
+				ERROR_INTERFACE ".InvalidArguments", NULL);
+
+	dbus_message_iter_get_basic(&args, &targetfile);
+	dbus_message_iter_next(&args);
+
+	apparam = g_obex_apparam_set_uint16(NULL, MAXLISTCOUNT_TAG,
+							DEFAULT_COUNT);
+	apparam = g_obex_apparam_set_uint16(apparam, LISTSTARTOFFSET_TAG,
+							DEFAULT_OFFSET);
+
+	if (parse_filters(apparam, &args) == NULL) {
+		g_obex_apparam_free(apparam);
+		return g_dbus_create_error(message,
+				ERROR_INTERFACE ".InvalidArguments", NULL);
+	}
+
+	return pull_vcard(pbap, message, name, targetfile, apparam);
+}
+
 static DBusMessage *pbap_list(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
@@ -1060,7 +1085,8 @@ static const GDBusMethodTable pbap_methods[] = {
 					{ "properties", "a{sv}" }),
 			pbap_pull_all) },
 	{ GDBUS_METHOD("Pull",
-			GDBUS_ARGS({ "vcard", "s" }, { "targetfile", "s" }),
+			GDBUS_ARGS({ "vcard", "s" }, { "targetfile", "s" },
+					{ "filters", "a{sv}" }),
 			GDBUS_ARGS({ "transfer", "o" },
 					{ "properties", "a{sv}" }),
 			pbap_pull_vcard) },
-- 
1.7.11.4

