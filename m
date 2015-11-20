Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v2 05/22] monitor/avdtp: Decode AVDTP_SET_CONFIGURATION
Date: Fri, 20 Nov 2015 15:13:23 +0100
Message-Id: <1448028820-25330-6-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1448028820-25330-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1448028820-25330-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< ACL Data TX: Handle 256 flags 0x00 dlen 18
      Channel: 258 len 14 [PSM 25 mode 0] {chan 2}
      AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 5 nosp 0
        ACP SEID: 1
        INT SEID: 3
        Service Category: Media Transport (0x01)
        Service Category: Media Codec (0x07)
        00 00 21 15 02 35                                ..!..5
> ACL Data RX: Handle 256 flags 0x02 dlen 6
      Channel: 66 len 2 [PSM 25 mode 0] {chan 2}
      AVDTP: Set Configuration (0x03) Response Accept (0x02) type 0x00 label 5 nosp 0
---
 monitor/avdtp.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index cf11d2e..6869183 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -307,6 +307,43 @@ response:
 	return decode_capabilities(avdtp_frame);
 }
 
+static bool avdtp_set_configuration(struct avdtp_frame *avdtp_frame)
+{
+	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
+	uint8_t acp_seid, int_seid;
+	uint8_t service_cat;
+
+	if (avdtp_frame->hdr & 0x01)
+		goto reject;
+
+	if (avdtp_frame->hdr & 0x02)
+		goto response;
+
+	if (!l2cap_frame_get_u8(frame, &acp_seid))
+		return false;
+
+	if (!l2cap_frame_get_u8(frame, &int_seid))
+		return false;
+
+	print_field("ACP SEID: %d", acp_seid >> 2);
+	print_field("INT SEID: %d", int_seid >> 2);
+
+	return decode_capabilities(avdtp_frame);
+
+reject:
+	if (!l2cap_frame_get_u8(frame, &service_cat))
+		return false;
+
+	print_field("Service Category: %s (0x%02x)",
+				servicecat2str(service_cat), service_cat);
+
+	return avdtp_reject_common(avdtp_frame);
+
+response:
+	/* no extra parameters */
+	return true;
+}
+
 static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 {
 	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
@@ -369,6 +406,9 @@ static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 	case AVDTP_GET_CAPABILITIES:
 		ret = avdtp_get_capabilities(avdtp_frame);
 		break;
+	case AVDTP_SET_CONFIGURATION:
+		ret = avdtp_set_configuration(avdtp_frame);
+		break;
 	default:
 		packet_hexdump(frame->data, frame->size);
 		ret = true;
-- 
2.6.2

