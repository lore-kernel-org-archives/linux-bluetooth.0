Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v3 17/22] monitor/avdtp: Decode basic Content Protection capabilities
Date: Sun, 22 Nov 2015 21:20:29 +0100
Message-Id: <1448223634-23305-18-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> ACL Data RX: Handle 256 flags 0x02 dlen 20
      Channel: 66 len 16 [PSM 25 mode 0] {chan 2}
      AVDTP: Get Capabilities (0x02) Response Accept (0x02) type 0x00 label 1 nosp 0
        Service Category: Media Transport (0x01)
        Service Category: Media Codec (0x07)
          Media Type: Audio (0x00)
          Media Codec: SBC (0x00)
        3f ff 02 35                                      ?..5
        Service Category: Content Protection (0x04)
          Content Protection Type: SCMS-T (0x0002)
---
 monitor/avdtp.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index 8041d35..f810f0e 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -199,6 +199,18 @@ static const char *mediacodec2str(uint8_t codec)
 	}
 }
 
+static const char *cptype2str(uint8_t cp)
+{
+	switch (cp) {
+	case 0x0001:
+		return "DTCP";
+	case 0x0002:
+		return "SCMS-T";
+	default:
+		return "Reserved";
+	}
+}
+
 static const char *servicecat2str(uint8_t service_cat)
 {
 	switch (service_cat) {
@@ -236,6 +248,31 @@ static bool avdtp_reject_common(struct avdtp_frame *avdtp_frame)
 	return true;
 }
 
+static bool service_content_protection(struct avdtp_frame *avdtp_frame,
+								uint8_t losc)
+{
+	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
+	uint16_t type = 0;
+
+	if (losc < 2)
+		return false;
+
+	if (!l2cap_frame_get_le16(frame, &type))
+		return false;
+
+	losc -= 2;
+
+	print_field("%*cContent Protection Type: %s (0x%04x)", 2, ' ',
+							cptype2str(type), type);
+
+	/* TODO: decode protection specific information */
+	packet_hexdump(frame->data, losc);
+
+	l2cap_frame_pull(frame, frame, losc);
+
+	return true;
+}
+
 static bool service_media_codec(struct avdtp_frame *avdtp_frame, uint8_t losc)
 {
 	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
@@ -281,6 +318,10 @@ static bool decode_capabilities(struct avdtp_frame *avdtp_frame)
 			return false;
 
 		switch (service_cat) {
+		case AVDTP_CONTENT_PROTECTION:
+			if (!service_content_protection(avdtp_frame, losc))
+				return false;
+			break;
 		case AVDTP_MEDIA_CODEC:
 			if (!service_media_codec(avdtp_frame, losc))
 				return false;
@@ -288,7 +329,6 @@ static bool decode_capabilities(struct avdtp_frame *avdtp_frame)
 		case AVDTP_MEDIA_TRANSPORT:
 		case AVDTP_REPORTING:
 		case AVDTP_RECOVERY:
-		case AVDTP_CONTENT_PROTECTION:
 		case AVDTP_HEADER_COMPRESSION:
 		case AVDTP_MULTIPLEXING:
 		case AVDTP_DELAY_REPORTING:
-- 
2.6.2

