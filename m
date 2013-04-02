Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 06/18] core: Refactor memory allocation for GATT service discovery
Date: Tue,  2 Apr 2013 12:50:53 -0400
Message-Id: <1364921465-31182-7-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Prior to implementing partial primary service discovery, it is necessary
to move allocation of struct included_search, so the list of found
services (search->services) can be created incrementally.

Note that this list is also used later to collect (secondary) included
services and only then the full list of found services is used for
registering new services and detecting added/removed profiles.
---
 src/device.c |   33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/src/device.c b/src/device.c
index b2a7ade..6fd255a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3073,17 +3073,15 @@ done:
 	return true;
 }
 
-static void find_included_services(struct browse_req *req, GSList *services)
+static void find_included_services(struct included_search *search,
+							GSList *services)
 {
-	struct btd_device *device = req->device;
-	struct included_search *search;
+	struct btd_device *device = search->req->device;
 	struct gatt_primary *prim;
 
 	if (services == NULL)
 		return;
 
-	search = g_new0(struct included_search, 1);
-	search->req = req;
 	search->services = g_slist_copy(services);
 	search->current = search->services;
 
@@ -3095,7 +3093,8 @@ static void find_included_services(struct browse_req *req, GSList *services)
 
 static bool primary_cb(GSList *services, guint8 status, gpointer user_data)
 {
-	struct browse_req *req = user_data;
+	struct included_search *search = user_data;
+	struct browse_req *req = search->req;
 
 	if (status) {
 		struct btd_device *device = req->device;
@@ -3109,10 +3108,12 @@ static bool primary_cb(GSList *services, guint8 status, gpointer user_data)
 
 		device->browse = NULL;
 		browse_request_free(req);
+		g_free(search);
+
 		return false;
 	}
 
-	find_included_services(req, services);
+	find_included_services(search, services);
 
 	return true;
 }
@@ -3297,13 +3298,25 @@ static void att_browse_error_cb(const GError *gerr, gpointer user_data)
 	browse_request_free(req);
 }
 
+static void discover_gatt_services(struct btd_device *device)
+{
+	struct included_search *search;
+
+	/* Do a "Discover All Primary Services" procedure, followed by
+	 * recursive "Find Included Services" on each found service (up to one
+	 * level).
+	 */
+	search = g_new0(struct included_search, 1);
+	search->req = device->browse;
+	gatt_discover_primary(device->attrib, NULL, primary_cb, search);
+}
+
 static void att_browse_cb(gpointer user_data)
 {
 	struct att_callbacks *attcb = user_data;
 	struct btd_device *device = attcb->user_data;
 
-	gatt_discover_primary(device->attrib, NULL, primary_cb,
-							device->browse);
+	discover_gatt_services(device);
 }
 
 static int device_browse_primary(struct btd_device *device, DBusMessage *msg,
@@ -3323,7 +3336,7 @@ static int device_browse_primary(struct btd_device *device, DBusMessage *msg,
 	device->browse = req;
 
 	if (device->attrib) {
-		gatt_discover_primary(device->attrib, NULL, primary_cb, req);
+		discover_gatt_services(device);
 		goto done;
 	}
 
-- 
1.7.9.5

