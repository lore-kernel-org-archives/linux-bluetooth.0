Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 06/15] GATT server: parse and resolve service includes
Date: Wed, 16 Mar 2011 21:00:30 -0400
Message-Id: <1300323639-13296-7-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

"Resolving" service includes consists of replacing pointers to the ID
strings with actual struct gatt_service pointers, after all services
have been parsed.
---
 plugins/gatt-profile.c |   73 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/plugins/gatt-profile.c b/plugins/gatt-profile.c
index c0b2a50..b746449 100644
--- a/plugins/gatt-profile.c
+++ b/plugins/gatt-profile.c
@@ -93,6 +93,28 @@ static void parse_service(const gchar **attribute_names,
 	*services = g_slist_prepend(*services, svc);
 }
 
+static void parse_include(const gchar **attribute_names,
+						const gchar **attribute_values,
+						struct gatt_service *cur_svc)
+{
+	const gchar *id;
+	int i;
+
+	for (i = 0, id = NULL; attribute_names[i]; i++) {
+		if (g_strcmp0(attribute_names[i], "id") == 0)
+			id = attribute_values[i];
+		else
+			error("Invalid XML attribute: %s", attribute_names[i]);
+	}
+
+	if (id == NULL || id[0] == '\0') {
+		error("\"id\" attribute required");
+		return;
+	}
+
+	cur_svc->includes = g_slist_append(cur_svc->includes, g_strdup(id));
+}
+
 static void element_start(GMarkupParseContext *ctx, const gchar *element_name,
 		const gchar **attribute_names, const gchar **attribute_values,
 		gpointer user_data, GError **err)
@@ -107,8 +129,18 @@ static void element_start(GMarkupParseContext *ctx, const gchar *element_name,
 	else if (g_strcmp0(element_name, "secondary-service") == 0)
 		parse_service(attribute_names, attribute_values, FALSE,
 								services);
-	else
-		error("Invalid XML tag: %s", element_name);
+	else {
+		struct gatt_service *cur_svc = g_slist_nth_data(*services, 0);
+
+		if (cur_svc == NULL)
+			error("XML tag \"%s\" must be inside a service",
+								element_name);
+		else if (g_strcmp0(element_name, "include") == 0)
+			parse_include(attribute_names, attribute_values,
+								cur_svc);
+		else
+			error("Invalid XML tag: %s", element_name);
+	}
 }
 
 static void element_end(GMarkupParseContext *ctx, const gchar *element_name,
@@ -117,11 +149,45 @@ static void element_end(GMarkupParseContext *ctx, const gchar *element_name,
 	/* TODO: verify tag balance */
 }
 
+static gint find_id(gconstpointer a, gconstpointer b)
+{
+	const struct gatt_service *svc = a;
+	const gchar *id = b;
+
+	return g_strcmp0(svc->id, id);
+}
+
+static void resolve_includes(gpointer data, gpointer user_data)
+{
+	struct gatt_service *svc = data;
+	GSList *services = user_data;
+	GSList *l, *includes = NULL;
+
+	/* TODO: check for circular references */
+
+	for (l = svc->includes; l; l = l->next) {
+		gchar *id = l->data;
+		GSList *l2;
+
+		l2 = g_slist_find_custom(services, id, find_id);
+		if (l2)
+			includes = g_slist_append(includes, l2->data);
+		else
+			error("Could not find service with ID %s", id);
+
+		g_free(id);
+	}
+
+	g_slist_free(svc->includes);
+	svc->includes = includes;
+}
+
 static void free_services(gpointer data, gpointer user_data)
 {
 	struct gatt_service *svc = data;
 
-	/* TODO: free characteristics, includes and descriptors */
+	g_free(svc->id);
+	g_slist_free(svc->includes);
 
 	g_free(svc);
 }
@@ -140,6 +206,7 @@ static int add_xml_profile(DBusConnection *conn, const char *profile)
 		ret = -EINVAL;
 	}
 
+	g_slist_foreach(services, resolve_includes, services);
 	g_slist_foreach(services, free_services, NULL);
 	g_slist_free(services);
 
-- 
1.7.0.4

