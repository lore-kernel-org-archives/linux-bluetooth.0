Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 11/15] GATT server: add service registration
Date: Wed, 16 Mar 2011 21:00:35 -0400
Message-Id: <1300323639-13296-12-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/gatt-profile.c |   63 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/plugins/gatt-profile.c b/plugins/gatt-profile.c
index b0256ba..f61bdb4 100644
--- a/plugins/gatt-profile.c
+++ b/plugins/gatt-profile.c
@@ -37,6 +37,7 @@
 #include "error.h"
 #include "log.h"
 #include "att.h"
+#include "attrib-server.h"
 
 #define GATT_PROFILE_INTERFACE "org.bluez.GattProfile"
 
@@ -74,6 +75,7 @@ struct gatt_service {
 	gchar *id;
 	GSList *chars;
 	GSList *includes;
+	GSList *attrs;
 };
 
 static void parse_service(const gchar **attribute_names,
@@ -404,6 +406,66 @@ static void resolve_includes(gpointer data, gpointer user_data)
 	svc->includes = includes;
 }
 
+static uint16_t service_size(struct gatt_service *svc)
+{
+	GSList *cl;
+	uint16_t size;
+
+	/* A service contains at minimum one declaration attribute, plus one
+	 * attribute for each service include. */
+	size = 1 + g_slist_length(svc->includes);
+
+	for (cl = svc->chars; cl; cl = cl->next) {
+		struct gatt_characteristic *c = cl->data;
+
+		/* A characteristic contains at least two attributes (for
+		 * declaration and value), plus one attribute for each
+		 * descriptor. */
+		size += 2 + g_slist_length(c->descriptors);
+	}
+
+	return size;
+}
+
+static void register_services(gpointer data, gpointer user_data)
+{
+	struct gatt_service *svc = data;
+	struct attribute *a;
+	uint16_t handle, size;
+	bt_uuid_t uuid;
+	char uuidstr[MAX_LEN_UUID_STR];
+	uint8_t atval[ATT_MAX_VALUE_LEN];
+	int atlen;
+
+	size = service_size(svc);
+	handle = attrib_db_find_avail(size);
+	if (handle == 0) {
+		error("Not enough space on attribute database");
+		return;
+	}
+
+	bt_uuid_to_string(&svc->uuid, uuidstr, MAX_LEN_UUID_STR);
+	DBG("service: primary=%s, uuid=%s, id=%s, handle=0x%04x, size=%u",
+				svc->primary ? "TRUE" : "FALSE", uuidstr,
+				svc->id ? svc->id : "", handle, size);
+
+	if (svc->primary)
+		bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
+	else
+		bt_uuid16_create(&uuid, GATT_SND_SVC_UUID);
+
+	att_put_uuid(svc->uuid, atval);
+	if (svc->uuid.type == BT_UUID16)
+		atlen = 2;
+	else
+		atlen = 16;
+
+	a = attrib_db_add(handle++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval,
+									atlen);
+	g_assert(a != NULL);
+	svc->attrs = g_slist_append(svc->attrs, a);
+}
+
 static void free_services(gpointer data, gpointer user_data)
 {
 	struct gatt_service *svc = data;
@@ -450,6 +512,7 @@ static int add_xml_profile(DBusConnection *conn, const char *profile)
 	}
 
 	g_slist_foreach(services, resolve_includes, services);
+	g_slist_foreach(services, register_services, NULL);
 	g_slist_foreach(services, free_services, NULL);
 	g_slist_free(services);
 
-- 
1.7.0.4

