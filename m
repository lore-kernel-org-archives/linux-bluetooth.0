Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 16/22] monitor/avdtp: Decode basic Media Codec capabilities
Date: Sat, 14 Nov 2015 14:44:33 +0100
Message-Id: <1447508679-21798-17-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/avdtp.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index e5bc13e..003134f 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -174,6 +174,24 @@ static const char *mediatype2str(uint8_t media_type)
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
@@ -211,6 +229,34 @@ static bool avdtp_reject_common(struct avdtp_frame *avdtp_frame)
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
+	print_field("%*cMedia Type: %s", 2, ' ',
+					mediatype2str(type >> 4));
+
+	print_field("%*cMedia Codec: %s", 2, ' ',
+					mediacodec2str(codec));
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
@@ -231,11 +277,23 @@ static bool decode_capabilities(struct avdtp_frame *avdtp_frame)
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

