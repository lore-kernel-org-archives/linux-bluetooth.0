Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 1/3] audio/a2dp: connect A2DP vendor codec if possible
Date: Thu, 07 May 2015 00:10:34 +0900
Message-id: <1430925036-20245-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

This patch gives the priority on vendor codec during A2DP codec
negotiation.
---
 profiles/audio/a2dp.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 31c5086..d9a2f72 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1751,6 +1751,8 @@ static gboolean check_vendor_codec(struct a2dp_sep *sep, uint8_t *cap,
 static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *list,
 					const char *sender)
 {
+	struct a2dp_sep *selected_sep = NULL;
+
 	for (; list; list = list->next) {
 		struct a2dp_sep *sep = list->data;
 		struct avdtp_remote_sep *rsep;
@@ -1776,15 +1778,20 @@ static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *list,
 		service = avdtp_get_codec(rsep);
 		cap = (struct avdtp_media_codec_capability *) service->data;
 
-		if (cap->media_codec_type != A2DP_CODEC_VENDOR)
-			return sep;
+		if (cap->media_codec_type != A2DP_CODEC_VENDOR) {
+			selected_sep = sep;
+			continue;
+		}
 
 		if (check_vendor_codec(sep, cap->data,
 					service->length - sizeof(*cap)))
 			return sep;
 	}
 
-	return NULL;
+	if (selected_sep)
+		return selected_sep;
+	else
+		return NULL;
 }
 
 static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, uint8_t type,
-- 
2.1.0

