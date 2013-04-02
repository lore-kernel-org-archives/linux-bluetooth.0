Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 09/18] core: Only do Find Included Services after receiving all GATT services
Date: Tue,  2 Apr 2013 12:50:56 -0400
Message-Id: <1364921465-31182-10-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that the primary service discovery callback is called on partial
discovery (instead of waiting for the entire discovery procedure to
finish), the included services discovery should wait until the full list
of services is found.

This is necessary because the logic for detecting added/removed services
depends on the full list of discovered services.
---
 src/device.c |   40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/src/device.c b/src/device.c
index 3b4d66b..13fda8f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3073,37 +3073,25 @@ done:
 	return true;
 }
 
-static void find_included_services(struct included_search *search,
-							GSList *services)
+static bool primary_cb(GSList *services, guint8 status, gpointer user_data)
 {
-	struct btd_device *device = search->req->device;
+	struct included_search *search = user_data;
+	struct browse_req *req = search->req;
+	struct btd_device *device = req->device;
 	struct gatt_primary *prim;
 	GSList *l;
 
-	if (services == NULL)
-		return;
+	if (status == ATT_ECODE_ATTR_NOT_FOUND) {
+		search->current = search->services;
+		prim = search->current->data;
+		gatt_find_included(device->attrib, prim->range.start,
+					prim->range.end, find_included_cb,
+					search);
 
-	for (l = services; l != NULL; l = l->next) {
-		prim = l->data;
-		search->services = g_slist_append(search->services,
-						g_memdup(prim, sizeof(*prim)));
+		return false;
 	}
-	search->current = search->services;
-
-	prim = search->current->data;
-	gatt_find_included(device->attrib, prim->range.start, prim->range.end,
-					find_included_cb, search);
-
-}
-
-static bool primary_cb(GSList *services, guint8 status, gpointer user_data)
-{
-	struct included_search *search = user_data;
-	struct browse_req *req = search->req;
 
 	if (status) {
-		struct btd_device *device = req->device;
-
 		if (req->msg) {
 			DBusMessage *reply;
 			reply = btd_error_failed(req->msg,
@@ -3119,7 +3107,11 @@ static bool primary_cb(GSList *services, guint8 status, gpointer user_data)
 		return false;
 	}
 
-	find_included_services(search, services);
+	for (l = services; l != NULL; l = l->next) {
+		prim = l->data;
+		search->services = g_slist_append(search->services,
+						g_memdup(prim, sizeof(*prim)));
+	}
 
 	return true;
 }
-- 
1.7.9.5

