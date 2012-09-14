Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v4 2/9] media: Add a2dp_sep_is_playing() to internal API
Date: Fri, 14 Sep 2012 14:03:09 +0200
Message-Id: <1347624196-11281-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1347624196-11281-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1347624196-11281-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Add this function to expose whether the local SEP is streaming or not.
---
 audio/a2dp.c |    8 ++++++++
 audio/a2dp.h |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index a9546b7..64b37e7 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1833,6 +1833,14 @@ gboolean a2dp_sep_unlock(struct a2dp_sep *sep, struct avdtp *session)
 	return TRUE;
 }
 
+gboolean a2dp_sep_is_playing(struct a2dp_sep *sep)
+{
+	if (avdtp_sep_get_state(sep->lsep) == AVDTP_STATE_STREAMING)
+		return TRUE;
+	else
+		return FALSE;
+}
+
 gboolean a2dp_sep_get_lock(struct a2dp_sep *sep)
 {
 	return sep->locked;
diff --git a/audio/a2dp.h b/audio/a2dp.h
index 27b4a57..deab3b8 100644
--- a/audio/a2dp.h
+++ b/audio/a2dp.h
@@ -90,6 +90,7 @@ gboolean a2dp_cancel(struct audio_device *dev, unsigned int id);
 gboolean a2dp_sep_lock(struct a2dp_sep *sep, struct avdtp *session);
 gboolean a2dp_sep_unlock(struct a2dp_sep *sep, struct avdtp *session);
 gboolean a2dp_sep_get_lock(struct a2dp_sep *sep);
+gboolean a2dp_sep_is_playing(struct a2dp_sep *sep);
 struct avdtp_stream *a2dp_sep_get_stream(struct a2dp_sep *sep);
 struct a2dp_sep *a2dp_get_sep(struct avdtp *session,
 				struct avdtp_stream *stream);
-- 
1.7.7.6

