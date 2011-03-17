Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 05/15] GATT server: parse primary/secondary services
Date: Wed, 16 Mar 2011 21:00:29 -0400
Message-Id: <1300323639-13296-6-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/gatt-profile.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 75 insertions(+), 1 deletions(-)

diff --git a/plugins/gatt-profile.c b/plugins/gatt-profile.c
index 694769c..c0b2a50 100644
--- a/plugins/gatt-profile.c
+++ b/plugins/gatt-profile.c
@@ -29,6 +29,7 @@
 #include <errno.h>
 
 #include <gdbus.h>
+#include <bluetooth/uuid.h>
 
 #include "plugin.h"
 #include "adapter.h"
@@ -40,12 +41,72 @@
 static DBusConnection *connection = NULL;
 static const char *any_path = NULL;
 
+struct gatt_service {
+	gboolean primary;
+	bt_uuid_t uuid;
+	gchar *id;
+	GSList *chars;
+	GSList *includes;
+};
+
+static void parse_service(const gchar **attribute_names,
+					const gchar **attribute_values,
+					gboolean primary, GSList **services)
+{
+	struct gatt_service *svc;
+	const gchar *uuid, *id;
+	int i;
+
+	for (i = 0, uuid = NULL, id = NULL; attribute_names[i]; i++) {
+		if (g_strcmp0(attribute_names[i], "uuid") == 0)
+			uuid = attribute_values[i];
+		else if (g_strcmp0(attribute_names[i], "id") == 0)
+			id = attribute_values[i];
+		else
+			error("Invalid XML attribute: %s", attribute_names[i]);
+	}
+
+	if (uuid == NULL) {
+		error("Missing UUID for service");
+		return;
+	}
+
+	if (!primary && (id == NULL || id[0] == '\0')) {
+		error("Missing ID for secondary service");
+		return;
+	}
+
+	svc = g_new0(struct gatt_service, 1);
+	svc->primary = primary;
+
+	if (bt_string_to_uuid(&svc->uuid, uuid) < 0) {
+		error("Invalid UUID: %s", uuid);
+		g_free(svc);
+		return;
+	}
+
+	svc->id = g_strdup(id);
+
+	DBG("New %s service with UUID %s", primary ? "primary" : "secondary",
+									uuid);
+
+	*services = g_slist_prepend(*services, svc);
+}
+
 static void element_start(GMarkupParseContext *ctx, const gchar *element_name,
 		const gchar **attribute_names, const gchar **attribute_values,
 		gpointer user_data, GError **err)
 {
+	GSList **services = user_data;
+
 	if (g_strcmp0(element_name, "gatt-profile") == 0)
 		return;
+	else if (g_strcmp0(element_name, "primary-service") == 0)
+		parse_service(attribute_names, attribute_values, TRUE,
+								services);
+	else if (g_strcmp0(element_name, "secondary-service") == 0)
+		parse_service(attribute_names, attribute_values, FALSE,
+								services);
 	else
 		error("Invalid XML tag: %s", element_name);
 }
@@ -56,19 +117,32 @@ static void element_end(GMarkupParseContext *ctx, const gchar *element_name,
 	/* TODO: verify tag balance */
 }
 
+static void free_services(gpointer data, gpointer user_data)
+{
+	struct gatt_service *svc = data;
+
+	/* TODO: free characteristics, includes and descriptors */
+
+	g_free(svc);
+}
+
 static int add_xml_profile(DBusConnection *conn, const char *profile)
 {
 	GMarkupParser parser = { element_start, element_end, NULL, NULL, NULL };
 	GMarkupParseContext *ctx;
+	GSList *services = NULL;
 	int ret = 0;
 
-	ctx = g_markup_parse_context_new(&parser, 0, NULL, NULL);
+	ctx = g_markup_parse_context_new(&parser, 0, &services, NULL);
 	if (!g_markup_parse_context_parse(ctx, profile, strlen(profile),
 									NULL)) {
 		error("Parsing of GATT profile XML failed");
 		ret = -EINVAL;
 	}
 
+	g_slist_foreach(services, free_services, NULL);
+	g_slist_free(services);
+
 	g_markup_parse_context_free(ctx);
 
 	return ret;
-- 
1.7.0.4

