Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 03/22] monitor/avdtp: Decode AVDTP_DISCOVER
Date: Sat, 14 Nov 2015 14:44:20 +0100
Message-Id: <1447508679-21798-4-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/avdtp.c | 133 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 131 insertions(+), 2 deletions(-)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index 209bbab..f851107 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -108,6 +108,114 @@ static const char *sigid2str(uint8_t sigid)
 	}
 }
 
+static const char *error2str(uint8_t error)
+{
+	switch (error) {
+	case 0x01:
+		return "BAD_HEADER_FORMAT";
+	case 0x11:
+		return "BAD_LENGTH";
+	case 0x12:
+		return "BAD_ACP_SEID";
+	case 0x13:
+		return "SEP_IN_USE";
+	case 0x14:
+		return "SEP_NOT_IN_USER";
+	case 0x17:
+		return "BAD_SERV_CATEGORY";
+	case 0x18:
+		return "BAD_PAYLOAD_FORMAT";
+	case 0x19:
+		return "NOT_SUPPORTED_COMMAND";
+	case 0x1a:
+		return "INVALID_CAPABILITIES";
+	case 0x22:
+		return "BAD_RECOVERY_TYPE";
+	case 0x23:
+		return "BAD_MEDIA_TRANSPORT_FORMAT";
+	case 0x25:
+		return "BAD_RECOVERY_FORMAT";
+	case 0x26:
+		return "BAD_ROHC_FORMAT";
+	case 0x27:
+		return "BAD_CP_FORMAT";
+	case 0x28:
+		return "BAD_MULTIPLEXING_FORMAT";
+	case 0x29:
+		return "UNSUPPORTED_CONFIGURATION";
+	case 0x31:
+		return "BAD_STATE";
+	default:
+		return "Unknown";
+	}
+}
+
+static const char *mediatype2str(uint8_t media_type)
+{
+	switch (media_type) {
+	case 0x00:
+		return "Audio";
+	case 0x01:
+		return "Video";
+	case 0x02:
+		return "Multimedia";
+	default:
+		return "Reserver";
+	}
+}
+
+static bool avdtp_reject_common(struct avdtp_frame *avdtp_frame)
+{
+	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
+	uint8_t error;
+
+	if (!l2cap_frame_get_u8(frame, &error))
+		return false;
+
+	print_field("Error code: %s (0x%02x)", error2str(error), error);
+
+	return true;
+}
+
+static bool avdtp_discover(struct avdtp_frame *avdtp_frame)
+{
+	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
+
+	if (avdtp_frame->hdr & 0x01)
+		goto reject;
+
+	if (avdtp_frame->hdr & 0x02)
+		goto response;
+
+	/* no extra parameters */
+	return true;
+
+reject:
+	return avdtp_reject_common(avdtp_frame);
+
+response:
+	for (;;) {
+		uint8_t seid;
+		uint8_t info;
+
+		if (!l2cap_frame_get_u8(frame, &seid))
+			break;
+
+		if (!l2cap_frame_get_u8(frame, &info))
+			return false;
+
+		print_field("ACP SEID %d", seid >> 2);
+		print_field("%*cMedia Type: %s", 2, ' ',
+						mediatype2str(info >> 4));
+		print_field("%*cSEP Type: %s", 2, ' ',
+						info & 0x04 ? "SNK" : "SRC");
+		print_field("%*cIn use: %s", 2, ' ',
+						seid & 0x02 ? "Yes" : "No");
+	}
+
+	return true;
+}
+
 static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 {
 	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
@@ -115,6 +223,7 @@ static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 	uint8_t hdr;
 	uint8_t nosp = 0;
 	uint8_t sigid;
+	bool ret;
 
 	if (frame->in)
 		pdu_color = COLOR_MAGENTA;
@@ -149,8 +258,28 @@ static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 				sigid, msgtype2str(hdr & 0x03),
 				hdr & 0x0c, hdr >> 4, nosp);
 
-	packet_hexdump(frame->data, frame->size);
-	return true;
+	/* Start Packet */
+	if ((hdr & 0x0c) == 0x04) {
+		/* TODO: handle fragmentation */
+		packet_hexdump(frame->data, frame->size);
+		return true;
+	}
+
+	/* General Reject */
+	if ((hdr & 0x03) == 0x03)
+		return true;
+
+	switch (sigid) {
+	case AVDTP_DISCOVER:
+		ret = avdtp_discover(avdtp_frame);
+		break;
+	default:
+		packet_hexdump(frame->data, frame->size);
+		ret = true;
+		break;
+	}
+
+	return ret;
 }
 
 void avdtp_packet(const struct l2cap_frame *frame)
-- 
2.6.2

