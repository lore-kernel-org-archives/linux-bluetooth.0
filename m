Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 12/15] GATT server: add service includes registration
Date: Wed, 16 Mar 2011 21:00:36 -0400
Message-Id: <1300323639-13296-13-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Service includes may appear in any other services (before or after the
include declaration), therefore its attribute is initially added to the
database with empty data, which is filled after all services have been
registered (and thus have allocated handles).
---
 plugins/gatt-profile.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/plugins/gatt-profile.c b/plugins/gatt-profile.c
index f61bdb4..83006fb 100644
--- a/plugins/gatt-profile.c
+++ b/plugins/gatt-profile.c
@@ -434,6 +434,7 @@ static void register_services(gpointer data, gpointer user_data)
 	uint16_t handle, size;
 	bt_uuid_t uuid;
 	char uuidstr[MAX_LEN_UUID_STR];
+	GSList *l;
 	uint8_t atval[ATT_MAX_VALUE_LEN];
 	int atlen;
 
@@ -464,6 +465,18 @@ static void register_services(gpointer data, gpointer user_data)
 									atlen);
 	g_assert(a != NULL);
 	svc->attrs = g_slist_append(svc->attrs, a);
+
+	bt_uuid16_create(&uuid, GATT_INCLUDE_UUID);
+
+	for (l = svc->includes; l; l = l->next) {
+		memset(atval, 0, 6);
+		a = attrib_db_add(handle++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 6);
+		g_assert(a != NULL);
+		svc->attrs = g_slist_append(svc->attrs, a);
+
+		DBG("include: handle=0x%04x", a->handle);
+	}
 }
 
 static void free_services(gpointer data, gpointer user_data)
@@ -497,6 +510,49 @@ static void free_services(gpointer data, gpointer user_data)
 	g_free(svc);
 }
 
+static void update_includes(gpointer data, gpointer user_data)
+{
+	struct gatt_service *svc = data;
+	GSList *al, *il;
+	bt_uuid_t uuid;
+
+	bt_uuid16_create(&uuid, GATT_INCLUDE_UUID);
+
+	il = svc->includes;
+	if (il == NULL)
+		return;
+
+	for (al = svc->attrs; al; al = al->next) {
+		struct attribute *a = al->data;
+		struct attribute *start, *end;
+		struct gatt_service *inc_svc;
+		uint8_t atval[20];
+
+		if (bt_uuid_cmp(&a->uuid, &uuid) != 0)
+			continue;
+
+		inc_svc = il->data;
+		start = inc_svc->attrs->data;
+		end = g_slist_last(inc_svc->attrs)->data;
+
+		att_put_u16(start->handle, &atval[0]);
+		att_put_u16(end->handle, &atval[2]);
+
+		att_put_uuid(start->uuid, &atval[4]);
+		if (start->uuid.type == BT_UUID16)
+			attrib_db_update(a->handle, NULL, atval, 6, &a);
+		else
+			/* According to spec, the include declaration shall
+			 * only contain the service UUID if it is 16-bit.
+			 * Otherwise, omitting the UUID the length is
+			 * 4 bytes. */
+			attrib_db_update(a->handle, NULL, atval, 4, &a);
+		al->data = a;
+
+		il = il->next;
+	}
+}
+
 static int add_xml_profile(DBusConnection *conn, const char *profile)
 {
 	GMarkupParser parser = { element_start, element_end, NULL, NULL, NULL };
@@ -513,6 +569,7 @@ static int add_xml_profile(DBusConnection *conn, const char *profile)
 
 	g_slist_foreach(services, resolve_includes, services);
 	g_slist_foreach(services, register_services, NULL);
+	g_slist_foreach(services, update_includes, NULL);
 	g_slist_foreach(services, free_services, NULL);
 	g_slist_free(services);
 
-- 
1.7.0.4

