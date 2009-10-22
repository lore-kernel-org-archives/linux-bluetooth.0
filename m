Return-Path: <cyrus@holtmann.org>
From: jaikumar@google.com
To: linux-bluetooth@vger.kernel.org
Cc: Jaikumar Ganesh <jaikumar@google.com>
Subject: [PATCH] Fix SDP handling when the SDP record is modified on remote device.
Date: Thu, 22 Oct 2009 15:46:27 -0700
Message-Id: <1256251587-18043-1-git-send-email-jaikumar@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jaikumar Ganesh <jaikumar@google.com>

We invalidate the in-memory SDP records list only when a profile
is added or removed. So when a SDP record attribute like the rfcomm
channel number is modified on the remote device, we will miss the update.
---
 src/device.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/device.c b/src/device.c
index 63f35de..6cb9641 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1313,11 +1313,6 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 
 	update_services(req, recs);
 
-	if (!req->profiles_added && !req->profiles_removed) {
-		debug("%s: No service update", device->path);
-		goto proceed;
-	}
-
 	if (device->tmp_records && req->records) {
 		sdp_list_free(device->tmp_records,
 					(sdp_free_func_t) sdp_record_free);
@@ -1325,6 +1320,11 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 		req->records = NULL;
 	}
 
+	if (!req->profiles_added && !req->profiles_removed) {
+		debug("%s: No service update", device->path);
+		goto proceed;
+	}
+
 	/* Probe matching drivers for services added */
 	if (req->profiles_added)
 		device_probe_drivers(device, req->profiles_added);
-- 
1.6.2.3

