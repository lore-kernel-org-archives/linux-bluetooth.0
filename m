Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] audio/AVDTP: Remove unused code
Date: Mon, 18 Nov 2013 13:50:11 +0200
Message-Id: <1384775415-10159-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/avdtp.c | 20 --------------------
 profiles/audio/avdtp.h |  8 --------
 2 files changed, 28 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 9378350..25b7525 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3283,31 +3283,11 @@ struct avdtp_remote_sep *avdtp_get_remote_sep(struct avdtp *session,
 	return NULL;
 }
 
-uint8_t avdtp_get_seid(struct avdtp_remote_sep *sep)
-{
-	return sep->seid;
-}
-
-uint8_t avdtp_get_type(struct avdtp_remote_sep *sep)
-{
-	return sep->type;
-}
-
 struct avdtp_service_capability *avdtp_get_codec(struct avdtp_remote_sep *sep)
 {
 	return sep->codec;
 }
 
-gboolean avdtp_get_delay_reporting(struct avdtp_remote_sep *sep)
-{
-	return sep->delay_reporting;
-}
-
-struct avdtp_stream *avdtp_get_stream(struct avdtp_remote_sep *sep)
-{
-	return sep->stream;
-}
-
 struct avdtp_service_capability *avdtp_service_cap_new(uint8_t category,
 							void *data, int length)
 {
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 5606506..30ade86 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -224,16 +224,8 @@ struct avdtp_service_capability *avdtp_service_cap_new(uint8_t category,
 struct avdtp_remote_sep *avdtp_get_remote_sep(struct avdtp *session,
 						uint8_t seid);
 
-uint8_t avdtp_get_seid(struct avdtp_remote_sep *sep);
-
-uint8_t avdtp_get_type(struct avdtp_remote_sep *sep);
-
 struct avdtp_service_capability *avdtp_get_codec(struct avdtp_remote_sep *sep);
 
-gboolean avdtp_get_delay_reporting(struct avdtp_remote_sep *sep);
-
-struct avdtp_stream *avdtp_get_stream(struct avdtp_remote_sep *sep);
-
 int avdtp_discover(struct avdtp *session, avdtp_discover_cb_t cb,
 			void *user_data);
 
-- 
1.8.3.1

