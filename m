Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH BlueZ] audio: Remove redundant variable gerr
Date: Fri, 27 Jul 2012 13:14:12 +0530
Message-id: <1343375053-19193-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 6162948..1c45753 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -381,7 +381,6 @@ static void get_incoming_record_cb(sdp_list_t *recs, int err,
 {
 	struct audio_device *dev = user_data;
 	struct gateway *gw = dev->gateway;
-	GError *gerr = NULL;
 
 	if (err < 0) {
 		error("Unable to get service record: %s (%d)", strerror(-err),
@@ -398,7 +397,7 @@ static void get_incoming_record_cb(sdp_list_t *recs, int err,
 	if (gw->version == 0)
 		goto fail;
 
-	rfcomm_connect_cb(gw->incoming, gerr, dev);
+	rfcomm_connect_cb(gw->incoming, NULL, dev);
 	return;
 
 fail:
-- 
1.7.1

