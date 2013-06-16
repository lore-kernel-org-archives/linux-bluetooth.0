Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] core: Fix crash when a duplicated record is found
Date: Sun, 16 Jun 2013 20:01:25 +0300
Message-Id: <1371402085-30762-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1371402085-30762-1-git-send-email-luiz.dentz@gmail.com>
References: <1371402085-30762-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

 Invalid read of size 8
    at 0x470101: update_bredr_services (device.c:2784)
    by 0x470591: browse_cb (device.c:2975)
    by 0x458B0E: search_completed_cb (sdp-client.c:186)
    by 0x47C154: sdp_process (sdp.c:4343)
    by 0x458954: search_process_cb (sdp-client.c:205)
    by 0x3F31A47A54: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
    by 0x3F31A47D87: ??? (in /usr/lib64/libglib-2.0.so.0.3400.2)
    by 0x3F31A48181: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
    by 0x40A265: main (main.c:595)
  Address 0x0 is not stack'd, malloc'd or (recently) free'd
---
 src/device.c | 65 +++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/src/device.c b/src/device.c
index 0f75c60..c324764 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2677,6 +2677,40 @@ static int rec_cmp(const void *a, const void *b)
 	return r1->handle - r2->handle;
 }
 
+static int update_record(struct browse_req *req, const char *uuid,
+							sdp_record_t *rec)
+{
+	GSList *l;
+
+	/* Check for duplicates */
+	if (sdp_list_find(req->records, rec, rec_cmp))
+		return -EALREADY;
+
+	/* Copy record */
+	req->records = sdp_list_append(req->records, sdp_copy_record(rec));
+
+	/* Check if UUID is duplicated */
+	l = g_slist_find_custom(req->device->uuids, uuid, bt_uuid_strcmp);
+	if (l == NULL) {
+		l = g_slist_find_custom(req->profiles_added, uuid,
+							bt_uuid_strcmp);
+		if (l == NULL)
+			return 0;
+		req->profiles_added = g_slist_append(req->profiles_added,
+							g_strdup(uuid));
+		return 0;
+	}
+
+	l = g_slist_find_custom(req->profiles_removed, uuid, bt_uuid_strcmp);
+	if (l == NULL)
+		return 0;
+
+	g_free(l->data);
+	req->profiles_removed = g_slist_delete_link(req->profiles_removed, l);
+
+	return 0;
+}
+
 static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 {
 	struct btd_device *device = req->device;
@@ -2712,7 +2746,6 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 		sdp_record_t *rec = (sdp_record_t *) seq->data;
 		sdp_list_t *svcclass = NULL;
 		char *profile_uuid;
-		GSList *l;
 
 		if (!rec)
 			break;
@@ -2754,12 +2787,8 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 							product, version);
 		}
 
-		/* Check for duplicates */
-		if (sdp_list_find(req->records, rec, rec_cmp)) {
-			g_free(profile_uuid);
-			sdp_list_free(svcclass, free);
-			continue;
-		}
+		if (update_record(req, profile_uuid, rec) < 0)
+			goto next;
 
 		if (sdp_key_file)
 			store_sdp_record(sdp_key_file, rec);
@@ -2767,26 +2796,8 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 		if (att_key_file)
 			store_primaries_from_sdp_record(att_key_file, rec);
 
-		/* Copy record */
-		req->records = sdp_list_append(req->records,
-							sdp_copy_record(rec));
-
-		l = g_slist_find_custom(device->uuids, profile_uuid,
-							bt_uuid_strcmp);
-		if (!l)
-			req->profiles_added =
-					g_slist_append(req->profiles_added,
-							profile_uuid);
-		else {
-			l = g_slist_find_custom(req->profiles_removed,
-							profile_uuid,
-							bt_uuid_strcmp);
-			g_free(l->data);
-			req->profiles_removed =
-				g_slist_delete_link(req->profiles_removed, l);
-			g_free(profile_uuid);
-		}
-
+next:
+		g_free(profile_uuid);
 		sdp_list_free(svcclass, free);
 	}
 
-- 
1.8.1.4

