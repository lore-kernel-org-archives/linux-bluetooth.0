Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 02/28] android/hog: Introduce bt_gatt_client
Date: Wed,  1 Apr 2015 18:40:18 +0200
Message-Id: <1427906444-11769-3-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
References: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces bt_gatt_client to HoG. Service handle will be used
to obtain the attribute from cached database.
---
 android/hidhost.c |  4 ++--
 android/hog.c     | 30 +++++++++++++++++++++---------
 android/hog.h     |  6 +++---
 unit/test-hog.c   |  4 ++--
 4 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 3da1130..47e5840 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -818,7 +818,7 @@ static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
 		goto fail;
 	}
 
-	if (!bt_hog_attach(dev->hog, dev->attrib)) {
+	if (!bt_hog_attach(dev->hog, dev->attrib, dev->client)) {
 		error("HoG: unable to attach");
 		goto fail;
 	}
@@ -864,7 +864,7 @@ static void hog_conn_cb(const bdaddr_t *addr, int err, void *attrib)
 	if (!dev->hog) {
 		/* TODO: Get device details */
 		dev->hog = bt_hog_new_default("bluez-input-device", dev->vendor,
-					dev->product, dev->version, NULL);
+					dev->product, dev->version, NULL, 0);
 		if (!dev->hog) {
 			error("HoG: unable to create session");
 			goto fail;
diff --git a/android/hog.c b/android/hog.c
index ff77bb3..5b8c079 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -45,6 +45,9 @@
 #include "src/shared/util.h"
 #include "src/shared/uhid.h"
 #include "src/shared/queue.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-client.h"
 #include "src/log.h"
 
 #include "attrib/att.h"
@@ -79,6 +82,7 @@
 
 struct bt_hog {
 	int			ref_count;
+	uint16_t		service_handle;
 	char			*name;
 	uint16_t		vendor;
 	uint16_t		product;
@@ -103,6 +107,7 @@ struct bt_hog {
 	struct queue		*bas;
 	GSList			*instances;
 	struct queue		*gatt_op;
+	struct bt_gatt_client	*client;
 };
 
 struct report {
@@ -1173,14 +1178,15 @@ static void hog_free(void *data)
 
 struct bt_hog *bt_hog_new_default(const char *name, uint16_t vendor,
 					uint16_t product, uint16_t version,
-					void *primary)
+					void *primary, uint16_t service_handle)
 {
-	return bt_hog_new(-1, name, vendor, product, version, primary);
+	return bt_hog_new(-1, name, vendor, product, version, primary,
+								service_handle);
 }
 
 struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 					uint16_t product, uint16_t version,
-					void *primary)
+					void *primary, uint16_t service_handle)
 {
 	struct bt_hog *hog;
 
@@ -1211,6 +1217,9 @@ struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 	if (primary)
 		hog->primary = g_memdup(primary, sizeof(*hog->primary));
 
+	if (service_handle)
+		hog->service_handle = service_handle;
+
 	return bt_hog_ref(hog);
 }
 
@@ -1321,14 +1330,14 @@ static void hog_attach_hog(struct bt_hog *hog, struct gatt_primary *primary)
 	}
 
 	instance = bt_hog_new(hog->uhid_fd, hog->name, hog->vendor,
-					hog->product, hog->version, primary);
+					hog->product, hog->version, primary, 0);
 	if (!instance)
 		return;
 
 	find_included(instance, hog->attrib, primary->range.start,
 			primary->range.end, find_included_cb, instance);
 
-	bt_hog_attach(instance, hog->attrib);
+	bt_hog_attach(instance, hog->attrib, hog->client);
 	hog->instances = g_slist_append(hog->instances, instance);
 }
 
@@ -1377,15 +1386,16 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 	}
 }
 
-bool bt_hog_attach(struct bt_hog *hog, void *gatt)
+bool bt_hog_attach(struct bt_hog *hog, void *gatt, void *client)
 {
 	struct gatt_primary *primary = hog->primary;
 	GSList *l;
 
-	if (hog->attrib)
+	if (hog->attrib || hog->client)
 		return false;
 
 	hog->attrib = g_attrib_ref(gatt);
+	hog->client = bt_gatt_client_ref(client);
 
 	if (!primary) {
 		discover_primary(hog, hog->attrib, NULL, primary_cb, hog);
@@ -1403,7 +1413,7 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 	for (l = hog->instances; l; l = l->next) {
 		struct bt_hog *instance = l->data;
 
-		bt_hog_attach(instance, gatt);
+		bt_hog_attach(instance, gatt, client);
 	}
 
 	if (hog->reports == NULL) {
@@ -1429,7 +1439,7 @@ void bt_hog_detach(struct bt_hog *hog)
 {
 	GSList *l;
 
-	if (!hog->attrib)
+	if (!hog->attrib || !hog->client)
 		return;
 
 	queue_foreach(hog->bas, (void *) bt_bas_detach, NULL);
@@ -1456,7 +1466,9 @@ void bt_hog_detach(struct bt_hog *hog)
 		bt_dis_detach(hog->dis);
 
 	queue_foreach(hog->gatt_op, (void *) cancel_gatt_req, NULL);
+	bt_gatt_client_unref(hog->client);
 	g_attrib_unref(hog->attrib);
+	hog->client = NULL;
 	hog->attrib = NULL;
 }
 
diff --git a/android/hog.h b/android/hog.h
index 2a9b899..61d756c 100644
--- a/android/hog.h
+++ b/android/hog.h
@@ -25,16 +25,16 @@ struct bt_hog;
 
 struct bt_hog *bt_hog_new_default(const char *name, uint16_t vendor,
 					uint16_t product, uint16_t version,
-					void *primary);
+					void *primary, uint16_t service_handle);
 
 struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 					uint16_t product, uint16_t version,
-					void *primary);
+					void *primary, uint16_t service_handle);
 
 struct bt_hog *bt_hog_ref(struct bt_hog *hog);
 void bt_hog_unref(struct bt_hog *hog);
 
-bool bt_hog_attach(struct bt_hog *hog, void *gatt);
+bool bt_hog_attach(struct bt_hog *hog, void *gatt, void *client);
 void bt_hog_detach(struct bt_hog *hog);
 
 int bt_hog_set_control_point(struct bt_hog *hog, bool suspend);
diff --git a/unit/test-hog.c b/unit/test-hog.c
index 2a25d09..c7c64e4 100644
--- a/unit/test-hog.c
+++ b/unit/test-hog.c
@@ -196,7 +196,7 @@ static struct context *create_context(gconstpointer data)
 	fd = open("/dev/null", O_WRONLY | O_CLOEXEC);
 	g_assert(fd > 0);
 
-	context->hog = bt_hog_new(fd, name, vendor, product, version, NULL);
+	context->hog = bt_hog_new(fd, name, vendor, product, version, NULL, 0);
 	g_assert(context->hog);
 
 	channel = g_io_channel_unix_new(sv[1]);
@@ -222,7 +222,7 @@ static void test_hog(gconstpointer data)
 {
 	struct context *context = create_context(data);
 
-	g_assert(bt_hog_attach(context->hog, context->attrib));
+	g_assert(bt_hog_attach(context->hog, context->attrib, NULL));
 }
 
 int main(int argc, char *argv[])
-- 
1.9.1

