Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v3 04/22] monitor/avdtp: Decode AVDTP_GET_CAPABILITIES
Date: Sun, 22 Nov 2015 21:20:16 +0100
Message-Id: <1448223634-23305-5-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< ACL Data TX: Handle 256 flags 0x00 dlen 7
      Channel: 258 len 3 [PSM 25 mode 0] {chan 2}
      AVDTP: Get Capabilities (0x02) Command (0x00) type 0x00 label 1 nosp 0
        ACP SEID: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 20
      Channel: 66 len 16 [PSM 25 mode 0] {chan 2}
      AVDTP: Get Capabilities (0x02) Response Accept (0x02) type 0x00 label 1 nosp 0
        Service Category: Media Transport (0x01)
        Service Category: Media Codec (0x07)
        00 00 3f ff 02 35                                ..?..5
        Service Category: Content Protection (0x04)
        02 00                                            ..
---
 monitor/avdtp.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index 610bff5..065e79a 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -59,6 +59,16 @@
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
 	uint8_t sig_id;
@@ -171,6 +181,30 @@ static const char *mediatype2str(uint8_t media_type)
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
@@ -184,6 +218,32 @@ static bool avdtp_reject_common(struct avdtp_frame *avdtp_frame)
 	return true;
 }
 
+static bool decode_capabilities(struct avdtp_frame *avdtp_frame)
+{
+	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
+	uint8_t service_cat;
+	uint8_t losc;
+
+	while (l2cap_frame_get_u8(frame, &service_cat)) {
+		print_field("Service Category: %s (0x%02x)",
+				servicecat2str(service_cat), service_cat);
+
+		if (!l2cap_frame_get_u8(frame, &losc))
+			return false;
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
@@ -217,6 +277,29 @@ static bool avdtp_discover(struct avdtp_frame *avdtp_frame)
 	return false;
 }
 
+static bool avdtp_get_capabilities(struct avdtp_frame *avdtp_frame)
+{
+	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
+	uint8_t type = avdtp_frame->hdr & 0x03;
+	uint8_t seid;
+
+	switch (type) {
+	case AVDTP_MSG_TYPE_COMMAND:
+		if (!l2cap_frame_get_u8(frame, &seid))
+			return false;
+
+		print_field("ACP SEID: %d", seid >> 2);
+
+		return true;
+	case AVDTP_MSG_TYPE_RESPONSE_ACCEPT:
+		return decode_capabilities(avdtp_frame);
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
@@ -274,6 +357,8 @@ static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 	switch (sig_id) {
 	case AVDTP_DISCOVER:
 		return avdtp_discover(avdtp_frame);
+	case AVDTP_GET_CAPABILITIES:
+		return avdtp_get_capabilities(avdtp_frame);
 	}
 
 	packet_hexdump(frame->data, frame->size);
-- 
2.6.2

