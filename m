Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH 1/2] GATT: Rename service and char structs
Date: Thu, 22 Mar 2012 15:24:39 +0200
Message-Id: <1332422680-20162-2-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1332422680-20162-1-git-send-email-chen.ganir@ti.com>
References: <1332422680-20162-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Rename the att_primary to gatt_primary and att_char to gatt_char.
Characteristic and Service do not exist in the ATT spec, only in
GATT.
---
 attrib/att.h         |   13 -------------
 attrib/client.c      |   12 ++++++------
 attrib/gatt.c        |    8 ++++----
 attrib/gatt.h        |   13 +++++++++++++
 attrib/gatttool.c    |    4 ++--
 attrib/interactive.c |    4 ++--
 src/adapter.c        |    7 ++++---
 src/device.c         |    8 ++++----
 8 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index dc266f1..09511d2 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -148,19 +148,6 @@ struct att_range {
 	uint16_t end;
 };
 
-struct att_primary {
-	char uuid[MAX_LEN_UUID_STR + 1];
-	uint16_t start;
-	uint16_t end;
-};
-
-struct att_char {
-	char uuid[MAX_LEN_UUID_STR + 1];
-	uint16_t handle;
-	uint8_t properties;
-	uint16_t value_handle;
-};
-
 /* These functions do byte conversion */
 static inline uint8_t att_get_u8(const void *ptr)
 {
diff --git a/attrib/client.c b/attrib/client.c
index 60cff01..7c01514 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -68,7 +68,7 @@ struct query {
 
 struct gatt_service {
 	struct btd_device *dev;
-	struct att_primary *prim;
+	struct gatt_primary *prim;
 	DBusConnection *conn;
 	GAttrib *attrib;
 	guint attioid;
@@ -821,7 +821,7 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 	DBusMessageIter iter, array_iter;
 	struct query_data *current = user_data;
 	struct gatt_service *gatt = current->gatt;
-	struct att_primary *prim = gatt->prim;
+	struct gatt_primary *prim = gatt->prim;
 	uint16_t *previous_end = NULL;
 	GSList *l;
 	bdaddr_t sba, dba;
@@ -835,7 +835,7 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 	}
 
 	for (l = characteristics; l; l = l->next) {
-		struct att_char *current_chr = l->data;
+		struct gatt_char *current_chr = l->data;
 		struct characteristic *chr;
 		guint handle = current_chr->value_handle;
 		GSList *lchr;
@@ -895,7 +895,7 @@ static void send_discover(GAttrib *attrib, gpointer user_data)
 {
 	struct query_data *qchr = user_data;
 	struct gatt_service *gatt = qchr->gatt;
-	struct att_primary *prim = gatt->prim;
+	struct gatt_primary *prim = gatt->prim;
 
 	gatt->attrib = g_attrib_ref(attrib);
 
@@ -995,7 +995,7 @@ static GDBusMethodTable prim_methods[] = {
 
 static struct gatt_service *primary_register(DBusConnection *conn,
 						struct btd_device *device,
-						struct att_primary *prim,
+						struct gatt_primary *prim,
 						int psm)
 {
 	struct gatt_service *gatt;
@@ -1027,7 +1027,7 @@ GSList *attrib_client_register(DBusConnection *connection,
 	GSList *l, *services;
 
 	for (l = primaries, services = NULL; l; l = l->next) {
-		struct att_primary *prim = l->data;
+		struct gatt_primary *prim = l->data;
 		struct gatt_service *gatt;
 
 		gatt = primary_register(connection, device, prim, psm);
diff --git a/attrib/gatt.c b/attrib/gatt.c
index 452a4cf..7cf718d 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -172,7 +172,7 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 
 	for (i = 0, end = 0; i < list->num; i++) {
 		const uint8_t *data = list->data[i];
-		struct att_primary *primary;
+		struct gatt_primary *primary;
 		bt_uuid_t uuid;
 
 		start = att_get_u16(&data[0]);
@@ -188,7 +188,7 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 			continue;
 		}
 
-		primary = g_try_new0(struct att_primary, 1);
+		primary = g_try_new0(struct gatt_primary, 1);
 		if (!primary) {
 			err = ATT_ECODE_INSUFF_RESOURCES;
 			goto done;
@@ -274,7 +274,7 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 
 	for (i = 0; i < list->num; i++) {
 		uint8_t *value = list->data[i];
-		struct att_char *chars;
+		struct gatt_char *chars;
 		bt_uuid_t uuid;
 
 		last = att_get_u16(value);
@@ -285,7 +285,7 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 		} else
 			uuid = att_get_uuid128(&value[5]);
 
-		chars = g_try_new0(struct att_char, 1);
+		chars = g_try_new0(struct gatt_char, 1);
 		if (!chars) {
 			err = ATT_ECODE_INSUFF_RESOURCES;
 			goto done;
diff --git a/attrib/gatt.h b/attrib/gatt.h
index c5f95ac..cf37914 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -25,6 +25,19 @@
 
 typedef void (*gatt_cb_t) (GSList *l, guint8 status, gpointer user_data);
 
+struct gatt_primary {
+	char uuid[MAX_LEN_UUID_STR + 1];
+	uint16_t start;
+	uint16_t end;
+};
+
+struct gatt_char {
+	char uuid[MAX_LEN_UUID_STR + 1];
+	uint16_t handle;
+	uint8_t properties;
+	uint16_t value_handle;
+};
+
 guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
 							gpointer user_data);
 
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 17ee913..24a85a4 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -146,7 +146,7 @@ static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
 	}
 
 	for (l = services; l; l = l->next) {
-		struct att_primary *prim = l->data;
+		struct gatt_primary *prim = l->data;
 		g_print("attr handle = 0x%04x, end grp handle = 0x%04x "
 			"uuid: %s\n", prim->start, prim->end, prim->uuid);
 	}
@@ -201,7 +201,7 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 	}
 
 	for (l = characteristics; l; l = l->next) {
-		struct att_char *chars = l->data;
+		struct gatt_char *chars = l->data;
 
 		g_print("handle = 0x%04x, char properties = 0x%02x, char value "
 			"handle = 0x%04x, uuid = %s\n", chars->handle,
diff --git a/attrib/interactive.c b/attrib/interactive.c
index be81424..2d650d6 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -161,7 +161,7 @@ static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
 
 	printf("\n");
 	for (l = services; l; l = l->next) {
-		struct att_primary *prim = l->data;
+		struct gatt_primary *prim = l->data;
 		printf("attr handle: 0x%04x, end grp handle: 0x%04x "
 			"uuid: %s\n", prim->start, prim->end, prim->uuid);
 	}
@@ -202,7 +202,7 @@ static void char_cb(GSList *characteristics, guint8 status, gpointer user_data)
 
 	printf("\n");
 	for (l = characteristics; l; l = l->next) {
-		struct att_char *chars = l->data;
+		struct gatt_char *chars = l->data;
 
 		printf("handle: 0x%04x, char properties: 0x%02x, char value "
 				"handle: 0x%04x, uuid: %s\n", chars->handle,
diff --git a/src/adapter.c b/src/adapter.c
index acb845e..c66968d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -58,6 +58,7 @@
 #include "storage.h"
 #include "gattrib.h"
 #include "att.h"
+#include "gatt.h"
 #include "attrib-server.h"
 #include "eir.h"
 
@@ -1893,10 +1894,10 @@ static GSList *string_to_primary_list(char *str)
 		return NULL;
 
 	for (i = 0; services[i]; i++) {
-		struct att_primary *prim;
+		struct gatt_primary *prim;
 		int ret;
 
-		prim = g_new0(struct att_primary, 1);
+		prim = g_new0(struct gatt_primary, 1);
 
 		ret = sscanf(services[i], "%04hX#%04hX#%s", &prim->start,
 							&prim->end, prim->uuid);
@@ -1938,7 +1939,7 @@ static void create_stored_device_from_primary(char *key, char *value,
 		return;
 
 	for (l = services, uuids = NULL; l; l = l->next) {
-		struct att_primary *prim = l->data;
+		struct gatt_primary *prim = l->data;
 		uuids = g_slist_append(uuids, prim->uuid);
 	}
 
diff --git a/src/device.c b/src/device.c
index dfc8e59..a11322a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1539,7 +1539,7 @@ GSList *device_services_from_record(struct btd_device *device, GSList *profiles)
 	for (l = profiles; l; l = l->next) {
 		const char *profile_uuid = l->data;
 		const sdp_record_t *rec;
-		struct att_primary *prim;
+		struct gatt_primary *prim;
 		uint16_t start = 0, end = 0, psm = 0;
 		uuid_t prim_uuid;
 
@@ -1553,7 +1553,7 @@ GSList *device_services_from_record(struct btd_device *device, GSList *profiles)
 		if (!gatt_parse_record(rec, &prim_uuid, &psm, &start, &end))
 			continue;
 
-		prim = g_new0(struct att_primary, 1);
+		prim = g_new0(struct gatt_primary, 1);
 		prim->start = start;
 		prim->end = end;
 		sdp_uuid2strn(&prim_uuid, prim->uuid, sizeof(prim->uuid));
@@ -1708,7 +1708,7 @@ static char *primary_list_to_string(GSList *primary_list)
 	services = g_string_new(NULL);
 
 	for (l = primary_list; l; l = l->next) {
-		struct att_primary *primary = l->data;
+		struct gatt_primary *primary = l->data;
 		char service[64];
 
 		memset(service, 0, sizeof(service));
@@ -1811,7 +1811,7 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 	device_set_temporary(device, FALSE);
 
 	for (l = services; l; l = l->next) {
-		struct att_primary *prim = l->data;
+		struct gatt_primary *prim = l->data;
 		uuids = g_slist_append(uuids, prim->uuid);
 	}
 
-- 
1.7.4.1

