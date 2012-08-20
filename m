Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 07/10] core: Add updating GATT services
Date: Mon, 20 Aug 2012 14:22:52 -0300
Message-Id: <1345483375-27621-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345483375-27621-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345483375-27621-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the functions to manage Profiles added, and removed
after a Discover All Primary Services procedure.
---
 src/device.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/src/device.c b/src/device.c
index 57e7897..8626ad6 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1532,6 +1532,46 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 	}
 }
 
+static gint primary_cmp(gconstpointer a, gconstpointer b)
+{
+	return memcmp(a, b, sizeof(struct gatt_primary));
+}
+
+static void update_gatt_services(struct browse_req *req, GSList *current,
+								GSList *found)
+{
+	GSList *l, *lmatch, *left = g_slist_copy(current);
+
+	/* Added Profiles */
+	for (l = found; l; l = g_slist_next(l)) {
+		struct gatt_primary *prim = l->data;
+
+		/* Entry found ? */
+		lmatch = g_slist_find_custom(current, prim, primary_cmp);
+		if (lmatch) {
+			left = g_slist_remove(left, lmatch->data);
+			continue;
+		}
+
+		/* New entry */
+		req->profiles_added = g_slist_append(req->profiles_added,
+							g_strdup(prim->uuid));
+
+		DBG("UUID Added: %s", prim->uuid);
+	}
+
+	/* Removed Profiles */
+	for (l = left; l; l = g_slist_next(l)) {
+		struct gatt_primary *prim = l->data;
+		req->profiles_removed = g_slist_append(req->profiles_removed,
+							g_strdup(prim->uuid));
+
+		DBG("UUID Removed: %s", prim->uuid);
+	}
+
+	g_slist_free(left);
+}
+
 static void store_profiles(struct btd_device *device)
 {
 	struct btd_adapter *adapter = device->adapter;
@@ -1830,11 +1870,17 @@ done:
 	return FALSE;
 }
 
+static void device_unregister_services(struct btd_device *device)
+{
+	attrib_client_unregister(device->services);
+	g_slist_free_full(device->services, g_free);
+	device->services = NULL;
+}
+
 static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 {
 	struct browse_req *req = user_data;
 	struct btd_device *device = req->device;
-	GSList *l, *uuids = NULL;
 
 	if (status) {
 		if (req->msg) {
@@ -1848,20 +1894,22 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 
 	device_set_temporary(device, FALSE);
 
-	for (l = services; l; l = l->next) {
-		struct gatt_primary *prim = l->data;
+	if (device->services)
+		device_unregister_services(device);
 
-		uuids = g_slist_append(uuids, prim->uuid);
-	}
+	update_gatt_services(req, device->primaries, services);
+	g_slist_free_full(device->primaries, g_free);
+	device->primaries = NULL;
 
 	device_register_services(req->conn, device, g_slist_copy(services), -1);
-	device_probe_drivers(device, uuids);
+	if (req->profiles_removed)
+		device_remove_drivers(device, req->profiles_removed);
+
+	device_probe_drivers(device, req->profiles_added);
 
 	if (device->attios == NULL && device->attios_offline == NULL)
 		attio_cleanup(device);
 
-	g_slist_free(uuids);
-
 	services_changed(device);
 	if (req->msg)
 		create_device_reply(device, req);
-- 
1.7.8.6

