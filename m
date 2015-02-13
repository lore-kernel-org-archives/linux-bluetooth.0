Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 6/8] android/avdtp: Fix registering SEP with wrong SEID
Date: Fri, 13 Feb 2015 11:23:00 +0200
Message-Id: <1423819382-20018-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1423819382-20018-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1423819382-20018-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add seid check fixing registering too many SEPs
---
 android/avdtp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/android/avdtp.c b/android/avdtp.c
index 728f3fd..f4b2d45 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -3368,6 +3368,10 @@ struct avdtp_local_sep *avdtp_register_sep(uint8_t type, uint8_t media_type,
 						void *user_data)
 {
 	struct avdtp_local_sep *sep;
+	uint8_t seid = avdtp_get_seid();
+
+	if (!seid)
+		return NULL;
 
 	if (g_slist_length(lseps) > MAX_SEID)
 		return NULL;
@@ -3375,7 +3379,7 @@ struct avdtp_local_sep *avdtp_register_sep(uint8_t type, uint8_t media_type,
 	sep = g_new0(struct avdtp_local_sep, 1);
 
 	sep->state = AVDTP_STATE_IDLE;
-	sep->info.seid = avdtp_get_seid();
+	sep->info.seid = seid;
 	sep->info.type = type;
 	sep->info.media_type = media_type;
 	sep->codec = codec_type;
-- 
2.1.0

