Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ] core: Fix walking the list while removing elements
Date: Thu,  4 Oct 2012 14:07:19 -0300
Message-Id: <1349370439-6345-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

If we are walking a GSList and remove the element we are pointing to,
the next iteration g_slist_next() will access previously freed
memory.
---
 src/device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index c659164..0339bcf 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1469,7 +1469,7 @@ static void device_remove_profiles(struct btd_device *device, GSList *uuids)
 	char srcaddr[18], dstaddr[18];
 	bdaddr_t src;
 	sdp_list_t *records;
-	GSList *l;
+	GSList *l, *next;
 
 	adapter_get_address(adapter, &src);
 	ba2str(&src, srcaddr);
@@ -1498,10 +1498,11 @@ static void device_remove_profiles(struct btd_device *device, GSList *uuids)
 	if (records)
 		sdp_list_free(records, (sdp_free_func_t) sdp_record_free);
 
-	for (l = device->profiles; l != NULL; l = g_slist_next(l)) {
+	for (l = device->profiles; l != NULL; l = next) {
 		struct btd_profile *profile = l->data;
 		GSList *probe_uuids;
 
+		next = l->next;
 		probe_uuids = device_match_profile(device, profile,
 								device->uuids);
 		if (probe_uuids != NULL) {
-- 
1.7.12.2

