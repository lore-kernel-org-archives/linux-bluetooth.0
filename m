Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH] core: Fix allow registering same custom property
Date: Wed, 16 Jan 2013 17:59:19 +0100
Message-Id: <1358355559-26975-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With several adapters, MediaEndpoint custom property is only created for the
first adapter. When a new connection happens on another adapter
btd_profile_custom_property_exists fails because the custom property doesn't
exist for this last adapter. In case of HFP ofono fails with error: "Media
Endpoint missing error".

This patch allows the creation of several custom property with same name that
can be distinguished based on a 'key'. When querying the property, additional
checking must happen. For example endpoint_properties_exists, compares
btd_adapter.
'NULL' key maintains existing behavior.
---
 profiles/audio/media.c |    5 +++--
 src/profile.c          |   22 ++++++++++++++++------
 src/profile.h          |    6 ++++--
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 4b91656..60a5da5 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -195,7 +195,7 @@ static void media_endpoint_remove(struct media_endpoint *endpoint)
 
 	if (media_adapter_find_endpoint(adapter, NULL, NULL,
 						endpoint->uuid) == NULL)
-		btd_profile_remove_custom_prop(endpoint->uuid,
+		btd_profile_remove_custom_prop(adapter, endpoint->uuid,
 							"MediaEndpoints");
 
 	media_endpoint_destroy(endpoint);
@@ -740,7 +740,8 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 						endpoint, NULL);
 
 	if (media_adapter_find_endpoint(adapter, NULL, NULL, uuid) == NULL) {
-		btd_profile_add_custom_prop(uuid, "a{sv}", "MediaEndpoints",
+		btd_profile_add_custom_prop(adapter, uuid, "a{sv}",
+						"MediaEndpoints",
 						endpoint_properties_exists,
 						endpoint_properties_get,
 						adapter);
diff --git a/src/profile.c b/src/profile.c
index b0c8500..2d0d2ba 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -572,6 +572,7 @@ struct ext_record {
 };
 
 struct btd_profile_custom_property {
+	const void *key;
 	char *uuid;
 	char *type;
 	char *name;
@@ -2208,7 +2209,8 @@ static const GDBusMethodTable methods[] = {
 	{ }
 };
 
-static struct btd_profile_custom_property *find_custom_prop(const char *uuid,
+static struct btd_profile_custom_property *find_custom_prop(const char *key,
+				const char *uuid,
 							const char *name)
 {
 	GSList *l;
@@ -2216,6 +2218,9 @@ static struct btd_profile_custom_property *find_custom_prop(const char *uuid,
 	for (l = custom_props; l; l = l->next) {
 		struct btd_profile_custom_property *prop = l->data;
 
+		if (prop->key != key)
+			continue;
+
 		if (strcasecmp(prop->uuid, uuid) != 0)
 			continue;
 
@@ -2226,7 +2231,8 @@ static struct btd_profile_custom_property *find_custom_prop(const char *uuid,
 	return NULL;
 }
 
-bool btd_profile_add_custom_prop(const char *uuid, const char *type,
+bool btd_profile_add_custom_prop(const void *key, const char *uuid,
+					const char *type,
 					const char *name,
 					btd_profile_prop_exists exists,
 					btd_profile_prop_get get,
@@ -2234,12 +2240,15 @@ bool btd_profile_add_custom_prop(const char *uuid, const char *type,
 {
 	struct btd_profile_custom_property *prop;
 
-	prop = find_custom_prop(uuid, name);
-	if (prop != NULL)
+	prop = find_custom_prop(key, uuid, name);
+	if (prop != NULL) {
+		DBG("Custom property %s already exists", name);
 		return false;
+	}
 
 	prop = g_new0(struct btd_profile_custom_property, 1);
 
+	prop->key = key;
 	prop->uuid = g_strdup(uuid);
 	prop->type = g_strdup(type);
 	prop->name = g_strdup(name);
@@ -2263,11 +2272,12 @@ static void free_property(gpointer data)
 	g_free(p);
 }
 
-bool btd_profile_remove_custom_prop(const char *uuid, const char *name)
+bool btd_profile_remove_custom_prop(const void *key, const char *uuid,
+							const char *name)
 {
 	struct btd_profile_custom_property *prop;
 
-	prop = find_custom_prop(uuid, name);
+	prop = find_custom_prop(key, uuid, name);
 	if (prop == NULL)
 		return false;
 
diff --git a/src/profile.h b/src/profile.h
index d858925..0764f6f 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -67,12 +67,14 @@ typedef bool (*btd_profile_prop_get)(const char *uuid,
 						DBusMessageIter *iter,
 						void *user_data);
 
-bool btd_profile_add_custom_prop(const char *uuid, const char *type,
+bool btd_profile_add_custom_prop(const void *key, const char *uuid,
+					const char *type,
 					const char *name,
 					btd_profile_prop_exists exists,
 					btd_profile_prop_get get,
 					void *user_data);
-bool btd_profile_remove_custom_prop(const char *uuid, const char *name);
+bool btd_profile_remove_custom_prop(const void *key, const char *uuid,
+					const char *name);
 
 void btd_profile_init(void);
 void btd_profile_cleanup(void);
-- 
1.7.9.5

