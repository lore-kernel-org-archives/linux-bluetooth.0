Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/8] obexd/client: Add FixedImageSize property
Date: Mon,  1 Dec 2014 10:47:16 +0200
Message-Id: <1417423638-29222-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1417423638-29222-1-git-send-email-luiz.dentz@gmail.com>
References: <1417423638-29222-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds FixedImageSize property to PhonebookAccess interface.
---
 doc/obex-api.txt    |  7 +++++++
 obexd/client/pbap.c | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index 44af2fa..32f9a79 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -519,6 +519,13 @@ Properties	string Folder [readonly]
 			Possible values: 32-character hexadecimal such
 			as A1A2A3A4B1B2C1C2D1D2E1E2E3E4E5E6
 
+		bool FixedImageSize [readonly, optional]
+
+			Indicate support for fixed image size.
+
+			Possible values: True if image is JPEG 300x300 pixels
+			otherwise False.
+
 Synchronization hierarchy
 =========================
 
diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index f048aaf..2398071 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -1148,11 +1148,30 @@ static gboolean get_secondary(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean image_size_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct pbap_data *pbap = data;
+
+	return pbap->supported_features & DEFAULT_IMAGE_FEATURE;
+}
+
+static gboolean get_image_size(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	dbus_bool_t value = TRUE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable pbap_properties[] = {
 	{ "Folder", "s", get_folder, NULL, folder_exists },
 	{ "DatabaseIdentifier", "s", get_databaseid, NULL, databaseid_exists },
 	{ "PrimaryCounter", "s", get_primary, NULL, version_exists },
 	{ "SecondaryCounter", "s", get_secondary, NULL, version_exists },
+	{ "FixedImageSize", "b", get_image_size, NULL, image_size_exists },
 	{ }
 };
 
-- 
1.9.3

