Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ v0 04/10] device: Remove misleading function
Date: Fri,  1 Mar 2013 20:22:27 -0300
Message-Id: <1362180153-11133-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1362180153-11133-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1362180153-11133-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

'device_register_primaries()' only appended a list of primary services
to the current list.
---
 src/device.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/src/device.c b/src/device.c
index 435a9b8..bfc60fa 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2789,12 +2789,6 @@ static GSList *device_services_from_record(struct btd_device *device,
 	return prim_list;
 }
 
-static void device_register_primaries(struct btd_device *device,
-						GSList *prim_list, int psm)
-{
-	device->primaries = g_slist_concat(device->primaries, prim_list);
-}
-
 static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 {
 	struct browse_req *req = user_data;
@@ -2829,7 +2823,8 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 
 		list = device_services_from_record(device, req->profiles_added);
 		if (list)
-			device_register_primaries(device, list, ATT_PSM);
+			device->primaries = g_slist_concat(device->primaries,
+									list);
 
 		device_probe_profiles(device, req->profiles_added);
 	}
@@ -3049,7 +3044,9 @@ static void register_all_services(struct btd_device *device, GSList *services)
 	g_slist_free_full(device->primaries, g_free);
 	device->primaries = NULL;
 
-	device_register_primaries(device, g_slist_copy(services), -1);
+	/* And keep the new one */
+	device->primaries = g_slist_copy(services);
+
 	if (removed)
 		device_remove_profiles(device, removed);
 
-- 
1.8.1.3

