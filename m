Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 04/15] GATT server: add initial XML parsing
Date: Wed, 16 Mar 2011 21:00:28 -0400
Message-Id: <1300323639-13296-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/gatt-profile.c |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/plugins/gatt-profile.c b/plugins/gatt-profile.c
index fc6b08e..694769c 100644
--- a/plugins/gatt-profile.c
+++ b/plugins/gatt-profile.c
@@ -32,6 +32,7 @@
 
 #include "plugin.h"
 #include "adapter.h"
+#include "error.h"
 #include "log.h"
 
 #define GATT_PROFILE_INTERFACE "org.bluez.GattProfile"
@@ -39,10 +40,53 @@
 static DBusConnection *connection = NULL;
 static const char *any_path = NULL;
 
+static void element_start(GMarkupParseContext *ctx, const gchar *element_name,
+		const gchar **attribute_names, const gchar **attribute_values,
+		gpointer user_data, GError **err)
+{
+	if (g_strcmp0(element_name, "gatt-profile") == 0)
+		return;
+	else
+		error("Invalid XML tag: %s", element_name);
+}
+
+static void element_end(GMarkupParseContext *ctx, const gchar *element_name,
+					gpointer user_data, GError **err)
+{
+	/* TODO: verify tag balance */
+}
+
+static int add_xml_profile(DBusConnection *conn, const char *profile)
+{
+	GMarkupParser parser = { element_start, element_end, NULL, NULL, NULL };
+	GMarkupParseContext *ctx;
+	int ret = 0;
+
+	ctx = g_markup_parse_context_new(&parser, 0, NULL, NULL);
+	if (!g_markup_parse_context_parse(ctx, profile, strlen(profile),
+									NULL)) {
+		error("Parsing of GATT profile XML failed");
+		ret = -EINVAL;
+	}
+
+	g_markup_parse_context_free(ctx);
+
+	return ret;
+}
+
 static DBusMessage *add_profile(DBusConnection *conn, DBusMessage *msg,
 								void *user_data)
 {
-	/* TODO */
+	const char *profile;
+	int err;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &profile,
+							DBUS_TYPE_INVALID))
+		return NULL;
+
+	err = add_xml_profile(conn, profile);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
 
 	return dbus_message_new_method_return(msg);
 }
-- 
1.7.0.4

