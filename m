Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 3/3] audio/a2dp: Remove useless check_vendor_codec()
Date: Thu, 07 May 2015 00:10:36 +0900
Message-id: <1430925036-20245-3-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1430925036-20245-1-git-send-email-chanyeol.park@samsung.com>
References: <1430925036-20245-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

This function could be removed because A2DP vendor codec match is already
verified in avdtp_find_remote_sep().
---
 profiles/audio/a2dp.c | 42 ++----------------------------------------
 1 file changed, 2 insertions(+), 40 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index c832048..856b19b 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1723,42 +1723,6 @@ done:
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
@@ -1792,11 +1756,9 @@ static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *list,
 		if (cap->media_codec_type != A2DP_CODEC_VENDOR) {
 			selected_sep = sep;
 			continue;
-		}
-
-		if (check_vendor_codec(sep, cap->data,
-					service->length - sizeof(*cap)))
+		} else {
 			return sep;
+		}
 	}
 
 	if (selected_sep)
-- 
2.1.0

