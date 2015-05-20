Return-Path: <cyrus@holtmann.org>
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v4 2/2] audio/a2dp: Remove useless check_vendor_codec()
Date: Wed, 20 May 2015 21:09:48 +0900
Message-id: <1432123788-12967-2-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1432123788-12967-1-git-send-email-chanyeol.park@samsung.com>
References: <1432123788-12967-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function could be removed because A2DP vendor codec match is
already verified in avdtp_find_remote_sep().
---
 profiles/audio/a2dp.c | 51 ++-------------------------------------------------
 1 file changed, 2 insertions(+), 49 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 3c5a8a2..04c42be 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1748,50 +1748,11 @@ done:
 	finalize_select(setup);
 }
 
-static gboolean check_vendor_codec(struct a2dp_sep *sep, uint8_t *cap,
-								size_t len)
-{
-	uint8_t *capabilities;
-	size_t length;
-	a2dp_vendor_codec_t *local_codec;
-	a2dp_vendor_codec_t *remote_codec;
-
-	if (len < sizeof(a2dp_vendor_codec_t))
-		return FALSE;
-
-	remote_codec = (a2dp_vendor_codec_t *) cap;
-
-	if (sep->endpoint == NULL)
-		return FALSE;
-
-	length = sep->endpoint->get_capabilities(sep,
-				&capabilities, sep->user_data);
-
-	if (length < sizeof(a2dp_vendor_codec_t))
-		return FALSE;
-
-	local_codec = (a2dp_vendor_codec_t *) capabilities;
-
-	if (btohl(remote_codec->vendor_id) != btohl(local_codec->vendor_id))
-		return FALSE;
-
-	if (btohs(remote_codec->codec_id) != btohs(local_codec->codec_id))
-		return FALSE;
-
-	DBG("vendor 0x%08x codec 0x%04x", btohl(remote_codec->vendor_id),
-						btohs(remote_codec->codec_id));
-
-	return TRUE;
-}
-
 static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *list,
 					const char *sender)
 {
 	for (; list; list = list->next) {
 		struct a2dp_sep *sep = list->data;
-		struct avdtp_remote_sep *rsep;
-		struct avdtp_media_codec_capability *cap;
-		struct avdtp_service_capability *service;
 
 		/* Use sender's endpoint if available */
 		if (sender) {
@@ -1805,19 +1766,11 @@ static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *list,
 				continue;
 		}
 
-		rsep = avdtp_find_remote_sep(session, sep->lsep);
-		if (rsep == NULL)
+		if (avdtp_find_remote_sep(session, sep->lsep) == NULL)
 			continue;
 
-		service = avdtp_get_codec(rsep);
-		cap = (struct avdtp_media_codec_capability *) service->data;
-
-		if (cap->media_codec_type != A2DP_CODEC_VENDOR)
-			return sep;
+		return sep;
 
-		if (check_vendor_codec(sep, cap->data,
-					service->length - sizeof(*cap)))
-			return sep;
 	}
 
 	return NULL;
-- 
2.1.0

