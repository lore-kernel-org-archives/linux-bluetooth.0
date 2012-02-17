Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v4 4/6] client: fix pbap select when same path given twice
Date: Fri, 17 Feb 2012 13:55:34 +0100
Message-Id: <1329483336-25853-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1329483336-25853-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329483336-25853-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

If the same path is selected twice, the operation can be skipped but the
D-Bus response should still be sent.
---
 client/pbap.c |   59 +++++++++++++++-----------------------------------------
 1 files changed, 16 insertions(+), 43 deletions(-)

diff --git a/client/pbap.c b/client/pbap.c
index dd5642d..c4b14a2 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -124,12 +124,6 @@ static const char *filter_list[] = {
 #define PBAP_INTERFACE  "org.openobex.PhonebookAccess"
 #define PBAP_UUID "0000112f-0000-1000-8000-00805f9b34fb"
 
-#define PBAP_ERROR pbap_error_quark()
-
-enum {
-	PBAP_INVALID_PATH,
-};
-
 struct pbap_data {
 	struct obc_session *session;
 	char *path;
@@ -173,11 +167,6 @@ struct apparam_hdr {
 
 static DBusConnection *conn = NULL;
 
-static GQuark pbap_error_quark(void)
-{
-	return g_quark_from_static_string("pbap-error-quark");
-}
-
 static void listing_element(GMarkupParseContext *ctxt,
 				const gchar *element,
 				const gchar **names,
@@ -283,37 +272,6 @@ static void pbap_setpath_cb(struct obc_session *session, GError *err,
 	pbap->msg = NULL;
 }
 
-static gboolean pbap_setpath(struct pbap_data *pbap, const char *location,
-					const char *item, GError **err)
-{
-	char *path;
-	guint id;
-
-	path = build_phonebook_path(location, item);
-	if (path == NULL) {
-		g_set_error(err, PBAP_ERROR, PBAP_INVALID_PATH,
-							"Invalid path");
-		return FALSE;
-	}
-
-	if (pbap->path != NULL && g_str_equal(pbap->path, path)) {
-		g_free(path);
-		return TRUE;
-	}
-
-	id = obc_session_setpath(pbap->session, path, pbap_setpath_cb, pbap,
-									err);
-	if (id > 0) {
-		g_free(pbap->path);
-		pbap->path = path;
-		return TRUE;
-	}
-
-	g_free(path);
-
-	return FALSE;
-}
-
 static void read_return_apparam(struct obc_session *session,
 				guint16 *phone_book_size, guint8 *new_missed_calls)
 {
@@ -704,6 +662,7 @@ static DBusMessage *pbap_select(DBusConnection *connection,
 {
 	struct pbap_data *pbap = user_data;
 	const char *item, *location;
+	char *path;
 	GError *err = NULL;
 
 	if (dbus_message_get_args(message, NULL,
@@ -713,14 +672,28 @@ static DBusMessage *pbap_select(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				ERROR_INF ".InvalidArguments", NULL);
 
-	if (!pbap_setpath(pbap, location, item, &err)) {
+	path = build_phonebook_path(location, item);
+	if (path == NULL)
+		return g_dbus_create_error(message,
+				ERROR_INF ".InvalidArguments", "Invalid path");
+
+	if (pbap->path != NULL && g_str_equal(pbap->path, path)) {
+		g_free(path);
+		return dbus_message_new_method_return(message);
+	}
+
+	obc_session_setpath(pbap->session, path, pbap_setpath_cb, pbap, &err);
+	if (err != NULL) {
 		DBusMessage *reply;
 		reply =  g_dbus_create_error(message, ERROR_INF ".Failed",
 							"%s", err->message);
 		g_error_free(err);
+		g_free(path);
 		return reply;
 	}
 
+	g_free(pbap->path);
+	pbap->path = path;
 	pbap->msg = dbus_message_ref(message);
 
 	return NULL;
-- 
1.7.6.5

