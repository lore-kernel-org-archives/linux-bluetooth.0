Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH] Fix error not returned if service is not supported
Date: Mon, 24 Nov 2014 17:41:39 +0530
Message-id: <1416831099-14791-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Without this patch, error will not be returned if remote device does not
support the service and hence application will never get any response
for the connect request
---
 src/profile.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/profile.c b/src/profile.c
index 252063b..4be4200 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1508,6 +1508,7 @@ static void record_cb(sdp_list_t *recs, int err, gpointer user_data)
 
 	if (!recs || !recs->data) {
 		error("No SDP records found for %s", ext->name);
+		err = -ENOTSUP;
 		goto failed;
 	}
 
@@ -1519,6 +1520,7 @@ static void record_cb(sdp_list_t *recs, int err, gpointer user_data)
 		if (sdp_get_access_protos(rec, &protos) < 0) {
 			error("Unable to get proto list from %s record",
 								ext->name);
+			err = -ENOTSUP;
 			goto failed;
 		}
 
@@ -1547,6 +1549,7 @@ static void record_cb(sdp_list_t *recs, int err, gpointer user_data)
 	if (!conn->chan && !conn->psm) {
 		error("Failed to find L2CAP PSM or RFCOMM channel for %s",
 								ext->name);
+		err = -ENOTSUP;
 		goto failed;
 	}
 
-- 
1.7.9.5

