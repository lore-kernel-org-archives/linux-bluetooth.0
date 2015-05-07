Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 1/2] audio/a2dp: Fix SEP selection
Date: Thu, 07 May 2015 19:02:57 +0900
Message-id: <1430992978-26779-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

When matching remote SEP to local SEP we do not match vendor codecs
properly, i.e. neither vendor ID not codec ID are checked, which may
cause wrong endpoint to be selected in case there are more that one
endpoints using vendor codec on remote.

This patch fixes this by assinging vendor codec indentification to
local SEP after it's registered and uses this information when matching
SEPs.

This patch is made based on e1c7dddd0dd2f5e23e4d4cf98a9dde713fe6dd53
written by Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>.
---
 profiles/audio/a2dp.c  | 11 +++++++++++
 profiles/audio/avdtp.c | 22 ++++++++++++++++++++++
 profiles/audio/avdtp.h |  3 ++-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 31c5086..85ec753 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1597,6 +1597,17 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 		return NULL;
 	}
 
+	if (codec == A2DP_CODEC_VENDOR) {
+		uint8_t *capabilities;
+		a2dp_vendor_codec_t *vndcodec;
+
+		endpoint->get_capabilities(sep, &capabilities, user_data);
+		vndcodec = (a2dp_vendor_codec_t *) capabilities;
+		avdtp_sep_set_vendor_codec(sep->lsep,
+						btohl(vndcodec->vendor_id),
+						btohs(vndcodec->codec_id));
+	}
+
 	sep->server = server;
 	sep->endpoint = endpoint;
 	sep->codec = codec;
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index f38188f..df6fd42 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -49,6 +49,7 @@
 #include "src/device.h"
 
 #include "avdtp.h"
+#include "a2dp-codecs.h"
 #include "sink.h"
 #include "source.h"
 
@@ -328,6 +329,8 @@ struct avdtp_local_sep {
 	struct avdtp_stream *stream;
 	struct seid_info info;
 	uint8_t codec;
+	uint32_t vndcodec_vendor;
+	uint16_t vndcodec_codec;
 	gboolean delay_reporting;
 	GSList *caps;
 	struct avdtp_sep_ind *ind;
@@ -1197,6 +1200,13 @@ static struct avdtp_local_sep *find_local_sep_by_seid(struct avdtp *session,
 	return queue_find(session->lseps, match_by_seid, INT_TO_PTR(seid));
 }
 
+void avdtp_sep_set_vendor_codec(struct avdtp_local_sep *sep, uint32_t vendor_id,
+							uint16_t codec_id)
+{
+	sep->vndcodec_vendor = vendor_id;
+	sep->vndcodec_codec = codec_id;
+}
+
 struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
 						struct avdtp_local_sep *lsep)
 {
@@ -1226,6 +1236,18 @@ struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
 		if (codec_data->media_codec_type != lsep->codec)
 			continue;
 
+		/* FIXME: Add Vendor Specific Codec match to SEP callback */
+		if (lsep->codec == A2DP_CODEC_VENDOR) {
+			a2dp_vendor_codec_t *vndcodec =
+				(void *) codec_data->data;
+
+			if (btohl(vndcodec->vendor_id) != lsep->vndcodec_vendor)
+				continue;
+
+			if (btohs(vndcodec->codec_id) != lsep->vndcodec_codec)
+				continue;
+		}
+
 		if (sep->stream == NULL)
 			return sep;
 	}
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 1b02232..e237b10 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -276,7 +276,8 @@ struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
 						struct avdtp_sep_ind *ind,
 						struct avdtp_sep_cfm *cfm,
 						void *user_data);
-
+void avdtp_sep_set_vendor_codec(struct avdtp_local_sep *sep, uint32_t vendor_id,
+							uint16_t codec_id);
 /* Find a matching pair of local and remote SEP ID's */
 struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
 						struct avdtp_local_sep *lsep);
-- 
2.1.0

