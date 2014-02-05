Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/handsfree: Fix memory leak
Date: Wed,  5 Feb 2014 12:50:59 +0200
Message-Id: <1391597459-3791-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Free classes if sdp_get_access_protos fails.
---
 android/handsfree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/handsfree.c b/android/handsfree.c
index edf3d27..9482b2e 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -229,6 +229,7 @@ static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 
 	if (sdp_get_access_protos(recs->data, &protos) < 0) {
 		error("handsfree: unable to get access protocols from record");
+		sdp_list_free(classes, free);
 		goto fail;
 	}
 
-- 
1.8.3.2

