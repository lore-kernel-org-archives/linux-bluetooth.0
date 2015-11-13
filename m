Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 1/3] tools/avinfo: Add partial support for Sony LDAC
Date: Fri, 13 Nov 2015 11:59:39 +0100
Message-Id: <1447412381-6208-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Contents of Vendor Specific Value in codec information is unknown at
the moment so only raw value is printed.
---
 profiles/audio/a2dp-codecs.h |  8 ++++++++
 tools/avinfo.c               | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index 4d2584d..e9da0bf 100644
--- a/profiles/audio/a2dp-codecs.h
+++ b/profiles/audio/a2dp-codecs.h
@@ -141,6 +141,9 @@
 #define APTX_SAMPLING_FREQ_44100	0x02
 #define APTX_SAMPLING_FREQ_48000	0x01
 
+#define LDAC_VENDOR_ID			0x0000012d
+#define LDAC_CODEC_ID			0x00aa
+
 typedef struct {
 	uint32_t vendor_id;
 	uint16_t codec_id;
@@ -186,6 +189,11 @@ typedef struct {
 	uint8_t frequency:4;
 } __attribute__ ((packed)) a2dp_aptx_t;
 
+typedef struct {
+	a2dp_vendor_codec_t info;
+	uint8_t unknown[2];
+} __attribute__ ((packed)) a2dp_ldac_t;
+
 #elif __BYTE_ORDER == __BIG_ENDIAN
 
 typedef struct {
diff --git a/tools/avinfo.c b/tools/avinfo.c
index 3f406ca..cc756f1 100644
--- a/tools/avinfo.c
+++ b/tools/avinfo.c
@@ -181,6 +181,16 @@ static void print_aptx(a2dp_aptx_t *aptx)
 	printf("\n");
 }
 
+static void print_ldac(a2dp_ldac_t *ldac)
+{
+	printf("\t\tVendor Specific Value (LDAC)");
+
+	printf("\n\t\t\tUnknown: %02x %02x", ldac->unknown[0],
+							ldac->unknown[1]);
+
+	printf("\n");
+}
+
 static void print_vendor(a2dp_vendor_codec_t *vendor)
 {
 	uint32_t vendor_id = btohl(vendor->vendor_id);
@@ -194,6 +204,8 @@ static void print_vendor(a2dp_vendor_codec_t *vendor)
 
 	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID)
 		print_aptx((void *) vendor);
+	else if (vendor_id == LDAC_VENDOR_ID && codec_id == LDAC_CODEC_ID)
+		print_ldac((void *) vendor);
 }
 
 static void print_mpeg24(a2dp_aac_t *aac)
-- 
2.6.2

