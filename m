Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 16/26] android/a2dp: Fix SEP selection
Date: Mon, 26 May 2014 15:16:42 +0200
Message-ID: <1401110212-11526-17-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When matching remote SEP to local SEP we do not match vendor codecs
properly, i.e. neither vendor ID not codec ID are checked, which may
cause wrong endpoint to be selected in case there are more that one
endpoints using vendor codec on remote.

This patch fixes this by assinging vendor codec indentification to
local SEP after it's registered and uses this information when matching
SEPs.
---
 android/a2dp.c  |  8 ++++++++
 android/avdtp.c | 23 +++++++++++++++++++++++
 android/avdtp.h |  2 ++
 3 files changed, 33 insertions(+)

diff --git a/android/a2dp.c b/android/a2dp.c
index c8119da..0b586a8 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -1230,6 +1230,14 @@ static uint8_t register_endpoint(const uint8_t *uuid, uint8_t codec,
 	endpoint->caps = presets->data;
 	endpoint->presets = g_slist_copy(g_slist_nth(presets, 1));
 
+	if (endpoint->codec == A2DP_CODEC_VENDOR) {
+		a2dp_vendor_codec_t *vndcodec = (void *) endpoint->caps->data;
+
+		avdtp_sep_set_vendor_codec(endpoint->sep,
+						btohl(vndcodec->vendor_id),
+						btohs(vndcodec->codec_id));
+	}
+
 	endpoints = g_slist_append(endpoints, endpoint);
 
 	return endpoint->id;
diff --git a/android/avdtp.c b/android/avdtp.c
index 3d309b9..d6684bb 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -39,8 +39,10 @@
 
 #include <glib.h>
 
+#include "lib/bluetooth.h"
 #include "src/log.h"
 #include "avdtp.h"
+#include "../profiles/audio/a2dp-codecs.h"
 
 #define AVDTP_PSM 25
 
@@ -317,6 +319,8 @@ struct avdtp_local_sep {
 	struct avdtp_stream *stream;
 	struct seid_info info;
 	uint8_t codec;
+	uint32_t vndcodec_vendor;
+	uint16_t vndcodec_codec;
 	gboolean delay_reporting;
 	GSList *caps;
 	struct avdtp_sep_ind *ind;
@@ -1089,6 +1093,18 @@ struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
 		if (codec_data->media_codec_type != lsep->codec)
 			continue;
 
+		/* Need also check for Vendor Specific Codec */
+		if (lsep->codec == A2DP_CODEC_VENDOR) {
+			a2dp_vendor_codec_t *vndcodec =
+						(void *) codec_data->data;
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
@@ -3349,6 +3365,13 @@ struct avdtp_local_sep *avdtp_register_sep(uint8_t type, uint8_t media_type,
 	return sep;
 }
 
+void avdtp_sep_set_vendor_codec(struct avdtp_local_sep *sep, uint32_t vendor_id,
+							uint16_t codec_id)
+{
+	sep->vndcodec_vendor = vendor_id;
+	sep->vndcodec_codec = codec_id;
+}
+
 int avdtp_unregister_sep(struct avdtp_local_sep *sep)
 {
 	if (!sep)
diff --git a/android/avdtp.h b/android/avdtp.h
index 7fdf597..9d683c4 100644
--- a/android/avdtp.h
+++ b/android/avdtp.h
@@ -268,6 +268,8 @@ struct avdtp_local_sep *avdtp_register_sep(uint8_t type, uint8_t media_type,
 						struct avdtp_sep_ind *ind,
 						struct avdtp_sep_cfm *cfm,
 						void *user_data);
+void avdtp_sep_set_vendor_codec(struct avdtp_local_sep *sep, uint32_t vendor_id,
+							uint16_t codec_id);
 
 /* Find a matching pair of local and remote SEP ID's */
 struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
-- 
1.9.3

