Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/5] avinfo: Print a2dp vendor codec info
Date: Tue, 09 Oct 2012 20:35:46 +0900
Message-id: <1349782548-27923-3-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1349782548-27923-1-git-send-email-chanyeol.park@samsung.com>
References: <1349782548-27923-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

---
 tools/avinfo.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/avinfo.c b/tools/avinfo.c
index 78a1544..f036cf8 100644
--- a/tools/avinfo.c
+++ b/tools/avinfo.c
@@ -158,6 +158,18 @@ struct getcap_resp {
 	uint8_t caps[0];
 } __attribute__ ((packed));
 
+static void print_vendor(a2dp_vendor_codec_t *vendor)
+{
+	printf("\tMedia Codec: Vendor Specific A2DP Codec");
+
+	printf("\n\t\tVendor ID 0x%02x%02x%02x%02x", vendor->vendor_id[0],
+		vendor->vendor_id[1], vendor->vendor_id[2],
+		vendor->vendor_id[3]);
+
+	printf("\n\t\tVendor Specific Codec ID 0x%02x%02x\n",
+			vendor->codec_id[0], vendor->codec_id[1]);
+}
+
 
 static void print_mpeg12(a2dp_mpeg_t *mpeg)
 {
@@ -292,6 +304,9 @@ static void print_media_codec(struct avdtp_media_codec_capability *cap)
 	case A2DP_CODEC_MPEG12:
 		print_mpeg12((void *) cap->data);
 		break;
+	case A2DP_CODEC_VENDOR:
+		print_vendor((void *) cap->data);
+		break;
 	default:
 		printf("\tMedia Codec: Unknown\n");
 	}
-- 
1.7.9.5

