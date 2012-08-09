Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] audio: Remove unused local A2DP endpoints reference
Date: Thu, 09 Aug 2012 15:09:26 +0900
Message-id: <1344492568-22777-2-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1344492568-22777-1-git-send-email-chanyeol.park@samsung.com>
References: <1344492568-22777-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>


diff --git a/audio/a2dp.c b/audio/a2dp.c
index db4bb13..a4369f5 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1562,7 +1562,6 @@ struct a2dp_sep *a2dp_add_sep(const bdaddr_t *src, uint8_t type,
 	GSList **l;
 	uint32_t *record_id;
 	sdp_record_t *record;
-	struct avdtp_sep_ind *ind;
 
 	server = find_server(servers, src);
 	if (server == NULL) {
@@ -1585,17 +1584,11 @@ struct a2dp_sep *a2dp_add_sep(const bdaddr_t *src, uint8_t type,
 
 	sep = g_new0(struct a2dp_sep, 1);
 
-	if (endpoint) {
-		ind = &endpoint_ind;
-		goto proceed;
-	}
-
-	ind = (codec == A2DP_CODEC_MPEG12) ? &mpeg_ind : &sbc_ind;
-
-proceed:
 	sep->lsep = avdtp_register_sep(&server->src, type,
 					AVDTP_MEDIA_TYPE_AUDIO, codec,
-					delay_reporting, ind, &cfm, sep);
+					delay_reporting, &endpoint_ind,
+					&cfm, sep);
+
 	if (sep->lsep == NULL) {
 		g_free(sep);
 		if (err)
-- 
1.7.9.5

