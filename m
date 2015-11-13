Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 2/3] tools/avinfo: Print content protection
Date: Fri, 13 Nov 2015 11:59:40 +0100
Message-Id: <1447412381-6208-2-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1447412381-6208-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1447412381-6208-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/avinfo.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/avinfo.c b/tools/avinfo.c
index cc756f1..31c4e10 100644
--- a/tools/avinfo.c
+++ b/tools/avinfo.c
@@ -74,6 +74,10 @@
 #define AVDTP_MEDIA_TYPE_VIDEO		0x01
 #define AVDTP_MEDIA_TYPE_MULTIMEDIA	0x02
 
+/* Content Protection types definitions */
+#define AVDTP_CONTENT_PROTECTION_TYPE_DTCP	0x0001
+#define AVDTP_CONTENT_PROTECTION_TYPE_SCMS_T	0x0002
+
 struct avdtp_service_capability {
 	uint8_t category;
 	uint8_t length;
@@ -158,6 +162,11 @@ struct getcap_resp {
 	uint8_t caps[0];
 } __attribute__ ((packed));
 
+struct avdtp_content_protection_capability {
+	uint16_t content_protection_type;
+	uint8_t data[0];
+} __attribute__ ((packed));
+
 static void print_aptx(a2dp_aptx_t *aptx)
 {
 	printf("\t\tVendor Specific Value (aptX)");
@@ -405,6 +414,25 @@ static void print_media_codec(struct avdtp_media_codec_capability *cap)
 	}
 }
 
+static void print_content_protection(
+				struct avdtp_content_protection_capability *cap)
+{
+	printf("\tContent Protection: ");
+
+	switch (btohs(cap->content_protection_type)) {
+	case AVDTP_CONTENT_PROTECTION_TYPE_DTCP:
+		printf("DTCP");
+		break;
+	case AVDTP_CONTENT_PROTECTION_TYPE_SCMS_T:
+		printf("SCMS-T");
+		break;
+	default:
+		printf("Unknown");
+	}
+
+	printf("\n");
+}
+
 static void print_caps(void *data, int size)
 {
 	int processed;
@@ -423,13 +451,15 @@ static void print_caps(void *data, int size)
 		case AVDTP_MEDIA_TRANSPORT:
 		case AVDTP_REPORTING:
 		case AVDTP_RECOVERY:
-		case AVDTP_CONTENT_PROTECTION:
 		case AVDTP_MULTIPLEXING:
 			/* FIXME: Add proper functions */
 			break;
 		case AVDTP_MEDIA_CODEC:
 			print_media_codec((void *) cap->data);
 			break;
+		case AVDTP_CONTENT_PROTECTION:
+			print_content_protection((void *) cap->data);
+			break;
 		}
 
 		processed += 2 + cap->length;
-- 
2.6.2

