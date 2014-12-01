Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/8] obexd/client: Add DatabaseIdentifier property
Date: Mon,  1 Dec 2014 10:47:14 +0200
Message-Id: <1417423638-29222-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1417423638-29222-1-git-send-email-luiz.dentz@gmail.com>
References: <1417423638-29222-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds DatabaseIdentifier property to PhonebookAccess interface.
---
 doc/obex-api.txt    |  4 ++-
 obexd/client/pbap.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index 349fe4c..ea82e39 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -500,8 +500,10 @@ Properties	string Folder [readonly]
 
 		string DatabaseIdentifier [readonly, optional]
 
-			128 bits persistent identifier.
+			128 bits persistent database identifier.
 
+			Possible values: 32-character hexadecimal such
+			as A1A2A3A4B1B2C1C2D1D2E1E2E3E4E5E6
 
 Synchronization hierarchy
 =========================
diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 57f58ee..97c7cb9 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -73,6 +73,7 @@
 #define FORMAT_TAG		0X07
 #define PHONEBOOKSIZE_TAG	0X08
 #define NEWMISSEDCALLS_TAG	0X09
+#define DATABASEID_TAG		0X0D
 
 #define DOWNLOAD_FEATURE	0x00000001
 #define BROWSE_FEATURE		0x00000002
@@ -133,6 +134,7 @@ struct pbap_data {
 	char *path;
 	uint16_t version;
 	uint32_t supported_features;
+	uint8_t databaseid[16];
 };
 
 struct pending_request {
@@ -272,8 +274,33 @@ static void pbap_setpath_cb(struct obc_session *session,
 	pending_request_free(request);
 }
 
+static void read_databaseid(struct pbap_data *pbap, GObexApparam *apparam)
+{
+	const guint8 *data;
+	guint8 value[16];
+	gsize len;
+
+	if (!(pbap->supported_features & DATABASEID_FEATURE))
+		return;
+
+	if (!g_obex_apparam_get_bytes(apparam, DATABASEID_TAG, &data, &len)) {
+		len = sizeof(value);
+		memset(value, 0, len);
+		data = value;
+	}
+
+	if (memcmp(data, pbap->databaseid, len)) {
+		memcpy(pbap->databaseid, data, len);
+		g_dbus_emit_property_changed(conn,
+					obc_session_get_path(pbap->session),
+					PBAP_INTERFACE, "DatabaseIdentifier");
+	}
+}
+
 static void read_return_apparam(struct obc_transfer *transfer,
-				guint16 *phone_book_size, guint8 *new_missed_calls)
+					struct pbap_data *pbap,
+					guint16 *phone_book_size,
+					guint8 *new_missed_calls)
 {
 	GObexApparam *apparam;
 
@@ -288,6 +315,8 @@ static void read_return_apparam(struct obc_transfer *transfer,
 							phone_book_size);
 	g_obex_apparam_get_uint8(apparam, NEWMISSEDCALLS_TAG,
 							new_missed_calls);
+
+	read_databaseid(pbap, apparam);
 }
 
 static void phonebook_size_callback(struct obc_session *session,
@@ -308,7 +337,8 @@ static void phonebook_size_callback(struct obc_session *session,
 
 	reply = dbus_message_new_method_return(request->msg);
 
-	read_return_apparam(transfer, &phone_book_size, &new_missed_calls);
+	read_return_apparam(transfer, request->pbap, &phone_book_size,
+							&new_missed_calls);
 
 	dbus_message_append_args(reply,
 			DBUS_TYPE_UINT16, &phone_book_size,
@@ -995,8 +1025,45 @@ static gboolean get_folder(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean databaseid_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct pbap_data *pbap = data;
+
+	return pbap->supported_features & DATABASEID_FEATURE;
+}
+
+static int u128_to_string(uint8_t *data, char *str, size_t len)
+{
+	return snprintf(str, len, "%02X%02X%02X%02X%02X%02X%02X%02X"
+					"%02X%02X%02X%02X%02X%02X%02X%02X",
+					data[0], data[1], data[2], data[3],
+					data[3], data[5], data[6], data[7],
+					data[8], data[9], data[10], data[11],
+					data[12], data[13], data[14], data[15]);
+}
+
+static gboolean get_databaseid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct pbap_data *pbap = data;
+	char value[33];
+	const char *pvalue = value;
+
+	if (!pbap->databaseid)
+		return FALSE;
+
+	if (u128_to_string(pbap->databaseid, value, sizeof(value)) < 0)
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &pvalue);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable pbap_properties[] = {
 	{ "Folder", "s", get_folder, NULL, folder_exists },
+	{ "DatabaseIdentifier", "s", get_databaseid, NULL, databaseid_exists },
 	{ }
 };
 
-- 
1.9.3

