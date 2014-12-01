Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/8] obexd/client: Add Folder property
Date: Mon,  1 Dec 2014 10:47:13 +0200
Message-Id: <1417423638-29222-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1417423638-29222-1-git-send-email-luiz.dentz@gmail.com>
References: <1417423638-29222-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds Folder property to PhonebookAccess interface.
---
 obexd/client/pbap.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index c33de3f..57f58ee 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -256,6 +256,10 @@ static void pbap_setpath_cb(struct obc_session *session,
 
 	if (err != NULL)
 		pbap_reset_path(pbap);
+	else
+		g_dbus_emit_property_changed(conn,
+					obc_session_get_path(pbap->session),
+					PBAP_INTERFACE, "Folder");
 
 	if (err) {
 		DBusMessage *reply = g_dbus_create_error(request->msg,
@@ -971,6 +975,31 @@ static const GDBusMethodTable pbap_methods[] = {
 	{ }
 };
 
+static gboolean folder_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct pbap_data *pbap = data;
+
+	return pbap->path != NULL;
+}
+
+static gboolean get_folder(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct pbap_data *pbap = data;
+
+	if (!pbap->path)
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &pbap->path);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable pbap_properties[] = {
+	{ "Folder", "s", get_folder, NULL, folder_exists },
+	{ }
+};
+
 static void pbap_free(void *data)
 {
 	struct pbap_data *pbap = data;
@@ -1030,7 +1059,8 @@ static int pbap_probe(struct obc_session *session)
 						pbap->supported_features);
 
 	if (!g_dbus_register_interface(conn, path, PBAP_INTERFACE, pbap_methods,
-						NULL, NULL, pbap, pbap_free)) {
+						NULL, pbap_properties, pbap,
+						pbap_free)) {
 		pbap_free(pbap);
 		return -ENOMEM;
 	}
-- 
1.9.3

