Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/4] android/arvrcp: Fix not parsing SDP record correctly
Date: Thu,  6 Mar 2014 15:45:26 +0200
Message-Id: <1394113527-4398-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1394113527-4398-1-git-send-email-luiz.dentz@gmail.com>
References: <1394113527-4398-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/android/avrcp.c b/android/avrcp.c
index d5eb31d..911b1df 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <stdlib.h>
 #include <stdbool.h>
 #include <errno.h>
 #include <glib.h>
@@ -817,15 +818,22 @@ static void search_cb(sdp_list_t *recs, int err, gpointer data)
 
 	for (list = recs; list; list = list->next) {
 		sdp_record_t *rec = list->data;
-		sdp_data_t *data;
+		sdp_list_t *l;
+		sdp_profile_desc_t *desc;
+		int features;
 
-		data = sdp_data_get(rec, SDP_ATTR_VERSION);
-		if (data)
-			dev->version = data->val.uint16;
+		if (sdp_get_profile_descs(rec, &l) < 0)
+			continue;
 
-		data = sdp_data_get(rec, SDP_ATTR_SUPPORTED_FEATURES);
-		if (data)
-			dev->features = data->val.uint16;
+		desc = l->data;
+		dev->version = desc->version;
+
+		if (sdp_get_int_attr(rec, SDP_ATTR_SUPPORTED_FEATURES,
+							&features) == 0)
+			dev->features = features;
+
+		sdp_list_free(l, free);
+		break;
 	}
 
 	if (dev->io) {
-- 
1.8.5.3

