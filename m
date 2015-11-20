Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v2 16/22] monitor/avdtp: Decode basic Media Codec capabilities
Date: Fri, 20 Nov 2015 15:13:34 +0100
Message-Id: <1448028820-25330-17-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1448028820-25330-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1448028820-25330-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
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
        02 00                                            ..
---
 monitor/avdtp.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index a4ff421..2e94558 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -175,6 +175,24 @@ static const char *mediatype2str(uint8_t media_type)
 	}
 }
 
+static const char *mediacodec2str(uint8_t codec)
+{
+	switch (codec) {
+	case 0x00:
+		return "SBC";
+	case 0x01:
+		return "MPEG-1,2 Audio";
+	case 0x02:
+		return "MPEG-2,4 AAC";
+	case 0x04:
+		return "ATRAC Family";
+	case 0xff:
+		return "Non-A2DP";
+	default:
+		return "Reserved";
+	}
+}
+
 static const char *servicecat2str(uint8_t service_cat)
 {
 	switch (service_cat) {
@@ -212,6 +230,34 @@ static bool avdtp_reject_common(struct avdtp_frame *avdtp_frame)
 	return true;
 }
 
+static bool service_media_codec(struct avdtp_frame *avdtp_frame, uint8_t losc)
+{
+	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
+	uint8_t type = 0;
+	uint8_t codec = 0;
+
+	if (losc < 2)
+		return false;
+
+	l2cap_frame_get_u8(frame, &type);
+	l2cap_frame_get_u8(frame, &codec);
+
+	losc -= 2;
+
+	print_field("%*cMedia Type: %s (0x%02x)", 2, ' ',
+					mediatype2str(type >> 4), type >> 4);
+
+	print_field("%*cMedia Codec: %s (0x%02x)", 2, ' ',
+					mediacodec2str(codec), codec);
+
+	/* TODO: decode codec specific information */
+
+	packet_hexdump(frame->data, losc);
+	l2cap_frame_pull(frame, frame, losc);
+
+	return true;
+}
+
 static bool decode_capabilities(struct avdtp_frame *avdtp_frame)
 {
 	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
@@ -232,11 +278,23 @@ static bool decode_capabilities(struct avdtp_frame *avdtp_frame)
 		if (frame->size < losc)
 			return false;
 
-		/* TODO: decode service capabilities */
-
-		packet_hexdump(frame->data, losc);
+		switch (service_cat) {
+		case AVDTP_MEDIA_CODEC:
+			if (!service_media_codec(avdtp_frame, losc))
+				return false;
+			break;
+		case AVDTP_MEDIA_TRANSPORT:
+		case AVDTP_REPORTING:
+		case AVDTP_RECOVERY:
+		case AVDTP_CONTENT_PROTECTION:
+		case AVDTP_HEADER_COMPRESSION:
+		case AVDTP_MULTIPLEXING:
+		case AVDTP_DELAY_REPORTING:
+		default:
+			packet_hexdump(frame->data, losc);
+			l2cap_frame_pull(frame, frame, losc);
+		}
 
-		l2cap_frame_pull(frame, frame, losc);
 	}
 
 	return true;
-- 
2.6.2

