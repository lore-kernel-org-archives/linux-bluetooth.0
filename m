Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 19/26] tools/avinfo: Decode MPEG-2,4 AAC codec capabilities
Date: Mon, 26 May 2014 15:16:45 +0200
Message-ID: <1401110212-11526-20-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/avinfo.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/tools/avinfo.c b/tools/avinfo.c
index e7747db..7e9dfd1 100644
--- a/tools/avinfo.c
+++ b/tools/avinfo.c
@@ -168,9 +168,57 @@ static void print_vendor(a2dp_vendor_codec_t *vendor)
 						btohs(vendor->codec_id));
 }
 
-static void print_mpeg24(a2dp_mpeg_t *mpeg)
+static void print_mpeg24(a2dp_aac_t *aac)
 {
-	printf("\tMedia Codec: MPEG24\n");
+	unsigned freq = AAC_GET_FREQUENCY(*aac);
+	unsigned bitrate = AAC_GET_BITRATE(*aac);
+
+	printf("\tMedia Codec: MPEG24\n\t\tObject Types: ");
+
+	if (aac->object_type & AAC_OBJECT_TYPE_MPEG2_AAC_LC)
+		printf("MPEG-2 AAC LC ");
+	if (aac->object_type & AAC_OBJECT_TYPE_MPEG4_AAC_LC)
+		printf("MPEG-4 AAC LC ");
+	if (aac->object_type & AAC_OBJECT_TYPE_MPEG4_AAC_LTP)
+		printf("MPEG-4 AAC LTP ");
+	if (aac->object_type & AAC_OBJECT_TYPE_MPEG4_AAC_SCA)
+		printf("MPEG-4 AAC scalable ");
+
+	printf("\n\t\tFrequencies: ");
+	if (freq & AAC_SAMPLING_FREQ_8000)
+		printf("8kHz ");
+	if (freq & AAC_SAMPLING_FREQ_11025)
+		printf("11.025kHz ");
+	if (freq & AAC_SAMPLING_FREQ_12000)
+		printf("12kHz ");
+	if (freq & AAC_SAMPLING_FREQ_16000)
+		printf("16kHz ");
+	if (freq & AAC_SAMPLING_FREQ_22050)
+		printf("22.05kHz ");
+	if (freq & AAC_SAMPLING_FREQ_24000)
+		printf("24kHz ");
+	if (freq & AAC_SAMPLING_FREQ_32000)
+		printf("32kHz ");
+	if (freq & AAC_SAMPLING_FREQ_44100)
+		printf("44.1kHz ");
+	if (freq & AAC_SAMPLING_FREQ_48000)
+		printf("48kHz ");
+	if (freq & AAC_SAMPLING_FREQ_64000)
+		printf("64kHz ");
+	if (freq & AAC_SAMPLING_FREQ_88200)
+		printf("88.2kHz ");
+	if (freq & AAC_SAMPLING_FREQ_96000)
+		printf("96kHz ");
+
+	printf("\n\t\tChannels: ");
+	if (aac->channels & AAC_CHANNELS_1)
+		printf("1 ");
+	if (aac->channels & AAC_CHANNELS_2)
+		printf("2 ");
+
+	printf("\n\t\tBitrate: %u", bitrate);
+
+	printf("\n\t\tVBR: %s", aac->vbr ? "Yes\n" : "No\n");
 }
 
 static void print_mpeg12(a2dp_mpeg_t *mpeg)
-- 
1.9.3

