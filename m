Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH v2 3/18] Move primary service storage to device.c
Date: Wed, 22 Dec 2010 17:01:13 -0500
Message-Id: <1293055273-21076-1-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <20101222115722.GC27483@jh-x301>
References: <20101222115722.GC27483@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Discover All Primary Services has beed moved to device.c in order
to follow a similar approach of BR/EDR service records.
---
 attrib/att.h      |    6 ++++++
 attrib/client.c   |   41 -----------------------------------------
 attrib/gattrib.c  |    1 +
 src/device.c      |   44 +++++++++++++++++++++++++++++++++++++++++++-
 src/glib-helper.c |   24 ++++++++++++++++--------
 5 files changed, 66 insertions(+), 50 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 0b8612e..08feeec 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -137,6 +137,12 @@ struct att_range {
 	uint16_t end;
 };
 
+struct att_primary {
+	char uuid[MAX_LEN_UUID_STR + 1];
+	uint16_t start;
+	uint16_t end;
+};
+
 /* These functions do byte conversion */
 static inline uint8_t att_get_u8(const void *ptr)
 {
diff --git a/attrib/client.c b/attrib/client.c
index 69e4fb8..00d0bbc 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -1086,35 +1086,6 @@ static void load_attribute_data(char *key, char *value, void *data)
 		chr->format = attr_data_from_string(value + MAX_LEN_UUID_STR);
 }
 
-static char *primary_list_to_string(GSList *primary_list)
-{
-	GString *services;
-	GSList *l;
-
-	services = g_string_new(NULL);
-
-	for (l = primary_list; l; l = l->next) {
-		struct primary *primary = l->data;
-		uuid_t *uuid128;
-		char service[64];
-		char uuidstr[MAX_LEN_UUID_STR];
-
-		memset(service, 0, sizeof(service));
-
-		uuid128 = sdp_uuid_to_uuid128(&primary->uuid);
-		sdp_uuid2strn(uuid128, uuidstr, MAX_LEN_UUID_STR);
-
-		bt_free(uuid128);
-
-		snprintf(service, sizeof(service), "%04X#%04X#%s ",
-				primary->start, primary->end, uuidstr);
-
-		services = g_string_append(services, service);
-	}
-
-	return g_string_free(services, FALSE);
-}
-
 static GSList *string_to_primary_list(struct gatt_service *gatt,
 							const char *str)
 {
@@ -1158,17 +1129,6 @@ static GSList *string_to_primary_list(struct gatt_service *gatt,
 	return l;
 }
 
-static void store_primary_services(struct gatt_service *gatt)
-{
-       char *services;
-
-       services = primary_list_to_string(gatt->primary);
-
-       write_device_services(&gatt->sba, &gatt->dba, services);
-
-       g_free(services);
-}
-
 static gboolean load_primary_services(struct gatt_service *gatt)
 {
 	GSList *primary_list;
@@ -1225,7 +1185,6 @@ static void primary_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		if (gatt->primary == NULL)
 			goto done;
 
-		store_primary_services(gatt);
 		register_primary(gatt);
 
 		g_slist_foreach(gatt->primary, discover_all_char, gatt);
diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index eace01b..9268001 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -30,6 +30,7 @@
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
 
 #include "att.h"
 #include "btio.h"
diff --git a/src/device.c b/src/device.c
index c306e43..4bf9b52 100644
--- a/src/device.c
+++ b/src/device.c
@@ -45,6 +45,7 @@
 #include "log.h"
 #include "textfile.h"
 
+#include "att.h"
 #include "hcid.h"
 #include "adapter.h"
 #include "device.h"
@@ -1518,10 +1519,36 @@ static void init_browse(struct browse_req *req, gboolean reverse)
 						l->data);
 }
 
+static char *primary_list_to_string(GSList *primary_list)
+{
+	GString *services;
+	GSList *l;
+
+	services = g_string_new(NULL);
+
+	for (l = primary_list; l; l = l->next) {
+		struct att_primary *primary = l->data;
+		char service[64];
+
+		memset(service, 0, sizeof(service));
+
+		snprintf(service, sizeof(service), "%04X#%04X#%s ",
+				primary->start, primary->end, primary->uuid);
+
+		services = g_string_append(services, service);
+	}
+
+	return g_string_free(services, FALSE);
+}
+
 static void primary_cb(GSList *services, int err, gpointer user_data)
 {
 	struct browse_req *req = user_data;
 	struct btd_device *device = req->device;
+	struct btd_adapter *adapter = device->adapter;
+	GSList *l, *uuids = NULL;
+	bdaddr_t dba, sba;
+	char *str;
 
 	if (err) {
 		DBusMessage *reply;
@@ -1532,10 +1559,25 @@ static void primary_cb(GSList *services, int err, gpointer user_data)
 
 	services_changed(device);
 	device_set_temporary(device, FALSE);
-	device_probe_drivers(device, services);
+
+	for (l = services; l; l = l->next) {
+		struct att_primary *prim = l->data;
+		uuids = g_slist_append(uuids, prim->uuid);
+	}
+
+	device_probe_drivers(device, uuids);
+	g_slist_free(uuids);
 
 	create_device_reply(device, req);
 
+	str = primary_list_to_string(services);
+
+	adapter_get_address(adapter, &sba);
+	device_get_address(device, &dba);
+
+	write_device_services(&sba, &dba, str);
+	g_free(str);
+
 done:
 	device->browse = NULL;
 	browse_request_free(req);
diff --git a/src/glib-helper.c b/src/glib-helper.c
index bf39a83..60248cf 100644
--- a/src/glib-helper.c
+++ b/src/glib-helper.c
@@ -55,7 +55,7 @@ struct gattrib_context {
 	bt_primary_t cb;
 	bt_destroy_t destroy;
 	gpointer user_data;
-	GSList *uuids;
+	GSList *primaries;
 };
 
 static GSList *gattrib_list = NULL;
@@ -75,8 +75,8 @@ static void gattrib_context_free(struct gattrib_context *ctxt)
 	if (ctxt->destroy)
 		ctxt->destroy(ctxt->user_data);
 
-	g_slist_foreach(ctxt->uuids, (GFunc) g_free, NULL);
-	g_slist_free(ctxt->uuids);
+	g_slist_foreach(ctxt->primaries, (GFunc) g_free, NULL);
+	g_slist_free(ctxt->primaries);
 	g_attrib_unref(ctxt->attrib);
 	if (ctxt->io) {
 		g_io_channel_unref(ctxt->io);
@@ -439,7 +439,7 @@ static void primary_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	struct gattrib_context *ctxt = user_data;
 	struct att_data_list *list;
 	unsigned int i, err;
-	uint16_t end;
+	uint16_t start, end;
 
 	if (status == ATT_ECODE_ATTR_NOT_FOUND) {
 		err = 0;
@@ -459,9 +459,10 @@ static void primary_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 	for (i = 0, end = 0; i < list->num; i++) {
 		const uint8_t *data = list->data[i];
-		char *prim;
+		struct att_primary *primary;
 		uuid_t u128, u16;
 
+		start = att_get_u16(&data[0]);
 		end = att_get_u16(&data[2]);
 
 		if (list->len == 6) {
@@ -475,8 +476,15 @@ static void primary_cb(guint8 status, const guint8 *pdu, guint16 plen,
 			/* Skipping invalid data */
 			continue;
 
-		prim = bt_uuid2string(&u128);
-		ctxt->uuids = g_slist_append(ctxt->uuids, prim);
+		primary = g_try_new0(struct att_primary, 1);
+		if (!primary) {
+			err = -ENOMEM;
+			goto done;
+		}
+		primary->start = start;
+		primary->end = end;
+		sdp_uuid2strn(&u128, primary->uuid, sizeof(primary->uuid));
+		ctxt->primaries = g_slist_append(ctxt->primaries, primary);
 	}
 
 	att_data_list_free(list);
@@ -489,7 +497,7 @@ static void primary_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	}
 
 done:
-	ctxt->cb(ctxt->uuids, err, ctxt->user_data);
+	ctxt->cb(ctxt->primaries, err, ctxt->user_data);
 	gattrib_context_free(ctxt);
 }
 
-- 
1.7.3.2

