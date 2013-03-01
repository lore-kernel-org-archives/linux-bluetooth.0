Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ v0 10/10] device: Remove detection of removed services during SDP browse
Date: Fri,  1 Mar 2013 20:22:33 -0300
Message-Id: <1362180153-11133-11-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1362180153-11133-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1362180153-11133-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Right now, the remote device services are discovered only once,
when it is created, and then this list is not expected to change,
neither the user has any way to update it.

The only[1] situation that a device may "lose" services is when it
supports GATT and sends the Service Changed notification, which
could mean that the device lost support for some services.

[1] In theory, it could also happen between doing a Device.Connect()
and Device.Pair(), because Pair() triggers another service discovery.
---
 src/device.c | 33 +++------------------------------
 1 file changed, 3 insertions(+), 30 deletions(-)

diff --git a/src/device.c b/src/device.c
index f2abcff..5ee84a3 100644
--- a/src/device.c
+++ b/src/device.c
@@ -109,7 +109,6 @@ struct browse_req {
 	struct btd_device *device;
 	GSList *match_uuids;
 	GSList *profiles_added;
-	GSList *profiles_removed;
 	sdp_list_t *records;
 	int search_uuid;
 	int reconnect_attempt;
@@ -349,7 +348,6 @@ static void browse_request_free(struct browse_req *req)
 	if (req->device)
 		btd_device_unref(req->device);
 	g_slist_free_full(req->profiles_added, g_free);
-	g_slist_free(req->profiles_removed);
 	if (req->records)
 		sdp_list_free(req->records, (sdp_free_func_t) sdp_record_free);
 
@@ -2667,16 +2665,12 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 
 		l = g_slist_find_custom(device->uuids, profile_uuid,
 							(GCompareFunc) strcmp);
-		if (!l)
+		if (l == NULL)
 			req->profiles_added =
 					g_slist_append(req->profiles_added,
 							profile_uuid);
-		else {
-			req->profiles_removed =
-					g_slist_remove(req->profiles_removed,
-							l->data);
+		else
 			g_free(profile_uuid);
-		}
 
 		sdp_list_free(svcclass, free);
 	}
@@ -2805,7 +2799,7 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 	device->tmp_records = req->records;
 	req->records = NULL;
 
-	if (!req->profiles_added && !req->profiles_removed) {
+	if (!req->profiles_added) {
 		DBG("%s: No service update", addr);
 		goto send_reply;
 	}
@@ -2822,10 +2816,6 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 		device_probe_profiles(device, req->profiles_added);
 	}
 
-	/* Remove profiles for services removed */
-	if (req->profiles_removed)
-		device_remove_profiles(device, req->profiles_removed);
-
 	/* Propagate services changes */
 	g_dbus_emit_property_changed(dbus_conn, req->device->path,
 						DEVICE_INTERFACE, "UUIDs");
@@ -2878,22 +2868,6 @@ done:
 	search_cb(recs, err, user_data);
 }
 
-static void init_browse(struct browse_req *req, gboolean reverse)
-{
-	GSList *l;
-
-	/* If we are doing reverse-SDP don't try to detect removed profiles
-	 * since some devices hide their service records while they are
-	 * connected
-	 */
-	if (reverse)
-		return;
-
-	for (l = req->device->uuids; l; l = l->next)
-		req->profiles_removed = g_slist_append(req->profiles_removed,
-						l->data);
-}
-
 static void store_services(struct btd_device *device)
 {
 	struct btd_adapter *adapter = device->adapter;
@@ -3357,7 +3331,6 @@ static int device_browse_sdp(struct btd_device *device, DBusMessage *msg,
 	req = g_new0(struct browse_req, 1);
 	req->device = btd_device_ref(device);
 	sdp_uuid16_create(&uuid, uuid_list[req->search_uuid++]);
-	init_browse(req, reverse);
 
 	err = bt_search_service(adapter_get_address(adapter), &device->bdaddr,
 						&uuid, browse_cb, req, NULL);
-- 
1.8.1.3

