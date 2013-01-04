Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH 1/2] storage: Fix memory leak
Date: Fri, 04 Jan 2013 11:12:27 +0530
Message-id: <1357278148-27872-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If bt_uuid2string() returns NULL then svcclass has to be freed
---
 src/storage.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/storage.c b/src/storage.c
index 375974a..be3bbf2 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -180,8 +180,10 @@ sdp_record_t *find_record_in_list(sdp_list_t *recs, const char *uuid)
 
 		/* Extract the uuid */
 		uuid_str = bt_uuid2string(svcclass->data);
-		if (!uuid_str)
+		if (!uuid_str) {
+			sdp_list_free(svcclass, free);
 			continue;
+		}
 
 		if (!strcasecmp(uuid_str, uuid)) {
 			sdp_list_free(svcclass, free);
-- 
1.7.9.5

