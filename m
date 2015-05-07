Return-Path: <cyrus@holtmann.org>
From: Rakesh M K <rakesh.mk@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rakesh M K <rakesh.mk@samsung.com>
Subject: [PATCH 1/1] Audio/A2DP: Fix SEP selection
Date: Thu, 07 May 2015 18:10:25 +0530
Message-id: <1431002425-1332-1-git-send-email-rakesh.mk@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When matching remote SEP to local SEP we do not match vendor codecs
properly, i.e. neither vendor ID nor codec ID are checked, which may
cause wrong endpoint to be selected in case there are more than one
endpoints using vendor codec on remote.

This patch fixes this by assinging vendor codec indentification to
local SEP after it's registered and uses this information when matching
SEPs.

This Patch is based on upstream android patch
e1c7dddd0dd2f5e23e4d4cf98a9dde713fe6dd53
---
 profiles/audio/a2dp.c  |    5 +++++
 profiles/audio/avdtp.c |   21 +++++++++++++++++++++
 profiles/audio/avdtp.h |    3 +++
 profiles/audio/media.c |   10 ++++++++++
 4 files changed, 39 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 31c5086..7cdc1f2 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2174,6 +2174,11 @@ struct avdtp_stream *a2dp_sep_get_stream(struct a2dp_sep *sep)
 	return sep->stream;
 }
 
+struct avdtp_local_sep *a2dp_sep_get_local_sep(struct a2dp_sep *sep)
+{
+	return sep->lsep;
+}
+
 struct btd_device *a2dp_setup_get_device(struct a2dp_setup *setup)
 {
 	if (setup->session == NULL)
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index f38188f..738816c 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -51,6 +51,7 @@
 #include "avdtp.h"
 #include "sink.h"
 #include "source.h"
+#include "a2dp-codecs.h"
 
 #define AVDTP_PSM 25
 
@@ -328,6 +329,8 @@ struct avdtp_local_sep {
 	struct avdtp_stream *stream;
 	struct seid_info info;
 	uint8_t codec;
+	uint32_t vndcodec_vendor;
+	uint16_t vndcodec_codec;
 	gboolean delay_reporting;
 	GSList *caps;
 	struct avdtp_sep_ind *ind;
@@ -1226,6 +1229,16 @@ struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
 		if (codec_data->media_codec_type != lsep->codec)
 			continue;
 
+		if (lsep->codec == A2DP_CODEC_VENDOR) {
+			a2dp_vendor_codec_t *vndcodec =
+				(void *) codec_data->data;
+
+			if (btohl(vndcodec->vendor_id) != lsep->vndcodec_vendor)
+				continue;
+			if (btohs(vndcodec->codec_id) != lsep->vndcodec_codec)
+				continue;
+		}
+
 		if (sep->stream == NULL)
 			return sep;
 	}
@@ -3552,6 +3565,14 @@ struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
 	return sep;
 }
 
+void avdtp_sep_set_vendor_codec(struct avdtp_local_sep *sep,
+						uint32_t vendor_id,
+						uint16_t codec_id)
+{
+	sep->vndcodec_vendor = vendor_id;
+	sep->vndcodec_codec = codec_id;
+}
+
 int avdtp_unregister_sep(struct queue *lseps, struct avdtp_local_sep *sep)
 {
 	if (!sep)
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 1b02232..52294c9 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -297,3 +297,6 @@ struct avdtp_server *avdtp_get_server(struct avdtp_local_sep *lsep);
 
 struct avdtp *avdtp_new(GIOChannel *chan, struct btd_device *device,
 							struct queue *lseps);
+void avdtp_sep_set_vendor_codec(struct avdtp_local_sep *sep,
+						uint32_t vendor_id,
+						uint16_t codec_id);
\ No newline at end of file
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index f12569e..fa9a7e8 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -54,6 +54,7 @@
 #include "transport.h"
 #include "a2dp.h"
 #include "avrcp.h"
+#include "a2dp-codecs.h"
 
 #define MEDIA_INTERFACE "org.bluez.Media1"
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
@@ -777,6 +778,15 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 						NULL);
 	}
 
+	if (endpoint->codec == A2DP_CODEC_VENDOR) {
+		a2dp_vendor_codec_t *vndcodec = (void *) endpoint->capabilities;
+		struct avdtp_local_sep * lsep = a2dp_sep_get_local_sep(
+								endpoint->sep);
+
+		avdtp_sep_set_vendor_codec(lsep, btohl(vndcodec->vendor_id),
+						btohs(vndcodec->codec_id));
+	}
+
 	adapter->endpoints = g_slist_append(adapter->endpoints, endpoint);
 	info("Endpoint registered: sender=%s path=%s", sender, path);
 
-- 
1.7.9.5

