Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv2 15/27] android/dis: Introduce bt_gatt_client
Date: Fri,  3 Apr 2015 15:43:44 +0200
Message-Id: <1428068636-13073-16-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
References: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces gattrib with bt_gatt_client and strips glib dependencies.
---
 android/dis.c | 104 ++++++++++++++++++++++------------------------------------
 android/dis.h |   4 +--
 android/hog.c |  18 ++++------
 3 files changed, 48 insertions(+), 78 deletions(-)

diff --git a/android/dis.c b/android/dis.c
index f699046..0d9d7d3 100644
--- a/android/dis.c
+++ b/android/dis.c
@@ -27,61 +27,52 @@
 #include <stdbool.h>
 #include <errno.h>
 
-#include <glib.h>
-
 #include "src/log.h"
 
 #include "lib/bluetooth.h"
-#include "lib/sdp.h"
 #include "lib/uuid.h"
 
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
-
-#include "attrib/gattrib.h"
-#include "attrib/att.h"
-#include "attrib/gatt.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-client.h"
 
 #include "android/dis.h"
 
-#define PNP_ID_SIZE	7
-
 struct bt_dis {
 	int			ref_count;
+	uint16_t		service_handle;
 	uint16_t		handle;
 	uint8_t			source;
 	uint16_t		vendor;
 	uint16_t		product;
 	uint16_t		version;
-	GAttrib			*attrib;	/* GATT connection */
-	struct gatt_primary	*primary;	/* Primary details */
 	bt_dis_notify		notify;
 	void			*notify_data;
-};
-
-struct characteristic {
-	struct gatt_char	attr;	/* Characteristic */
-	struct bt_dis		*d;	/* deviceinfo where the char belongs */
+	struct bt_gatt_client	*client;
+	struct gatt_db		*db;
 };
 
 static void dis_free(struct bt_dis *dis)
 {
 	bt_dis_detach(dis);
 
-	g_free(dis->primary);
-	g_free(dis);
+	free(dis);
 }
 
-struct bt_dis *bt_dis_new(void *primary)
+struct bt_dis *bt_dis_new(uint16_t service_handle)
 {
 	struct bt_dis *dis;
 
-	dis = g_try_new0(struct bt_dis, 1);
+	if (!service_handle)
+		return NULL;
+
+	dis = new0(struct bt_dis, 1);
 	if (!dis)
 		return NULL;
 
-	if (primary)
-		dis->primary = g_memdup(primary, sizeof(*dis->primary));
+	dis->service_handle = service_handle;
 
 	return bt_dis_ref(dis);
 }
@@ -107,26 +98,13 @@ void bt_dis_unref(struct bt_dis *dis)
 	dis_free(dis);
 }
 
-static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
+static void read_pnpid_cb(bool success, uint8_t att_ecode, const uint8_t *value,
+					uint16_t length, void *user_data)
 {
 	struct bt_dis *dis = user_data;
-	uint8_t value[PNP_ID_SIZE];
-	ssize_t vlen;
-
-	if (status != 0) {
-		error("Error reading PNP_ID value: %s", att_ecode2str(status));
-		return;
-	}
-
-	vlen = dec_read_resp(pdu, len, value, sizeof(value));
-	if (vlen < 0) {
-		error("Error reading PNP_ID: Protocol error");
-		return;
-	}
 
-	if (vlen < 7) {
-		error("Error reading PNP_ID: Invalid pdu length received");
+	if (length < 7) {
+		error("Error reading PNP_ID: Invalid length received");
 		return;
 	}
 
@@ -143,53 +121,51 @@ static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
 						dis->version, dis->notify_data);
 }
 
-static void configure_deviceinfo_cb(uint8_t status, GSList *characteristics,
+static void configure_deviceinfo_cb(struct gatt_db_attribute *attrib,
 								void *user_data)
 {
-	struct bt_dis *d = user_data;
-	GSList *l;
+	struct bt_dis *dis = user_data;
+	bt_uuid_t uuid, pnpid_uuid;
+	uint16_t value_handle;
 
-	if (status != 0) {
-		error("Discover deviceinfo characteristics: %s",
-							att_ecode2str(status));
-		return;
-	}
+	gatt_db_attribute_get_char_data(attrib, NULL, &value_handle,
+							NULL, &uuid);
 
-	for (l = characteristics; l; l = l->next) {
-		struct gatt_char *c = l->data;
+	bt_string_to_uuid(&pnpid_uuid, PNPID_UUID);
 
-		if (strcmp(c->uuid, PNPID_UUID) == 0) {
-			d->handle = c->value_handle;
-			gatt_read_char(d->attrib, d->handle, read_pnpid_cb, d);
-			break;
-		}
+	if (!bt_uuid_cmp(&uuid, &pnpid_uuid)) {
+		dis->handle = value_handle;
+		bt_gatt_client_read_value(dis->client, value_handle,
+						read_pnpid_cb, dis, NULL);
 	}
 }
 
-bool bt_dis_attach(struct bt_dis *dis, void *attrib)
+bool bt_dis_attach(struct bt_dis *dis, struct bt_gatt_client *client)
 {
-	struct gatt_primary *primary = dis->primary;
+	struct gatt_db_attribute *attrib;
 
-	if (dis->attrib || !primary)
+	if (!dis || dis->client || !dis->service_handle)
 		return false;
 
-	dis->attrib = g_attrib_ref(attrib);
+	dis->client = bt_gatt_client_ref(client);
+	dis->db = gatt_db_ref(bt_gatt_client_get_db(client));
+	attrib = gatt_db_get_attribute(dis->db, dis->service_handle);
 
 	if (!dis->handle)
-		gatt_discover_char(dis->attrib, primary->range.start,
-						primary->range.end, NULL,
-						configure_deviceinfo_cb, dis);
+		gatt_db_service_foreach_char(attrib, configure_deviceinfo_cb,
+									dis);
 
 	return true;
 }
 
 void bt_dis_detach(struct bt_dis *dis)
 {
-	if (!dis->attrib)
+	if (!dis->client)
 		return;
 
-	g_attrib_unref(dis->attrib);
-	dis->attrib = NULL;
+	gatt_db_unref(dis->db);
+	bt_gatt_client_unref(dis->client);
+	dis->client = NULL;
 }
 
 bool bt_dis_set_notification(struct bt_dis *dis, bt_dis_notify func,
diff --git a/android/dis.h b/android/dis.h
index faf27b3..55c6625 100644
--- a/android/dis.h
+++ b/android/dis.h
@@ -23,12 +23,12 @@
 
 struct bt_dis;
 
-struct bt_dis *bt_dis_new(void *primary);
+struct bt_dis *bt_dis_new(uint16_t service_handle);
 
 struct bt_dis *bt_dis_ref(struct bt_dis *dis);
 void bt_dis_unref(struct bt_dis *dis);
 
-bool bt_dis_attach(struct bt_dis *dis, void *gatt);
+bool bt_dis_attach(struct bt_dis *dis, struct bt_gatt_client *client);
 void bt_dis_detach(struct bt_dis *dis);
 
 typedef void (*bt_dis_notify) (uint8_t source, uint16_t vendor,
diff --git a/android/hog.c b/android/hog.c
index 6bec2aa..091a9a5 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -981,17 +981,17 @@ static void dis_notify(uint8_t source, uint16_t vendor, uint16_t product,
 	hog->version = version;
 }
 
-static void hog_attach_dis(struct bt_hog *hog, struct gatt_primary *primary)
+static void hog_attach_dis(struct bt_hog *hog, uint16_t service_handle)
 {
 	if (hog->dis) {
-		bt_dis_attach(hog->dis, hog->attrib);
+		bt_dis_attach(hog->dis, hog->client);
 		return;
 	}
 
-	hog->dis = bt_dis_new(primary);
+	hog->dis = bt_dis_new(service_handle);
 	if (hog->dis) {
 		bt_dis_set_notification(hog->dis, dis_notify, hog);
-		bt_dis_attach(hog->dis, hog->attrib);
+		bt_dis_attach(hog->dis, hog->client);
 	}
 }
 
@@ -1057,11 +1057,6 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 			continue;
 		}
 
-		if (strcmp(primary->uuid, DEVICE_INFORMATION_UUID) == 0) {
-			hog_attach_dis(hog, primary);
-			continue;
-		}
-
 		if (strcmp(primary->uuid, BATTERY_UUID) == 0) {
 			hog_attach_bas(hog, primary);
 		}
@@ -1087,8 +1082,7 @@ static void service_cb(struct gatt_db_attribute *attrib, void *user_data)
 		/* TODO */
 		return;
 	else if (!bt_uuid_strcmp(uuid, DEVICE_INFORMATION_UUID))
-		/* TODO */
-		return;
+		hog_attach_dis(hog, service_handle);
 	else if (!bt_uuid_strcmp(uuid, BATTERY_UUID))
 		/* TODO */
 		return;
@@ -1115,7 +1109,7 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt, void *client)
 		bt_scpp_attach(hog->scpp, gatt);
 
 	if (hog->dis)
-		bt_dis_attach(hog->dis, gatt);
+		bt_dis_attach(hog->dis, hog->client);
 
 	queue_foreach(hog->bas, (void *) bt_bas_attach, gatt);
 
-- 
1.9.1

