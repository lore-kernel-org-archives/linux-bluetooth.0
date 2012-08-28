Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 6/7 v2] client: Move common code to pull_phonebook
Date: Tue, 28 Aug 2012 15:31:54 +0300
Message-Id: <1346157115-23933-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1346157115-23933-1-git-send-email-luiz.dentz@gmail.com>
References: <1346157115-23933-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/pbap.c | 79 +++++++++++++++++++++++------------------------------------
 1 file changed, 30 insertions(+), 49 deletions(-)

diff --git a/client/pbap.c b/client/pbap.c
index e58efe5..f49aae9 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -523,22 +523,29 @@ static GObexApparam *parse_filters(GObexApparam *apparam,
 	return apparam;
 }
 
-static struct obc_transfer *pull_phonebook(struct pbap_data *pbap,
+static DBusMessage *pull_phonebook(struct pbap_data *pbap,
 						DBusMessage *message,
-						guint8 type, const char *name,
+						guint8 type,
 						const char *targetfile,
-						GObexApparam *apparam,
-						GError **err)
+						GObexApparam *apparam)
 {
 	struct pending_request *request;
 	struct obc_transfer *transfer;
+	char *name;
 	guint8 buf[32];
 	gsize len;
 	session_callback_t func;
+	DBusMessage *reply;
+	GError *err = NULL;
+
+	name = g_strconcat(pbap->path, ".vcf", NULL);
+
+	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
+	g_obex_apparam_free(apparam);
 
-	transfer = obc_transfer_get("x-bt/phonebook", name, targetfile, err);
+	transfer = obc_transfer_get("x-bt/phonebook", name, targetfile, &err);
 	if (transfer == NULL)
-		return NULL;
+		goto fail;
 
 	switch (type) {
 	case PULLPHONEBOOK:
@@ -554,19 +561,28 @@ static struct obc_transfer *pull_phonebook(struct pbap_data *pbap,
 		return NULL;
 	}
 
-	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
-
 	obc_transfer_set_params(transfer, buf, len);
 
-	if (!obc_session_queue(pbap->session, transfer, func, request, err)) {
+	if (!obc_session_queue(pbap->session, transfer, func, request, &err)) {
 		if (request != NULL)
 			pending_request_free(request);
 
-		return NULL;
+		goto fail;
 	}
 
+	g_free(name);
+
+	if (targetfile == NULL)
+		return NULL;
 
-	return transfer;
+	return obc_transfer_create_dbus_reply(transfer, message);
+
+fail:
+	g_free(name);
+	reply = g_dbus_create_error(message, ERROR_INTERFACE ".Failed", "%s",
+								err->message);
+	g_error_free(err);
+	return reply;
 }
 
 static DBusMessage *pull_vcard_listing(struct pbap_data *pbap,
@@ -655,11 +671,8 @@ static DBusMessage *pbap_pull_all(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	struct pbap_data *pbap = user_data;
-	struct obc_transfer *transfer;
 	const char *targetfile;
-	char *name;
 	GObexApparam *apparam;
-	GError *err = NULL;
 	DBusMessageIter args;
 
 	if (!pbap->path)
@@ -687,22 +700,8 @@ static DBusMessage *pbap_pull_all(DBusConnection *connection,
 				ERROR_INTERFACE ".InvalidArguments", NULL);
 	}
 
-	name = g_strconcat(pbap->path, ".vcf", NULL);
-
-	transfer = pull_phonebook(pbap, message, PULLPHONEBOOK, name,
-						targetfile, apparam, &err);
-	g_free(name);
-	g_obex_apparam_free(apparam);
-
-	if (transfer == NULL) {
-		DBusMessage *reply = g_dbus_create_error(message,
-					ERROR_INTERFACE ".Failed", "%s",
-					err->message);
-		g_error_free(err);
-		return reply;
-	}
-
-	return obc_transfer_create_dbus_reply(transfer, message);
+	return pull_phonebook(pbap, message, PULLPHONEBOOK, targetfile,
+								apparam);
 }
 
 static DBusMessage *pull_vcard(struct pbap_data *pbap, DBusMessage *message,
@@ -878,11 +877,7 @@ static DBusMessage *pbap_get_size(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	struct pbap_data *pbap = user_data;
-	DBusMessage *reply;
-	struct obc_transfer *transfer;
-	char *name;
 	GObexApparam *apparam;
-	GError *err = NULL;
 	DBusMessageIter args;
 
 	if (!pbap->path)
@@ -892,25 +887,11 @@ static DBusMessage *pbap_get_size(DBusConnection *connection,
 
 	dbus_message_iter_init(message, &args);
 
-	name = g_strconcat(pbap->path, ".vcf", NULL);
-
 	apparam = g_obex_apparam_set_uint16(NULL, MAXLISTCOUNT_TAG, 0);
 	apparam = g_obex_apparam_set_uint16(apparam, LISTSTARTOFFSET_TAG,
 							DEFAULT_OFFSET);
 
-	transfer = pull_phonebook(pbap, message, GETPHONEBOOKSIZE, name, NULL,
-								apparam, &err);
-
-	g_free(name);
-	g_obex_apparam_free(apparam);
-
-	if (transfer != NULL)
-		return NULL;
-
-	reply = g_dbus_create_error(message, ERROR_INTERFACE ".Failed", "%s",
-								err->message);
-	g_error_free(err);
-	return reply;
+	return pull_phonebook(pbap, message, GETPHONEBOOKSIZE, NULL, apparam);
 }
 
 static gchar **get_filter_strs(uint64_t filter, gint *size)
-- 
1.7.11.4

