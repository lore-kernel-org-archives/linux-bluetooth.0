Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 10/13 v2] client: remove use of gobex in pbap module
Date: Tue,  7 Feb 2012 16:25:49 +0200
Message-Id: <1328624752-26061-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1328624752-26061-1-git-send-email-luiz.dentz@gmail.com>
References: <1328624752-26061-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

gobex should not be use directly as it can interfere with ongoing
requests of the session.
---
 client/pbap.c |  132 ++++++++++++++++----------------------------------------
 1 files changed, 38 insertions(+), 94 deletions(-)

diff --git a/client/pbap.c b/client/pbap.c
index 4a93fd5..e1db0e7 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -124,6 +124,8 @@ static const char *filter_list[] = {
 #define PBAP_INTERFACE  "org.openobex.PhonebookAccess"
 #define PBAP_UUID "0000112f-0000-1000-8000-00805f9b34fb"
 
+#define PBAP_ERROR pbap_error_quark()
+
 struct pbap_data {
 	struct obc_session *session;
 	char *path;
@@ -167,6 +169,11 @@ struct apparam_hdr {
 
 static DBusConnection *conn = NULL;
 
+static GQuark pbap_error_quark(void)
+{
+	return g_quark_from_static_string("pbap-error-quark");
+}
+
 static void listing_element(GMarkupParseContext *ctxt,
 				const gchar *element,
 				const gchar **names,
@@ -240,84 +247,17 @@ static gchar *build_phonebook_path(const char *location, const char *item)
 	return path;
 }
 
-typedef void (*setpath_cb_t) (GError *err, gpointer user_data);
-
-struct setpath_data {
-	char **remaining;
-	int index;
-	setpath_cb_t func;
-	gpointer user_data;
-};
-
-static void setpath_complete(GError *err, struct setpath_data *data)
-{
-	if (data->func)
-		data->func(err, data->user_data);
-	g_strfreev(data->remaining);
-	g_free(data);
-}
-
-static void setpath_cb(GObex *obex, GError *err, GObexPacket *rsp,
-							gpointer user_data)
-{
-	struct setpath_data *data = user_data;
-	char *next;
-
-	if (err != NULL) {
-		setpath_complete(err, data);
-		return;
-	}
-
-	next = data->remaining[data->index];
-	if (next == NULL) {
-		setpath_complete(NULL, data);
-		return;
-	}
-
-	data->index++;
-
-	g_obex_setpath(obex, next, setpath_cb, data, &err);
-	if (err != NULL) {
-		setpath_complete(err, data);
-		g_error_free(err);
-	}
-}
-
-static gboolean setpath(GObex *obex, const char *path, size_t max_elem,
-					setpath_cb_t func, gpointer user_data)
-{
-	GError *err = NULL;
-	struct setpath_data *data;
-
-	data = g_new0(struct setpath_data, 1);
-
-	g_obex_setpath(obex, "", setpath_cb, data, &err);
-	if (err != NULL) {
-		error("set_path: %s", err->message);
-		g_error_free(err);
-		g_free(data);
-		return FALSE;
-	}
-
-	data->func = func;
-	data->user_data = user_data;
-	data->remaining = g_strsplit(path, "/", max_elem);
-
-	return TRUE;
-}
-
 /* should only be called inside pbap_set_path */
 static void pbap_reset_path(struct pbap_data *pbap)
 {
-	GObex *obex = obc_session_get_obex(pbap->session);
-
 	if (!pbap->path)
 		return;
 
-	setpath(obex, pbap->path, 3, NULL, NULL);
+	obc_session_setpath(pbap->session, pbap->path, NULL, NULL, NULL);
 }
 
-static void pbap_setpath_cb(GError *err, gpointer user_data)
+static void pbap_setpath_cb(struct obc_session *session, GError *err,
+							gpointer user_data)
 {
 	struct pbap_data *pbap = user_data;
 
@@ -339,23 +279,32 @@ static void pbap_setpath_cb(GError *err, gpointer user_data)
 	pbap->msg = NULL;
 }
 
-static int pbap_set_path(struct pbap_data *pbap, const char *path)
+static gboolean pbap_setpath(struct pbap_data *pbap, const char *location,
+					const char *item, GError **err)
 {
-	GObex *obex = obc_session_get_obex(pbap->session);
+	char *path;
 
-	if (!path)
-		return G_OBEX_RSP_BAD_REQUEST;
+	path = build_phonebook_path(location, item);
+	if (path == NULL) {
+		g_set_error(err, PBAP_ERROR, -EINVAL, strerror(-EINVAL));
+		return FALSE;
+	}
 
-	if (pbap->path != NULL && g_str_equal(pbap->path, path))
-		return 0;
+	if (pbap->path != NULL && g_str_equal(pbap->path, path)) {
+		g_free(path);
+		return TRUE;
+	}
 
-	if (!setpath(obex, path, 3, pbap_setpath_cb, pbap))
-		return G_OBEX_RSP_INTERNAL_SERVER_ERROR;
+	obc_session_setpath(pbap->session, path, pbap_setpath_cb, pbap, err);
+	if (err != NULL) {
+		g_free(pbap->path);
+		pbap->path = path;
+		return TRUE;
+	}
 
-	g_free(pbap->path);
-	pbap->path = g_strdup(path);
+	g_free(path);
 
-	return G_OBEX_RSP_SUCCESS;
+	return FALSE;
 }
 
 static void read_return_apparam(struct obc_session *session,
@@ -748,8 +697,7 @@ static DBusMessage *pbap_select(DBusConnection *connection,
 {
 	struct pbap_data *pbap = user_data;
 	const char *item, *location;
-	char *path = NULL;
-	int err = 0;
+	GError *err = NULL;
 
 	if (dbus_message_get_args(message, NULL,
 			DBUS_TYPE_STRING, &location,
@@ -758,17 +706,13 @@ static DBusMessage *pbap_select(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				ERROR_INF ".InvalidArguments", NULL);
 
-	path = build_phonebook_path(location, item);
-	if (!path)
-		return g_dbus_create_error(message,
-				ERROR_INF ".InvalidArguments", "InvalidPhonebook");
-
-	err = pbap_set_path(pbap, path);
-	g_free(path);
-	if (err != G_OBEX_RSP_SUCCESS)
-		return g_dbus_create_error(message,
-				ERROR_INF ".Failed",
-				"0x%02x", err);
+	if (!pbap_setpath(pbap, location, item, &err)) {
+		DBusMessage *reply;
+		reply =  g_dbus_create_error(message, ERROR_INF ".Failed",
+							"%s", err->message);
+		g_error_free(err);
+		return reply;
+	}
 
 	pbap->msg = dbus_message_ref(message);
 
-- 
1.7.7.6

