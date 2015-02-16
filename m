Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 6/8] android/avdtp: Fix registering SEP with wrong SEID
Date: Mon, 16 Feb 2015 13:08:13 +0200
Message-Id: <1424084895-20639-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1424084895-20639-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424084895-20639-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add seid check fixing registering too many SEPs
---
 android/avdtp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/android/avdtp.c b/android/avdtp.c
index ce75615..b290feb 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -3352,6 +3352,10 @@ struct avdtp_local_sep *avdtp_register_sep(uint8_t type, uint8_t media_type,
 						void *user_data)
 {
 	struct avdtp_local_sep *sep;
+	uint8_t seid = util_get_uid(&seids, MAX_SEID);
+
+	if (!seid)
+		return NULL;
 
 	if (g_slist_length(lseps) > MAX_SEID)
 		return NULL;
@@ -3359,7 +3363,7 @@ struct avdtp_local_sep *avdtp_register_sep(uint8_t type, uint8_t media_type,
 	sep = g_new0(struct avdtp_local_sep, 1);
 
 	sep->state = AVDTP_STATE_IDLE;
-	sep->info.seid = util_get_uid(&seids, MAX_SEID);
+	sep->info.seid = seid;
 	sep->info.type = type;
 	sep->info.media_type = media_type;
 	sep->codec = codec_type;
-- 
2.1.0

