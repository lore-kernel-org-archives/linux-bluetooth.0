Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ] core: Fix walking the list while removing elements
Date: Thu,  4 Oct 2012 03:06:26 -0300
Message-Id: <1349330786-30166-1-git-send-email-lucas.de.marchi@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If we are walking a GSList and remove the element we are pointing to,
the next iteration g_slist_next() will access previously freed
memory.
---

This was caught only by inspecting the code. I don't know why valgrind
didn't complain about accessing previously freed memory region.

 src/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index c659164..6150963 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1498,7 +1498,7 @@ static void device_remove_profiles(struct btd_device *device, GSList *uuids)
 	if (records)
 		sdp_list_free(records, (sdp_free_func_t) sdp_record_free);
 
-	for (l = device->profiles; l != NULL; l = g_slist_next(l)) {
+	for (l = device->profiles; l != NULL;) {
 		struct btd_profile *profile = l->data;
 		GSList *probe_uuids;
 
@@ -1506,9 +1506,11 @@ static void device_remove_profiles(struct btd_device *device, GSList *uuids)
 								device->uuids);
 		if (probe_uuids != NULL) {
 			g_slist_free(probe_uuids);
+			l = l->next;
 			continue;
 		}
 
+		l = l->next;
 		profile->device_remove(profile, device);
 		device->profiles = g_slist_remove(device->profiles, profile);
 	}
-- 
1.7.12.2

