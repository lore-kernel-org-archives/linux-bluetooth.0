Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/8] obexd/client: Add folder counters properties
Date: Mon,  1 Dec 2014 10:47:15 +0200
Message-Id: <1417423638-29222-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1417423638-29222-1-git-send-email-luiz.dentz@gmail.com>
References: <1417423638-29222-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds PrimaryCounter and SecondaryCounter properties to
PhonebookAccess interface.
---
 doc/obex-api.txt    | 14 +++++++++
 obexd/client/pbap.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index ea82e39..44af2fa 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -505,6 +505,20 @@ Properties	string Folder [readonly]
 			Possible values: 32-character hexadecimal such
 			as A1A2A3A4B1B2C1C2D1D2E1E2E3E4E5E6
 
+		string PrimaryCounter [readonly, optional]
+
+			128 bits primary version counter.
+
+			Possible values: 32-character hexadecimal such
+			as A1A2A3A4B1B2C1C2D1D2E1E2E3E4E5E6
+
+		string SecondaryCounter [readonly, optional]
+
+			128 bits primary version counter.
+
+			Possible values: 32-character hexadecimal such
+			as A1A2A3A4B1B2C1C2D1D2E1E2E3E4E5E6
+
 Synchronization hierarchy
 =========================
 
diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 97c7cb9..f048aaf 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -73,6 +73,8 @@
 #define FORMAT_TAG		0X07
 #define PHONEBOOKSIZE_TAG	0X08
 #define NEWMISSEDCALLS_TAG	0X09
+#define PRIMARY_COUNTER_TAG	0X0A
+#define SECONDARY_COUNTER_TAG	0X0B
 #define DATABASEID_TAG		0X0D
 
 #define DOWNLOAD_FEATURE	0x00000001
@@ -135,6 +137,8 @@ struct pbap_data {
 	uint16_t version;
 	uint32_t supported_features;
 	uint8_t databaseid[16];
+	uint8_t primary[16];
+	uint8_t secondary[16];
 };
 
 struct pending_request {
@@ -274,6 +278,44 @@ static void pbap_setpath_cb(struct obc_session *session,
 	pending_request_free(request);
 }
 
+static void read_version(struct pbap_data *pbap, GObexApparam *apparam)
+{
+	const guint8 *data;
+	uint8_t value[16];
+	gsize len;
+
+	if (!(pbap->supported_features & FOLDER_VERSION_FEATURE))
+		return;
+
+	if (!g_obex_apparam_get_bytes(apparam, PRIMARY_COUNTER_TAG, &data,
+								&len)) {
+		len = sizeof(value);
+		memset(value, 0, len);
+		data = value;
+	}
+
+	if (memcmp(pbap->primary, data, len)) {
+		memcpy(pbap->primary, data, len);
+		g_dbus_emit_property_changed(conn,
+					obc_session_get_path(pbap->session),
+					PBAP_INTERFACE, "PrimaryCounter");
+	}
+
+	if (!g_obex_apparam_get_bytes(apparam, SECONDARY_COUNTER_TAG, &data,
+								&len)) {
+		len = sizeof(value);
+		memset(value, 0, len);
+		data = value;
+	}
+
+	if (memcmp(pbap->secondary, data, len)) {
+		memcpy(pbap->secondary, data, len);
+		g_dbus_emit_property_changed(conn,
+					obc_session_get_path(pbap->session),
+					PBAP_INTERFACE, "SecondaryCounter");
+	}
+}
+
 static void read_databaseid(struct pbap_data *pbap, GObexApparam *apparam)
 {
 	const guint8 *data;
@@ -316,6 +358,7 @@ static void read_return_apparam(struct obc_transfer *transfer,
 	g_obex_apparam_get_uint8(apparam, NEWMISSEDCALLS_TAG,
 							new_missed_calls);
 
+	read_version(pbap, apparam);
 	read_databaseid(pbap, apparam);
 }
 
@@ -1061,9 +1104,55 @@ static gboolean get_databaseid(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean version_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct pbap_data *pbap = data;
+
+	return pbap->supported_features & FOLDER_VERSION_FEATURE;
+}
+
+static gboolean get_primary(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct pbap_data *pbap = data;
+	char value[33];
+	const char *pvalue = value;
+
+	if (!pbap->primary)
+		return FALSE;
+
+	if (u128_to_string(pbap->primary, value, sizeof(value)) < 0)
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &pvalue);
+
+	return TRUE;
+}
+
+static gboolean get_secondary(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct pbap_data *pbap = data;
+	char value[33];
+	const char *pvalue = value;
+
+	if (!pbap->secondary)
+		return FALSE;
+
+	if (u128_to_string(pbap->secondary, value, sizeof(value)) < 0)
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &pvalue);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable pbap_properties[] = {
 	{ "Folder", "s", get_folder, NULL, folder_exists },
 	{ "DatabaseIdentifier", "s", get_databaseid, NULL, databaseid_exists },
+	{ "PrimaryCounter", "s", get_primary, NULL, version_exists },
+	{ "SecondaryCounter", "s", get_secondary, NULL, version_exists },
 	{ }
 };
 
-- 
1.9.3

