Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] audio: Add check for vendor specific A2DP codec
Date: Mon, 08 Oct 2012 18:30:52 +0900
Message-id: <1349688653-20335-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

This patch adds checks(vendor ID, vendor specific codec ID) to make sure of
vendor specific A2DP codec selection.
---
 audio/a2dp-codecs.h |    6 +++++
 audio/a2dp.c        |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/audio/a2dp-codecs.h b/audio/a2dp-codecs.h
index 51c796a..42ae2e1 100644
--- a/audio/a2dp-codecs.h
+++ b/audio/a2dp-codecs.h
@@ -26,6 +26,7 @@
 #define A2DP_CODEC_MPEG12		0x01
 #define A2DP_CODEC_MPEG24		0x02
 #define A2DP_CODEC_ATRAC		0x03
+#define A2DP_CODEC_VENDOR		0xFF
 
 #define SBC_SAMPLING_FREQ_16000		(1 << 3)
 #define SBC_SAMPLING_FREQ_32000		(1 << 2)
@@ -114,3 +115,8 @@ typedef struct {
 #else
 #error "Unknown byte order"
 #endif
+
+typedef struct {
+	uint8_t vendor_id[4];
+	uint8_t codec_id[2];
+} __attribute__ ((packed)) non_a2dp_vendor_codec_t;
diff --git a/audio/a2dp.c b/audio/a2dp.c
index fd1c494..8b3c0f9 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -44,6 +44,7 @@
 #include "sink.h"
 #include "source.h"
 #include "a2dp.h"
+#include "a2dp-codecs.h"
 #include "sdpd.h"
 
 /* The duration that streams without users are allowed to stay in
@@ -1427,11 +1428,62 @@ done:
 	finalize_select(setup);
 }
 
+static gboolean vendor_codec_is_matched(uint8_t *remote_cap,
+				size_t remote_cap_len, struct a2dp_sep *sep)
+{
+	uint8_t *capabilities;
+	size_t	length;
+
+	non_a2dp_vendor_codec_t *local_codec;
+	non_a2dp_vendor_codec_t *remote_codec;
+
+	if (remote_cap_len < sizeof(non_a2dp_vendor_codec_t))
+		return FALSE;
+
+	remote_codec = (non_a2dp_vendor_codec_t *) remote_cap;
+
+	DBG("Remote vendor 0x%02x%02x%02x%02x codec 0x%02x%02x",
+			remote_codec->vendor_id[0], remote_codec->vendor_id[1],
+			remote_codec->vendor_id[2], remote_codec->vendor_id[3],
+			remote_codec->codec_id[0], remote_codec->codec_id[1]);
+
+	if (sep->endpoint == NULL)
+		return FALSE;
+
+	length = sep->endpoint->get_capabilities(sep,
+				&capabilities, sep->user_data);
+
+	if (length < sizeof(non_a2dp_vendor_codec_t))
+		return FALSE;
+
+	local_codec = (non_a2dp_vendor_codec_t *) capabilities;
+
+	DBG("Registered vendor 0x%02x%02x%02x%02x codec 0x%02x%02x",
+			local_codec->vendor_id[0], local_codec->vendor_id[1],
+			local_codec->vendor_id[2], local_codec->vendor_id[3],
+			local_codec->codec_id[0], local_codec->codec_id[1]);
+
+	if (memcmp(remote_codec->vendor_id, local_codec->vendor_id,
+					sizeof(local_codec->vendor_id)))
+		return FALSE;
+
+	if (memcmp(remote_codec->codec_id, local_codec->codec_id,
+					sizeof(local_codec->codec_id)))
+		return FALSE;
+
+	DBG("Vendor Codec info is matched");
+
+	return TRUE;
+}
+
 static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *list,
 					const char *sender)
 {
 	for (; list; list = list->next) {
 		struct a2dp_sep *sep = list->data;
+		struct avdtp_remote_sep *rsep;
+		struct avdtp_media_codec_capability *rsep_codec;
+		struct avdtp_service_capability *service;
 
 		/* Use sender's endpoint if available */
 		if (sender) {
@@ -1445,7 +1497,17 @@ static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *list,
 				continue;
 		}
 
-		if (avdtp_find_remote_sep(session, sep->lsep) == NULL)
+		rsep = avdtp_find_remote_sep(session, sep->lsep);
+		if (rsep == NULL)
+			continue;
+
+		service = avdtp_get_codec(rsep);
+		rsep_codec = (struct avdtp_media_codec_capability *)
+								service->data;
+
+		if (rsep_codec->media_codec_type == A2DP_CODEC_VENDOR &&
+			!vendor_codec_is_matched(rsep_codec->data,
+				service->length - sizeof(*rsep_codec), sep))
 			continue;
 
 		return sep;
-- 
1.7.9.5

