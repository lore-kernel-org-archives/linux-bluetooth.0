Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 12/26] audio: Fix a2dp_vendor_codec_t declaration
Date: Mon, 26 May 2014 15:16:38 +0200
Message-ID: <1401110212-11526-13-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As per A2DP spec, both Vendor ID (4.7.2.1) and Codec ID (4.7.2.2) are
defined as 32-bit and 16-bit values respectively rather that array of
bytes. Also changing to uint types will make using these values in code
much easier.
---
 profiles/audio/a2dp-codecs.h |  4 ++--
 profiles/audio/a2dp.c        | 12 ++++--------
 tools/avinfo.c               |  8 +++-----
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index 3dc31cb..0f44b10 100644
--- a/profiles/audio/a2dp-codecs.h
+++ b/profiles/audio/a2dp-codecs.h
@@ -134,6 +134,6 @@ typedef struct {
 #endif
 
 typedef struct {
-	uint8_t vendor_id[4];
-	uint8_t codec_id[2];
+	uint32_t vendor_id;
+	uint16_t codec_id;
 } __attribute__ ((packed)) a2dp_vendor_codec_t;
diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index cabdd66..c9dac9a 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1390,18 +1390,14 @@ static gboolean check_vendor_codec(struct a2dp_sep *sep, uint8_t *cap,
 
 	local_codec = (a2dp_vendor_codec_t *) capabilities;
 
-	if (memcmp(remote_codec->vendor_id, local_codec->vendor_id,
-					sizeof(local_codec->vendor_id)))
+	if (btohl(remote_codec->vendor_id) != btohl(local_codec->vendor_id))
 		return FALSE;
 
-	if (memcmp(remote_codec->codec_id, local_codec->codec_id,
-					sizeof(local_codec->codec_id)))
+	if (btohs(remote_codec->codec_id) != btohs(local_codec->codec_id))
 		return FALSE;
 
-	DBG("vendor 0x%02x%02x%02x%02x codec 0x%02x%02x",
-			remote_codec->vendor_id[0], remote_codec->vendor_id[1],
-			remote_codec->vendor_id[2], remote_codec->vendor_id[3],
-			remote_codec->codec_id[0], remote_codec->codec_id[1]);
+	DBG("vendor 0x%08x codec 0x%04x", btohl(remote_codec->vendor_id),
+						btohs(remote_codec->codec_id));
 
 	return TRUE;
 }
diff --git a/tools/avinfo.c b/tools/avinfo.c
index a4deaac..e7747db 100644
--- a/tools/avinfo.c
+++ b/tools/avinfo.c
@@ -162,12 +162,10 @@ static void print_vendor(a2dp_vendor_codec_t *vendor)
 {
 	printf("\tMedia Codec: Vendor Specific A2DP Codec");
 
-	printf("\n\t\tVendor ID 0x%02x%02x%02x%02x", vendor->vendor_id[0],
-		vendor->vendor_id[1], vendor->vendor_id[2],
-		vendor->vendor_id[3]);
+	printf("\n\t\tVendor ID 0x%08x", btohl(vendor->vendor_id));
 
-	printf("\n\t\tVendor Specific Codec ID 0x%02x%02x\n",
-			vendor->codec_id[0], vendor->codec_id[1]);
+	printf("\n\t\tVendor Specific Codec ID 0x%04x\n",
+						btohs(vendor->codec_id));
 }
 
 static void print_mpeg24(a2dp_mpeg_t *mpeg)
-- 
1.9.3

