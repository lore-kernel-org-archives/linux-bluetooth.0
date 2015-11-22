Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v3 03/22] monitor/avdtp: Decode AVDTP_DISCOVER
Date: Sun, 22 Nov 2015 21:20:15 +0100
Message-Id: <1448223634-23305-4-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< ACL Data TX: Handle 256 flags 0x00 dlen 6
      Channel: 258 len 2 [PSM 25 mode 0] {chan 2}
      AVDTP: Discover (0x01) Command (0x00) type 0x00 label 0 nosp 0
> ACL Data RX: Handle 256 flags 0x02 dlen 14
      Channel: 66 len 10 [PSM 25 mode 0] {chan 2}
      AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 0 nosp 0
        ACP SEID: 1
          Media Type: Audio (0x00)
          SEP Type: SRC (0x01)
          In use: No
        ACP SEID: 5
          Media Type: Audio (0x00)
          SEP Type: SRC (0x01)
          In use: No
        ACP SEID: 3
          Media Type: Audio (0x00)
          SEP Type: SRC (0x01)
          In use: No
        ACP SEID: 2
          Media Type: Audio (0x00)
          SEP Type: SRC (0x01)
          In use: No
---
 monitor/avdtp.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 1 deletion(-)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index 9d324bc..610bff5 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -38,6 +38,12 @@
 #include "l2cap.h"
 #include "avdtp.h"
 
+/* Message Types */
+#define AVDTP_MSG_TYPE_COMMAND		0x00
+#define AVDTP_MSG_TYPE_GENERAL_REJECT	0x01
+#define AVDTP_MSG_TYPE_RESPONSE_ACCEPT	0x02
+#define AVDTP_MSG_TYPE_RESPONSE_REJECT	0x03
+
 /* Signal Identifiers */
 #define AVDTP_DISCOVER			0x01
 #define AVDTP_GET_CAPABILITIES		0x02
@@ -109,6 +115,108 @@ static const char *sigid2str(uint8_t sigid)
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
+		return "Reserved";
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
+	uint8_t type = avdtp_frame->hdr & 0x03;
+	uint8_t seid;
+	uint8_t info;
+
+	switch (type) {
+	case AVDTP_MSG_TYPE_COMMAND:
+		return true;
+	case AVDTP_MSG_TYPE_RESPONSE_ACCEPT:
+		while (l2cap_frame_get_u8(frame, &seid)) {
+			print_field("ACP SEID: %d", seid >> 2);
+
+			if (!l2cap_frame_get_u8(frame, &info))
+				return false;
+
+			print_field("%*cMedia Type: %s (0x%02x)", 2, ' ',
+					mediatype2str(info >> 4), info >> 4);
+			print_field("%*cSEP Type: %s (0x%02x)", 2, ' ',
+						info & 0x04 ? "SNK" : "SRC",
+						(info >> 3) & 0x01);
+			print_field("%*cIn use: %s", 2, ' ',
+						seid & 0x02 ? "Yes" : "No");
+		}
+		return true;
+	case AVDTP_MSG_TYPE_RESPONSE_REJECT:
+		return avdtp_reject_common(avdtp_frame);
+	}
+
+	return false;
+}
+
 static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 {
 	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
@@ -163,9 +271,13 @@ static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 	if ((hdr & 0x03) == 0x03)
 		return true;
 
-	/* TODO: decode signalling messages */
+	switch (sig_id) {
+	case AVDTP_DISCOVER:
+		return avdtp_discover(avdtp_frame);
+	}
 
 	packet_hexdump(frame->data, frame->size);
+
 	return true;
 }
 
-- 
2.6.2

