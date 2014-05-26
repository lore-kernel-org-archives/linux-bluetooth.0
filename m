Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 20/26] tools/avinfo: Decode aptX codec capabilities
Date: Mon, 26 May 2014 15:16:46 +0200
Message-ID: <1401110212-11526-21-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/avinfo.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/tools/avinfo.c b/tools/avinfo.c
index 7e9dfd1..7d58e25 100644
--- a/tools/avinfo.c
+++ b/tools/avinfo.c
@@ -158,14 +158,42 @@ struct getcap_resp {
 	uint8_t caps[0];
 } __attribute__ ((packed));
 
+static void print_aptx(a2dp_aptx_t *aptx)
+{
+	printf("\t\tVendor Specific Value (aptX)");
+
+	printf("\n\t\t\tFrequencies: ");
+	if (aptx->frequency & APTX_SAMPLING_FREQ_16000)
+		printf("16kHz ");
+	if (aptx->frequency & APTX_SAMPLING_FREQ_32000)
+		printf("32kHz ");
+	if (aptx->frequency & APTX_SAMPLING_FREQ_44100)
+		printf("44.1kHz ");
+	if (aptx->frequency & APTX_SAMPLING_FREQ_48000)
+		printf("48kHz ");
+
+	printf("\n\t\t\tChannel modes: ");
+	if (aptx->channel_mode & APTX_CHANNEL_MODE_MONO)
+		printf("Mono ");
+	if (aptx->channel_mode & APTX_CHANNEL_MODE_STEREO)
+		printf("Stereo ");
+
+	printf("\n");
+}
+
 static void print_vendor(a2dp_vendor_codec_t *vendor)
 {
+	uint32_t vendor_id = btohl(vendor->vendor_id);
+	uint16_t codec_id = btohs(vendor->codec_id);
+
 	printf("\tMedia Codec: Vendor Specific A2DP Codec");
 
-	printf("\n\t\tVendor ID 0x%08x", btohl(vendor->vendor_id));
+	printf("\n\t\tVendor ID 0x%08x", vendor_id);
+
+	printf("\n\t\tVendor Specific Codec ID 0x%04x\n", codec_id);
 
-	printf("\n\t\tVendor Specific Codec ID 0x%04x\n",
-						btohs(vendor->codec_id));
+	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID)
+		print_aptx((void *) vendor);
 }
 
 static void print_mpeg24(a2dp_aac_t *aac)
-- 
1.9.3

