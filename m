Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 04/22] monitor/avdtp: Decode AVDTP_GET_CAPABILITIES
Date: Sat, 14 Nov 2015 14:44:21 +0100
Message-Id: <1447508679-21798-5-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/avdtp.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index f851107..cae704a 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -53,6 +53,16 @@
 #define AVDTP_GET_ALL_CAPABILITIES	0x0c
 #define AVDTP_DELAYREPORT		0x0d
 
+/* Service Categories */
+#define AVDTP_MEDIA_TRANSPORT		0x01
+#define AVDTP_REPORTING			0x02
+#define AVDTP_RECOVERY			0x03
+#define AVDTP_CONTENT_PROTECTION	0x04
+#define AVDTP_HEADER_COMPRESSION	0x05
+#define AVDTP_MULTIPLEXING		0x06
+#define AVDTP_MEDIA_CODEC		0x07
+#define AVDTP_DELAY_REPORTING		0x08
+
 struct avdtp_frame {
 	uint8_t hdr;
 	struct l2cap_frame l2cap_frame;
@@ -164,6 +174,30 @@ static const char *mediatype2str(uint8_t media_type)
 	}
 }
 
+static const char *servicecat2str(uint8_t service_cat)
+{
+	switch (service_cat) {
+	case AVDTP_MEDIA_TRANSPORT:
+		return "Media Transport";
+	case AVDTP_REPORTING:
+		return "Reporting";
+	case AVDTP_RECOVERY:
+		return "Recovery";
+	case AVDTP_CONTENT_PROTECTION:
+		return "Content Protection";
+	case AVDTP_HEADER_COMPRESSION:
+		return "Header Compression";
+	case AVDTP_MULTIPLEXING:
+		return "Multiplexing";
+	case AVDTP_MEDIA_CODEC:
+		return "Media Codec";
+	case AVDTP_DELAY_REPORTING:
+		return "Delay Reporting";
+	default:
+		return "Reserved";
+	}
+}
+
 static bool avdtp_reject_common(struct avdtp_frame *avdtp_frame)
 {
 	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
@@ -177,6 +211,36 @@ static bool avdtp_reject_common(struct avdtp_frame *avdtp_frame)
 	return true;
 }
 
+static bool decode_capabilities(struct avdtp_frame *avdtp_frame)
+{
+	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
+
+	for (;;) {
+		uint8_t service_cat;
+		uint8_t losc;
+
+		if (!l2cap_frame_get_u8(frame, &service_cat))
+			break;
+
+		if (!l2cap_frame_get_u8(frame, &losc))
+			return false;
+
+		print_field("Service Category: %s",
+						servicecat2str(service_cat));
+
+		if (frame->size < losc)
+			return false;
+
+		/* TODO: decode service capabilities */
+
+		packet_hexdump(frame->data, losc);
+
+		l2cap_frame_pull(frame, frame, losc);
+	}
+
+	return true;
+}
+
 static bool avdtp_discover(struct avdtp_frame *avdtp_frame)
 {
 	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
@@ -216,6 +280,31 @@ response:
 	return true;
 }
 
+static bool avdtp_get_capabilities(struct avdtp_frame *avdtp_frame)
+{
+	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
+	uint8_t seid;
+
+	if (avdtp_frame->hdr & 0x01)
+		goto reject;
+
+	if (avdtp_frame->hdr & 0x02)
+		goto response;
+
+	if (!l2cap_frame_get_u8(frame, &seid))
+		return false;
+
+	print_field("ACP SEID: %d", seid >> 2);
+
+	return true;
+
+reject:
+	return avdtp_reject_common(avdtp_frame);
+
+response:
+	return decode_capabilities(avdtp_frame);
+}
+
 static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 {
 	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
@@ -273,6 +362,9 @@ static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 	case AVDTP_DISCOVER:
 		ret = avdtp_discover(avdtp_frame);
 		break;
+	case AVDTP_GET_CAPABILITIES:
+		ret = avdtp_get_capabilities(avdtp_frame);
+		break;
 	default:
 		packet_hexdump(frame->data, frame->size);
 		ret = true;
-- 
2.6.2

